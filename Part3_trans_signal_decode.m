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

%% Part 3: Decode Hidden Message (30 Points)
load trans_signal.mat
%%
transmissionDelay = delta;
Ts = 1/fs;
sps = fs/symbolrate;
% Ss = 1/symbolrate;
attenuation = gain;
%%

numSamplesTransDelay = transmissionDelay/Ts;
numSamplesTauDelay = tau/Ts;

pulse = PulseShapeNumeric(pulseshape, sps, 1);
ES = EncodingSchemeNumeric(modulation);
rxSignal = signal/gain;

timescale = 0:Ts:(length(rxSignal)-1)*Ts;

%%
if pulse.id == 0            % not sinc pulse shape
    firstSampleIndex = numSamplesTransDelay+numSamplesTauDelay + sps/2;
    curIndex = firstSampleIndex;

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

    rxBits = eval(ES.decode_expression);

    %if strcmp(rxBits, inputBits)
    %    disp('Nice');
    %end
end
if pulse.id == 1        % sinc pulse shape
    L1idx = pulse.L1idx;
    Z1idx = pulse.Z1idx;
    R1idx = pulse.R1idx;
    IndexIncrement = Z1idx-L1idx;
    % polling time i (in samples) = numSamplesTransmissionDelay +
    % numSamplesTauDelay + Z1idx + (i-1)*(Z1idx-L1idx);
    firstSampleIndex = numSamplesTransDelay + numSamplesTauDelay + 6*sps;
    curIndex = firstSampleIndex;
    sampledSymbols = [];
    idx = 1;
    while curIndex <= length(rxSignal)-6*sps+1
        sampledSymbols(idx) = rxSignal(curIndex);
        idx = idx +1;
        curIndex = curIndex + (sps);
    end
    %disp(idx-1);
    figure(3)
    stem(sampledSymbols);
    hold on
    quantizedSymbols = eval(ES.quantizer_expression);
    stem(quantizedSymbols);   
    rxBits = eval(ES.decode_expression);    
    title('Sampled vs. Quantized Values');
    legend('Sampled', 'Quantized');
end
%rxBits = inputBits;
rxMessage = bin2ascii(rxBits);
rxString = convertCharsToStrings(rxMessage);
disp(['Received Message: ', rxMessage'])



