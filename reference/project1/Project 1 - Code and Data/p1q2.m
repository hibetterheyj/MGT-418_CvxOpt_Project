%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EPFL | MGT-418: Convex Optimization | Project 1, Question 2 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc
clearvars
load 20news_w60
docs = double(full(documents));
docs(docs == 0) = -1;
[n, m] = size(docs);

% Moments information
mu = mean(docs,2);          % mean vector
M = 1/m * (docs * docs');   % second order moment

% Regularization parameter
rho = 0.005;

% Type your code here ...

% Plot the graph and save its corresponding edges & nodes as csv files
% You can use these two csv files to plot graphs in third party softwares
% such as Gephi.
G = adj2gephilab('news', theta, wordlist);