close all;clc;clear;
Fs=1000;
t=0:1/Fs:3;
x=sin(2*pi*(50*t+20*t.^2))+sin(2*pi*(100*t+30*t.^2));;
figure;
plot(t,x);

% s=x;
% f = 0:Fs/2;
% tfr = tfrstft(s');
% tfr = tfr(1:floor(length(s)/2), :);
% figure
% imagesc(t, f, abs(tfr));
% set(gca,'YDir','normal')
% colorbar;
% xlabel('ʱ�� t/s');
% ylabel('Ƶ�� f/Hz');
% title('��ʱ����Ҷ�任ʱƵͼ'); 
% 
% 
% 
% % imagesc(t, fs, abs(Tx));
% % set(gca,'YDir','normal')
% % colorbar;
% % xlabel('ʱ�� t/s');
% % ylabel('Ƶ�� f/Hz');
% % title('ͬ��ѹ��ʱƵͼ'); 
% 
% 
% %% 
% x=x(:);
% CWTopt=struct('gamma',eps,'type','morlet','mu',6,'s',2,'om',0,'nv',64,'freqscale','linear'); %С���任������
% 
% % CWT Synchrosqueezing transform
% [Tx, fs, Wx, as, Cw] = synsq_cwt_fw(t, x, CWTopt.nv, CWTopt);
% xNew = synsq_cwt_iw(Tx, fs, CWTopt).';
% 
% figure;
% imagesc(t, fs, abs(Tx));axis xy % CWT-SSTʱƵͼ
% set(gca,'YDir','normal')
% colorbar;
% xlabel('ʱ�� t/s');
% ylabel('Ƶ�� f/Hz');
% title('ͬ��ѹ��ʱƵͼ');
% 
% % figure();
% % 
% % plot(t,[x,xNew(:,1)]);% �ع��źűȽ�
% 
% 
% 
% % % ����С���任ʱƵͼ
% s=x;
% wavename='cmor3-3';
% totalscal=256;
% Fc=centfrq(wavename); % С��������Ƶ��
% c=2*Fc*totalscal;
% scals=c./(1:totalscal);
% f=scal2frq(scals,wavename,1/Fs); % ���߶�ת��ΪƵ��
% coefs=cwt(s,scals,wavename); % ������С��ϵ��
% figure;
% imagesc(t,f,abs(coefs));
% set(gca,'YDir','normal')
% colorbar;
% xlabel('ʱ�� t/s');
% ylabel('Ƶ�� f/Hz');
% title('С��ʱƵͼ');
% 
%% κ���ɷֲ�
sig=x';




jieduan1=1;jieduan2=2;
%*************%��������WVD��Ҫ��ȡ���ź�ָ��****************************************
%%% ��ڣ���ɺ��ʱ��fs,t2,sig  fp
%%% ��ڣ�ԭ����fs_origin t vdata ��chishu����
%%% Ŀ�ģ����ź��������£�sʱ���Ա����WVD�˵�ЧӦ

%%%%WVDȥ�˵�ЧӦ�ٽض����߸�1s
% a=abs(t2-jieduan1);
[~,ind1]=min(abs(t-jieduan1));[~,ind2]=min(abs(t-jieduan2));
% sig=sig-mean(sig);
%  sig=sig';
%  specnum=length(sig);
%  sig=hilbert(sig);
%  sig=abs(sig);                        
%  sig=sig-mean(sig);
%  sig11=hilbert(sig);
sig11=sig;
g=tftb_window(round(length(sig11)/10+1),'hamming'); h=tftb_window(round(length(sig11)/10+1),'hamming'); 
[tfr,~,f] = tfrspwv(sig11,1:length(sig11),length(sig11),g,h);


f=f*Fs;

tfr=tfr(:,ind1:ind2);

t1=t(ind1:ind2);


% f=f(1:end/2)*fs;%%%%
% tfr=tfr(1:end/2,ind1:ind2);%%tfr(:,ind1:ind2);tfr(1:end/2,ind1:ind2);
% t1=t2(ind1:ind2);

figure;
%mesh(t1,f,tfr);
pcolor(t1,f,tfr);
shading interp;
colorbar;



[tfr,rtfr,f] = tfrstft(sig,1:length(sig),length(sig),hamming(125),hamming(125));
f=f*Fs;
figure;
% mesh(t1,f,tfr);
% pcolor(t2,f,abs(tfr));
pcolor(t,f,abs(tfr));
shading interp;
colorbar;

f=abs(f);
% tfr=abs(coefs);

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
 for p=1:size(route,1),   
route(p,:)=f(route(p,:));
end

