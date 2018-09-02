clear all
addpath ./Functions
addpath ./Functions/Netlab
addpath ./datasets
% addpath /Users/sehrism/Documents/datasets
addpath ./Leave1out_PWM
addpath ./test
addpath D:\SSI\Project\Datasets\starplus
mu=0;sigma0=2.68;
acc=[];

for i=1:0.1:5
    intervals1= mu+(i*sigma0)*[-2 -1 0 1 2]; % 1 1 1 1  0.98 1
    
    for subject=1:6
        switch(subject)
            case 1
                load('data-starplus-04799-v7.mat')
                single_subject_classification_test
                [accuracy1, Sparse_P1, Sparse_S1]= Optimal_Classify_LeaveOut_PWM_functions(X,Y,intervals1);
            case 2
                load('data-starplus-04820-v7.mat')
                single_subject_classification_test
                [accuracy2, Sparse_P2, Sparse_S2]= Optimal_Classify_LeaveOut_PWM_functions(X,Y,intervals1);
            case 3
                load('data-starplus-04847-v7.mat')
                single_subject_classification_test
                [accuracy3, Sparse_P3, Sparse_S3]= Optimal_Classify_LeaveOut_PWM_functions(X,Y,intervals1);
            case 4
                load('data-starplus-05675-v7.mat')
                single_subject_classification_test
                [accuracy4, Sparse_P4, Sparse_S4]= Optimal_Classify_LeaveOut_PWM_functions(X,Y,intervals1);
            case 5
                load('data-starplus-05680-v7.mat')
                single_subject_classification_test
                [accuracy5, Sparse_P5, Sparse_S5]= Optimal_Classify_LeaveOut_PWM_functions(X,Y,intervals1);
            case 6
                load('data-starplus-05710-v7.mat')
                single_subject_classification_test
                [accuracy6, Sparse_P6, Sparse_S6]= Optimal_Classify_LeaveOut_PWM_functions(X,Y,intervals1);
        end
    end
    clear acc1
    acc1= [i Sparse_P1 Sparse_S1 accuracy1 ;i , Sparse_P2 Sparse_S2 accuracy2; i Sparse_P3 Sparse_S3 accuracy3; i Sparse_P4 Sparse_S4 accuracy4; i Sparse_P5 Sparse_S5 accuracy5; i Sparse_P6 Sparse_S6 accuracy6];
    acc= [acc; acc1];
end
    

% load('data-starplus-05710-v7.mat')
% single_subject_classification_test
% [outcome, accuracy1, accuracy2]= Optimal_Classify_LeaveOut_PWM_functions(X,Y);
% % acc = Old_LeaveOut_PWM(X,Y);
% % [acc,outcome]= Generate_PWM(X,Y);