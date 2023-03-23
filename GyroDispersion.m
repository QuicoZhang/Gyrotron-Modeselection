clear;
%对于一个特定TM模式，只需输入其对应的第一类贝赛尔函数导数的极值即可。图中从下向上的模式对应的贝赛尔函数极值依次增大
%不考虑电子的轴向速度零散
%常数
c=2.998e+8;
me=9.1091e-31;
qe=1.6021e-19;
etm=qe/me;

%输入参数
rw=0.57e-2;
xmn=[2.4048 3.8317 5.1356 5.5200 6.3801 7.1022].';  %TM01,TM11,TM21,TM02,TM31,TM12
s=[1 2].'; 
B0tBg=1.1;
Vb=100e+3;
alpha=0.6;

%场模计算
kr=xmn/rw;
% kzn=(-10:0.2:10);  %kzn=kz*rw
kz=(-2000:1:2000);
ModeNum=length(xmn);
EleHarmonicNum=length(s);
Imode=ones(ModeNum,1);
Ieleharmonic=ones(EleHarmonicNum,1);
Iz=ones(1,length(kz));
k=(kr.^2*Iz+Imode*(kz.^2)).^0.5;   %ModeNum*length(kz)              k=sqrt(kz^2+kt^2)
omega=k*c; 
fre=omega/2/pi;
kn=k*rw;


%电子注模式计算
gamma0=(1+etm*Vb/c^2);
betazA=sqrt((1-gamma0^(-2))/(alpha^2+1));
pzA=gamma0*betazA*c*me;
gammaz0=(1-(pzA/gamma0/me/c)^2)^(-0.5);
vz=betazA*c;
Bg=kr(2)*c*gamma0*me/gammaz0/qe/s(1);              % 定义参与互作用的模式数和谐波次数
B0=Bg*B0tBg;
% B0 = 5.58;
EleClcOmega=etm*B0/gamma0;  

EleOmega=Ieleharmonic*vz*kz+s*EleClcOmega*Iz; % EleHarmonicNum*length(kz)     ω=kz*vz+s*Ω/γ
EleFre = EleOmega/2/pi;

%画图
hold on
for i=1:ModeNum
    plot(kz/100,fre(i,:)/1e9,'--');
end
plot(kz/100,fre(2,:)/1e9);
for j=1:EleHarmonicNum
    plot(kz/100,EleFre(j,:)/1e9);
end
plot(zeros(1001),0:(fre(ModeNum,length(kz))/1e9+10)/1000:fre(ModeNum,length(kz))/1e9+10)

xlabel('kz (1/cm)')
ylabel('Frequency  (GHz)')
axis([-(length(kz)-1)/200 (length(kz)-1)/200 0 fre(ModeNum,length(kz))/1e9+10])
text(-18,fre(2,1000)/1e9,' 谐振腔模式 \rightarrow')
% text(-11,fre(1,1000)/1e9,' 谐振腔模式 \rightarrow')
text(-15,EleFre(2,1000)/1e9,' s=2 \rightarrow')
text(-15,EleFre(1,1000)/1e9,' s=1 \rightarrow')
plot(3,EleFre(1,2320)/1e9,'b.','Markersize',16)
text(1.95,EleFre(1,2200)/1e9,'  \uparrow')
text(2.5,EleFre(1,1900)/1e9,'谐振点')
% plot(-1.75,EleFre(2,1830)/1e9,'b.','Markersize',16)
% text(-1.75,EleFre(2,1620)/1e9,' 2')