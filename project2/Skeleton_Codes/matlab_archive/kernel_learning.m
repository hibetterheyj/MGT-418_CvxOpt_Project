%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Kernel learning for soft margin SVM. 
%%% Implementation of problem (5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [mu_opt1, mu_opt2, mu_opt3, lambda_opt, b_opt] = kernel_learning(K1, K2, K3, y_tr, rho)  
    ...

    r1 = trace(K1);
    ...

    lambda_ = sdpvar(n_tr, 1);
    z = sdpvar(1);
    ...
    ...
    cons = [];
    cons = [cons, z * r1 >= 1 / (2 * rho) * lambda_.' * G1 * lambda_];
    ...
    
    ops = sdpsettings('solver', 'gurobi', 'verbose', 0, 'gurobi.QCPDual', 1);
    ...
    mu_opt1 = dual(cons(1));
    ...
    ...
end