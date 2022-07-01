function [aMax,aMin,aMean,aStd,aArea,gMax,gMin,gMean,gStd,gArea,gravMax,gravMin,gravMean,gravStd,gravArea] = MaxMin_trial(fGyroX,fGyroY,fGyroZ,fAccelX,fAccelY,fAccelZ,fGravX,fGravY,fGravZ)

% Minimum
gMin(:,1)=min(fGyroX);
gMin(:,2)=min(fGyroY);
gMin(:,3)=min(fGyroZ);

aMin(:,1)=min(fAccelX);
aMin(:,2)=min(fAccelY);
aMin(:,3)=min(fAccelZ);

gravMin(:,1)=min(fGravX);
gravMin(:,2)=min(fGravY);
gravMin(:,3)=min(fGravZ);

% gMinMean(1,1)=mean(gMin(1:length(gMin)-1,1));
% gMinMean(1,2)=mean(gMin(1:length(gMin)-1,2));
% gMinMean(1,3)=mean(gMin(1:length(gMin)-1,3));
% aMinMean(1,1)=mean(aMin(1:length(aMin)-1,1));
% aMinMean(1,2)=mean(aMin(1:length(aMin)-1,2));
% aMinMean(1,3)=mean(aMin(1:length(aMin)-1,3));
%%
% Maximum
gMax(:,1)=max(fGyroX);
gMax(:,2)=max(fGyroY);
gMax(:,3)=max(fGyroZ);

aMax(:,1)=max(fAccelX);
aMax(:,2)=max(fAccelY);
aMax(:,3)=max(fAccelZ);

gravMax(:,1)=max(fGravX);
gravMax(:,2)=max(fGravY);
gravMax(:,3)=max(fGravZ);

% gMaxMean(1,1)=mean(gMax(1:length(gMax),1));
% gMaxMean(1,2)=mean(gMax(1:length(gMax),2));
% gMaxMean(1,3)=mean(gMax(1:length(gMax),3));
% aMaxMean(1,1)=mean(aMax(1:length(aMax),1));
% aMaxMean(1,2)=mean(aMax(1:length(aMax),2));
% aMaxMean(1,3)=mean(aMax(1:length(aMax),3));
%%
%Mean
gMean(:,1)=mean(fGyroX);
gMean(:,2)=mean(fGyroY);
gMean(:,3)=mean(fGyroZ);

aMean(:,1)=mean(fAccelX);
aMean(:,2)=mean(fAccelY);
aMean(:,3)=mean(fAccelZ);

gravMean(:,1)=mean(fGravX);
gravMean(:,2)=mean(fGravY);
gravMean(:,3)=mean(fGravZ);

%Std
gStd(:,1)=std(fGyroX);
gStd(:,2)=std(fGyroY);
gStd(:,3)=std(fGyroZ);

aStd(:,1)=std(fAccelX);
aStd(:,2)=std(fAccelY);
aStd(:,3)=std(fAccelZ);

gravStd(:,1)=std(fGravX);
gravStd(:,2)=std(fGravY);
gravStd(:,3)=std(fGravZ);

% Under curve
gArea(:,1)= trapz(fGyroX);
gArea(:,2)= trapz(fGyroY);
gArea(:,3)= trapz(fGyroZ);

aArea(:,1)= trapz(fAccelX);
aArea(:,2)= trapz(fAccelY);
aArea(:,3)= trapz(fAccelZ);

gravArea(:,1)= trapz(fGravX);
gravArea(:,2)= trapz(fGravY);
gravArea(:,3)= trapz(fGravZ);

% Try the Short Time Fourrier Transform (STFT)
% gstft(:,1) = stft(fGyroX);
% gstft(:,2) = stft(fGyroY);
% stft(fGyroZ)

end

