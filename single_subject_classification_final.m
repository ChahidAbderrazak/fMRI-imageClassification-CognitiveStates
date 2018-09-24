clear all
addpath ./Functions
addpath ./Functions/Netlab
addpath ./datasets
% addpath /Users/sehrism/Documents/datasets

load('data-starplus-04799-v7.mat')
% load('data-starplus-04820-v7.mat')
% load('data-starplus-04847-v7.mat')
% load('data-starplus-05675-v7.mat')
% load('data-starplus-05680-v7.mat')
% load('data-starplus-05710-v7.mat')

normalization=0; % *Normalize each trial
normalization_PWM=0; % *Normalize the input to PWM
trials=find([info.cond]>1); % The trials of S and P 

%% Returns data for specified trials
[info0,data0,meta0]=transformIDM_selectTrials(info,data,meta,trials);

%% Select the voxels belong to the specified ROIs

[infoAvg,dataAvg,metaAvg] = transformIDM_selectROIVoxels(info0,data0,meta0,{'CALC'});
% [infoAvg,dataAvg,metaAvg] = transformIDM_avgROIVoxels(info0,data0,meta0,{'CALC' 'LIPL' 'LT' 'LTRIA' 'LOPER' 'LIPS' 'LDLPFC'});


% 'CALC' 'LIPL' 'LT' 'LTRIA' 'LOPER' 'LIPS' 'LDLPFC'

%% Returns data for specified firstStimulus
[infoP,dataP,metaP]=transformIDM_selectTrials(infoAvg,dataAvg,metaAvg,find([infoAvg.firstStimulus]=='P'));
[infoS,dataS,metaS]=transformIDM_selectTrials(infoAvg,dataAvg,metaAvg,find([infoAvg.firstStimulus]=='S'));

%% Returns IDM for the 1st 8 seconds 
[infoP1,dataP1,metaP1]=transformIDM_selectTimewindow(infoP,dataP,metaP,[1:16]);
[infoS1,dataS1,metaS1]=transformIDM_selectTimewindow(infoS,dataS,metaS,[1:16]);

%% Returns IDM for the 2nd 8 seconds 
[infoP2,dataP2,metaP2]=transformIDM_selectTimewindow(infoS,dataS,metaS,[17:32]);
[infoS2,dataS2,metaS2]=transformIDM_selectTimewindow(infoP,dataP,metaP,[17:32]);

%% *Normalize each snapshot
if normalization==1
    [infoP1,dataP1,metaP1] = transformIDM_normalizeTrials(infoP1,dataP1,metaP1);
    [infoP2,dataP2,metaP2] = transformIDM_normalizeTrials(infoP2,dataP2,metaP2);
    [infoS1,dataS1,metaS1] = transformIDM_normalizeTrials(infoS1,dataS1,metaS1);
    [infoS2,dataS2,metaS2] = transformIDM_normalizeTrials(infoS2,dataS2,metaS2);
end
%% *Normalize the input to PWM 
if normalization_PWM==1
    [infoP1,dataP1_PWM,metaP1] = transformIDM_normalizeTrials(infoP1,dataP1,metaP1);
    [infoP2,dataP2_PWM,metaP2] = transformIDM_normalizeTrials(infoP2,dataP2,metaP2);
    [infoS1,dataS1_PWM,metaS1] = transformIDM_normalizeTrials(infoS1,dataS1,metaS1);
    [infoS2,dataS2_PWM,metaS2] = transformIDM_normalizeTrials(infoS2,dataS2,metaS2);
    [X_P1_PWM,labelsP1,exInfoP1]=idmToExamples_condLabel(infoP1,dataP1_PWM,metaP1);
    [X_P2_PWM,labelsP2,exInfoP2]=idmToExamples_condLabel(infoP2,dataP2_PWM,metaP2);
    [X_S1_PWM,labelsS1,exInfoS1]=idmToExamples_condLabel(infoS1,dataS1_PWM,metaS1);
    [X_S2_PWM,labelsS2,exInfoS2]=idmToExamples_condLabel(infoS2,dataS2_PWM,metaS2);
    X_P_PWM=[X_P1_PWM;X_P2_PWM]; %X_P1 is the 1st 8s and X_P2 for 2nd 8s for firstStimulus='P'
    X_S_PWM=[X_S1_PWM;X_S2_PWM]; %X_S1 is the 1st 8s and X_S2 for 2nd 8s for firstStimulus='S'
    PWM = extract_PWM(X_P_PWM, X_S_PWM); % *Generate PWM features for normalized input

