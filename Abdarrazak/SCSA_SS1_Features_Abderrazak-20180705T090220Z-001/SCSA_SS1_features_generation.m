%  Builg DSP features for PolyA prediction 
clear all;close all
addpath ./Functions ; addpath ./Functions/Abderrazak; 

%% Generate SCSA Based Features
h=1;gm=0.5;fs=1;
your_feature=magic(80);
[F_featuresA_h1, S_featuresA_h1, B_featuresA_h1, P_featuresA_h1,AF_featuresA_h1]=SCSA_Transform_features(your_feature,h,gm,fs);
