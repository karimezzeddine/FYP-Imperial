function [meanY,areaY] = followthrough(GyroY,GyroZ)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N = length(GyroY(:,1));
n = length(GyroY(1,:));

meanY = zeros(1,n);
areaY = zeros(1,n);

for i=1:n
    
    meanY(1,i) = mean(GyroZ(N-40:N,i));
    areaY(1,i) = trapz(GyroZ(N-40:N,i));

end

