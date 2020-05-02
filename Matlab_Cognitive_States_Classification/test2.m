close all; clear all; clc 

addpath ../Functions
addpath ../Functions/Netlab
% addpath /Users/sehrism/Documents/datasets
addpath ../Datasets
addpath ../Datasets/StarPlus2018

addpath /Volumes/eman/chahida/Projects-Dataset/fMRI/StarPlus2018/

%% Input paramters
k=1;   %   optimal resolution k=1 
subject_list=1:6
ROI_list={'CALC'};%{'CALC' 'LIPL' 'LT' 'LTRIA' 'LOPER' 'LIPS' 'LDLPFC'};%{'CALC' 'LIPL'  'LOPER' 'LIPS'};%
List_classifiers={'svm','logisticRegression','SMLR','nbayes','neural'};

%% 
Nr=max(size(ROI_list));
k_all= [];
cnt = 0;
Accuracy = zeros(6,5);

parfor subject=1:6%subject_list
    fprintf('--> Subject %d in  parallel loop!!!\n',subject)

    [X,Y]=Convert_single_subject_data_to_matrix_parallel(subject,ROI_list)
    [Accuracy(subject,:)]= Classify_LeaveOut_VWM_functions_clfs(X,Y,k,List_classifiers);

%     cnt=cnt+1
    
end

save(strcat('Multi_classifier_results_ROIs',char(join(ROI_list,"_")),'.mat'), 'ROI_list','Accuracy', 'subject_list', 'k', 'List_classifiers')

