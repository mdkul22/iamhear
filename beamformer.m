clear all;
lfile = 'micchirp.wav';
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

bandPassLow = 1000;
bandPassHigh = 15000;
frequency = 8000;

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
figure(1);
hold on;
subplot(6, 1, 1);
plot(t, mic1, 'red');
subplot(6, 1, 2);
plot(t, mic2, 'green');
subplot(6, 1, 3);
plot(t, mic3, 'blue');
subplot(6, 1, 4);
plot(t, mic4, 'black');
subplot(6, 1, 5);
plot(t, mic5, 'cyan');
subplot(6, 1, 6);
plot(t, mic6, 'yellow');
hold off;
% doing thresholding to find limits
figure(2);
hold on;
threshold = 1.2;
length = 22050;
f1 = find(mic1 > threshold, 1);
t1 = f1/Fs;
fprintf("The mic 1 has time of arrival at %f seconds \n", t1);
f2 = find(mic2 > threshold, 1);
t2 = f2/Fs;
fprintf("The mic 2 has time of arrival at %f seconds \n", t2);
f3 = find(mic3 > threshold, 1);
t3 = f3/Fs;
fprintf("The mic 3 has time of arrival at %f seconds \n", t3);
f4 = find(mic4 > threshold, 1);
t4 = f4/Fs;
fprintf("The mic 4 has time of arrival at %f seconds \n", t4);
f5 = find(mic5 > threshold, 1);
t5 = f5/Fs;
fprintf("The mic 5 has time of arrival at %f seconds \n", t5);
f6 = find(mic6 > threshold, 1);
t6 = f6/Fs;
fprintf("The mic 6 has time of arrival at %f seconds \n", t6);
%subplot(6,1,1);
plot(t(1, f1:f1+length), mic1(1, f1:f1+length), 'r');
%subplot(6,1,2);
plot(t(1, f2:f2+length), mic2(1, f2:f2+length), 'g');
%subplot(6,1,3);
plot(t(1, f3:f3+length), mic3(1, f4:f4+length), 'b');
%subplot(6,1,4);
plot(t(1, f4:f4+length), mic3(1, f4:f4+length), 'black');
%subplot(6,1,5);
plot(t(1, f5:f5+length), mic5(1, f5:f5+length), 'cyan');
%subplot(6,1,6);
plot(t(1, f6:f6+length), mic6(1, f6:f6+length), 'yellow');

hold off;
mic1_s = mic1(1, f1:f1+length);
mic2_s = mic1(1, f2:f2+length);
mic3_s = mic1(1, f3:f3+length);
mic4_s = mic1(1, f4:f4+length);
mic5_s = mic1(1, f5:f5+length);
mic6_s = mic1(1, f6:f6+length);

angle1 = traditionalCalculation(mic6_s, mic5_s, mic1_s, frequency);
angle2 = traditionalCalculation(mic3_s, mic2_s, mic4_s, frequency);
angle3 = traditionalCalculation(mic6_s, mic2_s, mic3_s, frequency);

sndspeed = 343;
angle = (180/pi)*acos(sndspeed*((t6-t5)/(46.3e-3)));
fprintf("\nThe AoA bearing between 6 and 1 is %f\n\n", angle);
fprintf("The bearing for 6, 5, 1 is %f degrees\n", angle1*(180/pi));
fprintf("The bearing for 3, 2, 4 is %f degrees\n", angle2*(180/pi));
fprintf("The bearing for 6, 4, 3  is %f degrees\n", angle3*(180/pi));
