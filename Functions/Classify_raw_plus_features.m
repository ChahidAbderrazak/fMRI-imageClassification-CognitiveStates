% X_fourier=X;
% X_ESD=X;
% X_wavelet=X;
% X_SCSA=X;
clear X_added

for i=1:4

    switch(i)
        case 1
        
        for j=1:4
            switch(j)

                case 1
                X_added=X_FT;

                case 2
                clear X_added
                X_added=Max_X_FT;

                case 3
                X_added=I;

                case 4
                X_added=X_DC;
                
            end
            
           clear X_fourier
           X_fourier=[X, X_added];
           [acc1, acc2]= Apply_classification_to_data(X_fourier, Y);
           acc(j,1:2)=[acc1,acc2];
         end
        
        case 2
            X_added= ESD;
            X_ESD=[X, X_added];
           [acc1, acc2]= Apply_classification_to_data(X_ESD, Y);
           acc(end+1,1:2)=[acc1,acc2];
            
        case 3
            X_added= wavelet_features;
            X_wavelet= [X X_added];
           [acc1, acc2]= Apply_classification_to_data(X_wavelet, Y);
           acc(end+1,1:2)=[acc1,acc2];
           
        case 4
        
         for j=7:11
            switch(j)

                case 7
                X_added=F_featuresA_h1;

                case 8
                X_added=S_featuresA_h1;

                case 9
                clear X_added
                X_added=B_featuresA_h1;

                case 10
                X_added=P_featuresA_h1;

                case 11
                clear X_added
                X_added= AF_featuresA_h1;
        
            end
            
           clear X_SCSA
           X_SCSA=[X,X_added];
           [acc1, acc2]= Apply_classification_to_data(X_SCSA, Y);
           acc(j,1:2)=[acc1,acc2];
             
         end
         
    end
end
    
%     
%     %% TRain and get accuracy Acc_i
%     
%     [acc1, acc2]= Apply_classification_to_data(X, Y);
%     acc(j,1:2)=[acc1,acc2]
%     
%     
% end
