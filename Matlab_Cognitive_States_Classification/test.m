%% Get the statistical properties of the data

    SpD_pd = fitdist(Xp(:),'Normal');
    
    % plot 
     figure;
     plot(centers,counts); 
     
%% GEt the noral distibution for each subject
    SpD_pd_Sigma=floor(SpD_pd.sigma*10)/10;     SpD_pd_mu=floor(SpD_pd.mu*10)/10;     
        
 % plot 
 figure;
 histfit(Xp(:),100); 
 legend('Fitted Histogram',strcat('Gaussian distribution ( \mu=',num2str(SpD_pd_mu),', \sigma=',num2str(SpD_pd_Sigma),') '))
 xlabel('Spikes duration (#samples)')
 ylabel('Number of spikes')
 set(gca,'fontsize',16)

 
 %% 
 
%  clc
% clear
close all
nbins=100;
series1 = Xp(:);
series2 = Xn(:);

