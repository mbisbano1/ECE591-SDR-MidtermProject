function [symbols, bitsTransmitted, offset] = PAM2_SymbolGen(bitsIn)    
    L = length(bitsIn);
    offset = 0;
    bitsTransmitted = bitsIn;
    symbols = NaN(L,1);
    for i = 1:L
        symbols(i) = 2.*bin2dec(bitsIn(i))-1;
    end
end