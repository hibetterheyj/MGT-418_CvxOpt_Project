# cvxpy_start

- conda

```shell
conda-env list
source activate cvxpy
```

### Notes from tutorial solution code

- `tutorial4-ex1.py`

  ```python
  # add nonnegativity constraints
  constr.extend([x >= 0, y >= 0])
  
  # objectuve optimal value
  print("Optimal = {}".format(objective.value))
  ```

  - `constr += [condition]`与`constr.extend([condition])`等价
  - `constr.append(condition)`则是另外一种写法

- `tutorial4-ex3.py`

  ```python
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
  ```

  - symbolic: `v1 = cp.Parameter(pos=True)` or `eta_2 = cp.Parameter(nonneg=True)`

### 

### Notes from external links

- cvxpy求解SVM https://zhuanlan.zhihu.com/p/104051108

- cp.solvers.lp(c, A, b) 解决线性规划的问题 https://zhuanlan.zhihu.com/p/410478494

    - MSE

        ```python
        import cvxpy as cp
        import numpy as np
        
        # Problem data.
        m = 30
        n = 20
        np.random.seed(1)
        A = np.random.randn(m, n)
        b = np.random.randn(m)
        
        # Construct the problem.
        x = cp.Variable(n)
        objective = cp.Minimize(cp.sum_squares(A*x - b))
        constraints = [0 <= x, x <= 1]
        prob = cp.Problem(objective, constraints)
        
        # The optimal objective value is returned by `prob.solve()`.
        result = prob.solve()
        # The optimal value for x is stored in `x.value`.
        print(x.value)
        # The optimal Lagrange multiplier for a constraint is stored in
        # `constraint.dual_value`.
        print(constraints[0].dual_value)
        ```

    - linear programming

        ![](https://pic4.zhimg.com/80/v2-28994676a99fdc082fc4731e5ace7ee3_720w.png)

        ```python
        import numpy as np
        from cvxopt import matrix, solvers
        
        A = matrix([[-1.0, -1.0, 0.0, 1.0], [1.0, -1.0, -1.0, -2.0]])
        b = matrix([1.0, -2.0, 0.0, 4.0])
        c = matrix([2.0, 1.0])
        
        sol = solvers.lp(c,A,b)
        
        print(sol['x'])
        print(np.dot(sol['x'].T, c))
        print(sol['primal objective'])
        ```

        
