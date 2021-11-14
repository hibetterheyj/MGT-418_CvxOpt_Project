# -*-coding:utf-8 -*-
"""
@File    :   exe4_2.py
@Time    :   2021/11/14 21:27:06
@Author  :   Yujie He
@Version :   1.0
@Contact :   yujie.he@epfl.ch
@State   :   Dev
"""


import numpy as np
import cvxpy as cp

A = np.array([[-1, 0.4, 0.8], [1, 0, 0], [0, 1, 0]])  # 3x3
b = np.array([1, 0, 0.5]).reshape((3, 1))
x_0 = np.array([0.0, 0.0, 0.0]).reshape((3, 1))
x_des = np.array([7, 2, -6]).reshape((3, 1))
N = 10
D = 3

z = cp.Variable(N)
x = cp.Variable((3, N + 1))
u = cp.Variable((1, N))

objective = cp.Minimize(cp.sum(z))
constr = []
constr.extend([x[:, :1] == x_0, x[:, -1:] == x_des])
# result constraints
for t in range(N):
    constr.append(x[:, t + 1 : t + 2] == A @ x[:, t : t + 1] + u[0, t] * b)
    constr.append(z[t] >= cp.square(u[0, t]))  # cp.square而不是cp.norm
    constr.append(z[t] >= u[0, t])
    constr.append(-z[t] <= u[0, t])


problem = cp.Problem(objective, constr)
problem.solve(solver=cp.MOSEK, verbose=0)
print("Optimal = {}".format(objective.value))
print("optimal solution values:")
opt_x = x.value
print("opt_x", opt_x)
opt_u = u.value
print("opt_u", opt_u)
opt_z = z.value
print("opt_z", opt_z)
