    
Fs = 96000;
ts = 1/Fs;
T = 10;
t = 0:ts:T-ts;
t1 = ts:ts:(T/2);
T1 = 5;
f0 = 15000;
f1 = 20000;
y = chirp(t1, f0, T1, f1);
z = zeros(1, 5*Fs);
chirp = [z y];
S = RandStream('mt19937ar','Seed',5466);
y1 = awgn(chirp,10,0,S);
reset(S);
hold on;
plot(t, y1);
hold off;
filename = 'chirp15k20k_awgn.wav';
audiowrite(filename, y1, Fs);
sound(y1,Fs)