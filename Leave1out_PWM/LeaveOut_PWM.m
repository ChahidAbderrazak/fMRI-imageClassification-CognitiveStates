function PWM= Generate_PWM(X,Y)
global PWM_P PWM_S
for i=1:size(X,1)
    for j=1:size(X,2)
        if X(i,j) <= -3
            X(i,j)= 1;
        elseif X(i,j) <= -1
            X(i,j)= 2;
        elseif X(i,j) <= 1
            X(i,j)= 3;
        elseif X(i,j) < 3
            X(i,j)= 4;
        else 
            X(i,j)= 5;
        end
    end
end

PWM_P= zeros(catogries, size(X,2));
PWM_S= zeros(catogries, size(X,2));
PWM= zeros(size(X,1),2);

C = cvpartition(Y, 'LeaveOut');

for num_fold = 1:C.NumTestSets
    trIdx = C.training(num_fold);
    teIdx = C.test(num_fold);
    Idx= find(teIdx);
    X_train= X(trIdx);
    X_test= X(teIdx);
    Y_train= Y(trIdx);
    Y_test= Y(teIdx);
    if (Idx>=41) && (Idx<=80)
        
        for i=1:size(X_train, 2)
            PWM_P(1,i)= sum(X_train(1:40, i) == 1)/size(X_train,1);
            PWM_P(2,i)= sum(X_train(1:40, i) == 2)/size(X_train,1);
            PWM_P(3,i)= sum(X_train(1:40, i) == 3)/size(X_train,1);
            PWM_P(4,i)= sum(X_train(1:40, i) == 4)/size(X_train,1);
            PWM_P(5,i)= sum(X_train(1:40, i) == 5)/size(X_train,1);
        end
        
        for i=1:size(X_train, 2)
            PWM_S(1,i)= sum(X_train(1:39, i) == 1)/(size(X_train,1)-1);
            PWM_S(2,i)= sum(X_train(1:39, i) == 2)/(size(X_train,1)-1);
            PWM_S(3,i)= sum(X_train(1:39, i) == 3)/(size(X_train,1)-1);
            PWM_S(4,i)= sum(X_train(1:39, i) == 4)/(size(X_train,1)-1);
            PWM_S(5,i)= sum(X_train(1:39, i) == 5)/(size(X_train,1)-1);
        end
        
    else
        for i=1:size(X_train, 2)
            PWM_P(1,i)= sum(X_train(1:39, i) == 1)/(size(X_train,1)-1);
            PWM_P(2,i)= sum(X_train(1:39, i) == 2)/(size(X_train,1)-1);
            PWM_P(3,i)= sum(X_train(1:39, i) == 3)/(size(X_train,1)-1);
            PWM_P(4,i)= sum(X_train(1:39, i) == 4)/(size(X_train,1)-1);
            PWM_P(5,i)= sum(X_train(1:39, i) == 5)/(size(X_train,1)-1);
        end
        
        for i=1:size(X_train, 2)
            PWM_S(1,i)= sum(X_train(1:40, i) == 1)/size(X_train,1);
            PWM_S(2,i)= sum(X_train(1:40, i) == 2)/size(X_train,1);
            PWM_S(3,i)= sum(X_train(1:40, i) == 3)/size(X_train,1);
            PWM_S(4,i)= sum(X_train(1:40, i) == 4)/size(X_train,1);
            PWM_S(5,i)= sum(X_train(1:40, i) == 5)/size(X_train,1);
        end 
    end
    
% the test from a sentence sample
    if (Idx>=41) && (Idx<=80)
        PWM_P_ex= zeros(80, size(X,2));
        PWM_S_ex= zeros(78, size(X,2)); 
        PWM_P_ex_test= zeros(1, size(X,2));
        PWM_S_ex_test= zeros(1, size(X,2)); 
        for i=1:(size(X,1)/2) %1->40
            for j=1:size(X,2)
                if X_train(i,j)==1
                    PWM_P_ex(i,j)= PWM_P(1,j);
                    PWM_P_ex(i+size(X,1),j)= PWM_S(1,j);
                elseif X_train(i,j)==2
                    PWM_P_ex(i,j)= PWM_P(2,j);
                    PWM_P_ex(i+size(X),j)= PWM_S(2,j);
                elseif X_train(i,j)==3
                    PWM_P_ex(i,j)= PWM_P(3,j);
                    PWM_P_ex(i+size(X),j)= PWM_S(3,j);
                elseif X_train(i,j)==4
                    PWM_P_ex(i,j)= PWM_P(4,j);
                    PWM_P_ex(i+size(X),j)= PWM_S(4,j);
                elseif X_train(i,j)==5
                    PWM_P_ex(i,j)= PWM_P(5,j);
                    PWM_P_ex(i+size(X,1),j)= PWM_S(5,j);
                end
            end
        end
        for i=1:39
            for j=1:size(X,2)
                if X_train(i,j)==1
                    PWM_S_ex(i,j)= PWM_S(1,j);
                    PWM_S_ex(i+(size(X,1)/2)-1,j)= PWM_P(1,j);
                elseif X_train(i,j)==2
                    PWM_S_ex(i,j)= PWM_S(2,j);
                    PWM_S_ex(i+(size(X,1)/2)-1,j)= PWM_P(2,j);
                elseif X_train(i,j)==3
                    PWM_S_ex(i,j)= PWM_S(3,j);
                    PWM_S_ex(i+(size(X,1)/2)-1,j)= PWM_P(3,j);
                elseif X_train(i,j)==4
                    PWM_S_ex(i,j)= PWM_S(4,j);
                    PWM_S_ex(i+(size(X,1)/2)-1,j)= PWM_P(4,j);
                elseif X_train(i,j)==5
                    PWM_S_ex(i,j)= PWM_S(5,j);
                    PWM_S_ex(i+(size(X,1)/2)-1,j)= PWM_P(5,j);
                end
            end
        end
        
        for i=1:size(X,2)
                if X_test(i,j)==1
                    PWM_S_ex_test(:,i)= PWM_S(1,i);
                    PWM_S_ex_test(:,i)= PWM_P(1,i);
                elseif X_test(i,j)==2
                    PWM_S_ex_test(:,i)= PWM_S(2,j);
                    PWM_S_ex_test(:,i)= PWM_P(2,i);
                elseif X_test(i,j)==3
                    PWM_S_ex_test(:,j)= PWM_S(3,i);
                    PWM_S_ex_test(:,i)= PWM_P(3,i);
                elseif X_test(i,j)==4
                    PWM_S_ex_test(:,j)= PWM_S(4,i);
                    PWM_S_ex_test(:,i)= PWM_P(4,i);
                elseif X_test(i,j)==5
                    PWM_S_ex_test(:,j)= PWM_S(5,i);
                    PWM_S_ex_test(:,i)= PWM_P(5,i);
                end
        end
                
        
        for i=1:size(PWM_P_ex,1)
            PWM(i,1)=sum(PWM_P_ex(i,:));
        end
        
        for i=1:size(PWM_S_ex,1)
            PWM(i,2)=sum(PWM_S_ex(i,:));
        end
        
        PWM_final=zeros(80,2);
        PWM_final(1:40,1)=PWM(1:40,1);
        PWM_final(1:40,2)=PWM(41:80,1);
        PWM_final(41:79,1)=PWM(1:39,2);
        PWM_final(41:79,2)=PWM(40:78,2);

