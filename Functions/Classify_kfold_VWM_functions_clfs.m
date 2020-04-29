% Classify the VWM using Leave one sample out and returns the classificatiom accurcay
function [outcome, Sparse_P_ratio, Sparse_S_ratio, Accuracy,Sensitivity,Specificity,Precision,Gmean,F1score]= Classify_kfold_VWM_functions_clfs(X,Y,M,sigma0,mu0,List_classifiers)

catogries1= 1:M;
levels=size(catogries1,2);

% intervals1= mu0+k*sigma0*[-5 -4 -3 -2 -1 0 1 2 3 4 5]; % 1 1 1 1  0.9875 1

intervals1=linspace(mu0-3*sigma0, mu0+3*sigma0, levels-1);
%% Leave one sample Out Cross-Validation
K=10;
C = cvpartition(Y, 'KFold',K);

for num_fold = 1:C.NumTestSets
    clearvars -except List_classifiers accuracy sensitivity specificity precision gmean f1score X Y catogries1 catogries1 VWM_P VWM_S intervals1 intervals1 acc1 num_fold C outcome outcome2 outcome classPrior accuracy11 accuracy21 accuracy31 accuracy41 accuracy51 accuracy61
    
    trIdx = C.training(num_fold);
    teIdx = C.test(num_fold);
    Idx= find(teIdx);
    X_train= X(trIdx,:);
    X_test= X(teIdx,:);
    
    Y_train= Y(trIdx);
    Y_test= Y(teIdx);
    
    Xp=X_train(Y_train==1,:);   Np=size(Xp, 1);
    Xs=X_train(Y_train==2,:);   Ns=size(Xs, 1);
    
    Qp= mapping_levels(Xp,intervals1, catogries1);
    Qs= mapping_levels(Xs,intervals1, catogries1);
    
    VWM_P = Generate_VWM_matrix(Qp, catogries1);
    VWM_S = Generate_VWM_matrix(Qs, catogries1);
    
    X_train_levels=[Qp;Qs];
    levels=unique(X_train_levels);

    
    VWM_f_train= Generate_VWM_features(X_train_levels, VWM_P, VWM_S,levels);
    
    X_test_levels= mapping_levels(X_test, intervals1, catogries1);
    VWM_fP_test= Generate_VWM_features(X_test_levels, VWM_P, VWM_S,levels);


    %% Train and test the model
     %% Train and test the model
    zz=1;
    for clf = List_classifiers

        [classifier] = trainClassifier(VWM_f_train,Y_train, char(clf));   %train classifier
    %     [classifier] = trainClassifier(X_VWM_train,Y_train, 'logisticRegression');   %train classifier

        %% Test the model
        [predictions1] = applyClassifier(VWM_fP_test, classifier);       %test it
    %     [predictions1] = applyClassifier(X_VWM_test, classifier);       %test it

        [result1,predictedLabels1,trace1] = summarizePredictions(predictions1,classifier,'averageRank',Y_test);
    %     acc1(num_fold)= 1-result1{1};  % rank accuracy
    %     err=Y_test-predictedLabels1;
    %     acc=sum(err==0)/size(predictedLabels1,1)


        [accuracy(zz,num_fold),sensitivity(zz,num_fold),specificity(zz,num_fold),precision(zz,num_fold),gmean(zz,num_fold),f1score(zz,num_fold)]=prediction_performance(Y_test, predictedLabels1);
    
    
        zz=zz+1;
    end
end


outcome(num_fold,:)=[accuracy,sensitivity,specificity,precision,gmean,f1score];

%% Average Accuracy 
Accuracy= sum(accuracy)/C.NumTestSets;
Sensitivity= sum(sensitivity)/C.NumTestSets;
Specificity= sum(specificity)/C.NumTestSets;
Precision= sum(precision)/C.NumTestSets;
Gmean= sum(gmean)/C.NumTestSets;
F1score= sum(f1score)/C.NumTestSets;

%% Find the sparsity of PWM
Sparse_P= nnz(~VWM_P);
Sparse_S= nnz(~VWM_S);
Sparse_P_ratio= (Sparse_P/(size(VWM_P,1)*size(VWM_P,2)))*100;
Sparse_S_ratio= (Sparse_S/(size(VWM_S,1)*size(VWM_S,2)))*100;
end

