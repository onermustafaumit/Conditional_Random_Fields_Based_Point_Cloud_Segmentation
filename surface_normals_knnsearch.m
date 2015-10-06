clear all
close all

%% Data load

load('table_1.mat')

%% find k-neighbors

[neighbor_indices,neighbor_distances] = knnsearch(xyz,xyz,'K',11);

% Eliminate points themselves
neighbor_indices(:,1)=[];
neighbor_distances(:,1)=[];

for i=1:size(neighbor_indices,1)
   C=cov(xyz((neighbor_indices(i,:))',:));
   [eig_vect,eig_val] = eig(C);
   [X,I] = min(diag(eig_val));
   point_normal(i,:)=(eig_vect(:,I))';
end