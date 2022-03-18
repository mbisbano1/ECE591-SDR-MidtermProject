% ECE403/591
% Baseband transmission using 2-PAM
clear all;
close all;
fs = 48000; % sampling frequency
Ts = 1/fs; % sampling duration
symbolrate = 1000; % transmitted pulses/second should be an integer divisor of fs
sps = fs/symbolrate; % number of samples in one symbol
%% Transmitter setup
% define the basic rectangular pulse shape
pulse = ones(1,sps); % 1 pulse
data = [1 0 1 1 0 0 1 1 1 0 0 0 1 1 0 1 1 0];
[number, length0] = size(data);
symbol = 2*data-1;
for i = 1: length0
for j=1:sps
signal((i-1)*sps + j) = symbol(i) * pulse(j);
end
end
index = 0: Ts: (length0*sps-1)*Ts;
freq=fft(signal);
freq=fftshift(freq);
%%
figure(1);
plot(index, signal);
axis([0 1.5*length0*sps*Ts -2 2]);
xlabel('time');
ylabel('amplitude');
title('basband transmission signal of 2PAM');
figure(2);
plot(abs(freq));
xlabel('frequency');
ylabel('magnitude');
title('spectrum of 2PAM signal');