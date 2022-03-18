function asciiString = bin2ascii(bits)

    decString = bin2dec(reshape(bits, 7, []).');
    %asciiString = char(decString);
    asciiString = native2unicode(decString, 'US-ASCII');
end