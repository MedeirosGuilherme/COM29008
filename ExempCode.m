N = 63;  % Codeword length
K = 51;  % Message length
S = 39;  % Shortened message length
M = 64;  % Modulation order

numErrors = 200;
numBits = 1e7;
ebnoVec = (8:13)';
[ber0,ber1] = deal(zeros(size(ebnoVec)));

errorRate = comm.ErrorRate;

rsEncoder = comm.RSEncoder(N,K,'BitInput',true);
rsDecoder = comm.RSDecoder(N,K,'BitInput',true);
rate = K/N;

for k = 1:length(ebnoVec)
    
    % Convert the coded Eb/No to an SNR. Initialize the error statistics
    % vector.
    snrdB = ebnoVec(k) + 10*log10(rate) + 10*log10(log2(M));
    errorStats = zeros(3,1);
    
    while errorStats(2) < numErrors && errorStats(3) < numBits
        
        % Generate binary data.
        txData = randi([0 1],K*log2(M),1);
        
        % Encode the data.
        encData = rsEncoder(txData);
        
        % Apply 64-QAM modulation.
        txSig = qammod(encData,M, ...
            'UnitAveragePower',true,'InputType','bit');
        
        % Pass the signal through an AWGN channel.
        rxSig = awgn(txSig,snrdB);
        
        % Demodulated the noisy signal.
        demodSig = qamdemod(rxSig,M, ...
            'UnitAveragePower',true,'OutputType','bit');
        
        % Decode the data.
        rxData = rsDecoder(demodSig);
        
        % Compute the error statistics.
        errorStats = errorRate(txData,rxData);
    end
    
    % Save the BER data, and reset the errorRate counter.
    ber0(k) = errorStats(1);
    reset(errorRate)
end

gp = rsgenpoly(N,K,[],0);

rsEncoder = comm.RSEncoder(N,K,gp,S,'BitInput',true);
rsDecoder = comm.RSDecoder(N,K,gp,S,'BitInput',true);
rate = S/(N-(K-S));

for k = 1:length(ebnoVec)
    
    % Convert the coded Eb/No to an SNR. Initialize the error statistics
    % vector.
    snrdB = ebnoVec(k) + 10*log10(rate) + 10*log10(log2(M));
    errorStats = zeros(3,1);
    
    while errorStats(2) < numErrors && errorStats(3) < numBits
        
        % Generate binary data.
        txData = randi([0 1],S*log2(M),1);
        
        % Encode the data.
        encData = rsEncoder(txData);
        
        % Apply 64-QAM modulation.
        txSig = qammod(encData,M, ...
            'UnitAveragePower',true,'InputType','bit');
        
        % Pass the signal through an AWGN channel.
        rxSig = awgn(txSig,snrdB);
        
        % Demodulated the noisy signal.
        demodSig = qamdemod(rxSig,M, ...
            'UnitAveragePower',true,'OutputType','bit');
        
        % Decode the data.
        rxData = rsDecoder(demodSig);
        
        % Compute the error statistics.
        errorStats = errorRate(txData,rxData);
    end
    
    % Save the BER data, and reset the errorRate counter.
    ber1(k) = errorStats(1);
    reset(errorRate)
end

berapprox = bercoding(ebnoVec,'RS','hard',N,K,'qam',64);

semilogy(ebnoVec,ber0,'o-',ebnoVec,ber1,'c^-',ebnoVec,berapprox,'k--')
legend('RS(63,51)','RS(51,39)','Theory')
xlabel('Eb/No (dB)')
ylabel('Bit Error Rate')
grid