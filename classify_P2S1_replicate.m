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
[infoS1,dataS1,metaS1]=transformIDM_selectTimewindow(infoS,dataS,metaS,[1:16]);

%% Returns IDM for the 2nd 8 seconds 
[infoP2,dataP2,metaP2]=transformIDM_selectTimewindow(infoS,dataS,metaS,[17:32]);

%% Normalize each snapshot
if normalization == 1
    [infoP2,dataP2,metaP2] = transformIDM_normalizeTrials(infoP2,dataP2,metaP2);
    [infoS1,dataS1,metaS1] = transformIDM_normalizeTrials(infoS1,dataS1,metaS1);
end
%% Create X and labels, data is converted to X by concatenating the multiple data rows to one single row
[X_P2,labelsP2,exInfoP2]=idmToExamples_condLabel(infoP2,dataP2,metaP2);%X_P1 is the 1st 8s and X_P2 for 2nd 8s for firstStimulus='P'
[X_S1,labelsS1,exInfoS1]=idmToExamples_condLabel(infoS1,dataS1,metaS1);

%% combine X and create labels.  Label 'picture' 1, label 'sentence' 2.
labelsP=ones(size(X_P2,1),1);
labelsS=ones(size(X_S1,1),1)+1;
X=[X_P2;X_S1];
Y=[labelsP;labelsS];

%% Shuffle data
[X,Y,shuffledRow] = shuffleRow(X,Y);

%% Apply GNB
[classifier] = trainClassifier(X,Y, 'nbayes');   %train classifier
[predictions] = applyClassifier(X,classifier);       %test it
[result,predictedLabels,trace] = summarizePredictions(predictions,classifier,'averageRank',Y);
1-result{1}  % rank accuracy
