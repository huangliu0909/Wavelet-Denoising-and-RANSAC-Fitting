clc;clear all;close all;
%�����������
mu1=[0 0];  %��ֵ
S1=[1 2.5;2.5 8];  %Э����
data1=mvnrnd(mu1,S1,200);   %�ڵ㣺200����˹�ֲ�����
mu2=[2 2];
S2=[10 0;0 10];
data2=mvnrnd(mu2,S2,100);     %��㣺����100����������
%�ϲ�����
data=[data1',data2'];
figure;plot(data(1,:),data(2,:),'*');hold on; % ��ʾ���ݵ�
number = size(data,2); % �ܵ���
sigma = 1;
pretotal=0;     %�������ģ�͵����ݵĸ���
 for i=1:1000
     idx = randperm(number,2); % �ܵ�����������
     sample = data(:,idx); 

     %%%���ֱ�߷��� y=kx+b
     line = zeros(1,3);
     x = sample(:, 1);
     y = sample(:, 2);
     k=(y(1)-y(2))/(x(1)-x(2));      
     b = y(1) - k*x(1);
     line = [k -1 b]

     mask=abs(line*[data; ones(1,size(data,2))]);    %��ÿ�����ݵ����ֱ�ߵľ���
     total=sum(mask<sigma);              %�������ݾ���ֱ��С��һ����ֵ�����ݵĸ���

     if total>pretotal            %�ҵ��������ֱ�������������ֱ��
         pretotal=total;
         bestline=line;          %�ҵ���õ����ֱ��
    end  
 end
mask=abs(bestline*[data; ones(1,size(data,2))])<sigma;    
hold on;
k=1;% �ҵ�����֧�ָ�ģ�͵ĵ�
for i=1:length(mask)
    if mask(i)
        support(1,k) = data(1,i);
        k=k+1;
    end
end
 xAxis = min(support(1,:)):max(support(1,:));
 yAxis = bestline(1) * xAxis + bestline(3);
 plot(xAxis,yAxis,'r-','LineWidth',2);
