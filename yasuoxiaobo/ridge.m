function out=ridge ( c ) 
  %c��Ҫ��ȡ���ߵ�ʱƵ����,cԪ��Ϊ�Ǹ�
[B,A]=size(c);
N=floor(A*B/4);
%����N��Climber
temp=zeros(B,A);
for i=1:1:A*B
   if mod(i,4)==0
      temp(i)=1;
   end
end
T=max(max(c))-min(min(c));%ϵͳ��ʼ���¶�
Tt=T; %ϵͳ��ǰ�¶�
t=2; %ϵͳ��ǰʱ��

while Tt>=T/1000 %��ʱ��t��ѭ��
   for i=4:4:A*B %��ÿ��climber���ƶ�
      if mod(i,B)==0
         heng=mod(i,B)+B;
      else
         heng=mod(i,B);
      end %����climber�ĺ�����
     
      zong=ceil(i/B) %����climber��������
      p=sign(2*rand-1); %��������0.5�ĵȸ��ʷֱ���������ƶ�
      if heng==1
         p=1;
      elseif heng==A
         p=-1;
      end %�ų��߽�����
      heng_new=heng+p;

      %�����갴�����ƶ�
      p=sign(2*rand-1);
      if zong==1
         p=1;
      elseif zong==A
         p=-1;
      end %�ų��߽�����
      zong_new=zong+p;
      if c(heng_new,zong_new)>c(heng_new,zong)
         temp(heng,zong)=0;
         temp(heng_new,zong_new)=1;
      else
         pt=exp((c(heng_new,zong_new)-c(heng_new,zong))/Tt);
         if(rand<=pt)
             zong_new=zong+p;
             temp(heng,zong)=0;
             temp(heng_new,zong_new)=1;
         else
             zong_new=zong;
             temp(heng,zong)=0;
             temp(heng_new,zong_new)=1;
          end 
      end
   end
   Tt=T/log2(t);
   t=t+1;
end
