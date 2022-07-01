function [SignalX,SignalY,SignalZ,SignalTime] = segment_accel_trial(Filename,colaccX,colaccY,colaccZ)
% [SjX_new,SjY_new,SjZ_new,Signal_time_average] = segment_accel_trial(Filename)
%Backhand data set
A = readtable(Filename,'Delimiter',',');
timestamp = linspace(1,height(A)-1, height(A)-1);
% timestamp=timestamp./80;

faccX = A{1:height(A)-1,colaccX}; %for my data 3, and Jake 1
faccY = A{1:height(A)-1,colaccY}; %for my data 4, and Jake 2
faccZ = A{1:height(A)-1,colaccZ}; %for my data 5, and Jake 3

% faccX = lowpass(faccX,20,80);
% faccY = lowpass(faccY,20,80);
% faccZ = lowpass(faccZ,20,80);

% plot(timestamp, faccX);
% hold on;
% plot(timestamp, faccY);
% hold on;
% plot(timestamp, faccZ);
% legend('a_x','a_y','a_z');
% hold off;

%% Absolute magnitude of gyro data and curve smoothing
AccMean=sqrt((faccX.^2)+(faccY.^2)+(faccZ.^2)); % absolute magnitude backhand
windowSize=3; %was 3
faccMovav = tsmovavg(AccMean,'s',windowSize,1); % moving average backhand
%faccMovavSmooth = smoothdata(faccMovav);
[bpks,blocs] = findpeaks(faccMovav,'MinPeakProminence',2,'MinPeakDistance',80,'MinPeakHeight',2.5);
% for volley
% [bpks,blocs] = findpeaks(faccMovav,'MinPeakProminence',1,'MinPeakDistance',30,'MinPeakHeight',2); 
% peak distance of 2s and min peak height of 300


%
% figure
% plot(timestamp, faccMovav,timestamp(blocs),bpks,'or');
% bGyroMean=sqrt((bGyroX.^2)+(bGyroY.^2)+(bGyroZ.^2)); % absolute magnitude backhand
% windowSize=3;
% bGyroMeanMovav = tsmovavg(bGyroMean,'s',windowSize,1); % moving average backhand
% [bpks,blocs] = findpeaks(bGyroMeanMovav,'MinPeakProminence',2,'MinPeakDistance',2,'MinPeakHeight',10) % peak distance of 2s and min peak height of 300
%
% figure
% plot(bTimedomain, bGyroMeanMovav,bTimedomain(blocs),bpks,'or');
%xlim([180 300]);

%% Saving each shot into separate column of one big array
% shot length is assumed to be 5s in length

N = 120;
SignalTime=zeros(N,length(bpks));
SignalX=zeros(N,length(bpks)); % array to store each shot in one column, so 33 columns for 33 shots and 1081 rows for 1081 data points which represent 5s = 1 shot
SignalY=zeros(N,length(bpks));
SignalZ=zeros(N,length(bpks));

for j=1:length(bpks)-1
     timeIndex=blocs(j); % select first time value of peak
     startSignal=timeIndex-N/2; % subtract 2s worth od data points from peak to obtian time when shot begins
     endSignal=timeIndex+N/2-1 ;% add 2s worth of data points from peak to obtain end of signal
     if j==1
         startSignal=1;
         endSignal=N;
     else
         if j==length(bpks)
             startSignal=length(timestamp)-N+1;
             endSignal=length(timestamp);
         end
     end
     SignalTime(:,j) = timestamp(startSignal:endSignal); % 1 shot in time index to be saved in Signal matrix
     SignalX(:,j) = faccX(startSignal:endSignal);
     SignalY(:,j) = faccY(startSignal:endSignal);
     SignalZ(:,j) = faccZ(startSignal:endSignal);
    
end

