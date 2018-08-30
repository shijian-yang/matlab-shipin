clear;clc;close all
SamFreq=2048;
N=2*SamFreq;
fs=SamFreq;
t=0:1/fs:(N-1)/fs;

s_f1=(2.5*t.^2+10*t);s_f2=(12.5*t.^2+50*t);
f1=5*t+10;f2=50+25*t;
f1_zheng=f1;f2_zheng=f2;
figure(1);
plot(t,f1,'r');hold on;plot(t,f2,'b');
sig=cos(2*pi*s_f1)+sin(2*pi*s_f2); %�����sig
%sig=cos(2*pi*(10*t.^2+2*t))+cos(2*pi*(20*t.^2+4*t)); %�����sig
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

% s=sig;
% wavename='cmor3-3';
% totalscal=512;
% Fc=centfrq(wavename); % С��������Ƶ��
% c=2*Fc*totalscal;
% scals=c./(1:totalscal);
% f=scal2frq(scals,wavename,1/fs); % ���߶�ת��ΪƵ��
% coefs=cwt(s,scals,wavename); % ������С��ϵ��
% figure;
% f=(0:length(sig)/2-1)*fs/length(sig);
% % coefs=coefs(:,ind1:ind2);
% % 
% % t1=t2(ind1:ind2);
% 
% imagesc(t2,f,abs(coefs));
% set(gca,'YDir','normal')
% colorbar;
% xlabel('ʱ�� t/s');
% ylabel('Ƶ�� f/Hz');
% % title('С��ʱƵͼ');


% x=sig;
% CWTopt=struct('gamma',eps,'type','morlet','mu',6,'s',2,'om',0,'nv',64,'freqscale','linear'); %С���任������
% 
% % CWT Synchrosqueezing transform
% [Tx, ff, Wx, as, Cw] = synsq_cwt_fw(t, x, CWTopt.nv, CWTopt);
% xNew = synsq_cwt_iw(Tx, ff, CWTopt).';
% 
% figure;
% imagesc(t, ff, abs(Tx));axis xy % CWT-SSTʱƵͼ
% set(gca,'YDir','normal')
% colorbar;
% xlabel('ʱ�� t/s');
% ylabel('Ƶ�� f/Hz');
% title('ͬ��ѹ��ʱƵͼ');



% %% stft+spwv
sig=hilbert(sig);
sig=sig-mean(sig);
% [tfr,~,f] = tfrspwv(sig,1:length(sig),specnum,g,h);
[tfr,rtfr,f] = tfrstft(sig,1:length(sig),length(sig),hamming(125));
tfr=tfr(1:end/2,:);
% tfr=tfr(1:length(sig)/2,:);
% f=(0:length(sig)/2-1)*fs/length(sig);
%%%%%%D)
% f=0.5*(0:length(sig)-1)*fs/length(sig);
f=f(1:end/2,:)*fs;
% f=(0:length(sig)/2-1)*fs/length(sig)';
% f=f*fs;
% DD=(0.5*(0:length(f)-1)*fs/length(f))';
% tfr=tfr(:,ind1:ind2);

% t1=t2(ind1:ind2);

 figure();
 imagesc(t2, f, abs(tfr));
set(gca,'YDir','normal')
colorbar;


% %% �ֲ�����ֵ����
% 
fw=f;
% N=length(sig);
% a=zeros(1,N);
% b=zeros(1,N);
% b_p=zeros(1,N);
% coes_y=abs(tfr);
% [a(1),b(1)]=max(abs(coes_y(10:end,1)));
% temp1=80;%%��ʼ������Ƶ��
% b_p(1)=b(1)+temp1;
% for i=2:N
%     [a(i),b(i)]=max(abs(coes_y(temp1+b(i-1)-5:temp1+b(i-1)+5,i)));
%     temp1=b_p(i-1)-5-1;
%     b_p(i)=b(i)+temp1;
%    
% end
% figure(1);
% 
% f1=fw(b_p);
% 
% % plot(t2,f1);
% p=polyfit(t2,f1,1);
% y0=polyval(p,t2);
% 
% plot(t2,f1,t2,y0,'*');





% tfr=abs(coefs);
df=(f(2)-f(1));meiMge=floor(1/df); 
[tfr2,~,ind2]=pinglvfengduan(tfr,f,meiMge);
clear tfr;tfr=tfr2;clear tfr2 
% %%%%%%%����Ƶ�����

c=5;sigma=5;efxia=2;
[route,val_route]=viterbi3(abs(tfr),c,sigma,efxia);
for p=1:size(route,1),   
    temp=route(p,:);
    temp2=zeros(1,length(temp));
    for time_node=1:length(temp),
        temp2(time_node)=(temp(time_node)-1)*meiMge+ind2(temp(time_node),time_node)-1;
    end
    route(p,:)=temp2;
end
clear temp temp2 time_node p;


% f=2*f;
 for p=1:size(route,1),   
