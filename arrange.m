function arr_img=arrange(pos_rgb)

[val,index]=sort(pos_rgb(:,3));
pos_rgb=[pos_rgb(index,1:2), val, pos_rgb(index,4:6)];
x_min_max=minmax((pos_rgb(:,1))');
y_min_max=minmax((pos_rgb(:,2))');

pos_rgb(:,1)=round((pos_rgb(:,1)-x_min_max(1))/((x_min_max(2)-x_min_max(1))/639))+1;
%pos_rgb(:,1)=640-round((pos_rgb(:,1)-x_min_max(1))/((x_min_max(2)-x_min_max(1))/639));
pos_rgb(:,2)=round((pos_rgb(:,2)-y_min_max(1))/((y_min_max(2)-y_min_max(1))/479))+1;
%pos_rgb(:,2)=480-round((pos_rgb(:,2)-y_min_max(1))/((y_min_max(2)-y_min_max(1))/479));

% pos_rgb(:,1)=round((pos_rgb(:,1)-x_min_max(1))/((x_min_max(2)-x_min_max(1))/479))+1;
% %pos_rgb(:,1)=640-round((pos_rgb(:,1)-x_min_max(1))/((x_min_max(2)-x_min_max(1))/639));
% pos_rgb(:,2)=round((pos_rgb(:,2)-y_min_max(1))/((y_min_max(2)-y_min_max(1))/239))+1;
% %pos_rgb(:,2)=480-round((pos_rgb(:,2)-y_min_max(1))/((y_min_max(2)-y_min_max(1))/479));

arr_img=zeros(480,640,3);
%arr_img=zeros(240,480,3);


for i=1:size(pos_rgb,1)
        if (arr_img(pos_rgb(i,2),pos_rgb(i,1),1)==0 && arr_img(pos_rgb(i,2),pos_rgb(i,1),2)==0 && arr_img(pos_rgb(i,2),pos_rgb(i,1),3)==0)
            arr_img(pos_rgb(i,2),pos_rgb(i,1),:)=pos_rgb(i,4:6);
        end
end
