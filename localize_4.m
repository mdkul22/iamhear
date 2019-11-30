lfile = './audio/mic15k20k_2.wav';
l2file='./audio/chirp15k20k.wav';
Fs = 96000;
T = 10;
[y, Fs] = audioread(lfile);

SOUND_SPEED = 340.0;

MIC_DISTANCE_6 = 0.09218;
MAX_TDOA_6 = MIC_DISTANCE_6 / (SOUND_SPEED);


z=zeros(6,960000);
z(1,:) = transpose(y(:, 1));
z(2,:) = transpose(y(:, 2));
z(3,:) = transpose(y(:, 3));
z(4,:) = transpose(y(:, 4));
z(5,:) = transpose(y(:, 5));
z(6,:) = transpose(y(:, 6));

tau=zeros(3,1);
theta=zeros(3,1);
for i=1:3
tau(i)=gccphat(transpose(z(i,:)),transpose(z(i+3,:)),Fs);
theta(i)=asin(tau(i)/MAX_TDOA_6) * (180 / pi);
end
[c,min_index]=min(abs(tau));
if (min_index~=0 && theta(min_index)>=0 ) || (min_index==0 && theta(3)<0)
    disp('hi')
    best_guess=mod((theta(min_index)+360),360);
else
    best_guess=(180-theta(min_index));
end
best_guess
%best_guess=mod((best_guess+30+min_index*60),360)