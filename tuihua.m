clear;
imfinfo Boat.bmp;
I=imread('Boat.bmp');
subplot(2,2,1);imshow(I);
xlabel('ԭʼͼ��')
noise = 20 * randn(256,256); % ����Ϊ100
subplot(2,2,2);imshow(noise, []);
xlabel('����ͼ��')
noisImg = double(I) + noise;
subplot(2,2,3);imshow(noisImg, []);
xlabel('��������ͼ��')
var = var(double(noise(:)))  % ����
std = std2(noise)            % ��׼��
mean = mean2(noise)          % ��ά����ľ�ֵ
%��С������coif3��x����2��С���ֽ�
[c,s] = wavedec2(noisImg,2,'coif3');
%��ȡС���ֽ��е�һ��ĵ�Ƶͼ�񣬼�ʵ���˵�ͨ�˲�ȥ��
%���ó߶�����
n = [1,2];
%������ֵ����p
p = [10.12,23.28];
%�����������Ƶϵ��������ֵ����
nc = wthcoef2('h',c,s,n,p,'s');
nc = wthcoef2('v',nc,s,n,p,'s');
nc = wthcoef2('d',nc,s,n,p,'s');
%���µ�С���ֽ�ṹ[c,s]�����ع�
x1 = waverec2(nc,s,'coif3');
subplot(2,2,4);imshow(x1,[]);
xlabel('������ͼ��')