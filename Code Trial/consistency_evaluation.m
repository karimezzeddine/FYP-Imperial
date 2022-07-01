function [consistency_gyroX,consistency_gyroY,consistency_gyroZ,consistency_accelX,consistency_accelY,consistency_accelZ] = consistency_evaluation(template_gyroX, template_gyroY, template_gyroZ, template_accelX,template_accelY,template_accelZ,AllfGyroX,AllfGyroY,AllfGyroZ,AllfAccelX,AllfAccelY,AllfAccelZ)

%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N = length(AllfGyroX(:,2));
M = length(AllfGyroX(2,:));

consistency_gyroX = zeros(M,1)';
consistency_gyroY = zeros(M,1)';
consistency_gyroZ = zeros(M,1)';

consistency_accelX = zeros(M,1)';
consistency_accelY = zeros(M,1)';
consistency_accelZ = zeros(M,1)';


% rally_consistency_gyro = zeros(1,3);
% rally_consistency_accel = zeros(1,3);

for j=1:M
    for i=1:N
    consistency_gyroX(1,j) = consistency_gyroX(1,j) + sqrt(((AllfGyroX(i,j))-template_gyroX(i))^2);
    consistency_gyroY(1,j) = consistency_gyroY(1,j) + sqrt(((AllfGyroY(i,j))-template_gyroY(i))^2);
    consistency_gyroZ(1,j) = consistency_gyroZ(1,j) + sqrt(((AllfGyroZ(i,j))-template_gyroZ(i))^2);
    
    consistency_accelX(1,j) = consistency_accelX(1,j) + sqrt(((AllfAccelX(i,j))-template_accelX(i))^2);
    consistency_accelY(1,j) = consistency_accelY(1,j) + sqrt(((AllfAccelY(i,j))-template_accelY(i))^2);
    consistency_accelZ(1,j) = consistency_accelZ(1,j) + sqrt(((AllfAccelZ(i,j))-template_accelZ(i))^2);
    
    end

    consistency_gyroX(1,j) = consistency_gyroX(1,j)/N;
    consistency_gyroY(1,j) = consistency_gyroY(1,j)/N;
    consistency_gyroZ(1,j) = consistency_gyroZ(1,j)/N;
    
    consistency_accelX(1,j) = consistency_accelX(1,j)/N;
    consistency_accelY(1,j) = consistency_accelY(1,j)/N;
    consistency_accelZ(1,j) = consistency_accelZ(1,j)/N;
end

consistency_gyroX_total = mean(consistency_gyroX(:,1)')
consistency_gyroY_total = mean(consistency_gyroY(:,1)')
consistency_gyroZ_total = mean(consistency_gyroZ(:,1)')

consistency_accelX_total = mean(consistency_accelX(:,1)')
consistency_accelY_total = mean(consistency_accelY(:,1)')
consistency_accelZ_total = mean(consistency_accelZ(:,1)')



end

