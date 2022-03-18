function quantizedSamples = PAM4_Quantizer(sampledSymbols)
    quantizedSamples = NaN(size(sampledSymbols));
    for i = 1:length(sampledSymbols)
        if sampledSymbols(i) > 2
            quantizedSamples(i) = 3;
        elseif sampledSymbols(i) <= 2 && sampledSymbols(i) > 0
            quantizedSamples(i) = 1;
        elseif sampledSymbols(i) <= 0 && sampledSymbols(i) > -2
            quantizedSamples(i) = -1;
        else
            quantizedSamples(i) = -3;
        end        
    end
end