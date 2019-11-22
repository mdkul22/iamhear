
Fs = 44100;
ts = 1/Fs;
T = 10;
t = 0:ts:T-ts;
t1 = ts:ts:(T/2);
T1 = 5;
f0 = 1000;
f1 = 15000;
y = chirp(t1, f0, T1, f1);
z = zeros(1, 5*Fs);
chirp = [z y];
hold on;
plot(t, chirp);
hold off;
filename = 'chirp1k15k.wav';
audiowrite(filename, chirp, Fs);
%sound(chirp,Fs)