
%% This script transform the subject data to a single matrix with the rows as Voxels(features) and coloumn as trials(samples)
% the  datset should be alrady loaded. ie:             load('data-starplus-04799-v7.mat')
clear all; close all
tic
%%
addpath ../Functions
addpath ../Functions/Netlab
addpath ../Functions/Functions_abderrazak
addpath ../Datasets
addpath R:\chahida\Projects-Dataset\fMRI\StarPlus2018

%% nput parameters
M_list=6:10


%% load datsets
load('Epileptic_Seizure_UCI.mat')
Y=y;

%% 
Output_results=[];
for j=1:6
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


    figure(1);histogram(Xp);hold on;histogram(Xn)

    % build the dataset
    X=[Xp;Xn];
    y=[yp;yn];


    %% 5-folds cross-validation
    cnt = 0;
    for k=M_list
        
        cnt = cnt+1;
        %% Apply k_fold classification
        [outcome, Sparse_P(cnt,1), Sparse_S(cnt,1), Accuracy(cnt,1),...
         Sensitivity(cnt,1),Specificity(cnt,1),Precision(cnt,1),Gmean(cnt,1),...
         F1score(cnt,1)]= Classify_kfold_VWM_functions(X,y,k,sigma,mu);
     
        Accuracy
        
    end

    Accuracy_av(j)= sum(Accuracy)/size(Accuracy,1);
    one_vec=ones(cnt,1);
    Output_k =[ j*one_vec, M_list', mu*one_vec, sigma*one_vec, Accuracy,Sensitivity,Specificity,Precision,Gmean,F1score];

    Output_results=[Output_results;Output_k];
end

mean=mean(Accuracy_av)
var=std(Accuracy_av)^2

%% table
%% Add the  results to a table
colnames={'Shuffle', 'M','mu','sigma','Accuracy','Sensitivity','Specificity','Precision','Gmean','F1score'};
perform_output= array2table(Output_results, 'VariableNames',colnames);
  
% excel sheet
writetable(perform_output,strcat('../Excel/UCI_Epilepsy_kFold_Acc',num2str(Accuracy_av(1)),'.xlsx'))

save('summary_result.mat', 'perform_output', 'k')

