function quantizedSamples = OOK_Quantizer(sampledSymbols)
    quantizedSamples = NaN(size(sampledSymbols));
    for i = 1:length(sampledSymbols)
        if sampledSymbols(i) > 0.5
            quantizedSamples(i) = 1;
        else
            quantizedSamples(i) = 0;
        end        
    end
end