function acc1= Apply_LeavOut_classification_test(X, Y)

%% Apply GNB
for i = 1:(size(X,1)/2)
    [classifier] = trainClassifier(X(1:78,i:i+1), Y(1:78, i), 'nbayes');   %train classifier
    [predictions] = applyClassifier(X(79:80,i:i+1), classifier);       %test it
    [result,predictedLabels,trace] = summarizePredictions(predictions,classifier,'averageRank',Y(79:80,i));
    err(i)= 1-result{1};  % rank accuracy
end
acc1= sum(err)/i;