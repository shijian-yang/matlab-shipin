clear all;
close all;
vib=textread('E:\25600����\REC3953_ch3.txt','','headerlines',16);
pul=textread('E:\25600����\REC3953_ch2.txt','','headerlines',16);
pluse1=vib(:,1);
vdata=vib(:,2);
pul=pul(:,2);pul=-pul;threshold=abs(1)/3;
fs=25600;
figure;
plot(pluse1,vdata)
xlabel('t/s');ylabel('amplitude/g');title('ԭʼ�ź�');
%%%ȡ�����źŴ���
vdata=vdata(fs*0.5:fs*5.5);%����7-12
pul=pul(fs*0.5:fs*5.5);
n=length(vdata);
t=(0:n-1)/fs;
% f=(0:n-1)*fs/n;
figure;
plot(t,vdata)
xlabel('t/s');ylabel('amplitude/g');title('��ȡ�ź�');

sig=vdata;
%%����%%
% sig=sig0';
% [sig,startnode,xlength,tnode]=duichengyantuo(sig,fs);
% t=(0:length(sig)-1)/fs;
%% �Ͷ��˲�
% nlevel= 5;
% opt1=1;opt=2;
% figure()
% sig= Fast_Kurtogram2(sig,nlevel,fs,opt1,opt);
%% ��ͨ�˲� 
% fp=2000;fst=2100;%�˲����Ĳ�������
% sig=sig-mean(sig);
% sig=Noiseditong(sig,fs,fp,fst); 

fp=[3100,3700];fst=[2900,3900];%�˲����Ĳ�������
sig=sig-mean(sig);
sig=Noisedaitong(sig,fs,fp,fst);

% vdata=sig;

figure;
plot(t,sig);
xlabel('t/s');ylabel('amplitude/g')
title('�˲����ź�')
sig=sig-mean(sig); 

% vdata=sig;
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
subplot(211);plot(t,sig);xlabel('t/s');ylabel('amplitude/g');title('�˲����ź�');
subplot(212);plot(t2,sig1);xlabel('t/s');ylabel('amplitude/g');title('����Ƶ�ź�');%%%%t2
set(gcf,'unit','centimeters','position',[3 5 13.5 9])
% xlabel('t/s');ylabel('amplitude');
fs=fs2; 
clear ��chongcaiyanlv  pp fst;clear chongcaiyanlv fs2;pack;
%%%���Ͳ�Ƶ
%%%���ڣ���ɺ��ʱ��fs,t2,sig endfreq fp
%%%���ڣ�ԭ����fs_origin t vdata ��chishu����
%************%������ͨ�˲����˲���Ƶ����**************************************

%%
jieduan1=1.5;jieduan2=3.5;%1-2����
%*************%��������WVD��Ҫ��ȡ���ź�ָ��****************************************
%%% ��ڣ���ɺ��ʱ��fs,t2,sig  fp
%%% ��ڣ�ԭ����fs_origin t vdata ��chishu����
%%% Ŀ�ģ����ź��������£�sʱ���Ա����WVD�˵�ЧӦ
sig=sig1';
%%%%WVDȥ�˵�ЧӦ�ٽض����߸�1s
% a=abs(t2-jieduan1);
[~,ind1]=min(abs(t2-jieduan1));[~,ind2]=min(abs(t2-jieduan2));
sig=sig-mean(sig);
 sig=sig';
 specnum=length(sig);
 sig=hilbert(sig);
 sig=abs(sig);                        
 sig=sig-mean(sig);
 sig11=hilbert(sig);
g=tftb_window(round(length(sig11)/20+1),'hamming'); h=tftb_window(round(length(sig11)/20+1),'hamming'); 
[tfr,~,f] = tfrspwv(sig11,1:length(sig11),specnum,g,h);

% [tfr,tt,f]=tfrstft(sig11,1:length(sig11),specnum,g,h);%��ʱ����Ҷ�任

f=f*fs;

tfr=tfr(:,ind1:ind2);

t1=t2(ind1:ind2);

sig2=sig(ind1:ind2);
% f=f(1:end/2)*fs;%%%%
% tfr=tfr(1:end/2,ind1:ind2);%%tfr(:,ind1:ind2);tfr(1:end/2,ind1:ind2);
% t1=t2(ind1:ind2);

