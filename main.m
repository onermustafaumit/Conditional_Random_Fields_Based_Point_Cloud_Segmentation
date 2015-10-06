clear all
close all

%% Data load

load('table_1.mat')

global labels
global rgb_double
global xyz
global true_labels
global label_rgb

%%%----labels: 1:Background, 2:Bowl, 3:Cap, 4:Cereal Box, 5:Coffee Mug, 6:Soda Can ----%%%
label_rgb=[1,0,1; 0,1,0; 1,0,0; 0,0,1; 1,1,1; 1,1,0];

% Number of points in data cloud
global num_of_points
num_of_points=size(rgb_double,1);

% ind=find(true_labels==1);
% 
% rgb_double(ind,:)=repmat([255,0,255],size(ind,1),1);

global P
P=[xyz,rgb_double/255];
arr_img=arrange(P);
figure
image(arr_img);

%% Initial Labeling

% Number of labels is input to the system
global M
M = 6;

% nColors=1;
% color_values=zeros(255,1);
% labels=zeros(num_of_points,1);
% for i=1:num_of_points
%     point_color=uint32(rgb(i,1)*256*256) + uint32(rgb(i,2)*256) + uint32(rgb(i,3));
%     k=1;
%     while (k<nColors && point_color ~= color_values(k))
%         k=k+1;
%     end
%     if (point_color>0 && k==nColors)
%        if (k <= M)
%            color_values(nColors)=point_color;
%            nColors=nColors+1;
%        else
%            point_color=0;
%        end
%     end
%     if ( point_color>0 )
%         labels(i)=k;
%     end
% end

%%% Manual label assignment
labels=ones(num_of_points,1);
% for i=2:6
%     [row(i),col]=find(true_labels==i,1);
%     labels(row(i),1)=i;
% 	%labels(row(i),1)=2;
% end
labels(34506,1)=2; %Bowl
labels(50310,1)=3; %Cap
labels(19790,1)=3; %Cap
labels(63962,1)=4; %Cereal Box
labels(108632,1)=5; %Coffee Mug
labels(20758,1)=5; %Coffee Mug
labels(84785,1)=6; %Soda Can

% labels(44321,1)=2; %Bowl
% labels(4345,1)=3; %Cap
% labels(37642,1)=3; %Cap
% labels(24619,1)=4; %Cereal Box
% labels(35607,1)=5; %Coffee Mug
% labels(52468,1)=5; %Coffee Mug
% labels(17297,1)=6; %Soda Can

%% Compute Initial Unary Potentials
global unary_pot
unary_pot=unary_pot_cal(labels);   

%% Surface Normals

load('point_normal.mat')

%% Initialization of point potentials
Z=sum(exp(-unary_pot),1);
Z_bar=1./Z;
Z_bar=repmat(Z_bar,M,1);
global Q_X
Q_X=Z_bar.*exp(-unary_pot);
    
%% Iterative computation	
global Q_X_Tilda_Sum
Q_X_Tilda_Sum=zeros(M,num_of_points);

for i=1:3
    fprintf(1,'loop %d \n',i);
	%% Message Passing
	Q_X_Tilda=message_passing(xyz,rgb_double,point_normal);
    save('Q_X_Tilda.mat','Q_X_Tilda')
	%% Compatibility, local update, normalization
	compatibility_trans(Q_X_Tilda);

	%% Label Assignment
	[Max_values,t_labels]=max(Q_X);
    labels=transpose(t_labels);
	unary_pot=unary_pot_cal(labels);
    filename=strcat('Labels9_loop_',num2str(i),'.mat'); 
    save(filename,'labels')
    arr_seg_img=arrange_segmented();
    imwrite(uint8(255*arr_seg_img),['SegmentedImage9_loop_',num2str(i),'.jpg'],'jpg');
    figure
    image(arr_seg_img);
    C = confusionmat(true_labels,uint8(labels))
    save(['ConfusionMatrix9_loop_',num2str(i),'.mat'],'C')
end

