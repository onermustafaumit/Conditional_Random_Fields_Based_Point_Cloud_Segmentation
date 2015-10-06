function unary_pot=unary_pot_cal(labels)
global num_of_points
global M

GT_PROB = 0.5;
u_energy = 0;%-log( 1.0 / M );
n_energy = 50;%-log( (1.0 - GT_PROB) / (M-1) );
p_energy = 50;%-log( GT_PROB );

unary_pot=u_energy*ones(M,num_of_points);

for i=1:num_of_points
    if (labels(i,1)>1)
       unary_pot(:,i)=n_energy;
       unary_pot(labels(i,1),i)=p_energy;
    end
end 