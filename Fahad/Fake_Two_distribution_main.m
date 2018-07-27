clear all
addpath ./Functions
addpath ./Functions/Netlab
addpath ./datasets
% addpath /Users/sehrism/Documents/datasets
addpath ./Leave1out_PWM
addpath ./test
for subject=1:6
    switch(subject)
        case 1
            load('data-starplus-04799-v7.mat')
            single_subject_classification_test
            acc1= Fake_Two_distribution_Classify_LeaveOut_PWM_functions(X,Y);
        case 2
            load('data-starplus-04820-v7.mat')
            single_subject_classification_test
            acc2= Fake_Two_distribution_Classify_LeaveOut_PWM_functions(X,Y);
        case 3
            load('data-starplus-04847-v7.mat')
            single_subject_classification_test
            acc3= Fake_Two_distribution_Classify_LeaveOut_PWM_functions(X,Y);
        case 4
            load('data-starplus-05675-v7.mat')
            single_subject_classification_test
            acc4= Fake_Two_distribution_Classify_LeaveOut_PWM_functions(X,Y);
        case 5
            load('data-starplus-05680-v7.mat')
            single_subject_classification_test
            acc5= Fake_Two_distribution_Classify_LeaveOut_PWM_functions(X,Y);
        case 6
            load('data-starplus-05710-v7.mat')
            single_subject_classification_test
            acc6= Fake_Two_distribution_Classify_LeaveOut_PWM_functions(X,Y);
    end
end

acc= [acc1; acc2; acc3; acc4; acc5; acc6];

