    
Fs = 96000;
ts = 1/Fs;
T = 100;
t = 0:ts:T;
x=sawtooth(t);
S = RandStream('mt19937ar','Seed',5466);
y1 = awgn(x,10,0,S);
reset(S);
hold on;
plot(t, y1);
hold off;
filename = 'sawtooth_awgn.wav';
audiowrite(filename, y1, Fs);
%sound(y1,Fs)