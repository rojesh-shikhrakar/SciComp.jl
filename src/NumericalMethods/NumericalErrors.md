# Sources of Numerical Error

Computers do not represent real numbers exactly. All scientific computation must grapple with the consequences of this fact. Understanding numerical error is essential for designing algorithms that are stable, accurate, and reproducible.

## Floating Point Representation (IEEE 754)

Real numbers are infinite, but computers have finite memory.
Hence, floating-point numbers approximate real numbers with finite precision (i.e. in a fixed number of bits)

IEEE 754 standard defines how they are stored and operated on. For **Float64**, the binary representation is:

| Field               | Bits | Meaning                        |
| ------------------- | ---- | ------------------------------ |
| Sign                | 1    | +1 or −1                       |
| Exponent            | 11   | Scaled exponent with bias 1023 |
| Mantissa (fraction) | 52   | Significant digits             |

You get 64 bits in `sign | exponent | mantissa` order.

A floating-point number has the form:

$(-1)^s \times (1.m_1m_2m_3\ldots) \times 2^{e-1023}$

Some values are **exactly representable** (e.g., powers of 2).
Others cannot be represented precisely (e.g., `0.1`).

```julia
println(bitstring(0.5))
println(bitstring(0.1))  # long repeating binary fraction: not an exact representation
```

When a number is not representable, it is rounded to nearest representable value:

$fl(x) = x (1 + \delta),\quad |\delta| \le u$

where

- $fl(x)$ is the floating-point representation
- $u$ is the **unit roundoff** (≈ machine epsilon / 2)

This leads to rounding errors, loss of precision, and unexpected behavior in arithmetic operations

```julia
0.1 + 0.2 == 0.3   # terrifying isn't it
```

```julia
0.1 + 0.2 ≈ 0.3  # better use approx comparisons

1//10 + 2//10 == 3//10  # Use Rational Numbers for exact arithmetic

BigFloat(0.1) + BigFloat(0.2) == BigFloat(0.3) # Use BigFloat for Arbitrary Precision (default 256 bits) compromising performance

# or use DecFP (decimal floating point) library for financial or decimal-sensitive application avoiding binary representation errors.
```

IEEE 754 also distinguishes between +0 and -0, which can lead to subtle bugs in comparisons and algorithms

Explicitly check for NaN, Inf, and -0 in computations.

Add safeguards in code to handle these cases gracefully.

## Overflow and Underflow

Overflow: Occurs when a result is too large for representable exponent range.
  - Exceeeding Largest representable Float64 --> results blow up to infinity `Inf`

Underflow: Tiny numbers get rounded toward zero.
  - Number smaller than smallest normal Float64 enter **subnormal** range with lower precision ultimately --> 0

```julia
x = floatmax(Float64) * 2
```

```julia
smallest_float = floatmin(Float64)

smallest_float/100    # have lesser precision, degrading algorithm stability

smallest_float/1e100  # --> 0
```

## Catastrophic Cancellation

When subtracting two nearly equal numbers: $x - y$  the leading digits cancel out, leaving only low-precision “tail” bits.
This amplifies relative error dramatically.

Classic example

Compute: $f(x) = \sqrt{x^2 + 1} - 1$

For small x, these two subtracting values are nearly equal.

Use Algebraic reformulation to avoid unstable expression: $f(x) = \frac{x^2}{\sqrt{x^2 + 1} + 1}$

```julia
f1(x) = sqrt(x^2 + 1) - 1           # naive
f2(x) = x^2 / (sqrt(x^2 + 1) + 1)   # algebraically equivalent form also numerically stable

for x in [1e-1, 1e-3, 1e-6, 1e-8, 1e-10]
    println("x = $x   f1 = $(f1(x))  f2 = $(f2(x))")
end
```

## Conditioning vs Stability

Both represent sensitivity but are fundamentally different concept:

- Conditioning: A property of the *problem*
- Stability: A property of the *algorithm*

### Conditioning: A property of the *problem*

A **well-conditioned** problem is one where a small change in input produces a small change in output.

**Condition number** is a numerical measure of that sensitivity.

Example: $f(x) = x \quad\Rightarrow\quad \kappa = 1$   (output changes exactly as input)


Poorly conditioned problems amplify small perturbations.

Example: $f(x) = x^2 \text{ near } x=10^8$   (Small Δx → huge Δf , i.e tiny input changes cause huge output changes)

For a function $f(x)$, the condition number $\kappa$ is defined as:
$\kappa(x) = \underset{\delta \to 0}{\lim} \frac{\frac{|f(x+\delta) - f(x)|}{|f(x)|}}{\frac{|\delta|}{|x|}}$

This expresses the *worst-case relative change in output per relative change in input*.