end

%% Create X and labels, data is converted to X by concatenating the multiple data rows to one single row
[X_P1,labelsP1,exInfoP1]=idmToExamples_condLabel(infoP1,dataP1,metaP1);
[X_P2,labelsP2,exInfoP2]=idmToExamples_condLabel(infoP2,dataP2,metaP2);
[X_S1,labelsS1,exInfoS1]=idmToExamples_condLabel(infoS1,dataS1,metaS1);
[X_S2,labelsS2,exInfoS2]=idmToExamples_condLabel(infoS2,dataS2,metaS2);

%% combine X and create labels.  Label 'picture' 1, label 'sentence' 2.
X_P=[X_P1;X_P2]; %X_P1 is the 1st 8s and X_P2 for 2nd 8s for firstStimulus='P'
X_S=[X_S1;X_S2]; %X_S1 is the 1st 8s and X_S2 for 2nd 8s for firstStimulus='S'
labelsP=ones(size(X_P,1),1);
labelsS=ones(size(X_S,1),1)+1;
X=[X_P;X_S];
Y=[labelsP;labelsS];

%% Generate PWM features

if normalization_PWM==0
    [PWM, PWM_fake] = extract_PWM1(X_P, X_S);
end

%% *Append the DC component and MAX Amplitude of fourier transform to the features
[X_FT,Max_X_FT,I,X_DC]= apply_fourier(X, string('false'));
% X(:, size(X,2)+1)= X_DC(:,1);
% X= [X X_FT];
% X(:, size(X,2)+1)= Max_X_FT(:,1);
% X(:, size(X,2)+1)= I(:,1);

%% *Get ESD feature
ESD= X_FT.*conj(X_FT);
ESD= sum(ESD,2);
% X(:, size(X,2)+1)= ESD(:,1);

%% *Generate SCSA Based Features

%  addpath D:\SSI\Project\Matlab\SCSA_SS1_Features_Abderrazak-20180705T090220Z-001\Functions ; addpath D:\SSI\Project\Matlab\SCSA_SS1_Features_Abderrazak-20180705T090220Z-001\Functions\Abderrazak
% addpath ./Functions ; addpath ./Functions/Abderrazak; 
addpath /Users/sehrism/Documents/MATLAB/SCSA_SS1_Features_Abderrazak/Functions; addpath /Users/sehrism/Documents/MATLAB/SCSA_SS1_Features_Abderrazak/Functions/Abderrazak;

%% 
h=1;gm=0.5;fs=1;
[F_featuresA_h1, S_featuresA_h1, B_featuresA_h1, P_featuresA_h1,AF_featuresA_h1]= SCSA_Transform_features(X(:,1:112),h,gm,fs);
% X= [X F_featuresA_h1];
% X= [X S_featuresA_h1(:,1:52)]; %Increase the %error
% X= [X B_featuresA_h1];
% X= [X P_featuresA_h1];
% X(:,size(X,2)+1)= AF_featuresA_h1;

%% *Extract wavelet features
addpath /Users/sehrism/Documents/MATLAB;
wavelet_features= zeros(size(X,1),8);

for i=1:size(X,1)
    wavelet_features(i,:)= getwaveletFeature(X(i,:));
end

% classify_features
Classify_raw_plus_features % *
