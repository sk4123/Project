% returns the angular frequency and it's raw magnitude
% as well as a plot of the Fourier Transform of the data
function i = env(data,tvec)
    % number of data points:
    n = length(data);
    % sampling rate:
    fs = 1/(tvec(2)-tvec(1));
    
    % define the frequency vector:
    fBase = [1:n/2-1]*fs/n;
    % transform the time-domain data to the frequency domain:
    FT_data = fft(data);
    
    new = abs(FT_data(2:n/2));
    [b, j] = sort(new(:), 'descend');
    i = 2*pi*fs*j(1)/1000;

    figure;plot(fBase,new);grid
    xlim([0 8])
    xlabel('Frequency (Hz)')
    ylabel('Amplitude')
    title('Fourier transform of the data')
end