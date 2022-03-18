%% This is a 4PAM SINC pulse example.. It works for quite large sps values.

close all
clear all
clc
sps = 26;
sinc1 = PulseShape('SINC', sps, 1);

pulse = sinc1.vals;
Lidx = sinc1.L1idx;
Ridx = sinc1.R1idx;
Zidx = sinc1.Z1idx;

plot(pulse)
hold on
pulse2 = [zeros(1, Zidx-Lidx), pulse];
pulse3 = [zeros(1, Zidx-Lidx-1),zeros(1, Zidx-Lidx), pulse];
plot(pulse2)
plot(pulse3)
%%

pulse1 = [pulse, zeros(1, Zidx-Lidx)];

sumpulse = pulse1+pulse2;

figure
plot(sumpulse)

NumPulses = 10;

symbol = [1 1 -1 3 1 3 -1 -3 1 -1];

totalPulse = zeros(1, NumPulses*(Zidx-Lidx)+length(pulse));
for i = 1:NumPulses
   for j = 1:sps 
        totalPulse((i-1)*(Zidx-Lidx)+j)= totalPulse((i-1)*(Zidx-Lidx)+j) + pulse(j)*symbol(i);
   end
end
figure
plot(totalPulse);

% extractVals
extractedVals = NaN(1, NumPulses);
for i = 1:NumPulses    
    extractedVals(i) = totalPulse((i-1)*(Zidx-Lidx)+Zidx);    
end
stem(extractedVals)
hold on

quantizedVals = NaN(1, length(extractedVals));
for i = 1:length(extractedVals)
    if extractedVals(i) >= 0 && extractedVals(i) <2
        quantizedVals(i) = 1;        
    elseif extractedVals(i) < 0 && extractedVals(i) >=-2
        quantizedVals(i) = -1;
    elseif  extractedVals(i) < -2
        quantizedVals(i) = -3;        
    elseif  extractedVals(i) >= 2
        quantizedVals(i) = 3;
    end    
end
stem(quantizedVals)