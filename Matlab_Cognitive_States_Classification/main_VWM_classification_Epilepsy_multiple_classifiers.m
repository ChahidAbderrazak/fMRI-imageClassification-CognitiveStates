
%% This script transform the subject data to a single matrix with the rows as Voxels(features) and coloumn as trials(samples)
% the  datset should be alrady loaded. ie:             load('data-starplus-04799-v7.mat')
clear all; close all
tic
%%
addpath ../Functions
addpath ../Functions/Netlab
addpath ../Functions/Functions_abderrazak
addpath ../Datasets
addpath /Volumes/eman/chahida/Projects-Dataset/fMRI/StarPlus2018/

%% nput parameters
M=6%:10
List_classifiers={'logisticRegression','SMLR','nbayes','neural'};


%% load datsets
load('Epileptic_Seizure_UCI.mat')
Y=y;

%% 


%% prepare positive negative datsets
% shuffle data
rand_pos = randperm(length(EEG));
EEG=EEG(rand_pos,:);
Y=Y(rand_pos);

%% Get blaced dataset
indp=find(Y==1); Xp=EEG(indp,:); yp=Y(indp); Np=size(Xp,1);
indn=find(Y~=1); Xn=EEG(indn(1:Np),:); yn=0*Y(indn(1:Np))+2;

sigma=min([std(Xp(:)),std(Xn(:))]);
% sigma=sigma/8;
mu=mean([mean(Xp(:)),mean(Xn(:))]);


%     figure(1);histogram(Xp);hold on;histogram(Xn)

% build the dataset
X=[Xp;Xn];
y=[yp;yn];


%% 5-folds cross-validation

%% Apply k_fold classification
[outcome, Sparse_P, Sparse_S, Accuracy,Sensitivity,Specificity,Precision,Gmean,F1score]...
     = Classify_kfold_VWM_functions_clfs(X,y,M,sigma,mu,List_classifiers);

Accuracy


%     Accuracy_av(j,:)= sum(Accuracy)/size(Accuracy,1);

Output_results =[  Accuracy,Sensitivity]%,Specificity,Precision,Gmean,F1score];

%% table
%% Add the  results to a table
colnames={'Shuffle', 'M','mu','sigma','Acc-LR','Acc-SMLR','Acc-NB','Acc-NN',...
           'Sen-LR','Sen-SMLR','Sen-NB','Sen-NN','spec-LR','spec-SMLR','spec-NB','spec-NN',};  % {'logisticRegression','SMLR','nbayes','neural'};

perform_output= array2table(Output_results, 'VariableNames',colnames);
  
% excel sheet
writetable(perform_output,strcat('../Excel/UCI_Epilepsy_kFold_Acc',num2str(Accuracy_av(1)),'.xlsx'))

save('summary_result.mat', 'perform_output', 'k')

