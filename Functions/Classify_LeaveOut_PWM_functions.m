function [PWM, acc, outcome] = Classify_LeaveOut_PWM_functions(X,Y)
addpath ./Leave1out_PWM

% global PWM_P PWM_S
catogries= 5;

C = cvpartition(Y, 'LeaveOut');
intervals1= [-2 -1 0 1];
intervals2= [-2 -1 0 1];

for num_fold = 1:C.NumTestSets
    clearvars -except X Y catogries PWM_P PWM_S D1 D2 acc1 acc2 num_fold C outcome1 outcome2
    
    trIdx = C.training(num_fold);
    teIdx = C.test(num_fold);
    Idx= find(teIdx);
    X_train= X(trIdx,:);
    X_test= X(teIdx,:);
    Y_train= Y(trIdx);
    Y_test= Y(teIdx);

    Xp=X_train(Y_train==1,:);   Np=size(Xp, 1);
    Xs=X_train(Y_train==2,:);   Ns=size(Xs, 1);
    
    Xp= mapping_levels(Xp,intervals1);
    Xs= mapping_levels(Xs,intervals2);

    PWM_P = Generate_PWM_matrix(Xp, intervals1);
    PWM_S = Generate_PWM_matrix(Xs, intervals2);

    X_train_levels=[Xp;Xs];
    Y_train=[ones(1,size(Xp),1); 2*ones(1,size(Xs),1)];
    PWM_f_train= Generate_PWM_features(X_train_levels, PWM_P, PWM_S);

    X_test_P = Generate_PWM_S(X_test, D1);
    X_test_S = Generate_PWM_S(X_test, D2);
        
    %% Train and test the model 
    [classifier] = trainClassifier(PWM_f_train,Y_train, 'nbayes');   %train classifier


    %% Test1 the model 
    if Y_test==1
        PWM_test= Generate_PWM_features(X_test_P, PWM_P, PWM_S);
    else
        PWM_test= Generate_PWM_features(X_test_S, PWM_P, PWM_S);

    end


    [predictions] = applyClassifier(PWM_test, classifier);       %test it
    [result,predictedLabels,trace] = summarizePredictions(predictions,classifier,'averageRank',Y_test);
    acc(num_fold)= 1-result{1};  % rank accuracy



%         %% Test1 the model 
%         PWM_fP_test= Generate_PWM_features(X_test_P, PWM_P, PWM_S);
%         [predictions1] = applyClassifier(PWM_fP_test, classifier);       %test it
%         [result1,predictedLabels1,trace1] = summarizePredictions(predictions1,classifier,'averageRank',Y_test);
%         acc1(num_fold)= 1-result1{1};  % rank accuracy
%         outcome1(num_fold,:)=[Y_test  acc1(num_fold) classPrior];
%         
%         
%        %% Test1 the model 
%         PWM_fS_test= Generate_PWM_features(X_test_S, PWM_P, PWM_S);
%         [predictions2] = applyClassifier(PWM_fS_test, classifier);       %test it
%         [result2,predictedLabels2,trace2] = summarizePredictions(predictions1,classifier,'averageRank',Y_test);
%         acc2(num_fold)= 1-result2{1};  % rank accuracy
%         outcome2(num_fold,:)=[Y_test  acc2(num_fold) classPrior];
%         
        

  
end
outcome= [outcome1, outcome2];
acc(1)= sum(acc1)/sum(C.TestSize);
acc(2)= sum(acc2)/sum(C.TestSize);
end

%% Funtions

function X=mapping_levels(X,intervals)


    for i=1:size(X,1)
        for j=1:size(X,2)
            for k=1:max(size(intervals))
                if X(i,j) <= intervals(k)
                    X(i,j)= k;
                elseif X(i,j) > intervals(end)
                    X(i,j)= max(size(intervals))+1;
                end

            end
        end
    end

end

function PWM_matrix= Generate_PWM_matrix(X_train, intervals)
catogries=max(size(intervals))+1;
PWM_matrix= zeros(catogries, size(X_train,2)); %The weight matrix of picture



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


function X_test= Map_test_D1(X_test, D1)
for j=1:size(X_test,2)
    if X_test(:,j) <= D1(1)
        X_test(:,j)= 1;
    elseif X_test(:,j) <= D1(2)
        X_test(:,j)= 2;
    elseif X_test(:,j) <= D1(3)
        X_test(:,j)= 3;
    elseif X_test(:,j) < D1(4)
        X_test(:,j)= 4;
    else
        X_test(:,j)= 5;
    end
end


end
function X_test= Map_test_D2(X_test, D2)
for j=1:size(X_test,2)
    if X_test(:,j) <= D2(1)
        X_test(:,j)= 1;
    elseif X_test(:,j) <= D2(2)
        X_test(:,j)= 2;
    elseif X_test(:,j) <= D2(3)
        X_test(:,j)= 3;
    elseif X_test(:,j) < D2(4)
        X_test(:,j)= 3;
    else
        X_test(:,j)= 4;
    end
end
end

function [PWM_f1, PWM_f2]= Generate_PWM_test(X_test, PWM_P,PWM_S)
PWM_test= zeros(2, size(X_test,2));

for i=1:size(X_test,2)
    if X_test(1,i)==1
        PWM_test(1,i)= PWM_P(1,i);
        PWM_test(2,i)= PWM_S(1,i);
    elseif X_test(1,i)==2
        PWM_test(1,i)= PWM_P(2,i);
        PWM_test(2,i)= PWM_S(2,i);
    elseif X_test(1,i)==3
        PWM_test(1,i)= PWM_P(3,i);
        PWM_test(2,i)= PWM_S(3,i);
    elseif X_test(1,i)==4
        PWM_test(1,i)= PWM_P(4,i);
        PWM_test(2,i)= PWM_S(4,i);
    elseif X_test(1,i)==5
        PWM_test(1,i)= PWM_P(5,i);
        PWM_test(2,i)= PWM_S(5,i);
    end
end

%sum the test(sentence) columns to obtain the PWM feature
PWM_f1(1,1)= sum(PWM_test(1,:)); %+ve
PWM_f2(2,1)= sum(PWM_test(2,:)); %-ve
end
