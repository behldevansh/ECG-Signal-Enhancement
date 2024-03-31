% Load ECG data from a file
ecg = load('ecg_data.dat');

% Sampling rate in Hz
fs = 1000;

% Time vector based on the sampling rate and length of the ECG data
t = (0:length(ecg)-1)/fs;

% Number of samples in the ECG signal
N = length(ecg);

% Plot the original ECG signal over time
plot(t, ecg);

% Find the maximum value in the ECG signal
maxi = max(ecg);

% Label the axes and title the plot
xlabel('Time (s)'); 
ylabel('ECG signal (mV)');
title('Sample ECG Cycle');

% Initialize an output array with zeros
out = zeros(1, 788);

% Copy the first 788 samples from the original ECG signal to 'out'
for i = 1:788
    out(i) = ecg(i);
end

% Plot the first 788 samples of the ECG signal
plot(out);

% Initialize variables for counting and storing positions
count = 0;
posi = zeros(1, N);
ind = 1;

% Compute the cross-correlation between 'out' and the original ECG signal
cross_function = xcorr(out, ecg);

% Find the maximum value in the cross-correlation function
maxi_cor = max(cross_function);

% Loop through the cross-correlation function
for i = 1:length(cross_function)
    % Check if the cross-correlation value is above 75% of the maximum
    if cross_function(i) > 0.75 * maxi_cor
        % Save the position in the 'posi' array
        posi(ind) = i;
        ind = ind + 1;
        % If there are enough samples left in the ECG signal, add them to 'out'
        if i + 788 <= N-1
           for k = 1:788
            % Add the selected signal with samples
            out(k) = out(k) + ecg(i+k); 
           end
           % Update the count after adding the signal
           count = count + 1;
        end
    end
end

% Plot 'out' after adding signals
plot(out);

% Normalize 'out' by dividing by (count + 1)
for i = 1:788
    out(i) = out(i) / (count + 1); 
end

% Plot the final 'out' after normalization
plot(out);
