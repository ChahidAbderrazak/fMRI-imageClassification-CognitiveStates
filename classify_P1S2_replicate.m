clear all
addpath ./Functions
addpath ./Functions/Netlab
addpath ./datasets
load('data-starplus-05710-v7.mat')
normalization= 1;

trials=find([info.cond]>1); % The trials of S and P 

%% Returns data for specified trials
[info0,data0,meta0]=transformIDM_selectTrials(info,data,meta,trials);

%% Take the average of each ROIs
 [infoAvg,dataAvg,metaAvg] = transformIDM_avgROIVoxels(info0,data0,meta0,{'CALC' 'LIPL' 'LT' 'LTRIA' 'LOPER' 'LIPS' 'LDLPFC'});

%% Returns data for specified firstStimulus
[infoP,dataP,metaP]=transformIDM_selectTrials(infoAvg,dataAvg,metaAvg,find([infoAvg.firstStimulus]=='P'));
[infoS,dataS,metaS]=transformIDM_selectTrials(infoAvg,dataAvg,metaAvg,find([infoAvg.firstStimulus]=='S'));

%% Returns IDM for the 1st 8 seconds 
[infoP1,dataP1,metaP1]=transformIDM_selectTimewindow(infoP,dataP,metaP,[1:16]);

%% Returns IDM for the 2nd 8 seconds 
[infoS2,dataS2,metaS2]=transformIDM_selectTimewindow(infoP,dataP,metaP,[17:32]);

%% Normalize each snapshot
if normalization == 1
    [infoP1,dataP1,metaP1] = transformIDM_normalizeTrials(infoP1,dataP1,metaP1);
    [infoS2,dataS2,metaS2] = transformIDM_normalizeTrials(infoS2,dataS2,metaS2);
end
%% Create X and labels, data is converted to X by concatenating the multiple data rows to one single row
[X_P1,labelsP1,exInfoP1]=idmToExamples_condLabel(infoP1,dataP1,metaP1);
[X_S2,labelsS2,exInfoS2]=idmToExamples_condLabel(infoS2,dataS2,metaS2);%X_S1 is the 1st 8s and X_S2 for 2nd 8s for firstStimulus='S'

%% combine X and create labels.  Label 'picture' 1, label 'sentence' 2.
labelsP=ones(size(X_P1,1),1);
labelsS=ones(size(X_S2,1),1)+1;
X=[X_P1;X_S2];
Y=[labelsP;labelsS];

%% Shuffle data
[X,Y,shuffledRow] = shuffleRow(X,Y);

%% Apply GNB
[classifier] = trainClassifier(X,Y, 'nbayes');   %train classifier
[predictions] = applyClassifier(X,classifier);       %test it
[result,predictedLabels,trace] = summarizePredictions(predictions,classifier,'averageRank',Y);
1-result{1}  % rank accuracy
