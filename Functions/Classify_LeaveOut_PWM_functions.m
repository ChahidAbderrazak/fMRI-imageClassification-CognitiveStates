function [outcome, accuracy1, accuracy2]= Classify_LeaveOut_PWM_functions(X,Y)
addpath ./Leave1out_PWM

% global PWM_P PWM_S
catogries1= [1 2 3 4 5];
catogries2= [1 2 3 4];
PWM_t=[];

C = cvpartition(Y, 'LeaveOut');
intervals1= [-1 -1 -0.6 1 3];
intervals2= [-1 -1 0.6 3];
for num_fold = 1:C.NumTestSets
    clearvars -except X Y catogries1 catogries2 PWM_P PWM_S intervals1 intervals2 acc1 acc2 num_fold C outcome1 outcome2 outcome classPrior
    
    trIdx = C.training(num_fold);
    teIdx = C.test(num_fold);
    Idx= find(teIdx);
    X_train= X(trIdx,:);
    X_test= X(teIdx,:);
    Y_train= Y(trIdx);
    Y_test= Y(teIdx);
    
    Xp=X_train(Y_train==1,:);   Np=size(Xp, 1);
    Xs=X_train(Y_train==2,:);   Ns=size(Xs, 1);
    
    Xp= mapping_levels(Xp,intervals1, catogries1);
    Xs= mapping_levels(Xs,intervals2, catogries2);
    
    PWM_P = Generate_PWM_matrix(Xp, intervals1);
    PWM_S = Generate_PWM_matrix(Xs, intervals2);
    
    X_train_levels=[Xp;Xs];
    Y_train=[ones(size(Xp,1),1); 2*ones(size(Xs,1),1)];
    PWM_f_train= Generate_PWM_features(X_train_levels, PWM_P, PWM_S);
    X_test_P= Map_test_intervals1(X_test, intervals1);
    X_test_S= Map_test_intervals2(X_test, intervals2);
    
    %     [PWM_f1, PWM_f2]= Generate_PWM_test(X_test, PWM_P,PWM_S);
    %% Train and test the model
    [classifier] = trainClassifier(PWM_f_train,Y_train, 'nbayes');   %train classifier
    
    %     %% Test1 the model
    %     if Y_test==1
    %         PWM_test= Generate_PWM_test(X_test_P, PWM_P,PWM_S);
    %     else
    %         PWM_test= Generate_PWM_test(X_test_S, PWM_P, PWM_S);
    %     end
    %     PWM_t=[PWM_t;PWM_test];
    %     [predictions] = applyClassifier(PWM_test, classifier);       %test it
    %     [result,predictedLabels,trace] = summarizePredictions(predictions,classifier,'averageRank',Y_test);
    %     acc1(num_fold)= 1-result{1};  % rank accuracy
    
    %% Test1 the model
    PWM_fP_test= Generate_PWM_test(X_test_P, PWM_P, PWM_S);
    [predictions1] = applyClassifier(PWM_fP_test, classifier);       %test it
    [result1,predictedLabels1,trace1] = summarizePredictions(predictions1,classifier,'averageRank',Y_test);
    global classPrior
    acc1(num_fold)= 1-result1{1};  % rank accuracy
    outcome1(num_fold,:)=[Y_test  acc1(num_fold) classPrior];
    
    
    %% Test2 the model
    PWM_fS_test= Generate_PWM_test(X_test_S, PWM_P, PWM_S);
    [predictions2] = applyClassifier(PWM_fS_test, classifier);       %test it
    [result2,predictedLabels2,trace2] = summarizePredictions(predictions2,classifier,'averageRank',Y_test);
    acc2(num_fold)= 1-result2{1};  % rank accuracy
    outcome2(num_fold,:)=[Y_test  acc2(num_fold) classPrior];
end
% acc= sum(acc1)/sum(C.TestSize);
outcome= [outcome1, outcome2];
accuracy1= sum(acc1)/sum(C.TestSize);
accuracy2= sum(acc2)/sum(C.TestSize);

end

%% Funtions

function X=mapping_levels(X,intervals, catogries)

if size(catogries,2) ==4
    for i=1:size(X,1)
        for j=1:size(X,2)
            if X(i,j) <= intervals(1)
                X(i,j)= catogries(1);
            elseif X(i,j) <= intervals(2)
                X(i,j)= catogries(2);
            elseif X(i,j) <= intervals(3)
                X(i,j)= catogries(3);
            else
                X(i,j)= catogries(4);
            end
        end
    end

elseif size(catogries,2) ==5
    for i=1:size(X,1)
        for j=1:size(X,2)
            if X(i,j) <= intervals(1)
                X(i,j)= catogries(1);
            elseif X(i,j) <= intervals(2)
                X(i,j)= catogries(2);
            elseif X(i,j) <= intervals(3)
                X(i,j)= catogries(3);
            elseif X(i,j) <= intervals(4)
                X(i,j)= catogries(4);
            else
                X(i,j)= catogries(5);
            end
        end
    end
end
end

function PWM_matrix= Generate_PWM_matrix(X_train, intervals)
catogries=size(intervals,2);
PWM_matrix= zeros(5, size(X_train,2)); %The weight matrix of picture

for k=1:catogries
    for i=1:size(X_train, 2)
        PWM_matrix(k,i)= sum(X_train(:, i) == k)/40;
    end
end


end

function PWM_features= Generate_PWM_features(X_train, PWM_P, PWM_S)
    
PWM_f1= zeros(size(X_train,1), size(X_train,2));
PWM_f2= zeros(size(X_train,1), size(X_train,2));


for i=1:size(X_train,1)
    for j=1:size(X_train,2)
        pwm_idx=X_train(i,j);
        PWM_f1(i,j)= PWM_P(pwm_idx,j);
        PWM_f2(i,j)= PWM_S(pwm_idx,j);
    end
end

f1=sum(PWM_f1,2);
f2=sum(PWM_f2,2);
PWM_features=[f1 f2];

end

function X_test= Map_test_intervals1(X_test, intervals)
for j=1:size(X_test,2)
    if X_test(:,j) <= intervals(1)
        X_test(:,j)= 1;
    elseif X_test(:,j) <= intervals(2)
        X_test(:,j)= 2;
    elseif X_test(:,j) <= intervals(3)
        X_test(:,j)= 3;
    elseif X_test(:,j) < intervals(4)
        X_test(:,j)= 4;
    else
        X_test(:,j)= 5;
    end
end


end
function X_test= Map_test_intervals2(X_test, intervals)
for j=1:size(X_test,2)
    if X_test(:,j) <= intervals(1)
        X_test(:,j)= 1;
    elseif X_test(:,j) <= intervals(2)
        X_test(:,j)= 2;
    elseif X_test(:,j) <= intervals(3)
        X_test(:,j)= 3;
    elseif X_test(:,j) < intervals(4)
        X_test(:,j)= 3;
    else
        X_test(:,j)= 4;
    end
end
end

function X_PWM_test= Generate_PWM_test(X_test, PWM_P,PWM_S)
PWM_f1= zeros(size(X_test,1),size(X_test,2));
PWM_f2= zeros(size(X_test,1),size(X_test,2));

for j=1:size(X_test,2)
    pwm_idx=X_test(:,j);
    PWM_f1(:,j)= PWM_P(pwm_idx,j);
    PWM_f2(:,j)= PWM_S(pwm_idx,j);
end

%sum the test(sentence) columns to obtain the PWM feature
f1= sum(PWM_f1(1,:)); %+ve
f2= sum(PWM_f2(1,:)); %-ve

X_PWM_test= [f1 f2];
end
