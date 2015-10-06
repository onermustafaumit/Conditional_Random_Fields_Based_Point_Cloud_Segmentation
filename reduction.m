clear all
close all
load('table_1.mat')

index_x=find(xyz(:,1)<-1.4120 | xyz(:,1)>-0.2172);
rgb_double(index_x,:)=[];
true_labels(index_x,:)=[];
xyz(index_x,:)=[];

index_y=find(xyz(:,2)<-0.1443 | xyz(:,2)>0.3954);
rgb_double(index_y,:)=[];
true_labels(index_y,:)=[];
xyz(index_y,:)=[];

save('table_2.mat','rgb_double','true_labels','xyz')