The First order approximation is $\kappa(x) \approx \frac{|f'(x)| \cdot |x|}{|f(x)|}$

```julia
using ForwardDiff

f(x) = x^2 + 3x - 1

function condition_number(f, x)
    fx = f(x)
    dfx = ForwardDiff.derivative(f, x)
    return abs(dfx * x / fx)
end

# Test Condition number at different points
for x in [0.1, 1.0, 10.0, 100.0]
    println("Condition number at x=$x: ", condition_number(f, x))
end
```

#### Condition Number for Matrix

The condition number of a matrix $A$ (with respect to inversion) is:$ κ(A) = \|A\| \cdot \|A^{-1}\|$

Or equivalently, the ratio of the largest to smallest singular value of $A$ i.e $\kappa(A) = \frac{\sigma_{max}(A)}{\sigma_{min}(A)}$.

- **High condition number (≫1):** Problem is ill-conditioned → numerical solutions may be unreliable.  
- **Low condition number (≈1):** Problem is well-conditioned → stable solutions.  
- **Practical impact:** Even the best algorithm cannot overcome ill-conditioning; stability of the algorithm only matters once the problem itself is well-conditioned.
  - In linear regression, if the condition number of the design matrix X is high, the regression coefficients may be sensitive to small changes in the data.
  - When solving PDEs numerically, if the condition number of the discretized matrix is high, the solution may be sensitive to small changes in the discretization.

Calculating the condition number can be numerically unstable, especially for ill-conditioned matrices. Also computationally expensive. Use  Iterative methods, such as the power method, can be used to estimate the largest singular value. Similarly Randomized algorithms, such as randomized singular value decomposition, can be used to estimate the condition number.

```julia
using LinearAlgebra

A = [1.0 1.0; 1.0 1.0000001]
κ = cond(A)  # Large condition number → ill-conditioned system.
# solving Ax = b is ill-conditioned small change in b or rounding errors can drastically change x
```

#### Mitigating the Impact of Ill-Conditioning

- **Regularization** techniques, such as Tikhonov regularization, can be used to stabilize the solution.
- **Preconditioning** techniques, such as incomplete LU factorization, can be used to improve the conditioning of the matrix.
- **Scaling** the matrix can help to improve the conditioning.
- **Reordering** the matrix can help to improve the conditioning.
- Use **robust algorithms** that can handle ill-conditioning, such as those based on singular value decomposition.
- Monitor the **condition number** during the computation to detect potential numerical instability.

### Stability: A property of the *algorithm*

Stable algorithms ensure small rounding errors don’t grow uncontrollably (i.e. controls roundoff error and produces an answer close to the exact mathematical result).

Examples:

- Solving linear systems via **QR decomposition** is more stable than via naive Gaussian elimination.
- Barycentric Lagrange interpolation is more stable than classical polynomial interpolation.

```julia
# unstable summation
x = vcat(ones(10^7), 1e-8)
sum(x)              # unstable (left-to-right)
sum(sort(x))        # safer (ascending)
```

## Error Propagation

Error propagation quantifies how small perturbations grow

If evaluating: $f(x) = x^2 + 3x - 1$

and x contains some small perturbation δx, the output error is approximately:

$\delta f \approx f'(x),\delta x$

For multiple variables, use Jacobians.

```julia
using ForwardDiff

f(x) = x^2 + 3x - 1

x = 10.0
δx = 1e-8

dfdx = ForwardDiff.derivative(f, x)

@show approx_error = dfdx * δx

@show true_error = f(x + δx) - f(x)

# Linear propagation holds when δx is small relative to x.
```

Special values like NaN (Not a Number) and Infinity can propagate through calculations, causing unexpected results

## Machine Epsilon & Unit Roundoff

### Machine epsilon (ε)

Machine epsilon gives the smallest representable perturbation

Smallest positive number such that: $1 + \epsilon > 1$

```julia
eps()         # for Float64 → ε ≈ 2.22e−16
eps(Float32)  # for Float32 → ε ≈ 1.19e−7
```

### Unit roundoff (u)

$u = \frac{\epsilon}{2}$ bounds the relative rounding error:

$fl(x) = x(1 + \delta), \quad |\delta| \le u$

```julia
# Finding epsilon manually (didactic)

function compute_epsilon()
    ε = 1.0
    while 1.0 + ε/2 > 1.0
        ε /= 2
    end
    return ε
end

compute_epsilon()
```

## Stability Tests & Backward Error Analysis

Backward error asks:

> For the computed result (\hat{x}), is it the exact solution to a slightly perturbed input?

A backward-stable algorithm satisfies:

$\hat{x} = f(x + \delta x),\quad |\delta x| \text{ small}$

```julia
# Solving Ax = b
A = [1.0 2.0; 3.0 4.0]
b = [1.0, 0.0]

x̂ = A \ b
```

Check residual:

```julia
r = b - A*x̂
norm(r)
```

### Compute backward error

```julia
backward_error = norm(r) / (norm(A)*norm(x̂) + norm(b))
backward_error  # Small backward error → stable.
```

### Forward vs backward error

* **Forward error:** distance from true solution
* **Backward error:** how much the input must be perturbed to make the computed solution exact

Backward error is often easier and more informative.