% the test from a picture sample
    elseif (Idx>=0) && (Idx<=40)
        PWM_P_ex= zeros(78, size(X,2));
        PWM_S_ex= zeros(80, size(X,2));
        for i=1:(size(X,1)/2) %1->40
            for j=1:size(X,2)
                if X_train(i,j)==1
                    PWM_S_ex(i,j)= PWM_S(1,j);
                    PWM_S_ex(i+size(X,1),j)= PWM_P(1,j);
                elseif X(i,j)==2
                    PWM_S_ex(i,j)= PWM_S(2,j);
                    PWM_S_ex(i+size(X),j)= PWM_P(2,j);
                elseif X(i,j)==3
                    PWM_S_ex(i,j)= PWM_S(3,j);
                    PWM_S_ex(i+size(X),j)= PWM_P(3,j);
                elseif X(i,j)==4
                    PWM_S_ex(i,j)= PWM_S(4,j);
                    PWM_S_ex(i+size(X),j)= PWM_P(4,j);
                elseif X(i,j)==5
                    PWM_S_ex(i,j)= PWM_S(5,j);
                    PWM_S_ex(i+size(X,1),j)= PWM_P(5,j);
                end
            end
        end
        
        for i=1:39
            for j=1:size(X,2)
                if X(i,j)==1
                    PWM_P_ex(i,j)= PWM_P(1,j);
                    PWM_P_ex(i+(size(X,1)/2)-1,j)= PWM_S(1,j);
                elseif X(i,j)==2
                    PWM_P_ex(i,j)= PWM_P(2,j);
                    PWM_P_ex(i+(size(X,1)/2)-1,j)= PWM_S(2,j);
                elseif X(i,j)==3
                    PWM_P_ex(i,j)= PWM_P(3,j);
                    PWM_P_ex(i+(size(X,1)/2)-1,j)= PWM_S(3,j);
                elseif X(i,j)==4
                    PWM_P_ex(i,j)= PWM_P(4,j);
                    PWM_P_ex(i+(size(X,1)/2)-1,j)= PWM_S(4,j);
                elseif X(i,j)==5
                    PWM_P_ex(i,j)= PWM_P(5,j);
                    PWM_P_ex(i+(size(X,1)/2)-1,j)= PWM_S(5,j);
                end
            end
        end
        for i=1:size(X,2)
                if X_test(i,j)==1
                    PWM_P_ex_test(:,i)= PWM_P(1,i);
                    PWM_P_ex_test(:,i)= PWM_S(1,i);
                elseif X_test(i,j)==2
                    PWM_P_ex_test(:,i)= PWM_P(2,j);
                    PWM_P_ex_test(:,i)= PWM_S(2,i);
                elseif X_test(i,j)==3
                    PWM_P_ex_test(:,j)= PWM_P(3,i);
                    PWM_P_ex_test(:,i)= PWM_S(3,i);
                elseif X_test(i,j)==4
                    PWM_P_ex_test(:,j)= PWM_P(4,i);
                    PWM_P_ex_test(:,i)= PWM_S(4,i);
                elseif X_test(i,j)==5
                    PWM_P_ex_test(:,j)= PWM_P(5,i);
                    PWM_P_ex_test(:,i)= PWM_S(5,i);
                end
        end
                
        for i=1:size(PWM_P_ex,1)
            PWM(i,1)=sum(PWM_P_ex(i,:));
        end
        
        for i=1:size(PWM_S_ex,1)
            PWM(i,2)=sum(PWM_S_ex(i,:));
        end
        
        PWM_final=zeros(80,2);
        PWM_final(1:40,1)=PWM(1:39,1);
        PWM_final(1:40,2)=PWM(40:78,1);
        PWM_final(41:79,1)=PWM(1:40,2);
        PWM_final(41:79,2)=PWM(41:80,2);
        
    end
    
        
end

        
end



