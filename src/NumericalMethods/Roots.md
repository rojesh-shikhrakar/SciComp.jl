# Root Finding

Root finding is one of the oldest and most fundamental tasks in scientific computation:

> Given a function f(x), find x such that f(x) = 0.

---

## Bisection Method

The **simplest, most robust** root-finding algorithm.

Conditions

- Continuous function: f(x)
- Opposite signs at endpoints: f(a)f(b) < 0


Algorithm

1. Let $c = \frac{a+b}{2}$
2. Replace the interval [a,b] with the half that contains the root.
3. Repeat.

Convergence

- **Guaranteed** if the function is continuous
- **Linear convergence**

---

```julia
function bisection(f, a, b; tol=1e-12, maxiter=1000)
    fa = f(a)
    fb = f(b)
    if fa * fb > 0
        error("f(a) and f(b) must have opposite signs")
    end

    for i in 1:maxiter
        c = (a + b) / 2
        fc = f(c)

        if abs(fc) < tol || (b - a)/2 < tol
            return c
        end

        if fa * fc < 0
            b = c
            fb = fc
        else
            a = c
            fa = fc
        end
    end
    
    error("Did not converge")
end


f(x) = x^3 - 2x - 5
root = bisection(f, 2, 3)
```


## Fixed-Point Iteration

We rewrite the equation: $f(x) = 0 \quad \Leftrightarrow \quad x = g(x)$

Then iterate: $x_{n+1} = g(x_n)$

Convergence Condition

Fixed-point iteration converges if: $|g'(x)| < 1 \quad \text{near the root}$

```julia
function fixed_point(g, x0; tol=1e-12, maxiter=1000)
    x = x0
    for i in 1:maxiter
        x_new = g(x)
        if abs(x_new - x) < tol
            return x_new
        end
        x = x_new
    end
    error("Did not converge")
end

g(x) = cos(x)
root = fixed_point(g, 1.0)

```

## Newton’s Method

Newton’s method uses the tangent line of f(x) at the current guess:
$x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}$

Properties

- **Quadratic convergence** (very fast)
- Requires derivative ( f' )
- Not always robust


```julia
function newton(f, fp, x0; tol=1e-12, maxiter=100)
    x = x0
    for i in 1:maxiter
        fx = f(x)
        fpx = fp(x)
        if abs(fpx) < 1e-14
            error("Derivative too small")
        end
        x_new = x - fx / fpx
        if abs(x_new - x) < tol
            return x_new
        end
        x = x_new
    end
    error("Did not converge")
end


f(x) = x^3 - x - 2
fp(x) = 3x^2 - 1
root = newton(f, fp, 1.0)
```

## Secant Method

Derivative-free alternative to Newton:

$x_{n+1} = x_n - f(x_n)\frac{x_n - x_{n-1}}{f(x_n)-f(x_{n-1})}$

Properties

- Faster than bisection
- Avoids derivative
- **Superlinear convergence** (≈1.618 order)

```julia
function secant(f, x0, x1; tol=1e-12, maxiter=100)
    for i in 1:maxiter
        fx0 = f(x0)
        fx1 = f(x1)
        if abs(fx1 - fx0) < tol
            error("Denominator too small")
        end
        x2 = x1 - fx1 * (x1 - x0) / (fx1 - fx0)
        if abs(x2 - x1) < tol
            return x2
        end
        x0, x1 = x1, x2
    end
    error("Did not converge")
end

f(x) = cos(x) - x
root = secant(f, 0.0, 1.0)
```

## Convergence Order & Basins of Attraction

### Convergence order

Newton’s method: $|x_{n+1}-r| \approx C |x_n - r|^2$

Secant method: $\approx |x_n - r|^{1.618}$

Bisection: $\approx |x_n - r|$

### Basins of Attraction

Different starting values → different roots.

Example: multiple roots for: $f(x) = x^3 - 1$


```julia
using Plots

f(x) = x^3 - 1
fp(x) = 3x^2

function newton_step(x)
    x - f(x)/fp(x)
end

xs = range(-2, 2, length=500)
iterations = zeros(length(xs))

for (i,x0) in pairs(xs)
    x = x0
    for k in 1:30
        x = newton_step(x)
    end
    iterations[i] = x
end

plot(xs, iterations, ylabel="Final Value", xlabel="Initial Guess")
```

Different starting points converge to different cube roots.

## Polynomial Root Finding

Polynomials of degree ≥ 5 cannot be solved symbolically in general.
We must use numerical methods.


```julia
using Polynomials

p = Polynomial([ -6, 11, -6, 1 ])  # (x-1)(x-2)(x-3)
roots(p)
```

### Why specialized algorithms?

* Coefficients may be ill-conditioned
* Companion matrix methods are more stable
* Useful for high-degree polynomials

## Systems of Nonlinear Equations

Solve vector function: $F(x) = 0$

Newton’s method generalizes to:
$x_{n+1} = x_n - J_F(x_n)^{-1} F(x_n)$

Where $J_F$ = Jacobian matrix.

---

Example: Solve system

$$
\begin{cases}
x^2 + y^2 - 4 = 0 \
x - y = 0
\end{cases}
$$


```julia
using LinearAlgebra

function newton_system(F, J, x0; tol=1e-12, maxiter=20)
    x = x0
    for k in 1:maxiter
        Fx = F(x)
        Jx = J(x)
        dx = Jx \ Fx
        x_new = x - dx
        if norm(x_new - x) < tol
            return x_new
        end
        x = x_new
    end
    error("Did not converge")
end

F(x) = [x[1]^2 + x[2]^2 - 4;
       x[1] - x[2]]

J(x) = [2x[1]  2x[2];
         1      -1]

root = newton_system(F, J, [1.0, 1.0])
```

## Robust Root Finders (Brent’s Method)

Brent’s method combines:

- bisection
- secant method
- inverse quadratic interpolation

It is:

- **globally convergent**
- **fast**
- **the default in many systems (SciPy, Julia’s Roots.jl)**


```julia
using Roots

f(x) = x^3 - x - 2
root = find_zero(f, (1, 2), Brent())
```

Brent’s method is almost always the safest choice.

---

## Automatic Differentiation-Based Newton

Automatic differentiation (AD) computes derivatives exactly and efficiently.


```julia
using ForwardDiff

function newton_ad(f, x0; tol=1e-12, maxiter=30)
    x = x0
    for k in 1:maxiter
        fx = f(x)
        fpx = ForwardDiff.derivative(f, x)
        x_new = x - fx/fpx
        if abs(x_new - x) < tol
            return x_new
        end
        x = x_new
    end
    error("Did not converge")
end

f(x) = sin(x) - x/2
root = newton_ad(f, 1.0)
```

Works with arbitrary functions without manually writing derivatives.


## 🚀 **Summary of Methods**

| Method      | Speed       | Derivative? | Robustness  | Notes                  |
| ----------- | ----------- | ----------- | ----------- | ---------------------- |
| Bisection   | Slow        | No          | Guaranteed  | Must bracket root      |
| Fixed-point | Medium      | No          | Conditional | Sensitive to g(x) form |
| Secant      | Medium-fast | No          | Moderate    | Quasi-Newton           |
| Newton      | Fast        | Yes         | Low–medium  | Very fast near root    |
| Brent       | Fast        | No          | Excellent   | Should be default      |
| Newton (AD) | Very fast   | Automatic   | Good        | Great for complex f    |

