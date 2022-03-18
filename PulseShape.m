function pulse = PulseShape(shapeString, pulseLength, symbolVal)
    % Returns a pulse shape based on specified length, amplitude, and type
    
    % shapeString == RECT will return a rectangular pulse, amplitude symbolVal, length
    % pulseLength
    
    % shapeString == HAMM returns HAMMING window pulse, peak amp.
    % symbolVal, length pulseLength
    
    % shapeString == HANN returns HANNING window pulse, peak amp.
    % symbolVal, length pulseLength
    
    % shapeString == SINC returns SINC window pulse, peak amp.
    % symbolVal, length pulseLength. SINC pulse has exactly 5 sidelobes per side.
    
    
    switch shapeString
        case 'RECT'
            pulse.vals = ones(1, pulseLength).*symbolVal;
            pulse.id = 0;
        case 'HAMM'
            pulse.vals = hamming(pulseLength).*symbolVal;
            pulse.id = 0;
        case 'HANN'
            pulse.vals = hann(pulseLength).*symbolVal;    
            pulse.id = 0;
        case 'SINC'
            x = linspace(-6, 6, 12*pulseLength);
            pulse.vals = sinc(x).*symbolVal;
            pulse.id = 1;
            [L1, L1index] = min(abs(x+1));
            [R1, R1index] = min(abs(x-1));
            [Z1, Z1index] = min(abs(x));
            pulse.L1idx = L1index;
            pulse.R1idx = R1index;
            pulse.Z1idx = Z1index;
            
        otherwise
            pulse = 'error';        
    end
end