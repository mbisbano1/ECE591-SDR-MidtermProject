function [symbols, bitsTransmitted, offset] = PAM8_SymbolGen(bitsIn)    
    L = length(bitsIn);
    %disp(['Input Length: ', num2str(L)])
    %disp(['Input L%3: ', num2str(mod(L,3))])
    offset = 0;
    if mod(L,3) == 1        % if L doesn't evenly fit into 3's
                            % will need to append a zero to the end?
        bitsIn = [bitsIn, '00'];
        L = L+2;
        offset = 2;
    end
    if mod(L,3) == 2        % if L doesn't evenly fit into 3's
                            % will need to append 2 zeros to the end?
        bitsIn = [bitsIn, '0'];
        L = L+1;
        offset = 1;
    end
    bitsTransmitted = bitsIn;
    %disp(['Fixed Length: ', num2str(L)])
    %disp(['Fixed L%3: ', num2str(mod(L,3))])
    
    symbols = NaN(L/3,1);
    symbolMap = [-7, -5, -1, -3, 7, 5, 1, 3];
%                 0   1   2   3  4  5  6  7
    for i = 1:3:L-2
        Index = floor(i/3)+1;
        symbols(Index) = symbolMap(bin2dec(bitsIn(i:i+2))+1);
    end
end