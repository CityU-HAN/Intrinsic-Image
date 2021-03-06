%%%%%%%%%%
% run_comparison 
% of image segmentation on original image and intrinsic image
%
% 29 March 2012 AK
%%%%%%%%%%
clear all;close all;clc;

addpath(genpath('BSR'));
addpath(genpath('nips11intrinsic'));

eval('config_comp');
%set imgDir, outDir, param

D = dir(fullfile(imgDir,'*.jpg'));

addpath(genpath('edison'));

for i=1:numel(D)
    imPath=fullfile(imgDir,D(i).name);

    % 2. compute intrinsic image (Just use reflectance for the moment)
     albedoPath = fullfile(outDir,[D(i).name(1:end-4) '_albedo.mat']);
     if ~exist(albedoPath, 'file')
         fprintf('computing albedo map for %s\n', imPath); 
         %         R = im2retinex(imPath, albedoPath, param); 
         R = im2reflectance(imPath, albedoPath, param); 
         sfigure; subplot(211); imagesc(im2double(imread(imPath)));
         subplot(212); imagesc(R); title(sprintf('Retinex for %s', D(i).name(1:end-4)));
     end

     % 1. run Berkeley hierarchical image segmentation (BSR) on the original
     % segPath = fullfile(outDir,[D(i).name(1:end-4) '_ucm.mat']);
     % if ~exist(segPath,'file'), im2ucm(imPath, segPath);  end

     % 1b. run Mean-shift on the original
%     segPath2 = fullfile(outDir,[D(i).name(1:end-4) '_ms.mat']);
%     if ~exist(segPath2,'file')
%         I = im2double(imread(imPath));
%         [fim labels modes regSize] = edison_wrapper(I, @RGB2Luv, 'SpatialBandWidth', 15, 'MinimumRegionArea', 75);  
%         fim = Luv2RGB(fim);
%         keyboard
%         save(segPath2, 'fim', 'labels');
%     end
    
%     intSegPath = fullfile(outDir,[D(i).name(1:end-4) '_ucmR.mat']);
%     % 3. re-run BSR on the reflectance image
%     if ~exist(intSegPath, 'file'), im2ucm(albedoPath, intSegPath); end

%     seg = load(segPath); % loads ucm2
%     albedo = load(albedoPath); % loads estR
%     intseg = load(intSegPath); % loads ucm2

%     sfigure(1);
%     subplot(221); imagesc(imread(imPath)); title('original'); axis image;
%     subplot(221); imagesc(albedo); title('estimated reflectance'); axis image;
%     subplot(222); imagesc(seg); title('BSR:ultrametric contour map'); axis image;
%     subplot(222); imagesc(intseg); 
%     title('BSR-UCM on estimated reflectance '); axis image;
%     suptitle('segmentation with and without intrinsic image');

end


