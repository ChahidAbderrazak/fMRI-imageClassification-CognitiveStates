function acc= optimize_range(X_P,X_S,Y)
for i=1:5
    PWM= Generate_PWM_2(X_P, X_S, i);
    acc(i)=  Apply_LeavOut_classification(PWM, Y);
end
end