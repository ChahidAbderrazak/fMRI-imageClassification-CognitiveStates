% F_features: filtred input 
% S_features: the whole negative eigenvalues spectrum 
% B_features: two first and last eigenvalues 
% P_features: sum of all normalised eigen functions
% AF_features: Area under the filtred input 

function [F_features, S_features, B_features, P_features,AF_features]=SCSA_Transform_features(features,h0,gm,fs)
%% Split the data 

%% Run the scsa
[~, yscsaA,~,Neg_lamda,ProbaS]= SCSA_transform(features,fs,h0,gm);
F_features=[yscsaA];
AF_features=[trapz(yscsaA')'];
S_features=[Neg_lamda];
B_features=[Neg_lamda(:,1:4) ];
P_features=[ProbaS ];


%% Add normalizatio 


