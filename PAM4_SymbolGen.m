function [symbols, bitsTransmitted, offset] = PAM4_SymbolGen(bitsIn)    
    L = length(bitsIn);
    offset = 0;
    if mod(L,2) == 1        % if L is ODD
                            % will need to append a zero to the end?
        bitsIn = [bitsIn, '0'];
        L = L+1;
        offset = 1;
    end
    bitsTransmitted = bitsIn;
    symbols = NaN(L/2,1);
    %                       0   1  2  3
    symbolMap = [-3, -1, 3, 1];
    for i = 1:2:L-1
        Index = floor(i/2)+1;
        symbols(Index) = symbolMap(bin2dec(bitsIn(i:i+1))+1);
    end
end