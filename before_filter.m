ecg = load('ecg_data.dat');
fs = 1000; % Sampling rate in Hz
t = (0:length(ecg)-1)/fs;
N=length(ecg);
plot(t, ecg);
maxi=max(ecg);
xlabel('Time (s)');
ylabel('ECG signal (mV)');
title('Sample ECG Cycle');
out=zeros(1,788);
for i=1:788
out(i)=ecg(i);
end
plot(out);
count=0;
posi=zeros(1,N);ind=1;
cross_function=xcorr(out,ecg);
maxi_cor=max(cross_function);
for i=1:length(cross_function)
if(cross_function(i)>0.75*maxi_cor)
posi(ind)=i;ind=ind+1;%saving the position of in array
if(i+788<=N-1)
for k=1:788
out(k)=out(k)+ecg(i+k); %adding the selected signal with samples
signal
end
count=count+1; % update the count after adding the signal
end
end
end
plot(out);
for i=1:788
out(i)=out(i)/(count+1);
end
plot(out);