C = cvpartition(Y(1:40), 'LeaveOut');
PWM=[];
for i = 1:C.NumTestSets
    trIdx = C.training(i);
    teIdx = C.test(i);
    PWM1= extract_PWM_test(X_P(trIdx,:), X_S(trIdx,:));
    PWM= [PWM PWM1];
%     PWM= cat(2,PWM(:,i:i+1));
end



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
