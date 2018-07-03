function [X_FT,Max_X_FT,I] = apply_fourier(X)

X_FT= zeros(size(X,1), size(X,2));
Max_X_FT= zeros(size(X,1),1);
I= zeros(size(X,1),1);
for k=1:size(X,1)
    X_FT(k,:)= fft(abs(X(k,:)));
    [Max_X_FT(k,1), I(k,1)]= max(X_FT(k,:));
end

