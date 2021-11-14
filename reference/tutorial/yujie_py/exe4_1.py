# -*-coding:utf-8 -*-
"""
@File    :   exe4_1.py
@Time    :   2021/11/13 21:48:33
@Author  :   Yujie He
@Version :   1.0
@Contact :   yujie.he@epfl.ch
@State   :   Dev
"""

import numpy as np
import cvxpy as cp

I = 5
J = 5

# Known info
# demand
D = np.array([3475.0, 1223.0, 2260.0, 2700.0, 2950.0])
# percent of producation must from fresh wood
M = np.array([0.0, 0.47, 0.50, 0.40, 0.30])
# recycling wood
S = np.array([2000.0, 1600.0, 1000.0, 990.0, 2800.0])
# recycling rate
T = np.array([0.85, 0.9, 0.85, 0.85, 0.9])
# availability
A = np.array(
    [
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 0],
        [0, 1, 1, 1, 1],
        [0, 1, 1, 0, 1],
        [0, 0, 0, 0, 1],
    ]
)

# i-th old paper used in j-th new paper production
old_used = cp.Variable((I, J))
new_used = cp.Variable(J)

objective = cp.Minimize(cp.sum(new_used))
constr = []
# decision variables >= 0 constraints
constr.extend([old_used >= 0, new_used >= 0])  # important constraints
# result constraints
for i in range(I):
    constr += [new_used[i] >= D[i] * M[i]]
    # ith-old paper used in all other production
    constr += [cp.sum(cp.multiply(A[i, :], old_used[i, :])) <= S[i]]
    # larger than demand
    constr += [
        new_used[i] + T[i] * cp.sum(cp.multiply(A[:, i], old_used[:, i])) >= D[i]
    ]

problem = cp.Problem(objective, constr)
problem.solve(solver=cp.MOSEK, verbose=0)
# The optimal value for x is stored in `x.value`.
print(new_used.value)
print(old_used.value)
print("Optimal = {}".format(objective.value))
