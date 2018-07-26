clear all
addpath ./Functions
addpath ./Functions/Netlab
addpath ./datasets
% addpath /Users/sehrism/Documents/datasets
addpath ./Leave1out_PWM
addpath ./test
addpath D:\SSI\Project\Datasets\starplus

load('data-starplus-04799-v7.mat')
single_subject_classification_test
[PWM, acc, outcome]= Classify_LeaveOut_PWM_functions(X,Y);
% acc = Old_LeaveOut_PWM(X,Y);
% [acc,outcome]= Generate_PWM(X,Y);