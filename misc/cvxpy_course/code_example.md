[toc]



# Code snippets and example notes

> [Companion Jupyter notebook files](http://nbviewer.jupyter.org/github/cvxgrp/cvx_short_course/tree/master/python_intro/notebooks/) from cvx short course

## Advanced Features

> <https://www.cvxpy.org/tutorial/advanced/index.html>

### Optimal dual variable

can be obtained with `constraints[i].dual_value`

### Semidefinite matrices

- Semidefinite

  ```python
  ## method1: assign `PSD` args as True
  X = cp.Variable((100, 100), PSD=True)
  obj = cp.Minimize(cp.norm(X) + cp.sum(X))
  
  ## method2: use `>>` in constraints
  # expr1 must be positive semidefinite.
  constr1 = (expr1 >> 0)
  
  # expr2 must be negative semidefinite.
  constr2 = (expr2 << 0)
  ```

- Symmetric

  ```python
  constr = (expr == expr.T)
  Variable((n, n), symmetric=True)
  ```

## CVX Short cource

### [Total variation image in-painting](http://nbviewer.ipython.org/github/cvxgrp/cvxpy/blob/master/examples/notebooks/WWW/tv_inpainting.ipynb)

> https://nbviewer.ipython.org/github/cvxgrp/cvxpy/blob/master/examples/notebooks/WWW/tv_inpainting.ipynb

```
import cvxpy as cp

# formulate problem
U = cp.Variable(shape=(rows, cols))
obj = cp.Minimize(cp.tv(U))
constraints = [cp.multiply(known, U) == cp.multiply(known, u_corr)]
prob = cp.Problem(obj, constraints)

# solve problem
prob.solve(verbose=True, solver=cp.SCS)
print("optimal objective value: {}".format(obj.value))

## multi-dimension
for i in range(colors):
    U = cp.Variable(shape=(rows, cols))
    variables.append(U)
    constraints.append(cp.multiply(known[:, :, i], U) == cp.multiply(known[:, :, i], u_corr[:, :, i]))

prob = cp.Problem(cp.Minimize(cp.tv(*variables)), constraints)
```

- 目标函数：$\sum_{ij}\left\| \left[\begin{matrix} X_{i+1,j} - X_{ij} \\ X_{i,j+1} -X_{ij} \end{matrix}\right] \right\|_2$ -> `cp.tv()`， 还有其他函数包括`cp.trace(X)`更多函数可以查看 <https://www.cvxpy.org/tutorial/functions/index.html>
- 约束中 `cp.multiply()`表示矩阵点乘
- `.solve()`方法可以指定求解器`solver=cp.SCS`
- 对应的最优解在`x.value`

### [Control](http://nbviewer.ipython.org/github/cvxgrp/cvx_short_course/blob/master/intro/control.ipynb)

> https://nbviewer.ipython.org/github/cvxgrp/cvx_short_course/blob/master/intro/control.ipynb

#### Background: LQR control

- model: $x_{t+1} = Ax_t + Bu_t$

- $A \in {\bf R}^{n\times n}$ and $B \in {\bf R}^{n\times m}$ are known matrices

- inputs or actions $u_t\in {\bf R}^m$ can be used at each time step to affect the state

- optimization problem:
  $$
  \begin{array}{ll} \min & \sum_{t=0}^{T-1} \ell (x_t,u_t) + \ell_T(x_T)\\
  \mbox{s.t.} & x_{t+1} = Ax_t + Bu_t\\%, \quad t=0, \ldots, T-1\\
  & (x_t,u_t) \in \mathcal C, \quad x_T\in \mathcal C_T,
  %, \quad \quad t=0, \ldots, T
  \end{array}
  $$

  - $\ell: {\bf R}^n \times {\bf R}^m\to {\bf R}$ is the stage cost, $\ell$ is the terminal cost, $\mathcal C$ is the state/action constraints, and $\mathcal C_T$ is the terminal constraint. The optimization problem is convex if the costs and constraints are convex.

  - stage cost $\ell(x,u) = \|x\|_2^2 + \|u\|_2^2$
  - input constraint $\ell(x,u) = \|x\|_2^2 + \|u\|_2^2$
  - terminal constraint $x_T=0$

```python
import numpy as np
np.random.seed(1)
n = 8 # state
m = 2 # input
T = 50 # horizon
alpha = 0.2
beta = 5
A = np.eye(n) + alpha*np.random.randn(n,n) # state matrix
B = np.random.randn(n,m) # input mat
x_0 = beta*np.random.randn(n) # initial state

import cvxpy as cp

## formulate problem
x = cp.Variable((n, T+1))
u = cp.Variable((m, T))
cost = 0
constr = []
for t in range(T):
    # next state
    cost += cp.sum_square(x[:,t+1]) + cp.sum_square(T[:,t])
    constr += [x[:,t+1] == A@x[:,t] + B@u[:,t],
               cp.norm(u[:,t], 'inf') <= 1]]
# x[:,T] == 0 => finally converge to zero
constr += [x[:,T] == 0, x[:,0] == x_0]

problem = cp.Problem(cp.Minimize(cost), constr)
problem.solve(solver=cp.ECOS)

# resulting states x1, x2
plt.plot(x1)
plt.plot(range(51), x2)
```

- `cp.sum_square`, `cp.norm(x, 'inf')`
- element-wise multiplication A@x

### [SVM classifier with $\ell_1$ regularization](http://nbviewer.ipython.org/github/cvxgrp/cvx_short_course/blob/master/intro/SVM.ipynb)

- associated boolean outcomes $y_i \in \{\pm 1\}$

- feature vectors $x_i \in {\bf R}^n$

- linear classifier $\hat y = {\rm sign}(\beta^T x - v)$

- minimizing the (convex) function to find parameters

  $f(\beta,v) = (1/m) \sum_i \left(1 - y_i ( \beta^T x_i-v) \right)_+ + \lambda \| \beta\|_1$

  1. first term is the average hinge loss.
  2. second term shrinks the coefficients in $\beta$ -> sparsity
  3. scalar $\lambda \geq 0$

```python
beta = cp.Variable((n, 1))
v = cp.Variable()
loss = cp.sum(cp.pos(1 - cp.multiply(Y, X*beta - v)))
reg = cp.norm(beta, 1)
# 可以指定非负数
lambd = cp.Parameter(nonneg=True)
prob = cp.Problem(cp.Minimize(loss/m + lambd*reg))
```

- `lambd = cp.Parameter(nonneg=True)`

#### Reference

- BUILD YOUR OWN SUPPORT VECTOR MACHINE: https://ecomunsing.com/build-your-own-support-vector-machine

  `sklearn.svm.svc(kernel="linear")`

  https://scikit-learn.org/stable/modules/generated/sklearn.svm.SVC.html

  https://github.com/scikit-learn/scikit-learn/blob/main/sklearn/svm/src/libsvm/svm.cpp#L334

- Python Code Examples: https://www.programcreek.com/python/index/8715/cvxpy

- cvxopt: https://cvxopt.org/applications/svm/
