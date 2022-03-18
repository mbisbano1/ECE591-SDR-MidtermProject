function metadata = EncodingScheme(encodingString)
    switch encodingString
        case 'OOK'
            metadata.BitsPerSymbol = 1;
            metadata.symbolMap = [0, 1];
            %                     0, 1
            metadata.symbol_expression = 'OOK_SymbolGen(data)';
            metadata.signal_expression = 'OOK_SignalGen(symbol, length0, sps, Ts, pulse, samplesPerTau)';
            metadata.quantizer_expression = 'OOK_Quantizer(sampledSymbols)';
            metadata.decode_expression = 'OOK_Decoder(quantizedSymbols)';
        case '2PAM'            
            metadata.BitsPerSymbol = 1;
            metadata.symbolMap = [-1, 1];
            %                      0, 1
            metadata.symbol_expression = 'PAM2_SymbolGen(data)';
            metadata.signal_expression = 'PAM2_SignalGen(symbol, length0, sps, Ts, pulse, samplesPerTau)';
            metadata.quantizer_expression = 'PAM2_Quantizer(sampledSymbols)';
            metadata.decode_expression = 'PAM2_Decoder(quantizedSymbols)';
        case '4PAM'
            metadata.BitsPerSymbol = 2;
            %metadata.symbolMap = [-3, -1, 1, 3];
            % %                      0   1  3  2
            metadata.symbolMap = [-3, -1, 3, 1];
            %                      0   1  2  3
            metadata.symbol_expression = 'PAM4_SymbolGen(data)';
            metadata.signal_expression = 'PAM4_SignalGen(symbol, length0, sps, Ts, pulse, samplesPerTau)';
            metadata.quantizer_expression = 'PAM4_Quantizer(sampledSymbols)';
            metadata.decode_expression = 'PAM4_Decoder(quantizedSymbols)';
            
        case '8PAM'
            metadata.BitsPerSymbol = 3;
            %metadata.symbolMap = [-7, -5, -3, -1, 1, 3, 5, 7];
            %                      0   1   3   2  6  7  5  4
            metadata.symbolMap = [-7, -5, -1, -3, 7, 5, 1, 3];
            %                      0   1   2   3  4  5  6  7
            
            metadata.symbol_expression = 'PAM8_SymbolGen(data)';
            metadata.signal_expression = 'PAM8_SignalGen(symbol, length0, sps, Ts, pulse, samplesPerTau)';
            metadata.quantizer_expression = 'PAM8_Quantizer(sampledSymbols)';
            metadata.decode_expression = 'PAM8_Decoder(quantizedSymbols)';
        otherwise
            metadata = 'error';
    end
end