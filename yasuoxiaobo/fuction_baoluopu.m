function [order,ayy,array_angle,array_angle_amp] = fuction_baoluopu( vdata,pdata,Fs,order_max,numpr,threshold )

    array_time_amp=vdata;
    pluse=pdata;

N=length(array_time_amp);       
t=(0:N-1)/Fs;
Num_pluse1=1;
for temp2=1:length(pluse)-1;
    if abs(pluse(temp2))<threshold&&abs(pluse(temp2+1))>=threshold
        Num_pluse1=[Num_pluse1,temp2+1]; %���������ĸ���
    
    end
end

%%��ȥ����Ϊ0��ʱ��
k=[];
for i=2:length(Num_pluse1)
    if (Num_pluse1(i)-Num_pluse1(i-1))<256
        k=[k,i];
    end
end
m=0;
for i=1:length(k)
    Num_pluse1(k(i)-m)=[];
    m=m+1;
end




if length(Num_pluse1)<2,return,end;
t_pluse=(Num_pluse1-1)/Fs; %���������ֵ�ʱ��
%����������
 if mod(length(t_pluse),numpr)==0                         
     numpluse=floor((length(t_pluse)-1)/numpr);     
 else
     numpluse=floor(length(t_pluse)/numpr);
 end
 if numpr>=2  % ���ÿȦ���������������ϵļ����ź�                                                        
     whole_pluse=[];whole_pluse=[whole_pluse,t_pluse(1)];
     for k=1:numpluse
         imev=t_pluse(1+k*numpr);
         whole_pluse=[whole_pluse,imev];
     end
      t_pluse=whole_pluse;
 else
     whole_pluse=t_pluse; %���ʱ��
 end


%�ź��˲������ս״η�������������߽״ε�Ƶ�ʳɷ�
i=1;
while i<=length(whole_pluse)-1;
    ft=1/(whole_pluse(i+1)-whole_pluse(i)); %��������ļ��Ƶ��
     fomax=ft *order_max;
      prodata=array_time_amp(Num_pluse1(1+(i-1)*numpr):(Num_pluse1(1+i*numpr)-1));%��������֮�������
      prolen=length(prodata);fomn=ceil(prolen*fomax/Fs);
      freqd=fft(prodata);           
      if mod(prolen,2)==0         
          maxspectrumline=ceil(prolen/2)+1;      
      else
          maxspectrumline=ceil(prolen/2);         
      end
      %�����ڷ���Ƶ�ʵ���������
      if fomn<maxspectrumline;
          if mod(prolen-1,2)==0;          
              ii=maxspectrumline;
              while ii>fomn;
                  freqd(ii)=0;
                  freqd(mod(prolen-ii+1,prolen)+1)=0;
                  ii=ii-1;
               end
          else                                  
              freqd(maxspectrumline)=0;     
              ii=ceil(prolen/2);
              while ii>fomn;
                  freqd(ii)=0;
                  freqd(mod(prolen-ii+1,prolen)+1)=0;
                  ii=ii-1;
              end
          end;
      end
      Imed=ifft(freqd);
      array_time_amp(Num_pluse1(1+(i-1)*numpr):(Num_pluse1(1+i*numpr)-1))=Imed(1:(Num_pluse1(1+i*numpr)-Num_pluse1(1+(i-1)*numpr)));
      i=i+1;
end
% �����ز���
delt_thet=pi/order_max;
t_angle=[];
for temp3=3:length(t_pluse);
    b=inv([1,t_pluse(temp3-2),t_pluse(temp3-2)^2;1,t_pluse(temp3-1),t_pluse(temp3-1)^2;1,t_pluse(temp3),t_pluse(temp3)^2])*[0,2*pi,4*pi]';
    if temp3==3;                                              
        k=0;
        while k<1.5*2*pi/delt_thet; %��kС��3���ķ����״�
            if b(3)~=0;
                tt=(sqrt(4*b(3)*(k*delt_thet-b(1))+b(2)^2)-b(2))/(2*(b(3)+eps));
                t_angle=[t_angle,tt];
            else
                tt=(k*delt_thet-b(1))/b(2);
                t_angle=[t_angle,tt];
            end
            k=k+1;
        end
    else                                                             
        k=pi/delt_thet;
        while k>=pi/delt_thet && k<1.5*2*pi/delt_thet; %��k�ڷ����״κ�3�������״�֮��
            if b(3)~=0;
                tt=(sqrt(4*b(3)*(k*delt_thet-b(1))+b(2)^2)-b(2))/(2*(b(3)+eps));
                t_angle=[t_angle,tt];
            else
                tt=(k*delt_thet-b(1))/b(2);
                t_angle=[t_angle,tt];
            end
            k=k+1;
        end
    end
end
k=3*pi/delt_thet;                                        
while k<4*pi/delt_thet;
    if b(3)~=0;
        tt=(sqrt(4*b(3)*(k*delt_thet-b(1))+b(2)^2)-b(2))/(2*(b(3)+eps));
        t_angle=[t_angle,tt];
    else
        tt=(k*delt_thet-b(1))/b(2);
        t_angle=[t_angle,tt];
    end
    k=k+1;
end
array_angle=[0:length(t_angle)-1].*delt_thet; %��ȡ�����Ƕ�
array_angle_amp=interp1(t,array_time_amp,t_angle,'spline'); %��ȥ�����Ƕȴ����񶯷�ֵ
array_angle_amp=array_angle_amp-mean(array_angle_amp);  


% ʱ��ƽ��
lv=40;%% ͬ��ѹ����Ȧ��26
vec_num=floor(length(array_angle_amp)/(2*order_max*lv));
temp=zeros(1,2*order_max*lv);
m1=1;m2=2*order_max*lv;
for pp=1:vec_num
    xxx=array_angle_amp(m1:m2);
    temp=temp+xxx;
    m1=m1+2*order_max*lv;
    m2=m2+2*order_max*lv;
   temp=temp+array_angle_amp((pp-1)*2*order_max*lv+1:(pp-1)*2*order_max*lv+2*order_max*lv);
end
array_angle_amp=temp;
array_angle_amp=array_angle_amp/vec_num;
array_angle=[0:length(array_angle_amp)-1].*delt_thet;

 figure(30)
 plot(array_angle,array_angle_amp)
 xlabel('angle/rad');ylabel('amplitude');title('�ز����ź�');


 

array_angle_amp=hilbert(array_angle_amp);
array_angle_amp=abs(array_angle_amp);
array_angle_amp=array_angle_amp-mean(array_angle_amp);

%% ����Ҷ�任
angle_dom_ffty=abs(fft(array_angle_amp))*2/length(array_angle_amp);
 delt_order=2*pi/(length(angle_dom_ffty)*delt_thet);
angle_dom_fx=(0:length(angle_dom_ffty)-1)*delt_order;
order=angle_dom_fx(1:length(angle_dom_fx)/2);
ayy=angle_dom_ffty(1:length(angle_dom_fx)/2);
% figure; plot(order,ayy,'k');xlabel('t/s');ylabel('amplitude');title('��ת���źŵİ���״���ͼ')
% set(gcf,'unit','centimeters','position',[3 5 13.5 9])

end

