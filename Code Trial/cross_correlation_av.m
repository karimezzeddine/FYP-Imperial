function [SjY_new, Average_Signal] = cross_correlation_av(Signal,i,SignalTime)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
SjY1 = Signal(:,i) ;
SjY2 = Signal(:,i+1) ;
[CjY,lagjY] = xcorr(SjY1,SjY2);
CjY = CjY/max(CjY);
[MjY,IjY] = max(CjY);
tjY = lagjY(IjY);

%before cross-correlation
% figure
% hold on
% plot(SignalTime(:,1),SjY1,'r'); 
% plot(SignalTime(:,1),SjY2,'b'); 
% hold off

N = 120;
%cross-correlation
SjY_new = zeros(N,1);
    
if tjY==0
    SjY_new(:,1) = SjY1(1:end);
elseif tjY > 0 
    SjY_new(1:length(SjY1)-abs(tjY)+1,1) = SjY1(abs(tjY):N);
    SjY_new(length(SjY1)-abs(tjY)+1:N,1) = 0;
else
    SjY_new(1:abs(tjY),1) = 0;
    SjY_new(abs(tjY):N,1) = SjY1(1:N+1-abs(tjY));
end
    
%After cross-correlation
% figure
% hold on
% plot(SignalTime(:,1),SjY_new,'r'); 
% plot(SignalTime(:,1),SjY2,'b'); 
% hold off

% compute the mean of each sample point of all signals

Average_Signal = zeros(length(SignalTime(:,1)),1);
% 
for j=1:length(SignalTime(:,1))
    Average_Signal(j,:) = mean(Signal(j,i:i+1));
end

% figure
% hold on
% plot(SignalTime(:,1),Average_Signal,'g');
% hold off

end

