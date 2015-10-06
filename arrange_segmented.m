%function arr_seg_img=arrange_segmented()

global labels
global rgb_double
global xyz
global true_labels
global label_rgb

load('Labels7_loop_2.mat')

segmented_labels=uint8(labels);
pos_rgb=[xyz,rgb_double/255];

[val,index]=sort(pos_rgb(:,3));
pos_rgb=[pos_rgb(index,1:2), val, pos_rgb(index,4:6)];
x_min_max=minmax((pos_rgb(:,1))');
y_min_max=minmax((pos_rgb(:,2))');

comparison_true_labels=true_labels(index,1);
segmented_labels=segmented_labels(index,1);

pos_rgb(:,1)=round((pos_rgb(:,1)-x_min_max(1))/((x_min_max(2)-x_min_max(1))/639))+1;
%pos_rgb(:,1)=640-round((pos_rgb(:,1)-x_min_max(1))/((x_min_max(2)-x_min_max(1))/639));
pos_rgb(:,2)=round((pos_rgb(:,2)-y_min_max(1))/((y_min_max(2)-y_min_max(1))/479))+1;
%pos_rgb(:,2)=480-round((pos_rgb(:,2)-y_min_max(1))/((y_min_max(2)-y_min_max(1))/479));

arr_seg_img=zeros(480,640,3);


for i=1:size(pos_rgb,1)
        if (arr_seg_img(pos_rgb(i,2),pos_rgb(i,1),1)==0 && arr_seg_img(pos_rgb(i,2),pos_rgb(i,1),2)==0 && arr_seg_img(pos_rgb(i,2),pos_rgb(i,1),3)==0)
            if(segmented_labels(i,1)==comparison_true_labels(i,1))
                if(comparison_true_labels(i,1)==1)
                    arr_seg_img(pos_rgb(i,2),pos_rgb(i,1),:)=pos_rgb(i,4:6);
                else
                    arr_seg_img(pos_rgb(i,2),pos_rgb(i,1),:)=label_rgb(segmented_labels(i,1),:);
                end
            else
                arr_seg_img(pos_rgb(i,2),pos_rgb(i,1),:)=label_rgb(segmented_labels(i,1),:);
            end
        end
end

figure
image(arr_seg_img);
C = confusionmat(true_labels,uint8(labels))
imwrite(uint8(255*arr_seg_img),'SegmentedImage7_loop_2.jpg','jpg');