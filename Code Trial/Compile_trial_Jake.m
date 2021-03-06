function [SjX_all_gyro,SjY_all_gyro,SjZ_all_gyro,SjX_all_accel,SjY_all_accel,SjZ_all_accel] = Compile_trial_Jake(files, M, colaccX,colaccY,colaccZ,colgyroX,colgyroY,colgyroZ)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% iteratively add a file and concatenate the arrays 
% input of the compile function will be a list of files 
[AllfGyroX,AllfGyroY,AllfGyroZ,DfGyroTime]= segment_gyro_trial(files(1), colaccX,colaccY,colaccZ,colgyroX,colgyroY,colgyroZ);
[AllfAccelX,AllfAccelY,AllfAccelZ,DfAccelTime]= segment_accel_trial(files(1), colaccX,colaccY,colaccZ);

% M = 32;

for i=2:length(files)
    [DfGyroX,DfGyroY,DfGyroZ,DfGyroTime]= segment_gyro_trial(files(i),colaccX,colaccY,colaccZ,colgyroX,colgyroY,colgyroZ);
    [DfAccelX,DfAccelY,DfAccelZ,DfAccelTime]= segment_accel_trial(files(i),colaccX,colaccY,colaccZ);
    
    AllfGyroX=horzcat(AllfGyroX,DfGyroX);
    AllfGyroY=horzcat(AllfGyroY,DfGyroY);
    AllfGyroZ=horzcat(AllfGyroZ,DfGyroZ);
    AllfAccelX=horzcat(AllfAccelX,DfAccelX);
    AllfAccelY=horzcat(AllfAccelY,DfAccelY);
    AllfAccelZ=horzcat(AllfAccelZ,DfAccelZ);
    
end


SignalTime = DfAccelTime;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%       GYROSCOPE       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%       X       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllfGyroX_2power = AllfGyroX(:,1:M);

N = length(AllfGyroX_2power(1,:));

Av_Signal_X_Gyro = iterative_cross_correlation(AllfGyroX_2power,SignalTime);

while N>2
    Av_Signal_X_Gyro = iterative_cross_correlation(Av_Signal_X_Gyro,SignalTime);
    N = N/2;
end

SjX_all_gyro = final_step_cross_correlation(AllfGyroX_2power,Av_Signal_X_Gyro,SignalTime);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%       Y       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllfGyroY_2power = AllfGyroY(:,1:M);

N = length(AllfGyroY_2power(1,:));

Av_Signal_Y_Gyro = iterative_cross_correlation(AllfGyroY_2power,SignalTime);

while N>2
    Av_Signal_Y_Gyro = iterative_cross_correlation(Av_Signal_Y_Gyro,SignalTime);
    N = N/2;
end

SjY_all_gyro = final_step_cross_correlation(AllfGyroY_2power,Av_Signal_Y_Gyro,SignalTime);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%       Z       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllfGyroZ_2power = AllfGyroZ(:,1:M);

N = length(AllfGyroZ_2power(1,:));

Av_Signal_Z_Gyro = iterative_cross_correlation(AllfGyroZ_2power,SignalTime);

while N>2
    Av_Signal_Z_Gyro = iterative_cross_correlation(Av_Signal_Z_Gyro,SignalTime);
    N = N/2;
end

SjZ_all_gyro = final_step_cross_correlation(AllfGyroZ_2power,Av_Signal_Z_Gyro,SignalTime);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%       ACCELERATION       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%       X       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllfAccelX_2power = AllfAccelX(:,1:M);

N = length(AllfAccelX_2power(1,:));

Av_Signal_X_Accel = iterative_cross_correlation(AllfAccelX_2power,SignalTime);

while N>2
    Av_Signal_X_Accel = iterative_cross_correlation(Av_Signal_X_Accel,SignalTime);
    N = N/2;
end

SjX_all_accel = final_step_cross_correlation(AllfAccelX_2power,Av_Signal_X_Accel,SignalTime);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%       Y       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllfAccelY_2power = AllfAccelY(:,1:M);

N = length(AllfAccelY_2power(1,:));

Av_Signal_Y_accel = iterative_cross_correlation(AllfAccelY_2power,SignalTime);

while N>2
    Av_Signal_Y_accel = iterative_cross_correlation(Av_Signal_Y_accel,SignalTime);
    N = N/2;
end

SjY_all_accel = final_step_cross_correlation(AllfAccelY_2power,Av_Signal_Y_accel,SignalTime);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%       Z       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllfAccelZ_2power = AllfAccelZ(:,1:M);

N = length(AllfAccelZ_2power(1,:));

Av_Signal_Z_Accel = iterative_cross_correlation(AllfAccelZ_2power,SignalTime);

while N>2
    Av_Signal_Z_Accel = iterative_cross_correlation(Av_Signal_Z_Accel,SignalTime);
    N = N/2;
end

SjZ_all_accel = final_step_cross_correlation(AllfAccelZ_2power,Av_Signal_Z_Accel,SignalTime);


figure
hold on
for plotIdx = 1:size(SjX_all_gyro,2)
    plot(SjX_all_gyro(:,plotIdx),'r'); % overlay all forehand shots onto 1 curve
    plot(SjY_all_gyro(:,plotIdx),'g'); % overlay all forehand shots onto 1 curve
    plot(SjZ_all_gyro(:,plotIdx),'b'); % overlay all forehand shots onto 1 curve    
end
xlabel('Time (s)','FontSize', 20); %x-axis label 
set(gca,'XTickLabel',{'0.25','0.5','0.75','1','1.25','1.5',},'XTick',[20 40 60 80 100 120]);
legend('\omega_{x}', '\omega_{y}', '\omega_{z}','FontSize', 20)
ylabel('Gyroscope (100??/s)','FontSize', 20); %y-asix label
set(gca,'FontSize',20)
%
figure
hold on
for plotIdx = 1:size(SjX_all_accel,2)
    plot(SjX_all_accel(:,plotIdx),'r'); % overlay all forehand shots onto 1 curve
    plot(SjY_all_accel(:,plotIdx),'g'); % overlay all forehand shots onto 1 curve
    plot(SjZ_all_accel(:,plotIdx),'b'); % overlay all forehand shots onto 1 curve    
end
xlabel('Time (s)','FontSize', 20); %x-axis label 
set(gca,'XTickLabel',{'0.25','0.5','0.75','1','1.25','1.5',},'XTick',[20 40 60 80 100 120]);
legend('a_{x}', 'a_{y}', 'a_{z}','FontSize', 20)
ylabel('Acceleration (g)','FontSize', 20); %y-axis label
set(gca,'FontSize',20)
hold off
%


