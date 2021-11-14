
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EPFL | MGT-418: Convex Optimization | Tutorial 4, Exercise 3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

% define problem parameters
v_1 = 1;
eta_2 = 1.5;
eta_3 = 1.3;

% define decision variables
ell = sdpvar(3,1);
p = sdpvar(2,1);

% define objective function
objective = [1/v_1, eta_2/v_1, eta_3/v_1] * ell;

% define all constraints in one shot
constraints = [ell(1) >= norm([p(1);1],2),...
               ell(2) >= norm([p(2)-p(1);1],2),...
               ell(3) >= norm([4-p(2);0.5],2)];

% specify solver settings
opt_settings = sdpsettings('solver', 'mosek', 'verbose', 0);

% run solver
diagnosis = optimize(constraints, objective, opt_settings);

% display solver report
disp('solver report:');
disp(diagnosis);

% retrieve and display optimal objective value
disp('optimal objective value:');
opt_objective = value(objective);
disp(opt_objective);

% retrieve and display optimal solution values
disp('optimal solution values:');
opt_ell = value(ell);
disp(opt_ell);
opt_p = value(p);
disp(opt_p);
