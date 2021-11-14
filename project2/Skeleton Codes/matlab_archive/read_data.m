function [data, labels] = read_data()
A = importdata('ionosphere.data');
data = zeros(351, 34);
labels = zeros(351, 1);
for i = 1 : 351
    temp = split(A{i}, ',');
    temp_label = temp(35);
    if temp_label{1} == 'g'
        labels(i, 1) = -1;
    else
       labels(i, 1) = 1;
    end
    data_array = zeros(34, 1);
    for j = 1: 34
        data_array(j) = str2double(cell2mat(temp(j)));  
    end
%     data(i, :) = data_array;
    data(i, :) = data_array;
end
data(:, 2) = [];
data = data./ max(data);
end