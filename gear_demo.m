clear;clc;

m=1;%ģ��
z=17;%����
ha=1;c=0.25;x=0;%�ݶ���ϵ��;��϶ϵ��;��λϵ��
alpha=deg2rad(20);%ѹ����

r=z*m/2;%�ֶ�Բ�뾶
ra=r+(ha+x)*m;%�ݶ�Բ�뾶
rf=r-(ha+c-x)*m;%�ݸ�Բ�뾶
rb=r*cos(alpha);%��Բ�뾶

%circle(0,0,r,'black')
%circle(0,0,rb,'black')
%circle(0,0,ra,'r')
%circle(0,0,rf,'b')
hold on;
axis equal;

p=pi*m;%�ݾ�
s=p/2+2*x*m*tan(alpha);%�ݺ�

beta1=involute(acos(rb/r))
beta2=s/(2*r)
beta=beta1+beta2;

%��1�� ������
alphaK=0:0.01:acos(rb/ra);
thetaK1=involute(alphaK)-beta;%�Զ��庯��
rK1=rb./cos(alphaK);

%��2�� �ݶ�Բ
thetaba=involute(acos(rb/ra))
thetaa=beta-thetaba
theta2=-thetaa:0.01:thetaa;
rou2=ra*ones(1,length(theta2));

%��3�� ������ = ������1����
[x,y]=pol2cart(thetaK1,rK1);
y=-y;
[theta3,rou3]=cart2pol(x,y);
theta3=fliplr(theta3)%��������
rou3=fliplr(rou3)%��������

%��4�� ֱ��
rr=(rb-rf)/2;
t_start=beta;
t_end=t_start;
r_end=sqrt((rr+rf)^2-rr^2);
theta4=[t_start t_end];
rou4=[rb r_end];

%������1�� ֱ��=ֱ��4����
[x_1 y_1]=pol2cart(theta4,rou4);
y_1=-y_1;
[theta_1 rou_1]=cart2pol(x_1,y_1);

%��5�� Բ��
HE=rr;OH=rf+rr;
gama=asin(HE/OH);
epsilon=pi/2-gama-beta;
Hx=OH*sin(epsilon);
Hy=OH*cos(epsilon);
angle1=pi+gama+beta;
angle2=angle1+(pi/2-gama);
[x5 y5]=arc(Hx,Hy,rr,angle1,angle2,10);%�Զ��庯��
[theta5 rou5]=cart2pol(x5,y5);
theta5=fliplr(theta5);%��������
rou5=fliplr(rou5);%��������

%������2�� Բ�� = Բ��5����
x_2=x5;y_2=-y5;
[theta_2 rou_2]=cart2pol(x_2,y_2);

%��6�� �ݸ�Բ��
phi=2*pi/z-2*beta-2*gama;
theta6=beta+gama:0.01:beta+gama+phi;
rou6=rf*ones(1,length(theta6));

theta=[theta_2 theta_1 thetaK1 theta2 theta3 theta4 theta5 theta6];%
rou=[rou_2 rou_1 rK1 rou2 rou3 rou4 rou5 rou6];%
start=pi/2;
theta=theta+start;%

%polar(theta,rou)%������������

theta_all=[];rou_all=[];
for i=0:(z-1)
    temp_theta=theta+2*pi/z*i;
    temp_rou=rou;
    theta_all=[theta_all temp_theta];
    rou_all=[rou_all temp_rou];
end
polar(theta_all,rou_all);

[gear1x gear1y]=pol2cart(theta_all,rou_all);
gear2x=gear1x;
gear2y=gear1y+2*r;
plot(gear2x,gear2y);