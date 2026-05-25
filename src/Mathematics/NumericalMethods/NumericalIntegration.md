# Numerical Integration

principles & error

We approximate the definite integral $I = \int_a^b f(x),dx$ by weighted sums $\sum_i w_i f(x_i)$.

Two error components: truncation (quadrature error, depends on smoothness and degree of exactness) and roundoff.


## Newton–Cotes Formulas

Newton–Cotes rules are a family of quadrature formulas derived by integrating an interpolating (approximating the integrand) polynomial through equally spaced points.

- Order 1 (linear): Trapezoidal rule
- Order 2 (quadratic): Simpson’s rule
- Order 3 (cubic): Simpson’s 3/8 rule
- Order 4 (quartic): Boole’s rule
- Higher orders use higher-degree polynomials.

**Composite rules** apply these on sub-intervals for better accuracy.

### Trapezoidal Rule(2-point closed Newton–Cotes)

Approximates the area under the curve using trapezoids.  
  - Single-panel trapezoidal rule (one interval):
      $$\int_a^b f(x),dx \approx \frac{b-a}{2}\big(f(a)+f(b)\big),\quad \text{error}\ \sim -\frac{(b-a)^3}{12} f''(\xi)$$
      for some $\xi \in (a,b) $ assuming continuous $f''$
  - Composite trapezoidal rule (many equal sub-intervals): Partition [a,b] into n sub-intervals of width $h = \frac{b-a}{n}$ with nodes $x_0 = a, \dots, x_n = b$. Then
    $$ \int_a^b f(x)dx \approx \frac{h}{2}[f(a) + 2\sum_{i=1}^{n-1} f(x_i) + f(b)] $$
    - Its global error scales as $E_{comp} = -\frac{(b-a)h^2}{12}f''(\xi)$ for some $\xi \in (a,b) $ assuming continuous $f''$
    - More accurate as n increases
    - When 𝑛= 1 (ℎ=𝑏−𝑎) reduces exactly to the single-panel formula and error

### Simpson's Rule
Uses quadratic interpolation for higher accuracy.  
  $\int_a^b f(x)\,dx \approx \frac{h}{3}[f(a) + 4f(x_1) + 2f(x_2) + \dots + f(b)] $

  **Simpson (3-point, uses quadratic interpolant)**:
  
  $\int_a^b f(x),dx \approx \frac{b-a}{6}\big(f(a) + 4f((a+b)/2) + f(b)\big),\quad \text{error}\ \sim -\frac{(b-a)^5}{2880} f^{(4)}(\xi).$

```julia
using SpecialFunctions
# Composite trapezoid
function composite_trap(f, a, b, n)
    h = (b-a)/n
    s = 0.5*(f(a)+f(b))
    for k in 1:n-1
        s += f(a + k*h)
    end
    return h*s
end

# Composite Simpson (n must be even)
function composite_simpson(f, a, b, n)
    if isodd(n)
        error("n must be even for composite Simpson")
    end
    h = (b-a)/n
    s = f(a) + f(b)
    for k in 1:n-1
        x = a + k*h
        s += (isodd(k) ? 4.0 : 2.0) * f(x)
    end
    return s * h / 3
end

# Test convergence on a smooth function
f(x) = exp(-x^2)
a, b = -1.0, 1.0
for n in (4, 8, 16, 32, 64, 128)
    I_trap = composite_trap(f, a, b, n)
    I_simp = composite_simpson(f, a, b, n + isodd(n)) # ensure even
    println("n=$(n): trap_err=$(abs(I_trap - sqrt(pi)*erf(1))) simpson_err=$(abs(I_simp - sqrt(pi)*erf(1)))")
end
```

### Higher-order Newton–Cotes

Uses higher-degree polynomials but can suffer from instability.

### 2. Gaussian Quadrature (Gauss–Legendre) and Golub–Welsch

Gaussian quadrature with (n) nodes integrates polynomials up to degree (2n-1) exactly. For standard interval ([-1,1]):
$\int_{-1}^{1} f(x),dx \approx \sum_{i=1}^n w_i f(x_i)$

where ${x_i}$ are roots of Legendre polynomials $P_n(x)$.

