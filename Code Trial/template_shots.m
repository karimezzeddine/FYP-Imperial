function [template_gyroX, template_gyroY, template_gyroZ, template_accelX,template_accelY,template_accelZ] = template_shots(AllGyroX,AllGyroY,AllGyroZ, AllAccelX,AllAccelY,AllAccelZ)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
N = length(AllGyroX(:,2));

No_samples = linspace(1,N,N);

%take 5 shots randomly from experts and concatenate them together
gyroX = horzcat(AllGyroX(:,3),AllGyroX(:,8),AllGyroX(:,15),AllGyroX(:,22),AllGyroX(:,26));
gyroY = horzcat(AllGyroY(:,3),AllGyroY(:,8),AllGyroY(:,15),AllGyroY(:,22),AllGyroY(:,26));
gyroZ = horzcat(AllGyroZ(:,3),AllGyroZ(:,8),AllGyroZ(:,15),AllGyroZ(:,22),AllGyroZ(:,26));

accelX = horzcat(AllAccelX(:,3),AllAccelX(:,8),AllAccelX(:,15),AllAccelX(:,22),AllAccelX(:,26));
accelY = horzcat(AllAccelY(:,3),AllAccelY(:,8),AllAccelY(:,15),AllAccelY(:,22),AllAccelY(:,26));
accelZ = horzcat(AllAccelZ(:,3),AllAccelZ(:,8),AllAccelZ(:,15),AllAccelZ(:,22),AllAccelZ(:,26));

%initialize templates for the references for shot consistency and deviation
template_gyroX = zeros(N,1);
template_gyroY = zeros(N,1);
template_gyroZ = zeros(N,1);

template_accelX = zeros(N,1);
template_accelY = zeros(N,1);
template_accelZ = zeros(N,1);


%compute the mean for expert temlate shots
for i=1:N
    template_gyroX(i,1) = mean(gyroX(i,:));
    template_gyroY(i,1) = mean(gyroY(i,:));
    template_gyroZ(i,1) = mean(gyroZ(i,:));
    
    template_accelX(i,1) = mean(accelX(i,:));
    template_accelY(i,1) = mean(accelY(i,:));
    template_accelZ(i,1) = mean(accelZ(i,:));
end

figure;
hold on
plot(No_samples,template_gyroX,'r');
plot(No_samples,template_gyroY,'g');
plot(No_samples,template_gyroZ,'b');
xlabel('Time (s)'); %x-axis label 
set(gca,'XTickLabel',{'0.25','0.5','0.75','1','1.25','1.5',},'XTick',[20 40 60 80 100 120]);
legend('\omega_{x}', '\omega_{y}', '\omega_{z}')
ylabel('Gyroscope (100°/s)'); %y-asix label
hold off

figure;
hold on
% plot(No_samples,template_accelX,'r');
% plot(No_samples,template_accelY,'color', [0, 0.5, 0]);
plot(No_samples,template_accelZ,'b');
xlabel('No Samples','FontSize', 20); %x-axis label
% legend('a_{x}', 'a_{y}', 'a_{z}')
legend('a_{z}','FontSize', 20)
ylabel('Acceleration (g)','FontSize', 20); %y-axis label
set(gca,'FontSize',20)
hold off

end

