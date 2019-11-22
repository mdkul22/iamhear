
f = 4000;
Amp = 10;
fs = 44100;
ts = 1/fs;
T = 10;
t = 0:ts:T-ts;
y = Amp*sin(2*pi*f*t);
g1 = ones(1, fs*5); b1 = zeros(1, fs*5);
c = [b1 g1];
z = c.*y;
hold on;
plot(t, z);
filename = 'sin4000.wav';
audiowrite(filename, z, fs);
%sound(z,fs)
