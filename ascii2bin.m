function binRow = ascii2bin(inString)
    x = dec2bin(inString,7);
    y = reshape(x', 1, numel(x));
    binRow = y;


end 