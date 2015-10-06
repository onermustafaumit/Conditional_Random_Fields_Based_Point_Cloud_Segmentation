clear all
close all

%% Data load

load('table_2.mat')

%% find k-neighbors

[neighbor_indices,neighbor_distances] = rangesearch(xyz,xyz,0.001);


for i=1:size(neighbor_indices,1)
   if(size(neighbor_indices{i,:},2)>1)
       C=cov(xyz((neighbor_indices{i,:})',:));
       [eig_vect,eig_val] = eig(C);
       [X,I] = min(diag(eig_val));
       if ( dot((eig_vect(:,I))',xyz(i,:).*(-1))<0)
           point_normal(i,:)=-(eig_vect(:,I))';
       else
           point_normal(i,:)=(eig_vect(:,I))';
       end
   else
       point_normal(i,:)=xyz(i,:).*(-1);
   end
end

save('point_normal2.mat','point_normal','neighbor_indices','neighbor_distances')