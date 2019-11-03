clear;
imfinfo Boat.bmp;
I=imread('Boat.bmp');
subplot(2,2,1);imshow(I);
xlabel('原始图像')
noise = 20 * randn(256,256); % 方差为100
subplot(2,2,2);imshow(noise, []);
xlabel('噪声图像')
noisImg = double(I) + noise;
subplot(2,2,3);imshow(noisImg, []);
xlabel('含噪声的图像')
var = var(double(noise(:)))  % 方差
std = std2(noise)            % 标准差
mean = mean2(noise)          % 二维数组的均值
%用小波函数coif3对x进行2层小波分解
[c,s] = wavedec2(noisImg,2,'coif3');
%提取小波分解中第一层的低频图像，即实现了低通滤波去噪
%设置尺度向量
n = [1,2];
%设置阈值向量p
p = [10.12,23.28];
%对三个方向高频系数进行阈值处理
nc = wthcoef2('h',c,s,n,p,'s');
nc = wthcoef2('v',nc,s,n,p,'s');
nc = wthcoef2('d',nc,s,n,p,'s');
%对新的小波分解结构[c,s]进行重构
x1 = waverec2(nc,s,'coif3');
subplot(2,2,4);imshow(x1,[]);
xlabel('降噪后的图像')