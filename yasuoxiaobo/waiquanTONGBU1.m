clear all;
close all;
vib=textread('I:\bisheʵ������\25600����\REC3939_ch3.txt','','headerlines',16);
pul=textread('I:\bisheʵ������\25600����\REC3939_ch2.txt','','headerlines',16);
pluse1=vib(:,1);
vdata=vib(:,2);
% pul=pul(:,2);pul=-pul;
threshold=abs(1)/3;
fs=25600;
figure;
plot(pluse1,vdata)
xlabel('t/s');ylabel('amplitude');title('ԭʼ�ź�');
%%%ȡ�����źŴ���
vdata=vdata(fs*7.5:fs*9.5);
% pul=pul(fs*7:fs*9);
n=length(vdata);
t=(0:n-1)/fs;
% f=(0:n-1)*fs/n;
figure;
plot(t,vdata)
xlabel('t/s');ylabel('A/g');title('��ȡ�ź�');
set(gcf,'unit','centimeters','position',[10 8 13 9])

sig=vdata;
%%����%%
% sig=sig0';
% [sig,startnode,xlength,tnode]=duichengyantuo(sig,fs);
% t=(0:length(sig)-1)/fs;

% fs2=1024;
% chongcaiyanlv=floor(fs/fs2);
% fs_origin=fs;
% pp=1:(floor((length(sig)-1)/chongcaiyanlv)+1);%%�µĲ���Ƶ���¶�Ӧ�ĵ���λ��
%  pp=(pp-1)*chongcaiyanlv+1;
% sig1=sig(pp);
% t2=t(pp);%%%t2
% figure;
% plot(t2,sig1);%%%%t2
% title('��Ƶ�����ź�');
% xlabel('t/s');ylabel('A/g');
% set(gcf,'unit','centimeters','position',[10 8 13 9])
% fs=fs2; 
% clear ��chongcaiyanlv  pp fst;clear chongcaiyanlv fs2;pack;
% 
% x=sig1;
% CWTopt=struct('gamma',eps,'type','morlet','mu',6,'s',5,'om',0,'nv',64,'freqscale','linear'); %С���任������
% 
% % CWT Synchrosqueezing transform
% [Tx, f1, Wx, as, Cw] = synsq_cwt_fw(t2, x, CWTopt.nv, CWTopt);
% xNew = synsq_cwt_iw(Tx, f1, CWTopt).';
% 
% 
% figure;
% imagesc(t2, f1, abs(Tx));axis xy % CWT-SSTʱƵͼ
% set(gca,'YDir','normal')
% colorbar;
% xlabel('t/s');
% ylabel('f/Hz');
% title('ԭ�ź�ͬ��ѹ��ʱƵͼ');
% set(gcf,'unit','centimeters','position',[10 8 13 9])


%% С������
lev=5;
sig=wden(sig,'minimaxi','s','mln',lev,'sym5');%%���ݷ�λ���ٶ�ȥ��
figure;
plot(t,sig);
xlabel('t/s'),
ylabel('A/g');
title('������ź�'),
set(gcf,'unit','centimeters','position',[10 8 13 9])

figure;
set(gcf,'unit','centimeters','position',[10 8 13 9])
subplot(211);plot(t,vdata);xlabel('t/s');ylabel('A/g');title('ԭ�ź�')
subplot(212);plot(t,sig);xlabel('t/s');ylabel('A/g');title('�����ź�')

% % �Ͷ��˲�
% nlevel= 8;
% opt1=1;opt=2;
% figure()
% sig= Fast_Kurtogram2(sig,nlevel,fs,opt1,opt);
%% ��ͨ�˲� 
% fp=[5000,6100];fst=[4900,6200];%�˲����Ĳ�������


fp=1000;fst=3000;%�˲����Ĳ�������
sig=sig-mean(sig);
sig=Noiseditong(sig,fs,fp,fst); 
figure;
plot(t,sig);
xlabel('t/s');ylabel('amplitude')
title('�˲����ź�');
set(gcf,'unit','centimeters','position',[10 8 13 9])

% 
% figure;
% plot(t,sig);
% xlabel('t/s');ylabel('amplitude')
% title('�˲����ź�')
% sig=sig-mean(sig); 
% siglv=sig';
% %%
% sig=siglv;
fs2=1024;
chongcaiyanlv=floor(fs/fs2);
fs_origin=fs;
pp=1:(floor((length(sig)-1)/chongcaiyanlv)+1);%%�µĲ���Ƶ���¶�Ӧ�ĵ���λ��
 pp=(pp-1)*chongcaiyanlv+1;
sig1=sig(pp);
t2=t(pp);%%%t2
figure;
plot(t2,sig1);%%%%t2
title('��Ƶ�����ź�');
xlabel('t/s');ylabel('A/g');
set(gcf,'unit','centimeters','position',[10 8 13 9])
fs=fs2; 
clear ��chongcaiyanlv  pp fst;clear chongcaiyanlv fs2;pack;



% %% ��ʱ����Ҷ
% s=sig1;
% [tfr,~,f] = tfrstft(s,1:length(s),length(s),hamming(251));
% % tfr=tfr(1:length(s)/2,:);
% tfr=tfr(1:end/2,:);
% % f=(0:length(s)/2-1)*fs/length(s);
% % f=0.5*(0:length(s)-1)*fs/length(s);
% % f=0:1*fs/2/length(s):(length(s)/2-1)*fs/length(s);
% f=f(1:end/2)*fs;
% figure;
% imagesc(t2, abs(f), abs(tfr));
% set(gca,'YDir','normal')
% colorbar;
% xlabel('ʱ�� t/s');
% ylabel('Ƶ�� f/Hz');
% title('��ʱ����Ҷ�任ʱƵͼ'); 
% figure;
% mesh(t2,f,abs(tfr));

