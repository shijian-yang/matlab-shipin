clear all;
close all;
vib=textread('E:\bisheʵ������\25600����\REC3939_ch3.txt','','headerlines',16);
pul=textread('E:\bisheʵ������\25600����\REC3939_ch2.txt','','headerlines',16);
pluse1=vib(:,1);
vdata=vib(:,2);
% pul=pul(:,2);pul=-pul;
threshold=abs(1)/3;
fs=25600;
figure;
plot(pluse1,vdata)
xlabel('t/s');ylabel('amplitude');title('ԭʼ�ź�');
%%%ȡ�����źŴ���
vdata=vdata(fs*7:fs*9);
% pul=pul(fs*7:fs*9);
n=length(vdata);
t=(0:n-1)/fs;
% f=(0:n-1)*fs/n;
figure;
plot(t,vdata)
xlabel('t/s');ylabel('amplitude');title('��ȡ�ź�');

sig=vdata;
%%����%%
% sig=sig0';
% [sig,startnode,xlength,tnode]=duichengyantuo(sig,fs);
% t=(0:length(sig)-1)/fs;
%% С������
lev=5;
sig=wden(sig,'minimaxi','s','mln',lev,'sym5');%%���ݷ�λ���ٶ�ȥ��
figure;
plot(t,sig);


% % �Ͷ��˲�
% nlevel= 8;
% opt1=1;opt=2;
% figure()
% sig= Fast_Kurtogram2(sig,nlevel,fs,opt1,opt);
%% ��ͨ�˲� 
% fp=[5000,6100];fst=[4900,6200];%�˲����Ĳ�������


fp=[3800,4600];fst=[3600,4800];%�˲����Ĳ�������
% sig=sig-mean(sig);
% sig=Noisedaitong(sig,fs,fp,fst);
% figure;
% plot(t,sig);
% xlabel('t/s');ylabel('amplitude')
% title('�˲����ź�')


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
xlabel('t/s');ylabel('��ֵ');
fs=fs2; 
clear ��chongcaiyanlv  pp fst;clear chongcaiyanlv fs2;pack;

% x=sig1;
% CWTopt=struct('gamma',eps,'type','morlet','mu',6,'s',5,'om',0,'nv',64,'freqscale','linear'); %С���任������
% 
% % CWT Synchrosqueezing transform
% [Tx, f1, Wx, as, Cw] = synsq_cwt_fw(t2, x, CWTopt.nv, CWTopt);
% xNew = synsq_cwt_iw(Tx, f1, CWTopt).';
% 
% figure;
% imagesc(t2, f1, abs(Tx));axis xy % CWT-SSTʱƵͼ
% set(gca,'YDir','normal')
% colorbar;
% xlabel('ʱ�� t/s');
% ylabel('Ƶ�� f/Hz');
% title('ͬ��ѹ��ʱƵͼ');

% figure;
% mesh(t2,f1,abs(Tx));

%% ����С���任ʱƵͼ
s=sig1;
wavename='cmor3-3';
totalscal=2048;
Fc=centfrq(wavename); % С��������Ƶ��
c=2*Fc*totalscal;
scals=c./(1:totalscal);
fff=scal2frq(scals,wavename,1/fs); % ���߶�ת��ΪƵ��
coefs=cwt(s,scals,wavename); % ������С��ϵ��
figure;
% f=(0:length(sig1)/2-1)*fs/length(sig1);
f=0.5*(0:length(sig1)-1)*fs/length(sig1);
imagesc(t2,fff,abs(coefs));
set(gca,'YDir','normal')
colorbar;
xlabel('ʱ�� t/s');
ylabel('Ƶ�� f/Hz');
xlabel('ʱ�� t/s');
ylabel('Ƶ�� f/Hz');
title('С��ʱƵͼ');

