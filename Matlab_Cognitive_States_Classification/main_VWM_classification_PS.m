addpath ../Functions
addpath ../Functions/Netlab
% addpath /Users/sehrism/Documents/datasets
addpath ../Datasets
addpath R:\chahida\Projects-Dataset\fMRI\StarPlus2018

k_all= [];
cnt = 1;

for k=1:0.5:5
    
    for subject=1%:6
        switch(subject)
            case 1
                load('data-starplus-04799-v7.mat')
                Convert_single_subject_data_to_matrix
                [outcome, Accuracy(subject,1), Sparsity_P(subject,1), Sparsity_S(subject,1)]= Classify_LeaveOut_VWM_functions(X,Y,k);
            case 2
                load('data-starplus-04820-v7.mat')
                Convert_single_subject_data_to_matrix
                [outcome, Accuracy(subject,1), Sparsity_P(subject,1), Sparsity_S(subject,1)]= Classify_LeaveOut_VWM_functions(X,Y,k);
            case 3
                load('data-starplus-04847-v7.mat')
                Convert_single_subject_data_to_matrix
                [outcome, Accuracy(subject,1), Sparsity_P(subject), Sparsity_S(subject,1)]= Classify_LeaveOut_VWM_functions(X,Y,k);
                
            case 4
                load('data-starplus-05675-v7.mat')
                Convert_single_subject_data_to_matrix
                [outcome, Accuracy(subject,1), Sparsity_P(subject,1), Sparsity_S(subject,1)]= Classify_LeaveOut_VWM_functions(X,Y,k);
                
            case 5
                load('data-starplus-05680-v7.mat')
                Convert_single_subject_data_to_matrix
                [outcome, Accuracy(subject,1), Sparsity_P(subject,1), Sparsity_S(subject,1)]= Classify_LeaveOut_VWM_functions(X,Y,k);
                
            case 6
                load('data-starplus-05710-v7.mat')
                Convert_single_subject_data_to_matrix
                [outcome, Accuracy(subject,1), Sparsity_P(subject,1), Sparsity_S(subject,1)]= Classify_LeaveOut_VWM_functions(X,Y,k);
        end
        
%         save(strcat('k_',num2str(k),'.mat'),'k','Accuracy' ,'Sparsity_P','Accuracy_av')
        
    end
    
Accuracy_av= sum(Accuracy)/size(Accuracy,1);
Accuracy_all(cnt:cnt+5,:)= Accuracy;

Sparsity_P_all(cnt:cnt+5,:)= Sparsity_P;
Sparsity_S_all(cnt:cnt+5,:)= Sparsity_S;

k_all=[k_all k];

cnt= cnt+6;

% acc= [accuracy11 ; accuracy21  ;accuracy31 ;accuracy41 ;accuracy51 ;accuracy61];
% acc_Avg= mean(acc);
% avg_sparsity_P = mean([Sparse_P_ratio1 ;Sparse_P_ratio2;Sparse_P_ratio3;Sparse_P_ratio4;Sparse_P_ratio5;Sparse_P_ratio6]);
% avg_sparsity_S = mean([Sparse_S_ratio1;Sparse_S_ratio2;Sparse_S_ratio3;Sparse_S_ratio4;Sparse_S_ratio5;Sparse_S_ratio6]);
% acc_sparse=[acc_sparse;acc_Avg, avg_sparsity_P, avg_sparsity_S];

save(strcat('k_',num2str(k),'.mat'),'k','Accuracy' ,'Accuracy_av', 'Sparsity_P', 'Sparsity_S')

clearvars -except cnt Accuracy_all Sparsity_P_all Sparsity_S_all k_all
end

save('summary_result.mat', 'Accuracy_all', 'Sparsity_P_all', 'Sparsity_S_all', 'k_all')

