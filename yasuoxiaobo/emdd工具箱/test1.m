clear;clc;clf;
N=2048;
%fftĬ�ϼ�����ź��Ǵ�0��ʼ��
t=linspace(1,2,N);deta=t(2)-t(1);fs=1/deta;
x=5*sin(2*pi*10*t)+5*sin(2*pi*35*t);
z=x;
c=emd(z);

%����ÿ��IMF���������һ��ʣ�����residual��ԭʼ�źŵ������
[m,n]=size(c);
for i=1:m;
% a=corrcoef(c(i,:),z);
a=corrcoef(c{i},z);
xg(i)=a(1,2);
end
xg;


% for i=1:m-1
% %--------------------------------------------------------------------
% %�����IMF�ķ������
% %���壺����Ϊƽ���ľ�ֵ��ȥ��ֵ��ƽ��
% %��ֵ��ƽ��
% %imfp2=mean(c(i,:),2).^2
% %ƽ���ľ�ֵ
% %imf2p=mean(c(i,:).^2,2)
% %����IMF�ķ���
% % mse(i)=mean(c(i,:).^2,2)-mean(c(i,:),2).^2;
% mse(i)=mean(c{i}.^2,2)-mean(c{i},2).^2;
% end;
% mmse=sum(mse);
% for i=1:m-1
% mse(i)=mean(c(i,:).^2,2)-mean(c(i,:),2).^2; 
% %����ٷֱȣ�Ҳ���Ƿ������
% mseb(i)=mse(i)/mmse*100;
% %��ʾ����IMF�ķ���͹�����
% end;
% %����ÿ��IMF���������һ��ʣ�����residual��ͼ��
% figure(1)
% for i=1:m-1
% disp(['imf',int2str(i)]) ;disp([mse(i) mseb(i)]);
% end;
% subplot(m+1,1,1)
% plot(t,z)
% set(gca,'fontname','times New Roman')
% set(gca,'fontsize',14.0)
% ylabel(['signal','Amplitude'])
% 
% for i=1:m-1
% subplot(m+1,1,i+1);
% set(gcf,'color','w')
% plot(t,c(i,:),'k')
% set(gca,'fontname','times New Roman')
% set(gca,'fontsize',14.0)
% ylabel(['imf',int2str(i)])
% end
% subplot(m+1,1,m+1);
% set(gcf,'color','w')
% plot(t,c(m,:),'k')
% set(gca,'fontname','times New Roman')
% set(gca,'fontsize',14.0)
% ylabel(['r',int2str(m-1)])
% 
% %����ÿ��IMF������ʣ�����residual�ķ�Ƶ����
% figure(2)
% subplot(m+1,1,1)
% set(gcf,'color','w')
% [f,z]=fftfenxi(t,z);
% plot(f,z,'k')
% set(gca,'fontname','times New Roman')
% set(gca,'fontsize',14.0)
% ylabel(['initial signal',int2str(m-1),'Amplitude'])
% 
% for i=1:m-1
% subplot(m+1,1,i+1);
% set(gcf,'color','w')
% [f,z]=fftfenxi(t,c(i,:));
% plot(f,z,'k')
% set(gca,'fontname','times New Roman')
% set(gca,'fontsize',14.0)
% ylabel(['imf',int2str(i),'Amplitude'])
% end
% subplot(m+1,1,m+1);
% set(gcf,'color','w')
% [f,z]=fftfenxi(t,c(m,:));
% plot(f,z,'k')
% set(gca,'fontname','times New Roman')
% set(gca,'fontsize',14.0)
% ylabel(['r',int2str(m-1),'Amplitude'])
% 
% hx=hilbert(z);
% xr=real(hx);xi=imag(hx);
% %����˲ʱ���
% sz=sqrt(xr.^2+xi.^2);
% %����˲ʱ��λ
% sx=angle(hx);
% %����˲ʱƵ��
% dt=diff(t);
% dx=diff(sx);
% sp=dx./dt;
% figure(6)
% plot(t(1:N-1),sp)
% title('˲ʱƵ��')
%����HHTʱƵ�׺ͱ߼���
[A,fa,tt]=hhspectrum(c{1});
[E,tt1]=toimage(A,fa,tt,length(tt));
figure(3)
disp_hhs(E,tt1) %��άͼ��ʾHHTʱƵ�ף�E����õ�HHT��
pause
figure(4)
for i=1:size(c,1)
faa=fa(i,:);
[FA,TT1]=meshgrid(faa,tt1);%��άͼ��ʾHHTʱƵͼ
surf(FA,TT1,E)
title('HHTʱƵ����ά��ʾ')
hold on
end
hold off
E=flipud(E);
for k=1:size(E,1)
bjp(k)=sum(E(k,:))*1/fs; 
end
f=(1:N-2)/N*(fs/2);
figure(5)
plot(f,bjp);
xlabel('Ƶ�� / Hz');
ylabel('�źŷ�ֵ');
title('�źű߼���')%Ҫ��߼��ױ����ȶ��źŽ���EMD�ֽ�
