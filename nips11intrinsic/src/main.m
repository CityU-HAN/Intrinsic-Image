function [r, estReflectance, estShading] = main()
  addpath('../lib');
  init_libs();

  parameter = struct();
  result = struct();
  % create the optimization option struct
  opts = struct();

  parameter.energyThresh    = 1e-3;
  parameter.maxIterations   = 250;
  parameter.minimizeMaxIter = 10000;

  parameter.sumConstraint   = 1;
  parameter.reflectanceInit = 'ones'; % 'ones', 'normI', 'mixed'
  parameter.startFac        = 0.3;     % only valid for 'mixed'

  parameter.c_R             = 0;1;
  parameter.k               = 150;
  parameter.kMeansRestarts  = 4;
  parameter.clusteringInit  = 'RhatR'; % 'RhatR', 'chromaticity', 'normI'

  parameter.c_smooth        = 0;0.001;

  parameter.c_cret          = 1;%0.01;
  parameter.thresholdGray   = 0.075;
  parameter.thresholdColor  = 1;

  % load image
  parameter.img = 'sun';
  img = struct();
  [img.diffuse, img.reflectance, img.shading, img.specular, img.mask] = ...
    mitLoad(parameter.img);
sfigure(100); 
subplot(2,2,1);imagesc(img.diffuse); title('original'); axis image;
subplot(2,2,2);imagesc(img.reflectance); title('Reflectance');axis image;
subplot(2,2,3);imagesc(img.shading); title('Shading');axis image;
suplabel('original & ground truth');
%img.diffuse = img.diffuse(1:10, 1:10, :);
  %img.reflectance = img.reflectance(1:10, 1:10, :);
  %img.shading = img.shading(1:10, 1:10, :);
  %img.mask = img.mask(1:10, 1:10, :);

  cut = 3/(2^16-1);
  img.diffuse(img.diffuse < cut) = cut;
  img.diffuse = trimToMask(img.diffuse, img.mask);
  img.norm = sum(img.diffuse, 2);
  img.normedDiffuse = bsxfun(@rdivide, img.diffuse, img.norm);
  img.sz = size(img.mask);

  % init the diff operators
  [opts.filterH,opts.filterV] = create4connected_L1(img.sz(1), img.sz(2), ...
    img.mask);
  opts.laplacian = create4connected(img.sz(1), img.sz(2), img.mask);

  % initialize the energy term stack
  opts.energyStack = {};
  opts.energyWeights = {};

  % we would like to optimize this
  r = initializeR(img, parameter);

  % the different energy terms stacked upon each other
  if (parameter.c_R ~= 0)
    reflectanceWeights = ones(size(img.mask));
    fprintf('starting cluster term');
    tic
    opts.energyStack{end+1} =...
      ClusterTerm(img, parameter, opts, r);
    opts.energyWeights{end+1} = parameter.c_R;
    toc
    fprintf('done clusterTerm\n');
  end

  if (parameter.c_smooth ~= 0)
    opts.energyStack{end+1} =...
      SmoothTerm(img, opts);
    opts.energyWeights{end+1} = parameter.c_smooth;
  end

  if (parameter.c_cret ~= 0)
    opts.energyStack{end+1} = DiffTerm(img, parameter, opts);
    opts.energyWeights{end+1} = parameter.c_cret;
  end

  result.sse = zeros(0, 0);
  lastEnergy = Inf;
  energy = Inf;
  for i=1:parameter.maxIterations
    lastEnergy = energy;

    % optimize r given split
    r = minimize(r, @objective, ...
      struct('length', parameter.minimizeMaxIter, 'verbosity', 1), ...
      img, parameter, opts);

    energy = objective(r, img, parameter, opts);
    diffEnergy = lastEnergy - energy;
    assert(diffEnergy >= 0);

    % update the terms after the minimization step
    for i=1:numel(opts.energyStack)
      term = opts.energyStack{i};
      opts.energyStack{i} = term.update(term, r);
    end

    estReflectance = insertIntoMask(bsxfun(@times, img.normedDiffuse, r), ...
      img.mask);
    estShading = insertIntoMask(img.norm./r, img.mask);

    subplot(2, 2, 1);
    imagesc(insertIntoMask(r, img.mask));
    colorbar;
    subplot(2, 2, 3);
    image(getNormalized(estReflectance));
    subplot(2, 2, 4);
    image(getNormalized(repmat(estShading, [1, 1, 3])));
    drawnow;

    result.sse(end+1) = lmse(img.reflectance, img.shading, ...
      estReflectance, estShading, 20);
    fprintf('SSE %f\n', result.sse(end));

    energy = objective(r, img, parameter, opts);
    diffEnergy = lastEnergy - energy;
    assert(diffEnergy >= 0);
    fprintf('E   %f\n', energy);

    if diffEnergy < parameter.energyThresh
      break;
    end
  end

  result.r = r;
  fprintf('END of decomposition (\# iteration=%d)', i);
  sfigure(200); 
  subplot(2,2,1);imagesc(img.reflectance); title('Estimated Reflectance');axis image;
  subplot(2,2,2);imshow(img.shading, []); title('Shading');axis image;
  suplabel(sprintf('Result SSE: %g', result.sse(end)));


function [f, df] = objective(r, img, parameter, opts)
  if any(vec(r <= 0))
    error('r not positiv');
  end

  f = 0;
  df = zeros(size(r));

  for i=1:numel(opts.energyStack)
    term = opts.energyStack{i};
    [E, dE] = term.getEnergy(term, r);
    f = f + E * opts.energyWeights{i};
    df = df + dE * opts.energyWeights{i};
  end

  % project the gradient back such that mean(r) does not change
  if parameter.sumConstraint
    df = df - mean(df(:));
  end

function [r] = initializeR(img, parameter)
  switch parameter.reflectanceInit
  case 'normI'
    r = img.norm;

  case 'ones'
    r = ones(size(img.diffuse, 1), 1);

  case 'mixed'
    r = parameter.startFac * 3*ones(size(img.diffuse, 1), 1);
    r = r + (1-parameter.startFac) * img.norm;

  otherwise
    error('unknown reflectanceInit');
  end

  if parameter.sumConstraint
    r = r./sum(r(:));
    r = r.*numel(r);
  end

  assert(~any(isnan(r(:))))
  assert(all(r(:)>=0));
