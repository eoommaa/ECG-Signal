N = 500;        % Sample length
nn = 0:N-1;     % Sample vector

% Call the function 'ecg' to generate the signal
sn = ecg(N);        % s[n] is the clean ECG signal

% Create a subplot for clean ECG signal of 500 & 2000 samples respectively by concatenating four 500-sample ECG pulses
figure('Position', [0, 0, 790, 720]);

% Plot the clean ECG signal of 500 samples
subplot(2,1,1)
plot(nn, sn);       % Use plot instead of stem for plot clarity
% Add labels and titles
xlabel('Sample index n');
ylabel('Amplitude');
ylim([-1 1.5])
title('Clean ECG Signal (500 Samples)');
legend('s[n] - Clean ECG signal');
grid on;

% Generate 2000 samples long ECG signal by concatenating four 500-sample ECG pulses
N = 2000;
nn = 0:N-1;
ecg1 = [ecg(500) ecg(500) ecg(500) ecg(500)];   % 2000 samples long ECG signal

% Plot the clean ECG signal of 2000 samples
subplot(2,1,2)
plot(nn, ecg1);     % Use plot instead of stem for plot clarity
% Add labels and titles
xlabel('Sample index n');
ylabel('Amplitude');
ylim([-1 1.5])
title('Clean ECG Signal (2000 Samples)');
legend('ecg_{1}[n] - Clean ECG signal');
grid on;


%-----------------------------------------------
% Generate the same length 60 Hz cosine signal s2[n] w/ amp = 0.2, and phase = 0 sampled @ the same rate as the ecg1[n] signal
% Parameters for 500 samples
Fs = 500;                       % Sampling frequency, same as ecg1[n] signal
N = 500;                        % Sample length
n1 = 0:N-1;                     % Sample vector
t1 = n1/Fs;                     % Time vector for 500 samples
sn1 = 0.2*cos(2*pi*60*t1);      % s1[n] is the 60 Hz cosine signal w/ 0.2 amplitude, & no phase shift. Units = rads/sample

% Parameters for 2000 samples
N = 2000;
n2 = 0:N-1;
t2 = n2/Fs;
sn2 = 0.2*cos(2*pi*60*t2); 

% Create a subplot for 60 Hz cosine signals s1[n] & s2[n]
figure('Position', [0, 0, 790, 720]);

% Plot 60 Hz cosine signal s1[n] of 500 samples
subplot(2,1,1)
plot(n1, sn1)       % Use plot instead of stem for plot clarity
% Add labels and titles
xlabel('Sample index n');
ylabel('Amplitude');
ylim([-0.3 0.3])
title('60 Hz Cosine Signal Sampled at 500 Hz (500 Samples)');
legend('s_{1}[n] - Cosine signal');
grid on;

% Plot cosine signal s2[n] of 2000 samples
subplot(2,1,2)
plot(n2, sn2)       % Use plot instead of stem for plot clarity
% Add labels and titles
xlabel('Sample index n');
ylabel('Amplitude');
ylim([-0.3 0.3])
title('60 Hz Cosine Signal Sampled at 500 Hz (2000 Samples)');
legend('s_{2}[n] - Cosine signal');
grid on;


%-----------------------------------------------
% Generate the corrupted (can be noisy or unfiltered) signal x[n]
xn = ecg1 + sn2;        % x[n] is noisy signal from the sum of ecg1[n] & s[n] signals

% Filter the messy signal x[n] using 2nd order IIR notch filter of bandwidth = 2 Hz w/ 'designfilt'
d = designfilt('bandstopiir', 'FilterOrder', 2, 'HalfPowerFrequency1', 59, ...
    'HalfPowerFrequency2', 61, 'DesignMethod', 'butter', 'SampleRate', Fs);
yn = filtfilt(d, xn);       % y[n] is the output signal after filtering the messy ECG signal x[n] w/ 'filtfilt'

% Create a subplot for x[n], x[n] & y[n], and y[n]
figure('Position', [0, 0, 790, 720]);

% Plot corrupted signal x[n]
subplot (3,1,1)
plot(nn, xn)        % Use plot instead of stem for plot clarity
% Add labels and titles
xlabel('Sample index n');
ylabel('Amplitude');
ylim([-1 1.5])
title('ECG Signal with 60 Hz Interference');
legend('x[n] - Unfiltered ECG signal');
grid on;

% Plot unfiltered & filtered ECG signals
subplot(3,1,2)
plot(nn, xn);
hold on;        % Keeps the first plot, so second one can be plotted
plot(nn, yn);
hold off;       % Releases the hold to avoid overwriting the plot
% Add labels and titles
xlabel('Sample index n');
ylabel('Amplitude');
ylim([-1 1.5])
title('ECG Signal Filtering using {\itdesignfilt} and {\itfiltfilt}');
legend('x[n] - Unfiltered ECG signal','y[n] - Filtered ECG signal')
grid on

% Plot filtered ECG signal y[n]
subplot(3,1,3)
plot(nn, yn)
% Add labels and titles
xlabel('Sample index n');
ylabel('Amplitude');
ylim([-1 1.5])
title('Filtered ECG Signal')
legend('y[n] - Filtered ECG signal')
grid on


%-----------------------------------------------
% Plot to compare 2000 samples long ECG signal and filtered ECG signal
figure('Position', [0, 0, 790, 720]);
plot(nn, ecg1, 'LineWidth', 1.5);
hold on;        % Keeps the first plot, so second one can be plotted
plot(nn, yn);
hold off;       % Releases the hold to avoid overwriting the plot
% Add labels and titles
xlabel('Sample index n');
ylabel('Amplitude');
ylim([-1 1.5])
title('Clean and Filtered ECG Signals (2000 Samples)')
legend('ecg_{1}[n] - Clean ECG signal', 'y[n] - Filtered ECG signal')
grid on
