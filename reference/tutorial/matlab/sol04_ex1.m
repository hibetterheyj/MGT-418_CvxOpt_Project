
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EPFL | MGT-418: Convex Optimization | Tutorial 4, Exercise 1 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

% define problem parameters
d = [3475; 1223; 2260; 2700; 2950];
m = [0; 0.47; 0.5; 0.4; 0.3];
s = [2000; 1600; 1000; 990; 2800];
t = [0.85, 0.9, 0.85, 0.85, 0.9];

% define decision variables
x = sdpvar(5,1);
y = sdpvar(5,5,'full');

% define objective function
objective = sum(x);

% initialize constraints
constraints = [];

% add nonnegativity constraints
constraints = [constraints, x >= 0, y >=0];

% add demand meeting constraints
for j=1:5
    constraints = [constraints, x(j) + t(j)*sum(y(:,j)) >= d(j)];
end

% add minimum freshwood amount constraints
for j=1:5
    constraints = [constraints, (1-m(j))*x(j) - m(j)*t(j)*sum(y(:,j)) >= 0];
end

% add old paper availability constraints
for i=1:5
    constraints = [constraints, sum(y(i,:)) <= s(i)];
end

% add recycling compatibility constraints
constraints = [constraints, y(1,3)==0, y(1,4)==0, y(1,5)==0,...
                            y(2,5)==0,...
                            y(3,1)==0,...
                            y(4,1)==0, y(4,4)==0,...
                            y(5,1)==0, y(5,2)==0, y(5,3)==0, y(5,4)==0];

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
opt_y = value(y);
disp(opt_y);
