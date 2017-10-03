function []=gear(m,z,x,Ox,Oy)
%m=1;%模数
%z=17;%齿数
ha=1;c=0.25;%x=0;%齿顶高系数;顶隙系数;变位系数
alpha=deg2rad(20);%压力角

r=z*m/2;%分度圆半径
ra=r+(ha+x)*m;%齿顶圆半径
rf=r-(ha+c-x)*m;%齿根圆半径
rb=r*cos(alpha);%基圆半径

%circle(0,0,r,'black')
%circle(0,0,rb,'black')
%circle(0,0,ra,'r')
%circle(0,0,rf,'b')
hold on;
axis equal;

p=pi*m;%齿距
s=p/2+2*x*m*tan(alpha);%齿厚

beta1=involute(acos(rb/r))
beta2=s/(2*r)
beta=beta1+beta2;

%第1段 渐开线
alphaK=0:0.01:acos(rb/ra);
thetaK1=involute(alphaK)-beta;%自定义函数
rK1=rb./cos(alphaK);

%第2段 齿顶圆
thetaba=involute(acos(rb/ra))
thetaa=beta-thetaba
theta2=-thetaa:0.01:thetaa;
rou2=ra*ones(1,length(theta2));

%第3段 渐开线 = 渐开线1镜像
[x,y]=pol2cart(thetaK1,rK1);
y=-y;
[theta3,rou3]=cart2pol(x,y);
theta3=fliplr(theta3)%倒序排列
rou3=fliplr(rou3)%倒序排列

%第4段 直线
rr=(rb-rf)/2;
t_start=beta;
t_end=t_start;
r_end=sqrt((rr+rf)^2-rr^2);
theta4=[t_start t_end];
rou4=[rb r_end];

%倒数第1段 直线=直线4镜像
[x_1 y_1]=pol2cart(theta4,rou4);
y_1=-y_1;
[theta_1 rou_1]=cart2pol(x_1,y_1);

%第5段 圆角
HE=rr;OH=rf+rr;
gama=asin(HE/OH);
epsilon=pi/2-gama-beta;
Hx=OH*sin(epsilon);
Hy=OH*cos(epsilon);
angle1=pi+gama+beta;
angle2=angle1+(pi/2-gama);
[x5 y5]=arc(Hx,Hy,rr,angle1,angle2,10);%自定义函数
[theta5 rou5]=cart2pol(x5,y5);
theta5=fliplr(theta5);%倒序排列
rou5=fliplr(rou5);%倒序排列

%倒数第2段 圆角 = 圆角5镜像
x_2=x5;y_2=-y5;
[theta_2 rou_2]=cart2pol(x_2,y_2);

%第6段 齿根圆弧
phi=2*pi/z-2*beta-2*gama;
theta6=beta+gama:0.01:beta+gama+phi;
rou6=rf*ones(1,length(theta6));

theta=[theta_2 theta_1 thetaK1 theta2 theta3 theta4 theta5 theta6];%
rou=[rou_2 rou_1 rK1 rou2 rou3 rou4 rou5 rou6];%
start=pi/2;
theta=theta+start;%

%polar(theta,rou)%单个齿形曲线

theta_all=[];rou_all=[];
for i=0:(z-1)
    temp_theta=theta+2*pi/z*i;
    temp_rou=rou;
    theta_all=[theta_all temp_theta];
    rou_all=[rou_all temp_rou];
end
[x_all y_all]=pol2cart(theta_all,rou_all);
x_all=x_all+Ox;
y_all=y_all+Oy;

plot(x_all,y_all);

end