N = 500;        % Number of samples
nn = 0:N-1;

% Call the function 'ecg' to generate the signal
sn = ecg(N);    % s[n] is the clean ECG signal

% Plot noisy ECG signal with three different sigma values on the same figure
sigmas = [0.2, 0.5, 0.7];       % Standard deviation of the noise fluctuations
        % Larger sigma means the more noisy x[n] will look like when plotted vs n

% Loop to generate and plot clean & noisy ECG signals for diff sigmas
figure;
for i = 1:length(sigmas)
    sigma = sigmas(i);
    xn = sn + sigma * randn(1, N);      % x[n] is the noisy ECG signal

    subplot(3, 1, i);                   % Create a subplot for each sigma value
    plot(nn, xn, nn, sn);   % Use plot insteam of stem for plot clarity
    % Add labels and titles
    xlabel('Sample index n');
    ylabel('Amplitude');
    title(['Comparison of Noisy and Clean ECG Signals (Sigma = ', num2str(sigma), ')']);
    legend('x[n] - Noisy ECG signal', 's[n] - Clean ECG signal');
    grid on;
end


%-----------------------------------------------
% Plot diff sigmas (sigma = 0.2, 0.5, 0.7) w/ same order filter (N = 10)
M = 10;
h = ones(1,M+1)/(M+1);      % h is the moving avg FIR filter

figure;
for i = 1:length(sigmas)
    sigma = sigmas(i);
    xn = sn + sigma * randn(1, N);
    yn = conv(xn, h, 'same');       % Compute the moving avg filter using 'conv' func
    y_filter = filter(h, 1, xn);    % Filtered signal using 'filter' func
    
    subplot(3, 1, i);               % Create a subplot for each sigma value
    plot(nn, xn, nn, sn, nn, y_filter);
    % Add labels and titles
    xlabel('Sample index n');
    ylabel('Amplitude');
    title(['Filtered ECG Signals (Sigma = ', num2str(sigma), ' & Filter Order M = ', num2str(M), ')']);
    legend('x[n] - Noisy ECG signal', 's[n] - Clean ECG signal', 'y_{filter}[n]');
    grid on;
end


%-----------------------------------------------
% Plot diff filter orders (M = 10, 50, 100) for sigma = 0.2
sigma = 0.2;
filter_orders = [10, 50, 100];

figure;
for i = 1:length(filter_orders)
    M = filter_orders(i);
    h = ones(1, M+1) / (M+1);       % Moving average FIR filter
    xn = sn + sigma * randn(1, N);
    yn = conv(xn, h, 'same');       % Compute the moving avg filter using 'conv' func
    y_filter = filter(h, 1, xn);    % y_filter[n] is the filtered signal using 'filter' func
    
    subplot(3, 1, i);               % Create subplot for each filter order
    % Add labels and titles
    plot(nn, xn, nn, sn, nn, y_filter);
    xlabel('Sample index n');
    ylabel('Amplitude');
    title(['Filtered ECG Signals (Sigma = 0.2 & Filter Order M = ', num2str(M), ')']);
    legend('x[n] - Noisy ECG signal', 's[n] - Clean ECG signal', 'y_{filter}[n]');
    grid on;
end
