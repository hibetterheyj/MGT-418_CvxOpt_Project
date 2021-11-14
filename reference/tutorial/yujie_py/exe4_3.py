# -*-coding:utf-8 -*-
"""
@File    :   exe4_3.py
@Time    :   2021/11/14 22:01:48
@Author  :   Yujie He
@Version :   1.0
@Contact :   yujie.he@epfl.ch
@State   :   Dev
"""

import numpy as bp
import cvxpy as cp

p = cp.Variable(2)
l = cp.Variable(3)

v1 = 1
eta_2 = 1.5
eta_3 = 1.3
# cvxpy.error.ParameterError: A Parameter (whose name is 'param2') does not have a value associated with it;
# all Parameter objects must have values before solving a problem.
# v1 = cp.Parameter(pos=True)
# eta_2 = cp.Parameter(nonneg=True)
# eta_3 = cp.Parameter(nonneg=True)

objective = 1 / v1 * l[0] + eta_2 / v1 * l[1] + eta_3 / v1 * l[2]
"""
ValueError: The input must be a single CVXPY Expression, not a list.
Combine Expressions using atoms such as bmat, hstack, and vstack.
l[0] >= cp.norm([p[0], 1], 2),
l[1] >= cp.norm([p[1] - p[0], 1], 2),
l[2] >= cp.norm([4 - p[1], 0.5], 2)
"""
constr = [
    l[0] >= cp.norm(cp.vstack([p[0], 1]), 2),
    l[1] >= cp.norm(cp.vstack([p[1] - p[0], 1]), 2),
    l[2] >= cp.norm(cp.vstack([4 - p[1], 0.5]), 2),
]
problem = cp.Problem(cp.Minimize(objective), constr)
problem.solve(solver=cp.MOSEK, verbose=0)
# problem.solve(solver=cp.ECOS)
print("Optimal = {}".format(objective.value))
print("optimal solution values:")
opt_p = p.value
print("opt_p:", opt_p)
opt_l = l.value
print("opt_l:", opt_l)
