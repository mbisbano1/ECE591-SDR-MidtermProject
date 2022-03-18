function bitsOut = PAM8_Decoder(quantizedSymbols)
    bitsOut = '';    
    %symbolMap = [-7, -5, -1, -3, 7, 5, 1, 3];
%                  0   1   2   3  4  5  6  7
    for i = 1:length(quantizedSymbols)
        switch quantizedSymbols(i)
            case 3
                decimalVal = 7;
            case 1
                decimalVal = 6;
            case 5
                decimalVal = 5;
            case 7
                decimalVal = 4;
            case -3
                decimalVal = 3;
            case -1
                decimalVal = 2;
            case -5
                decimalVal = 1;
            case -7
                decimalVal = 0;
        end
        bitsOut = [bitsOut, dec2bin(decimalVal, 3)];
    end
    totLength = length(bitsOut);
    rem = mod(totLength, 7);
    if rem
        bitsOut = bitsOut(1:end-rem);
    end
end