%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%    Predict function for kernel SVM. 
%%%    See lecture slide 183.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function acc = svm_predict(kernel, lambda_opt, b_opt, y_tr, y_te, rho)
    [n_te, ~] = size(y_te);
    [n_tr, ~] = size(y_tr);
    ...
    acc = ...
end