% %% �ֲ����ֵ
% fw=fff;
% coes_y=coefs;
% N=length(s);
% a=zeros(1,N);
% b=zeros(1,N);
% b_p=zeros(1,N);
% [a(1),b(1)]=max(abs(coes_y(1:end,1)));
% temp1=30;%%��ʼ������Ƶ��
% b_p(1)=b(1)+temp1;
% for i=2:N
%     [a(i),b(i)]=max(abs(coes_y(temp1+b(i-1)-5:temp1+b(i-1)+5,i)));
%     temp1=b_p(i-1)-5-1;
%     b_p(i)=b(i)+temp1;
% %     coes_y(b_p(i)-5:b_p(i)+5,i)=0;
% end
% figure(1);
% 
% f1=fw(b_p);
% 
% % plot(t2,f1);
% p=polyfit(t2,f1,1);
% y0=polyval(p,t2);
% plot(t2,f1,t2,y0,'k');
% 
% 
% 
% fs=fs_origin;
% t1=t2;
% 
% f1=interp1(t1,f1,t1(1):1/fs:t1(end));%%%%%
% % f2=interp1(t1,f2,t1(1):1/fs:t1(end));
% f1=f1/2;
% t1=t1(1):1/fs:t1(end);%%%%%%
% 
% [ttt,frequency2]=shijispeed(pul,threshold,fs);
% 
% a=polyfit(t1,f1,1);
% f2=polyval(a,t1,1);
% figure;
% hold on;
% plot(t1,f1,'k');
% plot(t1,f2,'r');
% plot(ttt,frequency2);
% xlabel('t/s');ylabel('amplitude');title('����ת��');
% hold off;





%% viterbi����

tfr=abs(coefs);
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



route=route*(fs/2/totalscal);

%% �����У��
[row,col]=size(route);
for i=1:row
    for j=2:col
        if route(i,j)-route(i,j-1)>=15
            route(i,j)=route(i,j-1);
        end
    end
end

f1=route(1,:);
figure;
plot(t2,f1);

fs=fs_origin;
t1=t2;

f1=interp1(t1,f1,t1(1):1/fs:t1(end));%%%%%
% f2=interp1(t1,f2,t1(1):1/fs:t1(end));
f1=f1/2;
t1=t1(1):1/fs:t1(end);%%%%%%

[ttt,frequency2]=shijispeed(pul,threshold,fs);

a=polyfit(t1,f1,1);
f2=polyval(a,t1,1);
figure;
hold on;
plot(t1,f1,'k');
plot(t1,f2,'r');
plot(ttt,frequency2);
xlabel('t/s');ylabel('amplitude');title('����ת��');
hold off;



%  for p=1:size(route,1),   
% route(p,:)=f(route(p,:));
% end
% f1=route(12,:);
% f1=route(16,:);3942 3
f1=route(7,:);%5%1-3��Ļ���15��2-3�Ļ���7

%%%%�Լ�������Ĺ���ת�ٲ�ֵ��ԭ����fs

fs=fs_origin;
f1=interp1(t1,f1,t1(1):1/fs:t1(end));%%%%%
% f2=interp1(t1,f2,t1(1):1/fs:t1(end));
f1=f1/2;
t1=t1(1):1/fs:t1(end);%%%%%%

[ttt,frequency2]=shijispeed(pul,threshold,fs);

a=polyfit(t1,f1,3);
f2=polyval(a,t1,3);
figure;
hold on;
plot(t1,f1,'k');
plot(t1,f2,'r');
plot(ttt,frequency2);
xlabel('t/s');ylabel('amplitude');title('����ת��');
hold off;
%%%%�Լ�������Ĺ���ת�ٲ�ֵ��ԭ����fs
%%
[~,ind1]=min(abs(t-jieduan1));[~,ind2]=min(abs(t-jieduan2)); 
vdata1=vdata(ind1:ind2);
% %%%%%%%%%%%%�ݲ��˲�
vdata1=vdata1-mean(vdata1);
% vdata1=trapper(vdata1,50,fs,ceil(fs/50));
%%�״η���
tiepian=1;
pluse=freq2pluse(f2,fs,tiepian);%%����תƵ
figure(12)
hold on;
plot(t1,pluse);
ylim([0 1.3]);
% plot(pluse,'k')
xlabel('t/s');ylabel('amplitude');title('��������');
hold off;
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
xlim([0 20]); 

%%�״η���
[f,ayy,t_angle,array_time_amp]=FUCTION_COTA2(vdata1,pluse,fs,order_max,1,threshold);
figure;
plot(f,ayy)
title('�״���ͼ'),
xlabel('order'),
ylabel('amplitude');
xlim([0 20]); 




