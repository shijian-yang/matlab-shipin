function n = findpeaks(x)
% Find peaks. �Ҽ���ֵ�㣬���ض�Ӧ����ֵ�������
n    = find(diff(diff(x) > 0) < 0); % һ�׵������������������׵�С���㰼����
u    = find(x(n+1) > x(n));
n(u) = n(u)+1;                      % ��1��������Ӧ����ֵ��
