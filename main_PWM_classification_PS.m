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
            [outcome, accuracy11]= Classify_LeaveOut_PWM_functions(X,Y);
            X_P_vec1= X_P(:);
            X_S_vec1= X_S(:);
            pd_p1= fitdist(X_P_vec1,'Normal');
            pd_s1= fitdist(X_S_vec1,'Normal');
        case 2
            load('data-starplus-04820-v7.mat')
            single_subject_classification_test
            [outcome, accuracy21 ]= Classify_LeaveOut_PWM_functions(X,Y);
            X_P_vec2= X_P(:);
            X_S_vec2= X_S(:);  
            pd_p2= fitdist(X_P_vec2,'Normal');
            pd_s2= fitdist(X_S_vec2,'Normal');

        case 3
            load('data-starplus-04847-v7.mat')
            single_subject_classification_test
            [outcome, accuracy31]= Classify_LeaveOut_PWM_functions(X,Y);
            X_P_vec3= X_P(:);
            X_S_vec3= X_S(:);  
            pd_p3= fitdist(X_P_vec3,'Normal');
            pd_s3= fitdist(X_S_vec3,'Normal');

        case 4
            load('data-starplus-05675-v7.mat')
            single_subject_classification_test
            [outcome, accuracy41]= Classify_LeaveOut_PWM_functions(X,Y);
            X_P_vec4= X_P(:);
            X_S_vec4= X_S(:);
            pd_p4= fitdist(X_P_vec4,'Normal');
            pd_s4= fitdist(X_S_vec4,'Normal');
        case 5
            load('data-starplus-05680-v7.mat')
            single_subject_classification_test
            [outcome, accuracy51]= Classify_LeaveOut_PWM_functions(X,Y);
            X_P_vec5= X_P(:);
            X_S_vec5= X_S(:);
            pd_p5= fitdist(X_P_vec5,'Normal');
            pd_s5= fitdist(X_S_vec5,'Normal');
            
        case 6
            load('data-starplus-05710-v7.mat')
            single_subject_classification_test
            [outcome, accuracy61]= Classify_LeaveOut_PWM_functions(X,Y);
            X_P_vec6= X_P(:);
            X_S_vec6= X_S(:);
            pd_p6= fitdist(X_P_vec6,'Normal');
            pd_s6= fitdist(X_S_vec6,'Normal');
    end
end

acc= [accuracy11 ; accuracy21  ;accuracy31 ;accuracy41 ;accuracy51 ;accuracy61 ];

% load('data-starplus-05710-v7.mat')
% single_subject_classification_test
% [outcome, accuracy1, accuracy2]= Classify_LeaveOut_PWM_functions(X,Y);
% % acc = Old_LeaveOut_PWM(X,Y);
% % [acc,outcome]= Generate_PWM(X,Y);