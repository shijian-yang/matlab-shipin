function [tfr2,f2,ind2]=pinglvfengduan(tfr,f,meiMge)
[row,col]=size(tfr);
max_start=floor((row-1)/meiMge);
tfr2=zeros(max_start,col);ind2=zeros(max_start,col);
p=1:max_start;
start=(p-1)*meiMge+1;
f2=[];
for p=1:max_start,
    temp_start=start(p);temp_end=start(p)+meiMge-1;
    temp_tfr=tfr(temp_start:temp_end,:);
    [temp_val,temp_ind]=max(temp_tfr);%������������ֵ����ÿһ�е����ֵȻ�󷵻صڼ���
    tfr2(p,:)=temp_val;%ÿһ�����ֵ��һ��col��
    ind2(p,:)=temp_ind;%ind2ûһ�ж�Ӧ10����ÿһ�����ֵ��Ӧ�ĵڼ���
    f2=[f2,f(temp_start)];%��f2��Ϊ1��11��21
end
f2=f2';
end