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
            [outcome, accuracy11, accuracy12]= Classify_LeaveOut_PWM_functions(X,Y);
        case 2
            load('data-starplus-04820-v7.mat')
            single_subject_classification_test
            [outcome, accuracy21, accuracy22]= Classify_LeaveOut_PWM_functions(X,Y);
        case 3
            load('data-starplus-04847-v7.mat')
            single_subject_classification_test
            [outcome, accuracy31, accuracy32]= Classify_LeaveOut_PWM_functions(X,Y);
        case 4
            load('data-starplus-05675-v7.mat')
            single_subject_classification_test
            [outcome, accuracy41, accuracy42]= Classify_LeaveOut_PWM_functions(X,Y);
        case 5
            load('data-starplus-05680-v7.mat')
            single_subject_classification_test
            [outcome, accuracy51, accuracy52]= Classify_LeaveOut_PWM_functions(X,Y);
        case 6
            load('data-starplus-05710-v7.mat')
            single_subject_classification_test
            [outcome, accuracy61, accuracy62]= Classify_LeaveOut_PWM_functions(X,Y);
    end
end

acc= [accuracy11 accuracy12; accuracy21 accuracy22 ;accuracy31 accuracy32;accuracy41 accuracy42;accuracy51 accuracy52;accuracy61 accuracy62];

% load('data-starplus-05710-v7.mat')
% single_subject_classification_test
% [outcome, accuracy1, accuracy2]= Classify_LeaveOut_PWM_functions(X,Y);
% % acc = Old_LeaveOut_PWM(X,Y);
% % [acc,outcome]= Generate_PWM(X,Y);