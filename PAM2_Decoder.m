function bitsOut = PAM2_Decoder(quantizedSymbols)
    bitsOut = '';    
    for i = 1:length(quantizedSymbols)
        if quantizedSymbols(i) == 1
            %decimalArray = dec2bin(quantizedSymbols(i));
            bitsOut(i) =  dec2bin(1);
        else
            bitsOut(i) =  dec2bin(0);
        end
    end
    totLength = length(bitsOut);
    rem = mod(totLength, 7);
    if rem
        bitsOut = bitsOut(1:end-rem);
    end
end