route(p,:)=f(route(p,:));
end
f1=route(1,:);
f2=route(10,:);


%%
% jieduan1=1;jieduan2=ceil(max(t2)-1);
% %*************%��������WVD��Ҫ��ȡ���ź�ָ��****************************************
% %%% ��ڣ���ɺ��ʱ��fs,t2,sig  fp
% %%% ��ڣ�ԭ����fs_origin t vdata ��chishu����
% %%% Ŀ�ģ����ź��������£�sʱ���Ա����WVD�˵�ЧӦ
% sig=sig';
% %%%%WVDȥ�˵�ЧӦ�ٽض����߸�1s,ʵ�����ǵ�jieduan1+1:jieduan2-1(2~5s)���ź�
% [~,ind1]=min(abs(t2-jieduan1));[~,ind2]=min(abs(t2-jieduan2));
% sig=sig-mean(sig);
% % %%%%%%%A)stft
%  sig=sig';sig=sig-mean(sig);
%  specnum=length(sig);
%  %sig=hilbert(sig);sig=abs(sig);sig=sig-mean(sig);
%  sig=hilbert(sig);
% g=tftb_window(length(sig)/10,'hamming'); h=tftb_window(length(sig)/10,'hamming'); 
% 
% if mod(length(g),2)==0,
%     g=tftb_window(length(sig)/10+1,'hamming');
% end
%    
% if mod(length(h),2)==0,
%    h=tftb_window(length(sig)/10+1,'hamming');
% end
% % %% stft+spwv
% % [tfr,~,f] = tfrspwv(sig,1:length(sig),specnum,g,h);
% [tfr,rtfr,f] = tfrstft(sig,1:length(sig),specnum,g,h);
% %%%%%%%D)
% f=0.5*(0:length(sig)-1)*fs/length(sig)'
% % f=f*fs;
% % DD=(0.5*(0:length(f)-1)*fs/length(f))';
% tfr=tfr(:,ind1:ind2);
% 
% t1=t2(ind1:ind2);
% 
%  figure();
%  imagesc(t, f, abs(tfr));
% set(gca,'YDir','normal')
% colorbar;
% %mesh(t1,f,tfr);
% % pcolor(t1,abs(f),abs(tfr));
% % shading interp;
% % colorbar;
% xlabel('t/s');ylabel('f/Hz');title('���źŵ�SPWVʱƵ�ֲ�ͼ')
% set(gcf,'unit','centimeters','position',[3 5 13.5 9])
% set(gcf,'color','white');
% ylim([0 200]);
%% ����С���任ʱƵͼ
% s=sig;
% wavename='cmor3-3';
% totalscal=125;
% Fc=centfrq(wavename); % С��������Ƶ��
% c=2*Fc*totalscal;
% scals=c./(1:totalscal);
% f=scal2frq(scals,wavename,1/fs); % ���߶�ת��ΪƵ��
% coefs=cwt(s,scals,wavename); % ������С��ϵ��
% figure;
% 
% % coefs=coefs(:,ind1:ind2);
% % 
% % t1=t2(ind1:ind2);
% imagesc(t2,f,abs(coefs));
% set(gca,'YDir','normal')
% colorbar;
% xlabel('ʱ�� t/s');
% ylabel('Ƶ�� f/Hz');
% title('С��ʱƵͼ');


% %%
% %*************%����vitebi����Ƶ��·��****************************************
% %%%��ڲ�����ʱ��������t1 Ƶ��������f ʱƵ�ֲ�tfr  ��ʼƵ��startfreq 
% %%%��ڲ�����ԭʼ���źŵ�vdata,fs_origin ,t����������chishu 
% % %%%%%%%����Ƶ�����
% df=(f(2)-f(1));meiMge=floor(1/df); 
% [tfr2,~,ind2]=pinglvfengduan(tfr,f,meiMge);
% clear tfr;tfr=tfr2;clear tfr2 
% % %%%%%%%����Ƶ�����
% 
% c=5;sigma=2;efxia=2;
% [route,val_route]=viterbi3(abs(tfr),c,sigma,efxia);
% for p=1:size(route,1),   
%     temp=route(p,:);
%     temp2=zeros(1,length(temp));
%     for time_node=1:length(temp),
%         temp2(time_node)=(temp(time_node)-1)*meiMge+ind2(temp(time_node),time_node)-1;
%     end
%     route(p,:)=temp2;
% end
% clear temp temp2 time_node p;
%  for p=1:size(route,1),   
% route(p,:)=f(route(p,:));
% end
% f1=route(1,:);
% f2=route(7,:);



%%

%%%%�Լ�������Ĺ���ת�ٲ�ֵ��ԭ����fs
t1=t2;
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
% [~,ind1]=min(abs(t-jieduan1));[~,ind2]=min(abs(t-jieduan2)); 
% vdata1=vdata(ind1:ind2);

vdata1=vdata-mean(vdata);

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