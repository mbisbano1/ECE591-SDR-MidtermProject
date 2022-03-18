function [signal, index, axisArg] = PAM8_SignalGen(symbol, length0,sps, Ts, pulse, samplesPerTau)
    if pulse.id == 0
        signal = NaN((length0/3-1)*sps,1);
        index = signal;
        %for i = 1:length0/3
        for i = 1:length0/3+1
            for j = 1:sps
                signal((i-1)*sps+j) = symbol(i)*pulse.vals(j);
            end    
        end
        %signal = [zeros(samplesPerTau, 1); signal];
        delaySignal = zeros(samplesPerTau, 1);
        signal = [delaySignal; signal];
        totLen = length(signal);
        index = 0:Ts: (totLen-1)*Ts;
        axisArg = [0, Ts*(totLen+10), min(signal)-1, max(signal)+1];    
    elseif pulse.id == 1
        Lidx = pulse.L1idx;
        Zidx = pulse.Z1idx;
        Ridx = pulse.R1idx;
        %signal = zeros(ceil((length0/3)*(Zidx-Lidx)+length(pulse.vals)), 1);
        signal = zeros(length0/3*(sps)+length(pulse.vals), 1);
        %signal = zeros((length0)*sps,1);
        %signal = zeros(1, sps);
        for i = 1:length0/3+1
            for j = 1:length(pulse.vals)
                %try
                %    signal((i-1)*(Zidx-Lidx)+j)= signal((i-1)*(Zidx-Lidx)+j) + pulse.vals(j)*symbol(i);
                %catch EEE
                    %signal((i-1)*(Zidx-Lidx)+j)= signal((i-1)*(Zidx-Lidx)+j) + pulse.vals(j)*0;                    
                %end
                if i < length(symbol)
                    signal((i-1)*(sps)+j)= signal((i-1)*(sps)+j) + pulse.vals(j)*symbol(i);                    
                end
            end
        end
        delaySignal = zeros(samplesPerTau, 1);
        signal = [delaySignal; signal];
        totLen = length(signal);
        index = 0:Ts: (totLen-1)*Ts;
        axisArg = [0, Ts*(totLen+10), min(signal)-1, max(signal)+1];
    end
end