**Golub–Welsch**: compute nodes/weights via eigen-decomposition of the symmetric tri-diagonal Jacobi matrix built from recurrence coefficients of orthogonal polynomials. This is numerically stable and straightforward to implement using `LinearAlgebra.eig`.
- Uses optimally chosen points and weights (not equally spaced) to maximize accuracy for polynomials of degree \(2n-1\).  
- Example: Gauss–Legendre quadrature is widely used.  
- Very efficient when the integrand is smooth.

To integrate on ([a,b]), use the affine map (t = (b-a)/2 * x + (a+b)/2) and scale weights by ((b-a)/2).

### Tensor-product Gauss for multiple dims

For separable integrals, form tensor-product nodes & weights (cartesian product). Cost grows exponentially (curse of dimensionality).

```julia
using LinearAlgebra, Printf

# compute n-point Gauss-Legendre nodes and weights on [-1,1]
function gauss_legendre(n)
    if n == 1
        return ([0.0], [2.0])
    end
    # recurrence coefficients for Legendre polynomials
    β = zeros(n-1)
    for k in 1:n-1
        β[k] = k / sqrt((2k-1)*(2k+1))
    end
    J = SymTridiagonal(zeros(n), β)   # Jacobi matrix
    vals = eigen(J)
    x = vals.values
    V = vals.vectors
    w = 2 * (V[1,:].^2)   # weights
    return (x, w)
end

# Test integration: integrate cos(x) on [-1,1]
for n in 2:8
    x, w = gauss_legendre(n)
    I = sum(w .* cos.(x))
    exact = sin(1) - sin(-1)
    @printf("n=$(n)  approx=%.15f  exact=%.15f  err=%.3e\n", n, I, exact, abs(I - exact))
end
```

```julia
## Compare composite Simpson vs Gauss–Legendre on a smooth function
# Integrate f on [a,b] and compare methods
f(x) = cos(10*x) * exp(-x^2)
a, b = -1.0, 1.0

# high-accuracy reference using adaptive Simpson with very small tol
I_ref, _ = adaptive_simpson(f, a, b, tol=1e-12)

# composite Simpson
for n in (16, 32, 64, 128)
    I_s = composite_simpson(f, a, b, n)
    @printf("Simpson n=%3d  err=%.3e\n", n, abs(I_s - I_ref))
end

# Gauss-Legendre with n points
for n in 4:12
    x, w = gauss_legendre(n)
    # map to [a,b]
    xm = (b - a)/2 .* x .+ (a + b)/2
    wm = (b - a)/2 .* w
    I_g = sum(wm .* f.(xm))
    @printf("Gauss n=%2d  err=%.3e\n", n, abs(I_g - I_ref))
end

# You’ll typically see Gauss achieve small error with far fewer function evaluations than composite Simpson on smooth integrands.

```

### 3. **Adaptive Quadrature**
- Adjusts the step size depending on the function’s behavior.  
- More points are used where the function changes rapidly, fewer where it is smooth.  
- Commonly implemented with adaptive Simpson’s rule.

Adaptive quadrature subdivides intervals where function is poorly resolved. **Adaptive Simpson** is a common approach: compare Simpson on ([a,b]) with Simpson combined on ([a,m]) and ([m,b]) (m midpoint) and recurse where error estimate exceeds tolerance.

Below is a robust recursive adaptive Simpson implementation with stack-awareness to avoid extremely deep recursion (we include a recursion depth guard).

