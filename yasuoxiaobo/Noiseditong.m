function y=Noiseditong(sig,fs,fp,fst)
y=[];
%fp=1500;fst=2250;fs=15000; %�������ָ��
wp=2*fp/fs;                %���һ������ͨ����ֹƵ��
ws=2*fst/fs;                %���һ�����������ʼƵ��
% deltaw=ws-wp;               %����ɴ���
% N0=ceil(6.6/deltaw);       %�󴰿ڳ���    
% N=N0+mod(N0+1,2);           %ȷ�����ڳ���NΪ����
% n=N-1;                      %����˲����Ľ���n
n=100;
wn=(ws+wp)/2;                %����˲����Ľ�ֹƵ��
b=fir1(n,wn);              %����fir1��������˲�����ϵ��
% y=filter(b,1,sig);
% figure;
% freqz(b,1,512,fs);
% [h,w]=freqz(b,1,512,fs);
% magH=abs(h);
% phaH1=unwrap(angle(h));
% phaH=180*phaH1/pi;
% wnyq=w/pi;
% figure;
% subplot(2,1,1);
% plot(wnyq,magH);
% xlabel('Ƶ��f'); ylabel('��ֵ(dB)'); grid;
% subplot(2,1,2);
% plot(wnyq,phaH);
% xlabel('Ƶ��f'); ylabel('��λ(degree)'); grid;	

%figure()
 y=filtfilt(b,1,sig);


end