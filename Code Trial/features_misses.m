function [SMS,DMS,maxAZZ,minAZZ,GSMS,GDMS,maxGZZ,minGZZ] = features_misses(fAccelX,fAccelY,fAccelZ,fGravX,fGravY,fGravZ)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
N = length(fAccelX(1,:));

SMS = zeros(N,1);
DMS = zeros(N,1);
maxAZZ = zeros(N,1);
minAZZ = zeros(N,1);

GSMS = zeros(N,1);
GDMS = zeros(N,1);
maxGZZ = zeros(N,1);
minGZZ = zeros(N,1);

for i=1:N
    
    n = 2; %find n tallest peaks
    [pks,lcs] = maxk(fAccelZ(:,i),n); 
    
    [minAZ, iminAZ] = min(fAccelZ(:,i));
    [maxAZ, imaxAZ] = max(fAccelZ(:,i));

    SMS(i,1) = (pks(1)-pks(2))/(lcs(1)-lcs(2)); %Slope between maximum and minimum
    DMS(i,1) = (imaxAZ-iminAZ); %difference between position of max and min values
    maxAZZ(i,1) = maxAZ;
    minAZZ(i,1) = minAZ;
    
    
    [minGZ, iminGZ] = min(fGravZ(:,i));
    [maxGZ, imaxGZ] = max(fGravZ(:,i));

    GSMS(i,1) = (maxGZ-minGZ)/(imaxGZ-iminGZ); %Slope between maximum and minimum
    GDMS(i,1) = (imaxGZ-iminGZ); %difference between position of max and min values
    maxGZZ(i,1) = maxGZ;
    minGZZ(i,1) = minGZ;
    
end


