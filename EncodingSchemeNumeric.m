function metadata = EncodingSchemeNumeric(encodingNum)    
    switch encodingNum        
        case 1
            metadata = EncodingScheme('OOK');
        case 2
            metadata = EncodingScheme('2PAM');
        case 4
            metadata = EncodingScheme('4PAM');
        case 8
            metadata = EncodingScheme('8PAM');
    end
end