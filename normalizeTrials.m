function norm_data = normalizeTrials(data)
norm_data= zeros(size(data,1),size(data,2));

for i=1:size(data,1)
    norm_data(i,:) = (data(i,:) - min(data(i,:))) / ( max(data(i,:)) - min(data(i,:))) ;
end
