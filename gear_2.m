function []=gear_2(m,z1,x1,z2,x2)
gear(m,z1,x1,0,0);
gear(m,z2,x2,0,m*(z1+z2)/2);
end