function Q_X_Tilda = message_passing(xyz, rgb, point_normal)
% xyz=P(:,1:3);
% rgb=rgb_double;
global num_of_points
global Q_X

pos_weight=1;
color_weight=2; 
normal_weight=1; 
color_scale=0.5;%312.3099;
twocolorscalesqr=2*color_scale^2;
pos_scale=0.005;%2.3668;
twoposscalesqr=2*pos_scale^2;
normal_scale=6; %1;
twonormalscalesqr=2*normal_scale^2;
pos_color_scale=0.02;%4.3211;
twoposcolorscalesqr=2*pos_color_scale^2;
pos_normal_scale=0.02;%4.3211;
twoposnormalscalesqr=2*pos_normal_scale^2;

for i=1:num_of_points
   pos_vec=sum((repmat(xyz(i,:),num_of_points,1)-xyz).^2,2);
   col_vec=sum((repmat(rgb(i,:),num_of_points,1)-rgb).^2,2);
   norm_vec=sum((repmat(point_normal(i,:),num_of_points,1)-point_normal).^2,2);
   
   kernel=pos_weight*exp(-(pos_vec/twoposscalesqr))+color_weight*exp(-(pos_vec/twoposcolorscalesqr + col_vec/twocolorscalesqr))+ normal_weight*exp(-(pos_vec/twoposnormalscalesqr + norm_vec/twonormalscalesqr));
   kernel(i,1)=0;

   Q_X_Tilda(:,i)=Q_X*(kernel);
   if(mod(i,2000)==0)
      fprintf(1,'epoch %d \n',i);
   end
       
end