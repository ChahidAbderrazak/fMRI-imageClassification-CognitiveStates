clear all
addpath ./Functions
addpath ./Functions/Netlab
addpath ./datasets
addpath /Users/sehrism/Documents/datasets
addpath ./Leave1out_PWM
addpath ./test

load('data-starplus-04799-v7.mat')
single_subject_classification_test
acc1= LeaveOut_PWM(X,Y);

