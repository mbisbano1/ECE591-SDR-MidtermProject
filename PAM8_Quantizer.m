function quantizedSamples = PAM8_Quantizer(sampledSymbols)
    quantizedSamples = NaN(size(sampledSymbols));
    for i = 1:length(sampledSymbols)
        if sampledSymbols(i) > 6
            quantizedSamples(i) = 7;
        elseif sampledSymbols(i) <= 6 && sampledSymbols(i) > 4
            quantizedSamples(i) = 5;
        elseif sampledSymbols(i) <= 4 && sampledSymbols(i) > 2
            quantizedSamples(i) = 3;
        elseif sampledSymbols(i) <= 2 && sampledSymbols(i) > 0
            quantizedSamples(i) = 1;
        elseif sampledSymbols(i) <= 0 && sampledSymbols(i) > -2
            quantizedSamples(i) = -1;
        elseif sampledSymbols(i) <= -2 && sampledSymbols(i) > -4
            quantizedSamples(i) = -3;
        elseif sampledSymbols(i) <= -4 && sampledSymbols(i) > -6
            quantizedSamples(i) = -5;
        else
            quantizedSamples(i) = -7;
        end        
    end
end