x=sig1;
CWTopt=struct('gamma',eps,'type','morlet','mu',6,'s',5,'om',0,'nv',64,'freqscale','linear'); %С���任������

% CWT Synchrosqueezing transform
[Tx, f1, Wx, as, Cw] = synsq_cwt_fw(t2, x, CWTopt.nv, CWTopt);
xNew = synsq_cwt_iw(Tx, f1, CWTopt).';

%% ��ֵϸ��Ƶ���������޷�����viterib
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tt=0:1:length(f1)-1;
f1=interp1(tt,f1,tt(1):0.125:tt(end));
for i=1:length(t2)
    tx(:,i)=interp1(tt,Tx(:,i),tt(1):0.125:tt(end));
end
%% ͬʱϸ��ʱƵֵ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
imagesc(t2, f1, abs(tx));axis xy % CWT-SSTʱƵͼ
set(gca,'YDir','normal')
colorbar;
xlabel('t/s');
ylabel('f/Hz');
title('ͬ��ѹ��ʱƵͼ');
set(gcf,'unit','centimeters','position',[10 8 13 9])

% figure;
% imagesc(t2, f1, abs(Tx));axis xy % CWT-SSTʱƵͼ
% set(gca,'YDir','normal')
% colorbar;
% xlabel('ʱ�� t/s');
% ylabel('Ƶ�� f/Hz');
% title('ͬ��ѹ��ʱƵͼ');
% set(gcf,'unit','centimeters','position',[10 8 13 9])

% 
% figure;
% mesh(t2,f1,abs(Tx));
% 
% %% ����С���任ʱƵͼ
% sig=sig1;
% wavename='cmor3-3';
% totalscal=2048;
% Fc=centfrq(wavename); % С��������Ƶ��
% c=2*Fc*totalscal;
% scals=c./(1:totalscal);
% f=scal2frq(scals,wavename,1/fs); % ���߶�ת��ΪƵ��
% coefs=cwt(sig,scals,wavename); % ������С��ϵ��
% figure;
% imagesc(t2,f,abs(coefs));
% set(gca,'YDir','normal')
% colorbar;
% xlabel('ʱ�� t/s');
% ylabel('Ƶ�� f/Hz');
% title('С��ʱƵͼ');
% tfr=abs(coefs);


f=f1;
tfr=abs(tx);
df=(f(2)-f(1));meiMge=floor(1/df); 
[tfr2,~,ind3]=pinglvfengduan(tfr,f,meiMge);
clear tfr;tfr=tfr2;
clear tfr2 
%%%%%%%����Ƶ�����
c=5;sigma=3;efxia=2;
[route,val_route]=viterbi3(abs(tfr),c,sigma);
for p=1:size(route,1),   
    temp=route(p,:);
    temp2=zeros(1,length(temp));
    for time_node=1:length(temp),
        temp2(time_node)=(temp(time_node)-1)*meiMge+ind3(temp(time_node),time_node)-1;
    end
    route(p,:)=temp2;
end
clear temp temp2 time_node p;
% f=f*2;
 for p=1:size(route,1),   
route(p,:)=f(route(p,:));
end
% f1=route(12,:);
% f1=route(16,:);3942 3
f1=route(5,:);%5%1-3��Ļ���15��2-3�Ļ���7

%%%%�Լ�������Ĺ���ת�ٲ�ֵ��ԭ����fs

jieduan1=0.1;jieduan2=1.9;
[~,ind1]=min(abs(t2-jieduan1));[~,ind2]=min(abs(t2-jieduan2)); 
f1=f1(ind1:ind2);
% f2=f2(ind1:ind2);


t1=t2;
t1=t1(ind1:ind2);

fs=fs_origin;
f1=interp1(t1,f1,t1(1):1/fs:t1(end));%%%%%
% f2=interp1(t1,f2,t1(1):1/fs:t1(end));
f1=f1/2;

t1=t1(1):1/fs:t1(end);%%%%%%


[ttt,f8]=shijipinlv(pul,fs,7.5,9.5);

a=polyfit(t1,f1,3);
f2=polyval(a,t1,3);
figure;
hold on;
plot(t1,f1,'k','linewidth',2);
% plot(t1,f2,'r');
plot(ttt,f8);
xlabel('t/s');
ylabel('f/hz');
title('����ת��');
hold off;
set(gcf,'unit','centimeters','position',[10 8 13 9])

%%%%�Լ�������Ĺ���ת�ٲ�ֵ��ԭ����fs
%%

[~,ind1]=min(abs(t-jieduan1));[~,ind2]=min(abs(t-jieduan2)); 
vdata1=vdata(ind1:ind2);
vdata1=vdata1-mean(vdata1);


% vdata1=vdata;
% % %%%%%%%%%%%%�ݲ��˲�
% vdata1=vdata1-mean(vdata1);
% vdata1=trapper(vdata1,50,fs,ceil(fs/50));
%%�״η���
tiepian=1;
pluse=freq2pluse(f2,fs,tiepian);%%����תƵ
figure(12)
% hold on;
plot(t1,pluse);
ylim([0 1.2]);
xlabel('t/s');
ylabel('A');
title('��������');
set(gcf,'unit','centimeters','position',[10 8 13 9])

% hold off;
order_max=40;
numpr=1;
threshold=abs(1)/3;
%%����״η���
[order,ayy,array_angle_amp]=fuction_baoluopu(vdata1,pluse,fs,order_max,1,threshold);
figure;
plot(order,ayy);
title('����״���ͼ'),
xlabel('order'),
ylabel('amplitude');
xlim([0,20]); 
set(gcf,'unit','centimeters','position',[10 8 13 9])