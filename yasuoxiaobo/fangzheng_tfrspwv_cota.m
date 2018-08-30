clear;clc;close all
SamFreq=5120;
N=5*SamFreq;
fs=SamFreq;
t=0:1/fs:(N-1)/fs;

s_f1=(2.5*t.^2+2*t);s_f2=(25*t.^2+20*t);
f1=5*t+2;f2=20+50*t;
f1_zheng=f1;f2_zheng=f2;
figure(1);
plot(t,f1,'r');hold on;plot(t,f2,'b');
sig=cos(2*pi*s_f1)+sin(2*pi*s_f2); %����sig
%sig=cos(2*pi*(10*t.^2+2*t))+cos(2*pi*(20*t.^2+4*t)); %����sig
%sig=cos(2*pi*(120-100/3*t.^3))+cos(2*pi*(60-50/3*t.^3));

 sig=sig';
 SNR=1;
 sig=sigmerge(sig,rand(N,1),SNR);%sigmergeҪʹsig��rand��N,1������һ�У�Ҳ����sigmerge������N��һ��
vdata=real(sig);
%vdata=sig;
figure(2)
plot(t,vdata);

%%Ƶ�ʹ���
sig=vdata;
t=(0:length(sig)-1)/fs;
% %%����
% sig=sig';
% [sig,startnode,xlength,tnode]=duichengyantuo(sig,fs);
% %%%��ͨ�˲�
% chishu=1;
% fp=chishu*300;fst=chishu*300+10;
% sig=sig-mean(sig);
% sig=Noiseditong(sig,fs,fp,fst); %����λ��ͨ�˲�
% sig=sig-mean(sig); 
% sig=sig(startnode:startnode+xlength-1);%ȡ�����ź��е�ԭ�ź�
% figure;t2=t(tnode:tnode+xlength-1);
% sig=sig';
% plot(t2,sig);
% title('�˲�����ź�');xlabel('t/s');ylabel('��ֵ');
%%%���Ͳ�Ƶ
fs2=1024;chongcaiyanlv=floor(fs/fs2);
fs_origin=fs;
pp=1:(floor((length(sig)-1)/chongcaiyanlv)+1);%���Ͳ�Ƶ���źŵĳ���
 pp=(pp-1)*chongcaiyanlv+1;%ÿ��chonggcaiyanlv���ȡһ���㣬���Ȼ���length(pp)
sig=sig(pp);
t2=t(pp);
figure;plot(t2,sig);title('�˲����ٽ�Ƶ�����ź�');xlabel('t/s');ylabel('��ֵ');
fs=fs2; 
clear fs2��chongcaiyanlv  pp fst;clear chongcaiyanlv fs2;pack;
%%%���Ͳ�Ƶ
%%%���ڣ���ɺ��ʱ��fs,t2,sig endfreq fp
%%%���ڣ�ԭ����fs_origin t vdata ��chishu����
%************%������ͨ�˲����˲���Ƶ����**************************************

%%
jieduan1=1;jieduan2=ceil(max(t2)-1);
%*************%��������WVD��Ҫ��ȡ���ź�ָ��****************************************
%%% ��ڣ���ɺ��ʱ��fs,t2,sig  fp
%%% ��ڣ�ԭ����fs_origin t vdata ��chishu����
%%% Ŀ�ģ����ź��������£�sʱ���Ա����WVD�˵�ЧӦ
sig=sig';
%%%%WVDȥ�˵�ЧӦ�ٽض����߸�1s,ʵ�����ǵ�jieduan1+1:jieduan2-1(2~5s)���ź�
[~,ind1]=min(abs(t2-jieduan1));[~,ind2]=min(abs(t2-jieduan2));
sig=sig-mean(sig);
% %%%%%%%A)stft
 sig=sig';sig=sig-mean(sig);
 specnum=length(sig);
 %sig=hilbert(sig);sig=abs(sig);sig=sig-mean(sig);
 sig=hilbert(sig);
g=tftb_window(length(sig)/10,'hamming'); h=tftb_window(length(sig)/10,'hamming'); 

if mod(length(g),2)==0,
    g=tftb_window(length(sig)/10+1,'hamming');
end
   
if mod(length(h),2)==0,
   h=tftb_window(length(sig)/10+1,'hamming');
end

%[tfr,~,f] = tfrspwv(sig,1:length(sig),specnum,g,h);
%SPWVD
load  tfr ;
load f;
%[tfr,rtfr,hat] = tfrrspwv(x,t,N,g,h,trace);
% [~,tfr,~] = tfrrspwv(sig,1:length(sig),specnum);
% f=linspace(0,0.5,specnum);
%%%%%%%C)wvd

