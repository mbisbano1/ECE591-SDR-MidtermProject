function [symbols, bitsTransmitted, offset] = OOK_SymbolGen(bitsIn)    
    L = length(bitsIn);
    offset = 0;
    bitsTransmitted = bitsIn;
    symbols = NaN(L,1);
    for i = 1:L
        symbols(i) = bin2dec(bitsIn(i));
    end
end