addpath ../Functions
addpath ../Functions/Netlab
% addpath /Users/sehrism/Documents/datasets
addpath D:\SSI\Project\Datasets\starplus

for subject=1:6
    switch(subject)
        case 1
            load('data-starplus-04799-v7.mat')
            Convert_single_subject_data_to_matrix
            [outcome, accuracy11]= Classify_LeaveOut_VWM_functions(X,Y);
        case 2
            load('data-starplus-04820-v7.mat')
            Convert_single_subject_data_to_matrix
            [outcome, accuracy21 ]= Classify_LeaveOut_VWM_functions(X,Y);
        case 3
            load('data-starplus-04847-v7.mat')
            Convert_single_subject_data_to_matrix
            [outcome, accuracy31]= Classify_LeaveOut_VWM_functions(X,Y);

        case 4
            load('data-starplus-05675-v7.mat')
            Convert_single_subject_data_to_matrix
            [outcome, accuracy41]= Classify_LeaveOut_VWM_functions(X,Y);
            
        case 5
            load('data-starplus-05680-v7.mat')
            Convert_single_subject_data_to_matrix
            [outcome, accuracy51]= Classify_LeaveOut_VWM_functions(X,Y);
            
        case 6
            load('data-starplus-05710-v7.mat')
            Convert_single_subject_data_to_matrix
            [outcome, accuracy61]= Classify_LeaveOut_VWM_functions(X,Y);
    end
end

acc= [accuracy11 ; accuracy21  ;accuracy31 ;accuracy41 ;accuracy51 ;accuracy61 ];
