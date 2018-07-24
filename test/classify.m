C = cvpartition(Y(1:40), 'LeaveOut');
PWM_train=[];
PWM_test=[];
y=[];
Y_P= Y(1:40);
Y_S= Y(41:80);

for i = 1:C.NumTestSets
    trIdx = C.training(i);
    teIdx = C.test(i);
    PWM1_train= extract_PWM_test(X_P(trIdx,:), X_S(trIdx,:), 'train');
    PWM1_test= extract_PWM_test(X_P(teIdx,:), X_S(teIdx,:), 'test');
    PWM_train= [PWM_train PWM1_train];
    PWM_test=[PWM_test PWM1_test];
    Y_train_X_P= Y_P(trIdx);
    Y_test_X_P= Y_P(teIdx);
    Y_train_X_S= Y_S(trIdx);
    Y_test_X_S= Y_S(teIdx);
    
    Y_train=[Y_train_X_P; Y_train_X_S];
    Y_test=[Y_test_X_P; Y_test_X_S];
    
    Y_train_test= [Y_train; Y_test];
    y= [y Y_train_test];
end
PWM= [PWM_train; PWM_test];

acc1= Apply_LeavOut_classification_test(PWM, y);

% 
% X_P_1_1= X_P_1(40,:);
% X_S_1= X_S(40,:);
% 
% for j=1:size(X_P_1,2)
%     if X_P_1(:,j) <= -3
%         X_P_1(:,j)= 1;
%     elseif X_P_1(:,j) <= -1
%         X_P_1(:,j)= 2;
%     elseif X_P_1(:,j) <= 1
%         X_P_1(:,j)= 3;
%     elseif X_P_1(:,j) < 3
%         X_P_1(:,j)= 4;
%     else
%         X_P_1(:,j)= 5;
%     end
% end
% 
% for j=1:s:ze(X_S,2)
%     if X_S(:,j) <= -3
%         X_S(:,j)= 1;
%     elseif X_S(:,j) <= -1
%         X_S(:,j)= 2;
%     elseif X_S(:,j) <= 1
%         X_S(:,j)= 3;
%     elseif X_S(:,j) < 3
%         X_S(:,j)= 3;
%     else
%         X_S(:,j)= 4;
%     end
% end
% 