% figure;
% %mesh(t1,f,tfr);
% pcolor(t1,f,tfr);
% ylim([0,250]);
% shading interp;
% colorbar;
% xlabel('t/s');ylabel('f/Hz');
% title('���źŵ�SPWVʱƵ�ֲ�ͼ')
% set(gcf,'unit','centimeters','position',[3 5 13.5 9])


clear ind1 ind2 fs specnum  tfr_stft; 

%%% ���ڣ�ԭ����fs_origin t vdata ��chishu����
%%% ���ڣ���ɺ��ʱ��fs,t2,sig  fp
%%% ���ڣ�ֻ�Ƕ���������ضϺ�ʱ������־ind1��ind2
%%
%*************%����vitebi����Ƶ��·��****************************************
%%%��ڲ�����ʱ��������t1 Ƶ��������f ʱƵ�ֲ�tfr  ��ʼƵ��startfreq 
%%%��ڲ�����ԭʼ���źŵ�vdata,fs_origin ,t����������chishu 
% %%%%%%%����Ƶ�����
df=(f(2)-f(1));meiMge=floor(1/df); 
[tfr2,~,ind3]=pinglvfengduan(abs(tfr),f,meiMge);
clear tfr;tfr=tfr2;
clear tfr2 
%%%%%%%����Ƶ�����
c=5;sigma=3;efxia=2;
[route,val_route]=viterbi3(tfr,c,sigma);
for p=1:size(route,1),   
    temp=route(p,:);
    temp2=zeros(1,length(temp));
    for time_node=1:length(temp),
        temp2(time_node)=(temp(time_node)-1)*meiMge+ind3(temp(time_node),time_node)-1;
    end
    route(p,:)=temp2;
end
clear temp temp2 time_node p;
 for p=1:size(route,1),   
route(p,:)=f(route(p,:));
end
% f1=route(12,:);
% f1=route(16,:);3942 3
f1=route(5,:);%3

% f1=f1/2;
save('f11.mat','f1');
%%%%�Լ�������Ĺ���ת�ٲ�ֵ��ԭ����fs
fs=fs_origin;
% f1=interp1(t1,f1,t1(1):1/fs:t1(end));%%%%%
% % f2=interp1(t1,f2,t1(1):1/fs:t1(end));
% f1=f1/2;
% t1=t1(1):1/fs:t1(end);%%%%%%
% [ttt,frequency2]=shijispeed(pul,threshold,fs);
% 
% a=polyfit(t1,f1,3);
% f2=polyval(a,t1,3);
% 
% 
% figure;
% hold on;
% plot(t1,f1,'k');
% plot(t1,f2,'r');
% plot(ttt,frequency2);
% xlabel('t/s');ylabel('amplitude');title('����ת��');
% hold off;
%% ��������λ����
fs=1024;
f3=f1-f1(1);
phs = cumtrapz(f3)/fs*2*pi;
phs1=cumtrapz(f1)/fs*2*pi;
tt=(0:length(phs)-1)/fs;
phs = phs(:);
figure;
plot(phs);
%% ������
y = exp(j*(-phs)).*sig2;
n1=length(y);

%% ʱƵͼ
% myWindowFT(y,1,500,200,'Hanning',fs,'STFT',1)
[tfr,~,f]=tfrspwv(y,1:n1,n1,hamming(251),hamming(251));
f=f*fs;
% figure;
% contour(tt,f,abs(tfr));
% % ylim([0,250]);
% shading interp;
% colorbar;
% xlabel('t/s');ylabel('f/Hz');
% set(gcf,'unit','centimeters','position',[3 5 13.5 9])
%% ��ͨ�˲�
[yy] = mybpf(y,fs,45,54);
n2=length(yy);
[tfr,~,f]=tfrspwv(yy,1:n2,n2,hamming(251),hamming(251));

