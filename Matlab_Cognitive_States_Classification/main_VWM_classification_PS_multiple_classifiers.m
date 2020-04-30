close all; clear all; clc 

addpath ../Functions
addpath ../Functions/Netlab
% addpath /Users/sehrism/Documents/datasets
addpath ../Datasets
addpath /Volumes/eman/chahida/Projects-Dataset/fMRI/StarPlus2018/

%% Input paramters
k=0.8;   %   optimal resolution k=1 
subject_list=1:6
ROI_list={'CALC' 'LIPL' 'LT' 'LTRIA' 'LOPER' 'LIPS' 'LDLPFC'};%{'CALC' 'LIPL'  'LOPER' 'LIPS'};%{'CALC'};%
List_classifiers={'logisticRegression','SMLR','nbayes','neural'};

%% 
Nr=max(size(ROI_list));
k_all= [];
cnt = 1;
for subject=subject_list
    
    subject
    
    switch(subject)
        case 1
            load('data-starplus-04799-v7.mat')
            Convert_single_subject_data_to_matrix
            [outcome, Accuracy(subject,:), Sparsity_P(subject,1), Sparsity_S(subject,1)]= Classify_LeaveOut_VWM_functions_clfs(X,Y,k,List_classifiers);
        case 2
            load('data-starplus-04820-v7.mat')
            Convert_single_subject_data_to_matrix
            [outcome, Accuracy(subject,:), Sparsity_P(subject,1), Sparsity_S(subject,1)]= Classify_LeaveOut_VWM_functions_clfs(X,Y,k,List_classifiers);
        case 3
            load('data-starplus-04847-v7.mat')
            Convert_single_subject_data_to_matrix
            [outcome, Accuracy(subject,:), Sparsity_P(subject), Sparsity_S(subject,1)]= Classify_LeaveOut_VWM_functions_clfs(X,Y,k,List_classifiers);

        case 4
            load('data-starplus-05675-v7.mat')
            Convert_single_subject_data_to_matrix
            [outcome, Accuracy(subject,:), Sparsity_P(subject,1), Sparsity_S(subject,1)]= Classify_LeaveOut_VWM_functions_clfs(X,Y,k,List_classifiers);

        case 5
            load('data-starplus-05680-v7.mat')
            Convert_single_subject_data_to_matrix
            [outcome, Accuracy(subject,:), Sparsity_P(subject,1), Sparsity_S(subject,1)]= Classify_LeaveOut_VWM_functions_clfs(X,Y,k,List_classifiers);

        case 6
            load('data-starplus-05710-v7.mat')
            Convert_single_subject_data_to_matrix
            [outcome, Accuracy(subject,:), Sparsity_P(subject,1), Sparsity_S(subject,1)]= Classify_LeaveOut_VWM_functions_clfs(X,Y,k,List_classifiers);
    end


end

save(strcat('Multi_classifier_results_ROIs',num2str(Nr),'.mat'), 'ROI_list','Accuracy', 'subject_list', 'k', 'List_classifiers')

