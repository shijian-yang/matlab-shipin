clc;
clear;
close all;
% ԭʼ�ź�
fs=1000;
f1=50;
f2=100;
t=0:1/fs:1;
s = sin(2*pi*f1*t)+sin(2*pi*f2*t);%+randn(1, length(t));
% s = chirp(t,20,0.3,300);
s = chirp(t,20,1,500,'q');
figure;
plot(t, s);    %ԭʼ�ź�ͼ
% ����С���任ʱƵͼ
wavename='cmor3-3';
totalscal=256;
Fc=centfrq(wavename); % С��������Ƶ��
c=2*Fc*totalscal;
scals=c./(1:totalscal);
f=scal2frq(scals,wavename,1/fs); % ���߶�ת��ΪƵ��
coefs=cwt(s,scals,wavename); % ������С��ϵ��
figure;
imagesc(t,f,abs(coefs));
set(gca,'YDir','normal')
colorbar;
xlabel('ʱ�� t/s');
ylabel('Ƶ�� f/Hz');
title('С��ʱƵͼ');
% ��ʱ����Ҷ�任ʱƵͼ
figure
spectrogram(s,256,250,256,fs);
% ʱƵ������������Ķ�ʱ����Ҷ�任
f = 0:fs/2;
tfr = tfrstft(s');
tfr = tfr(1:floor(length(s)/2), :);
figure
imagesc(t, f, abs(tfr));
set(gca,'YDir','normal')
colorbar;
xlabel('ʱ�� t/s');
ylabel('Ƶ�� f/Hz');
title('��ʱ����Ҷ�任ʱƵͼ'); 