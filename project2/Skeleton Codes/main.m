%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%       MGT - 418         %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%      Convex Optimization - Project 2          %%%%%%%%%%%%%%
%%%%%%%%%%%%%%             2021-2022 Fall                    %%%%%%%%%%%%%%
%%%%%%%%%%%%%%      Learning the Kernel Function             %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
rho = 2;
sigma_ = 0.5;
[data, labels] = read_data();
acc_optimal_kernel = [];
acc_poly_kernel = [];
acc_linear_kernel = [];
acc_gauss_kernel = [];
for rep = 1 : 100
    yalmip('clear')
    %%%% Before defining a new problem, it is advised that you clear the 
    %%%% internal strure using yalmip(’clear’); It is not necessary to
    %%%% perform this command, but it cleans up some 
    %%%% memory structures and old solution structures.

    %%% Train-Test split
    %%% Please do not change the random seed.
    rng(rep)
    [n_all, ~] = size(data);
    msk = rand(n_all, 1) <= ...
    x_tr = data(...);
    x_te = data(...);
    y_tr = labels(...);
    y_te = labels(...);

    [n_tr, ~] = size(x_tr);
    [n_te, ~] = size(x_te);
    x_all = cat(1, x_tr, x_te);
    %%% Prepare the initial choice of kernels 
    %%% It is recommended to prepare the kernels for all the training and the test data
    %%% Then, the kernel size will be (n_tr + n_te)x(n_tr + n_te).
    %%% Use only the training block (like K1[0:n_tr, 0:n_tr] ) to learn the classifier 
    %%% (for the functions svm_fit and kernel_learning).
    %%% When predicting you may use the whole kernel as it is. 
    %%% Define kernels
    K1 =  ...
    K2 =  ...
    K3 =  ...
    ...
    %%% Kernel Learning
    [mu_opt1, mu_opt2, mu_opt3, lambda_opt, b_opt] = kernel_learning(...);
    opt_kernel = ...
    acc_optimal_kernel = [acc_optimal_kernel, svm_predict(...)];

    [lambda_opt, b_opt] = svm_fit(kernel(...);
    acc_poly_kernel = [acc_poly_kernel, svm_predict(...)];

    [lambda_opt, b_opt] = svm_fit(...);
    acc_gauss_kernel = [acc_gauss_kernel, svm_predict(...)];

    [lambda_opt, b_opt] = svm_fit(...);
    acc_linear_kernel = [acc_linear_kernel, svm_predict(...)];
    fprintf('Iteration --> %d \n', rep)
    
end
%%
fprintf('Averaged accuracy of the optimal kernel: %2f\n', mean(acc_optimal_kernel));
fprintf('Averaged accuracy of the polynomial kernel: %2f\n', mean(acc_poly_kernel));
fprintf('Averaged accuracy of the gaussian kernel: %2f\n', mean(acc_gauss_kernel));
fprintf('Averaged accuracy of the linear kernel: %2f\n', mean(acc_linear_kernel));