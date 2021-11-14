# Part1 Convex optimization overview

> [Video Part I](https://www.youtube.com/watch?v=9sDidkln7R0)

## Notebooks

  \- [Total variation image in-painting](http://nbviewer.ipython.org/github/cvxgrp/cvxpy/blob/master/examples/notebooks/WWW/tv_inpainting.ipynb)

  \- [Control](http://nbviewer.ipython.org/github/cvxgrp/cvx_short_course/blob/master/intro/control.ipynb)

  \- [SVM classifier with ![ell_1](https://stanford.edu/~boyd/papers/eqs/2349274112114421517-130.png) regularization](http://nbviewer.ipython.org/github/cvxgrp/cvx_short_course/blob/master/intro/SVM.ipynb)

## Notes

### Mathematical Optimization

$$
\begin{equation} \min f_0(x) \quad \\s.t.\ f_i(x) \leq 0,\ g_i(x) = 0 \end{equation}
$$

- Finding good (or best) **actions** x
- constraints limit **actions** x or impose conditions o n **outcome** y
- objective $f_0(x)$ is the prediction error on some observed data
  (and possibly a term that **penalizes model complexity)**

#### Summary

- optimization arises everywhere
- most optimization problems are intractable -> cannot solve very well
- **Exception**: **convex** optimization problems are tractable

### Convex Optimization

convex optimization problem:
$$
\begin{equation} \min f_0(x) \quad \\s.t.\ f_i(x) \leq 0,\ g_i(x) = 0 \end{equation}
$$

- variable $x \in \mathbb{R}^n$

- equality constraints are linear

- $f_0, \ldots, f_m$ are convex: for $\theta \in [0,1]$

  $f_i(\theta x + (1-\theta)y) \leq \theta f_i(x) + (1-\theta)f_i(y)$

  - have nonnegative (upward) curvature

#### Why

- beautiful, nearly complete theory -> duality, optimality conditions
- effective algorithms, methods
  - global solution (and optimality certificate)
  - polynomial complexity
- conceptual unification of many methods
- lots of **applications**

#### Approach

- formulate your optimization problem

  (usually) solve it (numerically)

- some tricks:

  - change of variables
  - approximation of true objective, constraints
  - relaxation: **ignore terms** or constraints you can’t handle

### Solvers & Modeling Languages

- Medium-scale solvers
  - reliably solved by interior-point methods
- Large-scale solvers
  - solved using custom (often problem specific) methods
  - require custom implementation, tuning for each problem
- Modeling languages
  - high level language support for cvx
    - description automatically transformed to a standard form
    - solved by standard solver, transformed back to original form
  - implementations:
    - YALMIP, CVX (Matlab)
    - CVXPY (Python)
  - enable rapid prototyping (for small and medium problems)

### Examples

#### Radiation treatment planning

#### Image in-painting

- guess pixel values in obscured/corrupted parts 为缺失像素上色
- minimize total variation 最小二乘法，考虑相邻元素变化小去恢复像素

#### Control

skip

#### Support vector machine classifier with $\ell_1$ regularization

### Summary

- convex optimization problems arise in **many applications**
- high level language support makes prototyping easy
