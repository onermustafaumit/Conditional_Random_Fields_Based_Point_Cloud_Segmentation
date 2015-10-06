function compatibility_trans(Q_X_Tilda)

global Q_X
global M
global unary_pot
global Q_X_Tilda_Sum
comp_mat=ones(M,M)-diag(ones(1,M));

Q_X_Tilda_Sum=Q_X_Tilda_Sum+Q_X_Tilda;
Q_X_Comp=comp_mat*Q_X_Tilda_Sum;

% Local Update

potential=unary_pot + Q_X_Comp;

% Normalization
Z=sum(exp(-potential),1);
Z_bar=1./Z;
Z_bar=repmat(Z_bar,M,1);

Q_X=Z_bar.*exp(-potential);
	



