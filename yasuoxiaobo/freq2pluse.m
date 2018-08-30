function pluse=freq2pluse(f,fs,tiepian)
%[R]=romberg(f,a,b,fs,tol)

%%%1)���ò���
pluse=zeros(1,length(f));
tol=1e-6;
round=tiepian;%round����Ǽ�ת,tiepian��ģ����������������Ƭ
%%%1)���ò���

%%%2�����ټ��������������η����Ի��֣����ڴ��Ե㸽����romberg���ַ�
R1=0;gujishibiao=[];r1=[];
round=1;
for num=1:length(f)-1,
    R1=R1+(f(num)+f(num+1))/fs/2;
    if R1>round,
        gujishibiao=[gujishibiao,num];
        round=round+1;
        r1=[r1,R1];
    end
end
R1=r1;
%%%2�����ټ��������������η����Ի��֣����ڴ��Ե㸽����romberg���ַ�

%%%3���Թ���ʱ�괦��romberg�����ٻ��֣��õ��Ͼ�ȷ��ֵR1
% R1=[];
% for p=1:length(gujishibiao),
%     a=0;b=gujishibiao(p)/fs;
%     temp=romberg(f,a,b,fs,tol);
%     R1=[R1,temp];
% end
%%%3���Թ���ʱ�괦��romberg�����ٻ��֣��õ��Ͼ�ȷ��ֵR1

%%%4���Թ��Ƶ㴦��ֵ��romberg��������һ�飬��¼ƫ��ƫСָ��updown
round=1;updown=[];up=1;down=0;
for p=1:length(R1),
    if R1(p)>round,
        updown=[updown,up];
    else
        updown=[updown,down];
    end
    round=round+1;
end
%%%4���Թ��Ƶ㴦��ֵ��romberg��������һ�飬��¼ƫ��ƫСָ��updown

num=1;round=tiepian;ind=1;
up_biaozhi=1;down_biaozhi=-1;

%%%5����R1����������õ�R���µ�ʱ��λ��ָ��ind
ind=2; %�������ʱ�������е�ָ�룬��һ�����������壬����Ե�1�����ݶ����ʼ����
for p=1:length(updown),
    if updown(p)==1,
        %%%����up���Ա����������ʹ������ƫ��Ҫ��romberg������
        %%%���������������Լ������
        while up_biaozhi>0,
            num1=gujishibiao(p);
            num2=num1-1;            
            zhengshu_f=ceil(f(num1));  %gujishubiao���´�������ֵ
            temp=(f(num1)+f(num2))/fs/2;
            R1(p)=R1(p)-temp;
            up_biaozhi=R1(p)-zhengshu_f;
            num1=num1-1;num2=num1-1;
        end
    else
        %%%����down���Ա����������ʹ������ƫС��Ҫ��romberg������ǰ
        %%%���������������Լ������  
        while down_biaozhi<0,
            num1=gujishibiao(p);
            num2=num1+1;            
            zhengshu_f=floor(f(num1));  %gujishubiao���´�������ֵ
            temp=(f(num1)+f(num2))/fs/2;
            R1(p)=R1(p)+temp;
            down_biaozhi=R1(p)-zhengshu_f;
            num1=num1+1;num2=num1+1;    
        end
    end
    ind=[ind,num1];
    up_biaozhi=1;down_biaozhi=-1;
end
%%%5����R1����������õ�R���µ�ʱ��λ��ָ��ind

% for num=1:length(f)-1,
%     temp_t=t(num);
%     a=0;b=temp_t;
%     [R1]=romberg(f,a,b,fs,tol);
%     b2=t(num+1);
%     [R2]=R1+(f(num)+f(num+1))/fs/2;
%     if  R1<=round&R2>=round,
%         ind=[ind,n];
%         round=round+1;
%     end
% end
pluse(ind)=1;
end