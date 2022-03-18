function quantizedSamples = PAM2_Quantizer(sampledSymbols)
    quantizedSamples = NaN(size(sampledSymbols));
    for i = 1:length(sampledSymbols)
        if sampledSymbols(i) > 0
            quantizedSamples(i) = 1;
        else
            quantizedSamples(i) = -1;
        end        
    end


end