%% Funtions
%% Replace each voxel intensity by integer number for each of the specified intervals
% % function Q=mapping_levels(X,intervals, catogries)
% % Q=0*X;
% % if size(catogries,2) ==4
% %     
% %     for i=1:size(X,1)
% %         
% %         for j=1:size(X,2)
% %             if X(i,j) <= intervals(1)
% %                 Q(i,j)= catogries(1);
% %             elseif X(i,j) <= intervals(2)
% %                 Q(i,j)= catogries(2);
% %             elseif X(i,j) <= intervals(3)
% %                 Q(i,j)= catogries(3);
% %             else
% %                 Q(i,j)= catogries(4);
% %             end
% %         end
% %     end
% % 
% % elseif size(catogries,2) ==5
% %     for i=1:size(X,1)
% %         for j=1:size(X,2)
% %             if X(i,j) <= intervals(1)
% %                 Q(i,j)= catogries(1);
% %             elseif X(i,j) <= intervals(2)
% %                 Q(i,j)= catogries(2);
% %             elseif X(i,j) <= intervals(3)
% %                 Q(i,j)= catogries(3);
% %             elseif X(i,j) <= intervals(4)
% %                 Q(i,j)= catogries(4);
% %             else
% %                 Q(i,j)= catogries(5);
% %             end
% %         end
% %     end
% % elseif size(catogries,2) ==6
% %     
% %     for i=1:size(X,1)
% %         for j=1:size(X,2)
% %             if X(i,j) <= intervals(1)
% %                 Q(i,j)= catogries(1);
% %             elseif X(i,j) <= intervals(2)
% %                 Q(i,j)= catogries(2);
% %             elseif X(i,j) <= intervals(3)
% %                 Q(i,j)= catogries(3);
% %             elseif X(i,j) <= intervals(4)
% %                 Q(i,j)= catogries(4);
% %             elseif X(i,j) <= intervals(5)
% %                 Q(i,j)= catogries(5);
% %             else
% %                 Q(i,j)= catogries(6);
% %             end
% % %             i
% % %             j
% % %             Q(i,j)
% %         end
% %     end
% %     
% % elseif size(catogries,2) ==8
% %     
% %     for i=1:size(X,1)
% %         for j=1:size(X,2)
% %             if X(i,j) <= intervals(1)
% %                 Q(i,j)= catogries(1);
% %             elseif X(i,j) <= intervals(2)
% %                 Q(i,j)= catogries(2);
% %             elseif X(i,j) <= intervals(3)
% %                 Q(i,j)= catogries(3);
% %             elseif X(i,j) <= intervals(4)
% %                 Q(i,j)= catogries(4);
% %             elseif X(i,j) <= intervals(5)
% %                 Q(i,j)= catogries(5);
% %             elseif X(i,j) <= intervals(6)
% %                 Q(i,j)= catogries(6);
% %             elseif X(i,j) <= intervals(7)
% %                 Q(i,j)= catogries(7);
% %             else
% %                 Q(i,j)= catogries(8);
% %             end
% % %             i
% % %             j
% % %             Q(i,j)
% %         end
% %     end
% % end
% % 
% % end
%% Computes the Voxel Probability Matrix (VPM)
function VWM_matrix= Generate_VWM_matrix(X_train, catogries)
catogries=size(catogries,2);
VWM_matrix= zeros(5, size(X_train,2));

for k=1:catogries
    for i=1:size(X_train, 2)
        VWM_matrix(k,i)= sum(X_train(:, i) == k)/size(X_train,1);
    end
end


end
%% Converts the VPM to Voxel Weight Matrix (VWM)
function VWM_features= Generate_VWM_features(X_train, VWM_P, VWM_S,levels)
    
VWM_f1= zeros(size(X_train,1), size(X_train,2)); %f1 is the first feature of VWM
VWM_f2= zeros(size(X_train,1), size(X_train,2)); %f1 is the second feature of VWM

% replace the integer values by its probability from VPM

VWM_fp=zeros(size(X_train,1), size(levels,1));
VWM_fn=zeros(size(X_train,1), size(levels,1));

for i=1:size(X_train,1)
    for j=1:size(X_train,2)
        VWM_idx=X_train(i,j);
        VWM_f1(i,j)= VWM_P(VWM_idx,j);
        VWM_f2(i,j)= VWM_S(VWM_idx,j);
        
        %% seperate features-levels
        VWM_fp(i,VWM_idx)=VWM_fp(i,VWM_idx)+VWM_P(VWM_idx,j);
        VWM_fn(i,VWM_idx)=VWM_fn(i,VWM_idx)+VWM_S(VWM_idx,j);

        
        
        
    end
end

% % sum all the probabilities to get the VWM
% f1=sum(VWM_P,2);
% f2=sum(VWM_S,2);
% 
% figure;
% for k=1:6
%     lgnd{k}=strcat('level',num2str(k));
% plot(VWM_P(k,:))
% hold on
% xlabel('position')
% legend(lgnd)
% end

% VWM_features=[VWM_fp VWM_fn];

f1=sum(VWM_f1,2);
f2=sum(VWM_f2,2);
% VWM_features=[f1 f2 ];

VWM_features=[f1 VWM_fp VWM_fn f2];



end