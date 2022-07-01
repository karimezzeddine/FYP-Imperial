function [prominent_values] = maxminanalysis(Array1,Array2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
prominent_values = zeros(size(Array1));

arraycat = horzcat(Array1,Array2);

for i=1:size(arraycat(1,:))
    for j=1:3
        if abs(arraycat(i,j))>=abs(arraycat(i,j+3))
            prominent_values(i,j) = arraycat(i,j);
        else
            prominent_values(i,j) = arraycat(i,j+3);
        end
    end
end

end

