function []=circle(x,y,r,cr)
rectangle('Position',[x-r,y-r,2*r,2*r],'Curvature',[1,1],'edgecolor',cr),axis equal
end