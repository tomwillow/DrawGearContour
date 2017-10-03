function [x y]=arc(Ox,Oy,r,angle1,angle2,all_step)%ÄæÊ±Õë
t=angle1:(angle2-angle1)/all_step:angle2;
x=r.*cos(t)+Ox;
y=r.*sin(t)+Oy;
end