```julia
# Single-interval Simpson estimate
function simpson_single(f, a, b)
    c = (a + b) / 2
    return (b - a) * (f(a) + 4f(c) + f(b)) / 6
end

"""
adaptive_simpson(f, a, b; tol=1e-8, maxrec=20)

Adaptive Simpson integration on [a,b] returning (I, est_err).
"""
function adaptive_simpson(f, a, b; tol=1e-8, maxrec=20)
    # inner recursive function
    function _adapt(f, a, b, fa, fb, fc, I, tol, depth)
        c = (a + b) / 2
        d = (a + c) / 2
        e = (c + b) / 2
        fd = f(d)
        fe = f(e)
        Ileft  = (c - a)*(fa + 4fd + fc)/6
        Iright = (b - c)*(fc + 4fe + fb)/6
        I2 = Ileft + Iright
        err = I2 - I
        if (abs(err) <= 15*tol) || (depth >= maxrec)
            return (I2 + err/15, abs(err)/15)   # Richardson-style correction
        else
            L, el = _adapt(f, a, c, fa, fc, fd, Ileft, tol/2, depth+1)
            R, er = _adapt(f, c, b, fc, fb, fe, Iright, tol/2, depth+1)
            return (L + R, el + er)
        end
    end

    fa = f(a); fb = f(b); c = (a+b)/2; fc = f(c)
    I = (b-a)*(fa + 4fc + fb)/6
    return _adapt(f, a, b, fa, fb, fc, I, tol, 0)
end

# Example usage
f(x) = exp(-x^2)
I, err = adaptive_simpson(f, -2.0, 2.0, tol=1e-10)
@printf("I=%.12f  est_err=%.3e\n", I, err)

# This implementation returns an improved estimate using a Richardson correction and an error estimate. 
# It is robust for smooth and many non-smooth integrands
# but fails if the function is extremely oscillatory / singular (then specialized techniques are needed).

```

```julia
# Adaptive Simpson with caching
# This version caches `f(x)` evaluations to avoid repeated expensive function calls:

function adaptive_simpson_cached(f, a, b; tol=1e-8, maxrec=20)
    cache = Dict{Float64,Float64}()
    getf(x) = get!(cache, x) do
        f(x)
    end

    function _adapt(a, b, fa, fb, fc, I, tol, depth)
        c = (a + b)/2
        d = (a + c)/2
        e = (c + b)/2
        fd = getf(d)
        fe = getf(e)
        Ileft  = (c - a)*(fa + 4fd + fc)/6
        Iright = (b - c)*(fc + 4fe + fb)/6
        I2 = Ileft + Iright
        err = I2 - I
        if (abs(err) <= 15*tol) || (depth >= maxrec)
            return (I2 + err/15, abs(err)/15)
        else
            L, el = _adapt(a, c, fa, fc, fd, Ileft, tol/2, depth+1)
            R, er = _adapt(c, b, fc, fb, fe, Iright, tol/2, depth+1)
            return (L + R, el + er)
        end
    end

    fa = getf(a); fb = getf(b); c = (a + b)/2; fc = getf(c)
    I = (b-a)*(fa + 4fc + fb)/6
    return _adapt(a, b, fa, fb, fc, I, tol, 0)
end

# Example run with a moderately expensive f
f_slow(x) = begin
    # pretend-heavy computation
    s = 0.0
    for k in 1:50
        s += sin(k*x) / k
    end
    return s
end

I, est = adaptive_simpson_cached(f_slow, 0.0, 3.0, tol=1e-8)
@printf("Adaptive Simpson cached result: I=%.12f  est_err=%.3e  evals=%d\n", I, est, length(keys(Ref(adaptive_simpson_cached).parent.args[1] isa Nothing ? Dict() : Dict())))
# Note: above print for eval count is illustrative; to inspect exact cache size, capture cache externally or modify function to return it.
```

### 4. **Monte Carlo Integration**
- Uses random sampling to estimate integrals, especially in higher dimensions.  
- Accuracy improves with more samples.  
- Very useful for multidimensional integrals where deterministic methods are expensive.

```julia
# Monte Carlo integration of f over domain [a,b]^d
function monte_carlo_integral(f, a::Vector, b::Vector, N::Int)
    d = length(a)
    vol = prod(b .- a)
    s = 0.0
    for i in 1:N
        x = a .+ rand(d) .* (b .- a)
        s += f(x)
    end
    return vol * s / N
end

# Example: ∫_{[0,1]^3} x*y*z dx = 1/8
f3(x) = x[1]*x[2]*x[3]
@show monte_carlo_integral(f3, [0.0,0.0,0.0], [1.0,1.0,1.0], 200_000)
```

### 5. **Romberg Integration**
- Combines trapezoidal rule with Richardson extrapolation to systematically improve accuracy.  
- Builds a table of approximations with decreasing step sizes.

## Cubature (Multidimensional Integration)

Extends quadrature methods to multiple dimensions. Multidimensional integrals are expensive. Approaches:

