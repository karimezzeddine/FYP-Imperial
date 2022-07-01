function Av_Signals = iterative_cross_correlation(Signal,SignalTime)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

N = length(Signal(1,:));

Av_Signals = zeros(length(Signal(:,1)), N/2);
% SjX_all = zeros(length(Signal(:,1)), N);
j = 1;

for i=1:2:N-1
    [SjX_new, Average_Signal_X] = cross_correlation_av(Signal,i,SignalTime);
    
    Av_Signals(:,j) = Average_Signal_X;
    j = j + 1;
    
end


end

