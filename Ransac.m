clc;clear all;close all;
%生成随机数据
mu1=[0 0];  %均值
S1=[1 2.5;2.5 8];  %协方差
data1=mvnrnd(mu1,S1,200);   %内点：200个高斯分布数据
mu2=[2 2];
S2=[10 0;0 10];
data2=mvnrnd(mu2,S2,100);     %外点：产生100个噪声数据
%合并数据
data=[data1',data2'];
figure;plot(data(1,:),data(2,:),'*');hold on; % 显示数据点
number = size(data,2); % 总点数
sigma = 1;
pretotal=0;     %符合拟合模型的数据的个数
 for i=1:1000
     idx = randperm(number,2); % 总点数中挑两个
     sample = data(:,idx); 

     %%%拟合直线方程 y=kx+b
     line = zeros(1,3);
     x = sample(:, 1);
     y = sample(:, 2);
     k=(y(1)-y(2))/(x(1)-x(2));      
     b = y(1) - k*x(1);
     line = [k -1 b]

     mask=abs(line*[data; ones(1,size(data,2))]);    %求每个数据到拟合直线的距离
     total=sum(mask<sigma);              %计算数据距离直线小于一定阈值的数据的个数

     if total>pretotal            %找到符合拟合直线数据最多的拟合直线
         pretotal=total;
         bestline=line;          %找到最好的拟合直线
    end  
 end
mask=abs(bestline*[data; ones(1,size(data,2))])<sigma;    
hold on;
k=1;% 找到所有支持该模型的点
for i=1:length(mask)
    if mask(i)
        support(1,k) = data(1,i);
        k=k+1;
    end
end
 xAxis = min(support(1,:)):max(support(1,:));
 yAxis = bestline(1) * xAxis + bestline(3);
 plot(xAxis,yAxis,'r-','LineWidth',2);
