% ECE591: Software Defined Radio
% Midterm 1
% Michael Bisbano
%       &
% Jin Feng Lin
% 3-4-2022
clear all
close all
clc
format shortEng
format compact
%% Part 1: Transmitter Design (25 Points)
inputMessage = input('Enter Message to Transmit: ', 's');
inputBits = ascii2bin(inputMessage);
numBitsInMessage = length(inputBits);

EncodingSchemeString = input('Enter Encoding Scheme {OOK, 2PAM, 4PAM, 8PAM}: \n-> ', 's');
PulseShapeString = input('Enter Pulse Shape {RECT, HAMM, HANN, SINC}: \n-> ', 's');
%txGain = input('Enter Transmission Gain: ');
txGain = 1;


fs = 48000; % sampling frequency
Ts = 1/fs; % sampling duration
symbolrate = 1000; % transmitted pulses/second should be an integer divisor of fs, modify for sinc
sps = fs/symbolrate; % number of samples in one symbol
samplesPerTau = floor(1500*rand);
tau = Ts.*samplesPerTau;
%tau = 0 + 0.05*roundedRand100/100; % initial time delay between 0 and 0.05 seconds
%samplesPerTau = fs*tau;
ES = EncodingScheme(EncodingSchemeString);
pulse = PulseShape(PulseShapeString, sps, 1);

%plot(pulse)

%% construct pulse:
[number, length0] = size(inputBits);
data = inputBits;
[symbol, bitsTransmitted, offset] = eval(ES.symbol_expression);
[signal, index, axisArg] = eval(ES.signal_expression);
%
%for i = 1:length0
%    for j = 1:sps
%        signal((i-1)*sps+j) = symbol(i)*pulse(j);
%    end    
%end
signal = signal*txGain;

%%
%index = 0:Ts: ((length0/2)*sps-1)*Ts;
freq=fft(signal);
freq = fftshift(freq);
figure(1);
plot(index, signal);
axis(axisArg);
xlabel('time');
ylabel('amplitude');
title(['basband transmission of ', EncodingSchemeString, ' signal, window shape ', PulseShapeString]);
figure(2);
plot(abs(freq));
xlabel('frequency');
ylabel('magnitude');
title(['spectrum of ', EncodingSchemeString,' signal, window shape ', PulseShapeString]);
%% Part 2: Receiver Design (25 Points)
transmissionDelaySamples = floor(1500*rand);
transmissionDelay = Ts*transmissionDelaySamples;
transDelaySignal = zeros(transmissionDelaySamples, 1);


rxSignal = signal/txGain;
rxSignal = [transDelaySignal; rxSignal];

numSamplesTransDelay = transmissionDelay/Ts;
numSamplesTauDelay = tau/Ts;

if pulse.id == 0            % not sinc pulse shape
    firstSampleIndex = numSamplesTransDelay+numSamplesTauDelay + sps/2;
    curIndex = int64(firstSampleIndex);

    sampledSymbols = [];
    idx = 1;
    while curIndex <= length(rxSignal)

        sampledSymbols(idx) = rxSignal(curIndex);
        idx = idx +1;
        curIndex = curIndex + sps;
    end
    %disp(idx-1);

    figure(3)
    stem(sampledSymbols);
    hold on
    quantizedSymbols = eval(ES.quantizer_expression);
    stem(quantizedSymbols);
    title('Sampled vs. Quantized Values');
    legend('Sampled', 'Quantized');
    rxBits = eval(ES.decode_expression);

    %if strcmp(rxBits, inputBits)
    %    disp('Nice');
    %end
elseif pulse.id == 1        % sinc pulse shape
    L1idx = pulse.L1idx;
    Z1idx = pulse.Z1idx;
    R1idx = pulse.R1idx;
    % polling time i (in samples) = numSamplesTransmissionDelay +
    % numSamplesTauDelay + Z1idx + (i-1)*(Z1idx-L1idx);
    firstSampleIndex = numSamplesTransDelay + numSamplesTauDelay + 6*sps;
    curIndex = firstSampleIndex;
    IndexIncrement = Z1idx-L1idx;
    sampledSymbols = [];
    idx = 1;
    while curIndex <= length(rxSignal)-6*sps+1
        sampledSymbols(idx) = rxSignal(curIndex);
        idx = idx +1;
        curIndex = curIndex + (sps);
    end
    %disp(idx-1);
    fig = figure(3);
    set(gcf(), 'Position',[296 274 560 166]);
    stem(sampledSymbols);
    hold on
    quantizedSymbols = eval(ES.quantizer_expression);
    stem(quantizedSymbols);
    title('Sampled vs. Quantized Values');
    legend('Sampled', 'Quantized');
    
    rxBits = eval(ES.decode_expression);
    
    
end
%rxBits = inputBits;
rxMessage = bin2ascii(rxBits);
rxString = convertCharsToStrings(rxMessage);
disp(['Received Message: ', rxMessage'])
%% Part 3: Decode the Given Data (30 Points)


