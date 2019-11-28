lfile = './audio/mic15k20k_5.wav';
l2file='./audio/chirp15k20k.wav';
Fs = 96000;
T = 10;
[y, Fs] = audioread(lfile);
[y1,Fs1]=audioread(l2file);
t = (1/Fs):1/Fs:T;
z=zeros(6,960000);
z(1,:) = transpose(y(:, 1));
z(2,:) = transpose(y(:, 2));
z(3,:) = transpose(y(:, 3));
z(4,:) = transpose(y(:, 4));
z(5,:) = transpose(y(:, 5));
z(6,:) = transpose(y(:, 6));
tau=zeros(6,1);
  tau(6)=gccphat(transpose(z(6,:)),(y1),Fs);
  tau(1)=gccphat(transpose(z(1,:)),(y1),Fs);
  tau(2)=gccphat(transpose(z(2,:)),(y1),Fs);
    tau(3)=gccphat(transpose(z(3,:)),(y1),Fs);
      tau(4)=gccphat(transpose(z(4,:)),(y1),Fs);
       tau(5)=gccphat(transpose(z(5,:)),(y1),Fs);
theta=zeros(6,1);
for i=1:6  
    if i==6
 theta(i)=((asin(((abs(tau(6)-tau(1))*340)/0.0463)))-((6-1)*(pi/3)));
    
    else
 theta(i)=((asin(((abs(tau(i)-tau(i+1))*340)/0.0463)))-((i-1)*(pi/3)));
    end
end
sum=0;
for i=1:6
    sum=sum+theta(i);
end
sum=sum/6.0