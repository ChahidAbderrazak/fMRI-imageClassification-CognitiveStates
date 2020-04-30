
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
k=3;
List_classifiers={'logisticRegression','SMLR','nbayes'};%,'neural'};


%% load datsets
load('Epileptic_Seizure_UCI.mat')
Y=y;

%% 
Nc=max(size(List_classifiers));

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
[Accuracy,Sensitivity,Specificity,Precision,Gmean,F1score]...
     = Classify_kfold_VWM_functions_clfs(X,y,M,sigma,mu,k,List_classifiers);

Accuracy


%     Accuracy_av(j,:)= sum(Accuracy)/size(Accuracy,1);
one_vec=ones(Nc,1);
    
Output_results =[  M*one_vec, k*one_vec, mu*one_vec, sigma*one_vec mean(Accuracy,2),mean(Sensitivity,2),mean(Specificity,2),mean(Precision,2),mean(Gmean,2),mean(F1score,2)];
Accuracy_av=mean(Accuracy);

%% table
%% Add the  results to a table
colnames={'Shuffle', 'M','mu','sigma','Accuracy','Sensitivity','Specificity','Precision','Gmean','F1score'};  % {'logisticRegression','SMLR','nbayes','neural'};

perform_output= array2table(Output_results, 'VariableNames',colnames);
perform_output.Classifier=List_classifiers';
% excel sheet
writetable(perform_output,strcat('../Excel/UCI_Epilepsy_kFold_Acc',num2str(Accuracy_av(1)),'_Clf',num2str(Nc),'.xlsx'))

