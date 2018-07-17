function X = extract_PWM(X)
for i=1:size(X,1)
    for j=1:size(X,2)
        if X(i,j) <= 0.25
            X(i,j)= 0;
        elseif X(i,j) <=0.5
            X(i,j)= 1;
        elseif X(i,j) <=0.75
            X(i,j)= 2;
        else 
            X(i,j)= 3;
        end
    end
end

