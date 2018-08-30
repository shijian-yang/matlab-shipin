function [route,val_route]=viterbi3(tfr,c1,sigma0,efxia)

[row,col]=size(tfr);

tfr(1:3,:)=-1000*ones(3,col);

[row,col]=size(tfr);
sigma=sigma0;

temp=zeros(row,1);
%   N1:ÿ��ȡ����������
%   N2:ÿ�����������ڽ��ĵ���
N1=20;N2=20*4;
% pre_route=inf*ones(row,col);
% val_pre_route=inf*ones(row,col);

%%%%%%%������ۺ���f(x)=trf(x)
    for di_i=1:col,
        di_i_col=tfr(:,di_i);
        [val,ind]=sort(di_i_col,'descend');
        temp1=[0:row-1]';
        temp(ind)=temp1;
        tfr(:,di_i)=temp;
    end
%%%%%%%������ۺ���f(x)=tfr(x)
   
%%%route���м�¼�������о��������
route=inf*ones(N1,col);

[c_mins,ind_mins]=sort(tfr(:,1));
ind_mins=ind_mins(1:N1);%indmins�Ǵ�С�������е�����ԭ����ĵڼ���
route(:,1)=ind_mins;%route����Ϊn1

val_route=c_mins(1:N1);

%%%%%%%����ÿ��ĺ������·��pre_route��val_pre_route
  for di_i=1:col-1,    %����di_i��
%       [c_mins,ind_mins]=sort(tfr(:,di_i));
%       ind_mins=ind_mins(1:N1);
%       route(:,di_i)=ind_mins;
        ind_mins=route(:,di_i);
    for pointer=1:N1,%�Ƚ�di_i�еĵ�pointer����
        %�������
          min_pre_ind=max([ind_mins(pointer)-N2,1]);
          max_pre_ind=min([ind_mins(pointer)+N2,row]);
          keneng_ind=[min_pre_ind:max_pre_ind];
%        pre_pinglv=ind_mins(pointer);%����ǰһ��Ƶ�ʽ��,pointer�У�di_i��%%
          %%%%%%%%%%%%%%%������ۺ���g(x)
          gx=abs(keneng_ind-ind_mins(pointer));
          ind_sigma=find(gx<sigma|gx==sigma);
          ind_sigma2=find(gx>sigma);
          gx(ind_sigma)=0;
          gx(ind_sigma2)=c1*(gx(ind_sigma2)-sigma);
          %%%%%%%%%%%%%%%������ۺ���g(x)
          temp=gx'+tfr(keneng_ind,di_i+1);  
          [c0,ind0]=min(temp);  %ind0����di_i-1����keneng_ind��ind0�����
                                %���tfr(keneng_ind(ind0),di_i-1)
                                %�뱾���tfr(ind_mins(pointer),di_i)���
                                %�������ܲ���ǰ���ѳ��ĽϺõĽ��
          chang_ind0=find(temp==c0); %chang_ind0��ǰ����ۺ�������С��һЩ
                                     %���壺tfr(keneng_ind(chang_ind0,di_i))
          foundind=keneng_ind(chang_ind0); %foundind��ȫ�ֵ�
          [found_c,found_ind]=min(abs(foundind-ind_mins(pointer)));
          route(pointer,di_i+1)=foundind(found_ind); 
          val_route(pointer)=val_route(pointer)+c0;
%           xianzaipinglv=foundind(found_ind);%����Ƶ�ʽ��,pointert�У�di_i+1��
%                     number=0;
%                     if xianzaipinglv==pre_pinglv,
%               number=number+1;
%               if number>20,
%                   sigma=sigma+0.1*(number-20);
%                   pre_pinglv=xianzaipinglv;
%               end
%           else
%               sigma=sigma0;
%               number=0;
%           end
    end
  end
end