%%%%%%%D)
%f=f*fs;
%%%���߶�������1�͵�4s
% ind1=jieduan1*fs; if ind1==0,ind1=1;end;
% ind2=length(t1)-fs-1;%����jiduan2����
tfr=tfr(:,ind1:ind2);
%tfr_stft=tfr_stft(:,ind1:ind2);
%tfr=tfr.*tfr_stft;
t1=t2(ind1:ind2);
% figure();
% mesh(t1,f,tfr);
% xlabel('t/s');ylabel('f/Hz');
% axis([jieduan1 jieduan2 0 fp]);
% hold on;
% hold off;
%%%%%%%D)
 figure();
%mesh(t1,f,tfr);
pcolor(t1,f,tfr);
shading interp;
colorbar;
xlabel('t/s');ylabel('f/Hz');title('���źŵ�SPWVʱƵ�ֲ�ͼ')
set(gcf,'unit','centimeters','position',[3 5 13.5 9])
set(gcf,'color','white');
ylim([0 200]);


clear ind1 ind2 fs sig specnum t2 tfr_stft; 
clear winlen  h vdata1 y f0;pack;
clear fp vdata1
%%% ���ڣ�ԭ����fs_origin t vdata ��chishu����
%%% ���ڣ���ɺ��ʱ��fs,t2,sig  fp
%%% ���ڣ�ֻ�Ƕ���������ضϺ�ʱ������־ind1��ind2
%*************%������ȡ���ź���stft��wvd����****************************************
%%

%%
%*************%����vitebi����Ƶ��·��****************************************
%%%��ڲ�����ʱ��������t1 Ƶ��������f ʱƵ�ֲ�tfr  ��ʼƵ��startfreq 
%%%��ڲ�����ԭʼ���źŵ�vdata,fs_origin ,t����������chishu 
% %%%%%%%����Ƶ�����
df=(f(2)-f(1));meiMge=floor(1/df); 
[tfr2,~,ind2]=pinglvfengduan(tfr,f,meiMge);
clear tfr;tfr=tfr2;clear tfr2 
% %%%%%%%����Ƶ�����

c=5;sigma=2;efxia=2;
[route,val_route]=viterbi_fcl3(abs(tfr),c,sigma,efxia);
for p=1:size(route,1),   
    temp=route(p,:);
    temp2=zeros(1,length(temp));
    for time_node=1:length(temp),
        temp2(time_node)=(temp(time_node)-1)*meiMge+ind2(temp(time_node),time_node)-1;
    end
    route(p,:)=temp2;
end
clear temp temp2 time_node p;
 for p=1:size(route,1),   
route(p,:)=f(route(p,:));
end
f1=route(1,:);
f2=route(7,:);
%%%%�Լ�������Ĺ���ת�ٲ�ֵ��ԭ����fs
fs=fs_origin;
f1=interp1(t1,f1,t1(1):1/fs:t1(end));
f2=interp1(t1,f2,t1(1):1/fs:t1(end));
t1=t1(1):1/fs:t1(end);


figure(1);hold on;
plot(t1,f1,'r-');
plot(t1,f2,'b');hold off;
%%%%�Լ�������Ĺ���ת�ٲ�ֵ��ԭ����fs

%%%���ڲ�����ʱ��������t2 Ƶ��������f   
%%%���ڲ�����ԭʼ���źŵ�vdata,fs_origin ,t����������chishu 
%*************%����vitebi����Ƶ��·��****************************************
%%

%%
[~,ind1]=min(abs(t-jieduan1));[~,ind2]=min(abs(t-jieduan2)); 
vdata1=vdata(ind1:ind2);
vdata1=vdata1-mean(vdata1);

% %%
% f1_zheng=f1_zheng(ind1:ind2);
% f2_zheng=f2_zheng(ind1:ind2);
% 
% per1=percent_err(f1,f1_zheng)
% per2=percent_err(f2,f2_zheng)

%%

%%
%f2=f2/32;
tiepian=1;
pluse=freq2pluse(f1,fs,tiepian);
order_max=30;numpr=1;threshold=abs(1)*2/3;
%COTA(vdata,pdata,Fs,order_max,numpr,threshold)
figure;
[f,ayy]=FUCTION_COTA3(vdata1,pluse,fs,order_max,numpr,threshold);
plot(f,ayy);
title('�״η���'),
xlabel('�״�'),
ylabel('��ֵ');