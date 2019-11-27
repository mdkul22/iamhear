lfile = './audio/micchirp_2.wav';
Fs = 44100;
T = 10;
[y, Fs] = audioread(lfile);
t = (1/Fs):1/Fs:T;
z1 = transpose(y(:, 1));
z2 = transpose(y(:, 2));
z3 = transpose(y(:, 3));
z4 = transpose(y(:, 4));
z5 = transpose(y(:, 5));
z6 = transpose(y(:, 6));

bandPassLow = 5999;
frequency = 6000;
bandPassHigh = 6001;


bpFiltFir = designfilt('bandpassiir', 'FilterOrder', 4, ...
    'HalfPowerFrequency1', bandPassLow, 'HalfPowerFrequency2', bandPassHigh, ...
    'SampleRate', Fs);
%bpFiltFir = designfilt('bandpassfir', 'FilterOrder', 4, ...
%                       'CutoffFrequency1', 99.98, 'CutoffFrequency2', ...
%                       100.02, 'SampleRate', 16000, 'Window', 'hamming');

mic1 = filter(bpFiltFir, z1);
mic2 = filter(bpFiltFir, z2);
mic3 = filter(bpFiltFir, z3);
mic4 = filter(bpFiltFir, z4);
mic5 = filter(bpFiltFir, z5);
mic6 = filter(bpFiltFir, z6);

[xc,lags] = xcorr(mic4,mic3);
 xc = xc(441000:end);
 lags = lags(441000:end);
  [val,index] = max(abs(xc));
  lags(index);
  theta=(180/pi)*((asin(((lags(index)*340)/0.046)))-((3-1)*(pi/3)));
disp(theta)
 