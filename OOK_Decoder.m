function bitsOut = OOK_Decoder(quantizedSymbols)
    bitsOut = '';
    for i = 1:length(quantizedSymbols)
        bitsOut(i) = dec2bin(quantizedSymbols(i));
    end
    totLength = length(bitsOut);
    rem = mod(totLength, 7);
    if rem
        bitsOut = bitsOut(1:end-rem);
    end
end