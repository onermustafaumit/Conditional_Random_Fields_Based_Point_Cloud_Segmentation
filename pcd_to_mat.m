clear all
close all

%% Data read

true_labels = dlmread('table_1.label');
true_labels=cast(true_labels,'uint8')+1;
true_labels(1,:)=[];

data = readPcd('table_1.pcd');

rgb =unpackRGBFloat(single(data(:,4)));
%%%----labels: 1:Background, 2:Bowl, 3:Cap, 4:Cereal Box, 5:Coffee Mug, 6:Soda Can ----%%%

num_of_points=size(rgb,1);
rgb_double=double(rgb);

r = randi(num_of_points,floor(num_of_points/20),1);

xyz=data(r,1:3);
rgb_double=rgb_double(r,:);
true_labels=true_labels(r,:);

save('table_1.mat','xyz','rgb_double', 'true_labels')