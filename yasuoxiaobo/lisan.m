clc;clear all;close all;

fs=1000;
t=0:1/fs:1;
% sig=cos(2*pi*(10*t.^2+20*t))+cos(2*pi*(50*t.^2+100*t)); %%��ƽ��
sig=cos(2*pi*(20*t))+cos(2*pi*(100*t)); 
figure;
plot(t,sig);


%% % % ����С��
%%%%%%%%%%%%%
figure;
cw1=cwt(sig,1:32,'db4','plot');
xlabel('ԭʼ�ź�');
[cw1,sc]=cwt(sig,1:32,'db4','scal');
title('�����任������ϵ��');
xlabel('ʱ��');ylabel('�߶�');
%%%%%%%%%%%

s=sig;
wavename='cmor3-3';
% wavename='morlet';
totalscal=128;
Fc=centfrq(wavename); % С��������Ƶ��
c=2*Fc*totalscal;
scals=c./(1:totalscal);
f=scal2frq(scals,wavename,1/fs); % ���߶�ת��ΪƵ��
coefs=cwt(s,scals,wavename); % ������С��ϵ��
figure;
f=(0:length(sig)/2-1)*fs/length(sig);
imagesc(t,f,abs(coefs));
set(gca,'YDir','normal')
colorbar;
xlabel('t/s');
ylabel('f/Hz');
title('С��ʱƵͼ');


%% %% ��ɢС���任
[ca,cd]=dwt(sig,'haar');
figure;
subplot(211);plot(ca);
subplot(212);plot(cd);
%%%%%%%%%%%%%%
figure;
[c,l]=wavedec(s,5,'db10');
%%��Ƶ����
for i=1:5
    qq=wrcoef('a',c,l,'db10',6-i);
    subplot(5,1,i);
    plot(qq);
    ylabel(['a',num2str(6-i)]);
end
%%��Ƶ����
figure;
for i=1:5
    qq=wrcoef('d',c,l,'db10',6-i);
    subplot(5,1,i);
    plot(qq);
    ylabel(['a',num2str(6-i)]);
end
    

    