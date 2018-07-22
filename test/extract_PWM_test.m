function [PWM, X_P, X_S] = extract_PWM_test(X_P, X_S)
catogries= 5;



for i=1:size(X_P,1)
    for j=1:size(X_P,2)
        if X_P(i,j) <= -3
            X_P(i,j)= 1;
        elseif X_P(i,j) <= -1
            X_P(i,j)= 2;
        elseif X_P(i,j) <= 1
            X_P(i,j)= 3;
        elseif X_P(i,j) < 3
            X_P(i,j)= 4;
        else 
            X_P(i,j)= 5;
        end
    end
end

for i=1:size(X_S,1)
    for j=1:size(X_S,2)
        if X_S(i,j) <= -3
            X_S(i,j)= 1;
        elseif X_S(i,j) <= -1
            X_S(i,j)= 2;
        elseif X_S(i,j) <= 1
            X_S(i,j)= 3;
        elseif X_S(i,j) < 3
            X_S(i,j)= 3;
        else 
            X_S(i,j)= 4;
        end
    end
end



PWM_P= zeros(catogries, size(X_P,2));
PWM_S= zeros(catogries, size(X_S,2));

for i=1:size(X_P, 2)
    PWM_P(1,i)= sum(X_P(:, i) == 1)/size(X_P,1);
    PWM_P(2,i)= sum(X_P(:, i) == 2)/size(X_P,1);
    PWM_P(3,i)= sum(X_P(:, i) == 3)/size(X_P,1);
    PWM_P(4,i)= sum(X_P(:, i) == 4)/size(X_P,1);
    PWM_P(5,i)= sum(X_P(:, i) == 5)/size(X_P,1);

end

for i=1:size(X_S, 2)
    PWM_S(1,i)= sum(X_S(:, i) == 1)/size(X_S,1);
    PWM_S(2,i)= sum(X_S(:, i) == 2)/size(X_S,1);
    PWM_S(3,i)= sum(X_S(:, i) == 3)/size(X_S,1);
    PWM_S(4,i)= sum(X_S(:, i) == 4)/size(X_S,1);
    PWM_S(5,i)= sum(X_S(:, i) == 5)/size(X_S,1);
end

PWM= zeros(size(X_P,1)+size(X_S,1),2);
PWM_P_ex=zeros(size(X_P,1)+size(X_S,1),size(X_S,2));
PWM_S_ex=zeros(size(X_P,1)+size(X_S,1),size(X_S,2));

for i=1:size(X_P,1)
    for j=1:size(X_P,2)
        if X_P(i,j)==1
            PWM_P_ex(i,j)= PWM_P(1,j);
            PWM_P_ex(i+size(X_P,1),j)= PWM_S(1,j);
        elseif X_P(i,j)==2
            PWM_P_ex(i,j)= PWM_P(2,j);
            PWM_P_ex(i+size(X_P,1),j)= PWM_S(2,j);
        elseif X_P(i,j)==3
            PWM_P_ex(i,j)= PWM_P(3,j);
            PWM_P_ex(i+size(X_P,1),j)= PWM_S(3,j);
        elseif X_P(i,j)==4
            PWM_P_ex(i,j)= PWM_P(4,j);
            PWM_P_ex(i+size(X_P,1),j)= PWM_S(4,j);
        elseif X_P(i,j)==5
            PWM_P_ex(i,j)= PWM_P(5,j);
            PWM_P_ex(i+size(X_P,1),j)= PWM_S(5,j);
        end
    end
end

for i=1:size(X_P,1)
    for j=1:size(X_S,2)
        if X_S(i,j)==1
            PWM_S_ex(i,j)= PWM_S(1,j);
            PWM_S_ex(i+size(X_S,1),j)= PWM_P(1,j);
        elseif X_S(i,j)==2
            PWM_S_ex(i,j)= PWM_S(2,j);
            PWM_S_ex(i+size(X_S,1),j)= PWM_P(2,j);
        elseif X_S(i,j)==3
            PWM_S_ex(i,j)= PWM_S(3,j);
            PWM_S_ex(i+size(X_S,1),j)= PWM_P(3,j);
        elseif X_S(i,j)==4
            PWM_S_ex(i,j)= PWM_S(4,j);
            PWM_S_ex(i+size(X_S,1),j)= PWM_P(4,j);
        elseif X_S(i,j)==5
            PWM_S_ex(i,j)= PWM_S(5,j);
            PWM_S_ex(i+size(X_S,1),j)= PWM_P(5,j);
        end
    end
end

for i=1:size(PWM_P_ex,1)
    PWM(i,1)=sum(PWM_P_ex(i,:));
end

for i=1:size(PWM_S_ex,1)
    PWM(i,2)=sum(PWM_S_ex(i,:));
end