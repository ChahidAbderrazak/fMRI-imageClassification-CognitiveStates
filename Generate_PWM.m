% single_subject_classification_test
function acc = Generate_PWM(X,Y)
addpath ./Leave1out_PWM


% global PWM_P PWM_S
%% Replace each value in X by its category
for i=1:size(X(1:40,:),1)
    for j=1:size(X,2)
        if X(i,j) <= -3
            X(i,j)= 1;
        elseif X(i,j) <= -1
            X(i,j)= 2;
        elseif X(i,j) <= 1
            X(i,j)= 3;
%         elseif X(i,j) < 3
%             X(i,j)= 4;
        else 
            X(i,j)= 4;
        end
    end
end

% for i=1:size(X(1:40,:),1)
%     for j=1:size(X,2)
%         if X(i,j) <= -2
%             X(i,j)= 1;
%         elseif X(i,j) <= -1
%             X(i,j)= 2;
%         elseif X(i,j) <= 0
%             X(i,j)= 3;
%         elseif X(i,j) < 3.5
%             X(i,j)= 4;
%         else 
%             X(i,j)= 5;
%         end
%     end
% end
% 
% for i=41:size(X,1)
%     for j=1:size(X,2)
%         if X(i,j) <= -2
%             X(i,j)= 1;
%         elseif X(i,j) <= -1
%             X(i,j)= 2;
%         elseif X(i,j) <= 0
%             X(i,j)= 3;
%         elseif X(i,j) < 3.5
%             X(i,j)= 4;
%         else 
%             X(i,j)= 5;
%         end
%     end
% end


for i=41:size(X,1)
    for j=1:size(X,2)
        if X(i,j) <= -3
            X(i,j)= 1;
        elseif X(i,j) <= -1
            X(i,j)= 2;
        elseif X(i,j) <= 1
            X(i,j)= 3;
%         elseif X(i,j) < 3
%             X(i,j)= 4;
        else 
            X(i,j)= 5;
        end
    end
end

catogries= 5;


C = cvpartition(Y, 'LeaveOut');

for num_fold = 1:C.NumTestSets
    clearvars -except X Y catogries PWM_P PWM_S acc1 num_fold C
    PWM_P= zeros(catogries, size(X,2)); %The weight matrix of picture
    PWM_S= zeros(catogries, size(X,2)); %The weight matrix of sentence
    PWM= zeros(size(X,1),2); %The weight
    
    trIdx = C.training(num_fold);
    teIdx = C.test(num_fold);
    Idx= find(teIdx);
    X_train= X(trIdx,:);
    X_test= X(teIdx,:);
    Y_train= Y(trIdx);
    Y_test= Y(teIdx);
    
    Xp=X_train(Y_train==1,:);
    Xs=X_train(Y_train==2,:);
    
    for k=1:catogries
        for i=1:size(X_train, 2)
            PWM_P(k,i)= sum(Xp(:, i) == 1)/40;
            PWM_S(k,i)= sum(Xs(:, i) == 1)/40;
        end
    end    
    
    
    
    

        for i=1:size(X_train,1)
            for j=1:size(X_train,2)
                    pwm_idx=X_train(i,j);
                    PWM_f1(i,j)= PWM_P(pwm_idx,j);
                    PWM_f2(i,j)= PWM_S(pwm_idx,j);
            end
        end
        
    
%                 
%         
%         for i=1:size(PWM_P_ex,1)
%             PWM_ex(i,1)=sum(PWM_P_ex(i,:));
%         end
%         
%         for i=1:size(PWM_S_ex,1)
%             PWM_ex(i,2)=sum(PWM_S_ex(i,:));
%         end
%         %sum the test(sentence) columns to obtain the PWM feature
%         PWM_ex_test(1,1)= sum(PWM_S_ex_test(1,:)); %+ve
%         PWM_ex_test(2,1)= sum(PWM_S_ex_test(2,:)); %-ve
% 
%         PWM(1:40,1)=PWM_ex(1:40,1);
%         PWM(1:40,2)=PWM_ex(41:80,1);
%         PWM(41:79,1)=PWM_ex(1:39,2);
%         PWM(41:79,2)=PWM_ex(40:78,2);
%         PWM(80,1)= PWM_ex_test(1,1);
%         PWM(80,2)= PWM_ex_test(2,1);
%         
% % the test from a picture sample
% 
%                 
%         for i=1:size(PWM_P_ex,1)
%             PWM_ex(i,1)=sum(PWM_P_ex(i,:));
%         end
%         
%         for i=1:size(PWM_S_ex,1)
%             PWM_ex(i,2)=sum(PWM_S_ex(i,:));
%         end
%         
%         %sum the test(picture) columns to obtain the PWM feature
%         PWM_ex_test(1,1)= sum(PWM_P_ex_test(1,:)); %+ve
%         PWM_ex_test(2,1)= sum(PWM_P_ex_test(2,:)); %-ve
% 
%         PWM(1:39,1)=PWM_ex(1:39,1);
%         PWM(1:39,2)=PWM_ex(40:78,1);
%         PWM(40:79,1)=PWM_ex(1:40,2);
%         PWM(40:79,2)=PWM_ex(41:80,2);
%         PWM(80,1)= PWM_ex_test(1,1);
%         PWM(80,2)= PWM_ex_test(2,1);
%         
%     end
%     
%     [classifier] = trainClassifier(PWM(1:79,:),Y_train, 'nbayes');   %train classifier
%     [predictions] = applyClassifier(PWM(80,:), classifier);       %test it
%     [result,predictedLabels,trace] = summarizePredictions(predictions,classifier,'averageRank',Y_test);
%     acc1(num_fold)= 1-result{1};  % rank accuracy
% 
%         
end

acc=2;% sum(acc1)/sum(C.TestSize);
