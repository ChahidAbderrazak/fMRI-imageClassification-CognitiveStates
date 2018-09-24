function wavelet_features = getwaveletFeature(x,y)
%% this is to test the wavelet feature extraction
% x is the current EIIP signal
% y is the current ESD signal
% wavelet_features is a matrix that contains the features generated from wavelet analysis

%% Wavelet analysis for EIIP signal
[wpt,packetlevs,cfreq,energy,relenergy] = modwpt(x,3,'db3');
wavelet_features(1) = energy(1);
wavelet_features(2) = energy(2);
wavelet_features(3) = energy(3);
wavelet_features(4) = energy(4);
wavelet_features(5) = energy(5);
wavelet_features(6) = energy(6);
wavelet_features(7) = energy(7);
wavelet_features(8) = energy(8);

%% Wavelet analysis for ESD signal
% [wpt,packetlevs,cfreq,energy,relenergy] = modwpt(y,3,'db3');
% 
% wavelet_features(19) = energy(1);
% wavelet_features(20) = energy(2);
% wavelet_features(21) = energy(3);
% wavelet_features(22) = energy(4);
% wavelet_features(23) = energy(5);
% wavelet_features(24) = energy(6);
% wavelet_features(25) = energy(7);
% wavelet_features(26) = energy(8);


end

