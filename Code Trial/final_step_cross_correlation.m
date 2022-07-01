function  Sj_All = final_step_cross_correlation(Signal1,Signal2,SignalTime)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

Sj_all = zeros(length(Signal1(:,1)),length(Signal1(1,:)));
N=120;
% figure
% hold on
    
for i=1:length(Signal1(1,:))-1
    SjY1 = Signal1(:,i);
    SjY2 = Signal2 ;
    [CjY,lagjY] = xcorr(SjY1,SjY2);
    CjY = CjY/max(CjY);
    [MjY,IjY] = max(CjY);
    tjY = lagjY(IjY);
    
    
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

    Sj_All(:,i) = SjY_new;
end
% plot(SignalTime(:,1),Signal2,'b');
% hold off
end