f=f*fs;
% figure;
% contour(tt,f,abs(tfr));
% shading interp;
% colorbar;
% xlabel('t/s');ylabel('f/Hz');
% set(gcf,'unit','centimeters','position',[3 5 13.5 9])
%% GFT���任
y3=yy.*exp(-j*(-phs));
[tfr,~,f]=tfrspwv(y3,1:n1,n1,hamming(251),hamming(251));
f=f*fs;
% figure;
% pcolor(tt,f,abs(tfr));
% shading interp;
% colorbar;
% xlabel('t/s');ylabel('f/Hz');
% set(gcf,'unit','centimeters','position',[3 5 13.5 9])


%% ȡGFT���任���ʵ��
y4=real(y3);
figure;
plot(tt,y4);
xlabel('t/s');ylabel('amplitude/g');
set(gcf,'unit','centimeters','position',[3 5 13.5 9])
%% ��˲ʱ��λ
y5=hilbert(y4);
yh1=unwrap(angle(y5));%2��г��˲ʱ��λ
% yh1=yh1/2;%%��˲ʱ��λ
figure;
plot(tt,yh1,'r','linewidth',2);
% hold on
% plot(tt,phs1);
xlabel('t/s');ylabel('phase/rad');
set(gcf,'unit','centimeters','position',[3 5 13.5 9])

yh1=yh1/2;%%��˲ʱ��λ
phs1=phs1/2;
f1=f1/2;
yhd=fs*diff(yh1)/(2*pi);%˲ʱƵ��
figure;
plot(yhd);



%% �ز���
[~,ind1]=min(abs(t-jieduan1));[~,ind2]=min(abs(t-jieduan2)); 
vdata1=vdata(ind1:ind2);
x1=vdata1;
% x1=hilbert(x1);

fs=25600;
% f1=interp1(t1,f1,t1(1):1/fs:t1(end));%%%%%
% f2=interp1(t1,f2,t1(1):1/fs:t1(end));
phs1=interp1(tt,phs1,tt(1):1/fs:tt(end));
yh1=interp1(tt,yh1,tt(1):1/fs:tt(end));

% fs=25600;
data=2*pi*min(f1)/fs;
tangle=0:data:phs1(end);
tangle1=0:data:yh1(end);

array_angle_amp=interp1(phs1,x1,tangle,'spline');%��ֵ
array_angle_amp1=interp1(phs1,x1,tangle1,'spline');%��ֵ
figure;
plot(tangle,array_angle_amp);%�ز����ź�
% set(gcf,'unit','centimeters','position',[3 5 13.5 9])
% figure;
% plot(tangle1,array_angle_amp1);
% xlabel('angle/rad');ylabel('amplitude/g');

array_angle_amp1=array_angle_amp1(1:end-0.1*fs);%��������
% array_angle_amp1=hilbert(array_angle_amp1);
% array_angle_amp1=abs(array_angle_amp1);
% array_angle_amp1=array_angle_amp1-mean(array_angle_amp1);
figure;
plot(tangle1(1:end-0.1*fs),array_angle_amp1);
% xlabel('angle/rad');ylabel('amplitude/g');
% set(gcf,'unit','centimeters','position',[3 5 13.5 9])


array_angle_amp=hilbert(array_angle_amp1);
array_angle_amp=abs(array_angle_amp);
array_angle_amp=array_angle_amp-mean(array_angle_amp);

angle_dom_ffty=abs(fft(array_angle_amp))*2/length(array_angle_amp);
 delt_order=2*pi/(length(angle_dom_ffty)*data);
angle_dom_fx=(0:length(angle_dom_ffty)-1)*delt_order;%����ʱ��ģ�0��n-1)*n/fs
freq=angle_dom_fx(1:length(angle_dom_fx)/2);%�״�
ayy=angle_dom_ffty(1:length(angle_dom_fx)/2);
figure;
plot(freq,ayy);
xlabel('order');ylabel('amplitude/g');
xlim([0,20]);
set(gcf,'unit','centimeters','position',[3 5 13.5 9])

ffs=2*pi/data;
[freq,ayy,vec_num]=zijijieci(array_angle_amp1,ffs,data);
figure;
plot(freq,ayy);
xlabel('order');ylabel('amplitude/g');
xlim([0,20]);
set(gcf,'unit','centimeters','position',[3 5 13.5 9])