1. **Tensor-product rules** (product of 1D Gauss rules) — accurate but cost (O(n^d)).
2. **Monte Carlo (MC)** — cost independent of dimension; error (O(N^{-1/2})), useful in high-dim.
3. **Quasi-Monte Carlo (QMC)** — low-discrepancy sequences (Sobol, Halton) give (O(N^{-1} (\log N)^d)) for smooth integrands in some cases.
4. **Sparse grids** (Smolyak) — reduce cost vs tensor product for moderate dims and smooth integrands.
5. **Importance sampling** — sample from a pdf to reduce variance for MC.

## Integration error analysis

* **Newton–Cotes rules**: error term depends on derivatives of (f) (e.g., Simpson's error involves (f^{(4)})). For composite rules, error decreases like (h^p) where (p) depends on the method (Simpson (p=4) for global error, trapezoid (p=2)).

* **Gaussian quadrature**: with (n) nodes is exact for polynomials up to degree (2n-1). For analytic (f), error decays rapidly with (n). For smooth functions, Gauss often needs far fewer nodes than Newton–Cotes to reach same accuracy.

* **Adaptive methods**: error estimate is local; global error controlled by summing local contributions. Beware: estimators assume smoothness, may be wrong near singularities but usually conservative.

* **Roundoff**: many quadrature sums add many terms; using a stable summation (Kahan/Neumaier) reduces rounding error for large (n).

```julia
# Kahan summation: reduce rounding error
function kahan_sum(arr)
    s = zero(eltype(arr))
    c = zero(eltype(arr))
    for x in arr
        y = x - c
        t = s + y
        c = (t - s) - y
        s = t
    end
    return s
end

# Use `kahan_sum(w .* f(x))` when summing many weighted evaluations if rounding error is suspected.
```

```rust

```

## Importance sampling (simple 1D example)

```julia
# Integrate ∫_0^∞ e^{-x} g(x) dx by sampling from Exp(1) and taking expectations
using Random, Distributions

function importance_integral(g, pdf, sampler, N)
    s = 0.0
    for i in 1:N
        x = sampler()
        s += g(x) / pdf(x)
    end
    return s / N
end

# Example: integrate sin(x)/(1+x^2) on [0,∞) sampling from Exp(1)
pdf_exp = x -> pdf(Exponential(1.0), x)
sampler_exp = () -> rand(Exponential(1.0))
g(x) = sin(x)/(1+x^2)
I = importance_integral(g, pdf_exp, sampler_exp, 200_000)
println(I)
```

## Practical implementation notes & tips

* **Reuse function evaluations**: in composite rules and adaptive algorithms, cache function values to avoid duplicate evaluations (important for expensive `f`).
* **Vectorization vs loops**: for many function evaluations, use loops (Julia is fast) or `@inbounds`/`@simd` when safe; avoid allocating temporary arrays if performance-critical.
* **Handling singularities/endpoint issues**: transform the integral variable (change of variables) or isolate singular behavior analytically before numeric integration.
* **Oscillatory integrals**: use specialized methods (Filon-type, Levin methods, or quadrature with analytic weight).
* **Parallel evaluation**: node/weight evaluations for Gaussian quadrature and Monte Carlo are embarrassingly parallel; use `Threads.@threads` or distributed computing for heavy tasks.
* **Use tested libraries when possible**: Julia packages `QuadGK.jl`, `FastGaussQuadrature.jl`, `Cubature.jl` (for multidim), `HCubature.jl`, `Cuba.jl` exist; they are robust and optimized. (But the code above is pure-Julia and educational.)

## Summary Table

| Approach              | Key Idea | Accuracy | Best Use Case | Contraindication |
|-----------------------|----------|----------|---------------|------------------|
| Trapezoidal Rule      | Linear approximation | O(h²) | Simple, smooth functions | less stable for high-order polynomial|
| Simpson’s Rule        | Quadratic approximation | O(h⁴) | Smooth functions, moderate accuracy |smooth and well-behaved function and even num of intervals |
| Gaussian Quadrature   | Optimal nodes & weights | Very high | Smooth integrands | requires precomputed weights and nodes |
| Adaptive Quadrature   | Variable step size | High | Functions with irregular behavior | computationally heavier|
| Monte Carlo           | Random sampling | Probabilistic | High-dimensional integrals |converges slowly |
| Romberg Integration   | Extrapolation | Very high | Smooth functions, high precision |requires multiple evaluations |



