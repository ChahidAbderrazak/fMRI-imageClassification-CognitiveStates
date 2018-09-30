%% Classify SCSA_features
for j=1:5
    switch(j)
        
        case 1
            clear X_added
            X_added=F_featuresA_h1;
            
        case 2
            clear X_added
            X_added=S_featuresA_h1;
            
        case 3
            clear X_added
            X_added=B_featuresA_h1;
            
        case 4
            clear X_added
            X_added=P_featuresA_h1;
            
        case 5
            clear X_added
            X_added= AF_featuresA_h1;
    end
    clear X_SCSA
    X_SCSA=X_added;
    [acc1, acc2]= Apply_LeavOut_classification(X_SCSA, Y);
    acc(j,1:2)=[acc1,acc2];
end
%% Classify X+SCSA_features
% for j=1:5
%     switch(j)
%         
%         case 1
%             clear X_added
%             X_added=F_featuresA_h1;
%             
%         case 2
%             clear X_added
%             X_added=S_featuresA_h1;
%             
%         case 3
%             clear X_added
%             X_added=B_featuresA_h1;
%             
%         case 4
%             clear X_added
%             X_added=P_featuresA_h1;
%             
%         case 5
%             clear X_added
%             X_added= AF_featuresA_h1;
%             
%     end
%     
%     clear X_SCSA
%     X_SCSA=[X,X_added];
%     [acc1, acc2]= Apply_LeavOut_classification(X_SCSA, Y);
%     acc(j,1:2)=[acc1,acc2];
%     
% end