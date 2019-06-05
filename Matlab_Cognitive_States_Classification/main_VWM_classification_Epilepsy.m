
%% This script transform the subject data to a single matrix with the rows as Voxels(features) and coloumn as trials(samples)
% the  datset should be alrady loaded. ie:             load('data-starplus-04799-v7.mat')
clear all; close all
tic
%%
addpath ../Functions
addpath ../Functions/Netlab
addpath ../Functions/Functions_abderrazak
addpath ../Datasets


normalization=0; % *Normalize each trial
normalization_PWM=0; % *Normalize the input to PWM



%% load datsets
load('Epileptic_Seizure_UCI.mat')
Y=y;


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


    figure;histogram(Xp);hold on;histogram(Xn)

    % build the dataset
    X=[Xp;Xn];
    y=[yp;yn];


    %% 5-folds cross-validation
    cnt = 0;
    for k=1:0.5:5  
    cnt = cnt+1;
    [outcome, Accuracy(cnt,1), Sparsity_P(cnt,1), Sparsity_S(cnt,1)]= Classify_kfold_VWM_functions(X,y,k,sigma,mu);
    Accuracy
    end

    Accuracy_av(j)= sum(Accuracy)/size(Accuracy,1)

end

mean=mean(Accuracy_av)
var=std(Accuracy_av)^2


save('summary_result.mat', 'Accuracy', 'Sparsity_P', 'Sparsity_S', 'k')

