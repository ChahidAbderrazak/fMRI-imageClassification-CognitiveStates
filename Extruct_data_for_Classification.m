trials=find([info.cond]>1);

%%
[info1,data1,meta1]=transformIDM_selectTrials(info,data,meta,trials);
[infoP1,dataP1,metaP1]=transformIDM_selectTrials(info1,data1,meta1,find([info1.firstStimulus]=='P'));
[infoS1,dataS1,metaS1]=transformIDM_selectTrials(info1,data1,meta1,find([info1.firstStimulus]=='S'));

[infoP3,dataP3,metaP3]=transformIDM_selectTimewindow(infoS1,dataS1,metaS1,[17:32]);
[infoS2,dataS2,metaS2]=transformIDM_selectTimewindow(infoP1,dataP1,metaP1,[17:32]);


[infoP2,dataP2,metaP2]=transformIDM_selectTimewindow(infoP1,dataP1,metaP1,[1:16]);
[infoS3,dataS3,metaS3]=transformIDM_selectTimewindow(infoS1,dataS1,metaS1,[1:16]);


%% firdt stri : use only first stimulus

[examplesP2,labelsP2,exInfoP2]=idmToExamples_condLabel(infoP2,dataP2,metaP2);
[examplesP3,labelsP3,exInfoP3]=idmToExamples_condLabel(infoP3,dataP3,metaP3);
[examplesS2,labelsS2,exInfoS2]=idmToExamples_condLabel(infoS2,dataS2,metaS2);
[examplesS3,labelsS3,exInfoS3]=idmToExamples_condLabel(infoS3,dataS3,metaS3);
examplesP= [examplesP2; examplesP3];
examplesS=[examplesS2;examplesS3];
size(examplesP,1)
size(examplesP)
help ones
labelsP = ones(size(examplesP), 1);
labelsP = ones(size(examplesP,1), 1);
labelsS = ones(size(examplesS,1), 1)+1;
examples=[examplesP;examplesS];
labels = [labelsP;labelsS];