%PUT IN CROSS-CORRELATION FUNCTION CODE
% compute the mean of each sample point of all signals
% Average_Signal_X = zeros(length(SignalTime(:,1)));
% Average_Signal_Y = zeros(length(SignalTime(:,1)));
% Average_Signal_Z = zeros(length(SignalTime(:,1)));
% 
% for i=1:length(SignalTime(:,1))
%     Average_Signal_X(i,:) = mean(SignalX(i,:));
%     Average_Signal_Y(i,:) = mean(SignalY(i,:));
%     Average_Signal_Z(i,:) = mean(SignalZ(i,:));
% end
% %Specify time array from 0 to 1.5 with increments of 0.125
% incr = 1.5/120;
% Signal_time_average = 0:incr:1.5-incr;
% %plot the average signal across the time interval
% % figure
% % hold on
% % plot(Signal_time_average, Average_Signal_X,'r');
% % plot(Signal_time_average, Average_Signal_Y,'g');
% % plot(Signal_time_average, Average_Signal_Z,'b');
% % legend('w_x','w_y','w_z')
% % hold off
% 
% % figure
% % hold on
% %compute cross-correlation of every signal with the average signal and
% %align them in plot
% for j=2:length(bpks)-1
%     %for X
%     SjX = SignalX(:,j);
%     [CjX,lagjX] = xcorr(SjX,Average_Signal_X(:,j));
%     CjX = CjX/max(CjX);
%     [MjX,IjX] = max(CjX);
%     tjX = lagjX(IjX);
%     
%     %for Y
%     SjY = SignalY(:,j);
%     [CjY,lagjY] = xcorr(SjY,Average_Signal_Y(:,j));
%     CjY = CjY/max(CjY);
%     [MjY,IjY] = max(CjY);
%     tjY = lagjY(IjY);
% 
%     
%     %for Z
%     SjZ = SignalZ(:,j);
%     [CjZ,lagjZ] = xcorr(SjZ,Average_Signal_Z(:,j));
%     CjZ = CjZ/max(CjZ);
%     [MjZ,IjZ] = max(CjZ);
%     tjZ = lagjZ(IjZ);
%     
%     if tjX == 0
%         SjX_new(:,j) = SjX(1:end);
% %         plot(Signal_time_average,SjX_new,'r'); 
%     
%     else
%         SjX_new(1:abs(tjX),j) = 0;
%         SjX_new(abs(tjX):120,j) = SjX(abs(tjX):end);
% %         plot(Signal_time_average(abs(tjX):end),SjX_new,'r'); 
%     end
%     
%     if tjZ == 0
%         SjZ_new(:,j) = SjZ(1:end);
% %         plot(Signal_time_average,SjZ_new,'b'); 
%     
%     else
%         SjZ_new(1:abs(tjZ),j) = 0;
%         SjZ_new(abs(tjZ):120,j) = SjZ(abs(tjZ):end);
% %         plot(Signal_time_average(abs(tjZ):end),SjZ_new,'b'); 
%     end
%    
%     
%     if tjY == 0
%         SjY_new(:,j) = SjY(1:end);
% %         plot(Signal_time_average,SjY_new,'g'); 
%     else
%         SjY_new(1:abs(tjY),j) = 0;
%         SjY_new(abs(tjY):120,j) = SjY(abs(tjY):end);
% %         plot(Signal_time_average(abs(tjY):end),SjY_new,'g');
%     end

   
% legend('w_x','w_y','w_z')
% end
% xlabel('Time (s)'); %x-axis label 
% set(gca,'XTickLabel',{'1','2','3','4',},'XTick',[126 252 378 504],'Fontsize',18);
% ylabel('Acceleration (g)'); %y-asix label
% legend boxoff
% hold off


% figure
% hold on
% for plotIdx = 1:size(SignalX,2)
%      plot(SignalX(:,plotIdx),'r'); % overlay all forehand shots onto 1 curve
%      plot(SignalY(:,plotIdx),'g'); % overlay all forehand shots onto 1 curve
%      plot(SignalZ(:,plotIdx),'b'); % overlay all forehand shots onto 1 curve
%      legend('a_x','a_y','a_z')
% end
% xlabel('Time (s)'); %x-axis label 
% set(gca,'XTickLabel',{'1','2','3','4',},'XTick',[126 252 378 504],'Fontsize',18);
% ylabel('Acceleration (g)'); %y-asix label
% legend boxoff
% hold off
end

