function [signal, index, axisArg] = OOK_SignalGen(symbol, length0,sps, Ts, pulse, samplesPerTau)

    if pulse.id == 0                    % rect, hamm, or hann
        signal = NaN((length0)*sps,1);
        index = signal;
        for i = 1:length0
            for j = 1:sps
                signal((i-1)*sps+j) = symbol(i)*pulse.vals(j);
            end    
        end
        delaySignal = zeros(samplesPerTau, 1);
        signal = [delaySignal; signal];
        totLen = length(signal);
        index = 0:Ts: (totLen-1)*Ts;
        axisArg = [0, Ts*(totLen+10), min(signal)-1, max(signal)+1];
        
    elseif pulse.id == 1                % sinc window
        Lidx = pulse.L1idx;
        Zidx = pulse.Z1idx;
        Ridx = pulse.R1idx;
        %signal = zeros(length0*(Zidx-Lidx)+length(pulse.vals), 1);
        length(pulse.vals);
        signal = zeros(length0*(sps)+length(pulse.vals), 1);
        %signal = zeros((length0)*sps,1);
        for i = 1:length0
            for j = 1:length(pulse.vals) 
                signal((i-1)*(sps)+j)= signal((i-1)*(sps)+j) + pulse.vals(j)*symbol(i);
            end
        end
        delaySignal = zeros(samplesPerTau, 1);
        signal = [delaySignal; signal];
        totLen = length(signal);
        index = 0:Ts: (totLen-1)*Ts;
        axisArg = [0, Ts*(totLen+10), min(signal)-1, max(signal)+1];
    end
end