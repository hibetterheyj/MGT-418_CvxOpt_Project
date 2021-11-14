# cvxpy_start

- conda

```shell
conda-env list
source activate cvxpy
```

### Notes from tutorial solution code

- tutorial4-ex1.py

```
# add nonnegativity constraints
constr.extend([x >= 0, y >= 0])

# objectuve optimal value
print("Optimal = {}".format(objective.value))
```

- `constr += [condition]`与`constr.extend([condition])`等价
- `constr.append(condition)`则是另外一种写法



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

        
