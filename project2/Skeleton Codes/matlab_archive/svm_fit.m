%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Dual of soft-margin SVM problem (2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [lambda_opt, b_opt] = svm_fit(kernel, y_tr, rho)
    
    [n_tr, ~] = size(y_tr); 
    ...
    lambda = sdpvar(1, n_tr);
    obj = ...  1/(2 * rho) * lambda * G * lambda.';
    cons = [];
    ...
    ops = sdpsettings('solver', 'gurobi', 'verbose', 0);

    ...
    lambda_opt = value(lambda);
    b_opt = ...
end