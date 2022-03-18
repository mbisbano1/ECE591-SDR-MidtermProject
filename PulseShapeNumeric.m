function pulse = PulseShapeNumeric(shapeNum, pulseLength, symbolVal)
    switch(shapeNum)
        case 1
            pulse = PulseShape('RECT', pulseLength, symbolVal);
        case 2
            pulse = PulseShape('HAMM', pulseLength, symbolVal);
        case 3
            pulse = PulseShape('HANN', pulseLength, symbolVal);
        case 4
            pulse = PulseShape('SINC', pulseLength, symbolVal);
    end
end