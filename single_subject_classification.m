clear all
load('data-starplus-04799-v7.mat')
trials=find([info.cond]>1); % The trials of S and P 

%% Returns data for specified trials
[info0,data0,meta0]=transformIDM_selectTrials(info,data,meta,trials);

%% Returns an IDM for specified ROIs
[info1,data1,meta1] = transformIDM_selectROIVoxels(info0,data0,meta0,{'CALC' 'LIPL' 'LT' 'LTRIA' 'LOPER' 'LIPS' 'LDLPFC'});

%% Take the average
    [info11,data11,meta11] = transformIDM_avgROIVoxels(info,data,meta,{'CALC' 'LIPL' 'LT' 'LTRIA' 'LOPER' 'LIPS' 'LDLPFC'});

%    alltrials= 1:meta.ntrials;
%    ts= [info.actionAnswer]==0;
%    trialsOfInterest=alltrials(ts);
%    [i,d,m]=transformIDM_avgTrials(info,data,meta,trialsOfInterest);
%    plotVoxel(i,d,m,36,62,8);
%    animate16Trial(i,d,m,1);
% 

%% Normalize the features 

[info2,data2,meta2] = transformIDM_normalizeTrials(info1,data1,meta1);

% norm_data2= zeros(size(data1{1,1},1),size(data1{1,1},2) );
% 
% for i=1:size(data1{1,1},1)
%     norm_data2(i,:) = (data1{1,1}(i,:) - min(data1{1,1}(i,:))) / ( max(data1{1,1}(i,:)) - min(data1{1,1}(i,:)) );
% 
% end
% for k=1:size(data1,1)
%     n(k)= normalize(data1{k,1});
% 
% end    
    
%% Returns data for specified firstStimulus
[infoP,dataP,metaP]=transformIDM_selectTrials(info1,data1,meta1,find([info1.firstStimulus]=='P'));
[infoS,dataS,metaS]=transformIDM_selectTrials(info1,data1,meta1,find([info1.firstStimulus]=='S'));
%% Returns IDM for the 1st 8 seconds 
[infoP1,dataP1,metaP1]=transformIDM_selectTimewindow(infoP,dataP,metaP,[1:16]);
[infoS1,dataS1,metaS1]=transformIDM_selectTimewindow(infoS,dataS,metaS,[1:16]);

%% Returns IDM for the 2nd 8 seconds 
[infoP2,dataP2,metaP2]=transformIDM_selectTimewindow(infoS,dataS,metaS,[17:32]);
[infoS2,dataS2,metaS2]=transformIDM_selectTimewindow(infoP,dataP,metaP,[17:32]);

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

%% Shuffle data
[X,Y,shuffledRow] = shuffleRow(X,Y);

%% Run Classification
for l=1:10
    Acc(l)=Apply_GNB(0.72, X, Y);
    plot(Acc);
end

%% Apply GNB

[classifier] = trainClassifier(X,labels,'nbayes');   %train classifier
[predictions] = applyClassifier(X,classifier);       %test it

[result,predictedLabels,trace] = summarizePredictions(predictions,classifier,'averageRank',labels);
1-result{1}  % rank accuracy
