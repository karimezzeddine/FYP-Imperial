function [RacketSpeedAverage] = RacketSpeed(AllGyroY, AllGyroZ)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

N = length(AllGyroY(1,:));

g_y_max =  zeros(N,1);
g_z_max =  zeros(N,1);

for i=1:N
    g_y_max(i,1) = max(abs(AllGyroY(:,i)));
    g_z_max(i,1) = max(abs(AllGyroZ(:,i)));
end

g_y_max_av = mean(g_y_max);
g_z_max_av = mean(g_z_max);

omega=sqrt((g_y_max_av)^2 + (g_z_max_av)^2);
% omega=sqrt((g_y_max_av*0.0174533)^2 + (g_z_max_av*0.0174533)^2); what is
% this number for?


RacketSpeedAverage = omega * 0.7445 * 3.6

end

