
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EPFL | MGT-418: Convex Optimization | Tutorial 4, Exercise 2 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

% define problem parameters
A = [-1, 0.4, 0.8; 1, 0, 0; 0, 1, 0];
b = [1; 0; 0.5];
x_des = [7; 2; -6];
N = 10;
n = size(A,1);

% define decision variables (note: time index runs through columns)
x = sdpvar(n,N+1,'full');
u = sdpvar(1,N);
z = sdpvar(1,N);

% define objective function
objective = sum(z);

% initialize constraints
constraints = [];

% add initial state constraints
constraints = [constraints, x(:,1) == zeros(n,1)];

% add desired final state constraints
constraints = [constraints, x(:,N+1) == x_des];

% add system dynamics constraints
for t=1:N
    constraints = [constraints, x(:,t+1) == A*x(:,t) + b*u(t)];
end

% add epigraphical variable constraints
for t=1:N
    constraints = [constraints, -z(t) <= u(t), u(t) <= z(t)];
    constraints = [constraints, z(t) >= u(t)*u(t)];
end

% specify solver settings
opt_settings = sdpsettings('solver', 'gurobi', 'verbose', 0);

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
opt_x = value(x);
disp(opt_x);
opt_u = value(u);
disp(opt_u);
opt_z = value(z);
disp(opt_z);
