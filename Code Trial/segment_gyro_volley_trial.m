function [SignalX,SignalY,SignalZ,SignalTime] = segment_gyro_volley_trial(Filename, colaccX,colaccY,colaccZ,colgyroX,colgyroY,colgyroZ)

%Backhand data set
A = readtable(Filename,'Delimiter',',');
timestamp = linspace(1,height(A)-1, height(A)-1);
timestamp=timestamp./80;

fgyroX = A{1:height(A)-1,colgyroX};
fgyroY = A{1:height(A)-1,colgyroY};
fgyroZ = A{1:height(A)-1,colgyroZ};

%for segmenting purposes
faccX = A{1:height(A)-1,colaccX};
faccY = A{1:height(A)-1,colaccY};
faccZ = A{1:height(A)-1,colaccZ};


% plot(timestamp, fgyroX);
% hold on;
% plot(timestamp, fgyroY);
% hold on;
% plot(timestamp, fgyroZ);
% legend('w_x','w_y','w_z');
% hold off;
% legend();


%% Absolute magnitude of gyro data and curve smoothing
AccMean=sqrt((faccX.^2)+(faccY.^2)+(faccZ.^2)); % absolute magnitude backhand
windowSize=3;
faccMovav = tsmovavg(AccMean,'s',windowSize,1); % moving average backhand
%faccMovavSmooth = smoothdata(faccMovav);
% [bpks,blocs] = findpeaks(faccMovav,'MinPeakProminence',2,'MinPeakDistance',20,'MinPeakHeight',5); 
% for volley
[bpks,blocs] = findpeaks(faccMovav,'MinPeakProminence',1,'MinPeakDistance',30,'MinPeakHeight',2); 
% peak distance of 2s and min peak height of 300

% t=zeros(length(faccMovav),1) + 2.5;
% 
% figure
% plot(timestamp, faccMovav,timestamp(blocs),bpks,'or')
% hold on
% plot(timestamp, t, 'red')
% hold off
% xlabel('No Sample');
% ylabel('Acceleration Magnitude (g)');
%% Saving each shot into separate column of one big array
% shot length is assumed to be 5s in length

SignalTime=zeros(120,length(bpks));
SignalX=zeros(120,length(bpks)); 
% array to store each shot in one column, so 33 columns for 33 shots and 
% 1081 rows for 1081 data points which represent 5s = 1 shot
SignalY=zeros(120,length(bpks));
SignalZ=zeros(120,length(bpks));

for j=1:length(bpks)-1
     timeIndex=blocs(j); % select first time value of peak
     startSignal=timeIndex-60; % subtract 2s worth od data points from peak to obtian time when shot begins
     endSignal=timeIndex+59 ;% add 2s worth of data points from peak to obtain end of signal
     if j==1
         startSignal=1;
         endSignal=120;
     else
         if j==length(bpks)
             startSignal=length(timestamp)-119;
             endSignal=length(timestamp);
         end
     end
     SignalTime(:,j) = timestamp(startSignal:endSignal); % 1 shot in time index to be saved in Signal matrix
     SignalX(:,j) = fgyroX(startSignal:endSignal);
     SignalY(:,j) = fgyroY(startSignal:endSignal);
     SignalZ(:,j) = fgyroZ(startSignal:endSignal);
end


% figure
% hold on
% for plotIdx = 1:size(SignalX,2)
%      plot(SignalX(:,plotIdx),'r'); % overlay all forehand shots onto 1 curve
%      plot(SignalY(:,plotIdx),'g'); % overlay all forehand shots onto 1 curve
%      plot(SignalZ(:,plotIdx),'b'); % overlay all forehand shots onto 1 curve
%      legend('w_x','w_y','w_z')
% end
% xlabel('Time (s)'); %x-axis label 
% set(gca,'XTickLabel',{'1','2','3','4',},'XTick',[126 252 378 504],'Fontsize',18);
% ylabel('Rotation Rate (rad/s)'); %y-asix label
% legend boxoff
% hold off
end