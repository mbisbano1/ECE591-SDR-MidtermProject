function bitsOut = PAM4_Decoder(quantizedSymbols)
%                         0   1  2  3
%           symbolMap = [-3, -1, 3, 1];
    bitsOut = '';    
    for i = 1:length(quantizedSymbols)
        switch quantizedSymbols(i)
            
            case 1
                decimalVal = 3;
            case 3
                decimalVal = 2;
            case -1
                decimalVal = 1;
            case -3
                decimalVal = 0;
        end
        bitsOut = [bitsOut, dec2bin(decimalVal, 2)];                
    end
    totLength = length(bitsOut);
    rem = mod(totLength, 7);
    if rem
        bitsOut = bitsOut(1:end-rem);
    end
end