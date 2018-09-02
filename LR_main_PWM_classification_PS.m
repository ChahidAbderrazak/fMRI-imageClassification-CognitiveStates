clear all
addpath ./Functions
addpath ./Functions/Netlab
addpath ./datasets
% addpath /Users/sehrism/Documents/datasets
addpath ./Leave1out_PWM
addpath ./test
addpath D:\SSI\Project\Datasets\starplus
for subject=1:6
    switch(subject)
        case 1
            load('data-starplus-04799-v7.mat')
            single_subject_classification_test
            [accuracy1, acc1]= LR_one_distribution_LeaveOut_PWM_functions(X,Y);
        case 2
            load('data-starplus-04820-v7.mat')
            single_subject_classification_test
            [accuracy2, acc2]= LR_one_distribution_LeaveOut_PWM_functions(X,Y);
        case 3
            load('data-starplus-04847-v7.mat')
            single_subject_classification_test
            [accuracy3, acc3]= LR_one_distribution_LeaveOut_PWM_functions(X,Y);
        case 4
            load('data-starplus-05675-v7.mat')
            single_subject_classification_test
            [accuracy4, acc4]= LR_one_distribution_LeaveOut_PWM_functions(X,Y);
        case 5
            load('data-starplus-05680-v7.mat')
            single_subject_classification_test
            [accuracy5, acc5]= LR_one_distribution_LeaveOut_PWM_functions(X,Y);
        case 6
            load('data-starplus-05710-v7.mat')
            single_subject_classification_test
            [accuracy6, acc6]= LR_one_distribution_LeaveOut_PWM_functions(X,Y);
    end
end

acc= [accuracy1 ; accuracy2  ;accuracy3 ;accuracy4 ;accuracy5 ;accuracy6 ];
