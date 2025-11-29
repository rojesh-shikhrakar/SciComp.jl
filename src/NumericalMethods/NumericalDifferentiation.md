# Numerical Differentiation

## Finite Difference Approximations

Given a smooth scalar function (f(x)), approximate (f'(x)) using stepsize (h>0).

### Forward Difference

  Uses the slope between the point and a forward neighbor.

  $$f'(x) \approx \frac{f(x+h)-f(x)}{h}$$
  Truncation error (Taylor): (f(x+h)=f(x)+hf'(x)+\tfrac{h^2}{2}f''(x)+\mathcal{O}(h^3))
  → forward difference error (=\mathcal{O}(h)).

### Backward Difference

  $f'(x) \approx \frac{f(x) - f(x-h)}{h}$ also $\mathcal{O}(h)$.
  Uses the slope between the point and a backward neighbor.

### Central Difference

  $$ f'(x) \approx \frac{f(x+h) - f(x-h)}{2h}$$
  From Taylor expansions truncation error (\mathcal{O}(h^2)) — **higher order** for same stencil width.

  More accurate since it balances forward and backward errors.

**Important practical point:** rounding error competes with truncation error. For very small (h), subtractive cancellation and floating error dominate. Optimal (h) ≈ ( \sqrt{\text{machine epsilon}} ) for central difference approximations of first derivatives (for typical well-scaled problems).

```julia
{{#include ./Differentiation/FiniteDiff.jl}}
```

## Higher-Order Difference Formulas

- Use more points to reduce truncation error.  
  Example:  
  $f'(x) \approx \frac{-f(x+2h) + 8f(x+h) - 8f(x-h) + f(x-2h)}{12h}$
  Provides better accuracy than simple two-point formulas.

## Interpolation-Based Differentiation (Newton’s forward/backward interpolation)

- Construct an interpolating polynomial (e.g., Newton’s forward/backward interpolation) and differentiate it.  
- Useful when data points are **tabulated** and not given by a continuous function.

## Richardson Extrapolation

- Improves accuracy by combining approximations with different step sizes.  
- Example: Use forward difference with step $h$ and $h/2$, then extrapolate to reduce error.

Richardson extrapolation uses values at multiple (h) to eliminate leading error terms and increase convergence order.

If $A(h) = A + c_1 h^p + c_2 h^{p+1} + \cdots$, then

$A_{\text{extrap}} = \frac{2^p A(h/2) - A(h)}{2^p - 1}$

cancels the (h^p) term.

{{#include ./Differentiation/Richardson.jl}}

## Spline Differentiation

- Fit a spline (piecewise polynomial) to data and differentiate the spline function.  
- Very effective for **smooth curves** and experimental data.

## Numerical Differentiation of Noisy Data

- Techniques like **Savitzky–Golay filters** smooth data before differentiation.  
- Important when working with experimental measurements.

---

## Trade-offs to Consider

- **Step size (h):** Too large → truncation error; too small → round-off error.  
- **Data quality:** Noisy data requires smoothing before differentiation.  
- **Accuracy vs. computational cost:** Higher-order formulas are more accurate but require more points.

---

## Summary Table

| Method                     | Formula Example | Accuracy | Use Case |
|----------------------------|-----------------|----------|----------|
| Forward Difference         | \(\frac{f(x+h)-f(x)}{h}\) | O(h) | Quick estimate, start of interval |
| Backward Difference        | \(\frac{f(x)-f(x-h)}{h}\) | O(h) | End of interval |
| Central Difference         | \(\frac{f(x+h)-f(x-h)}{2h}\) | O(h²) | General use, balanced error |
| Higher-Order Differences   | Multi-point formulas | O(h⁴) | High accuracy |
| Interpolation Differentiation | Differentiate polynomial | Depends | Tabulated data |
| Richardson Extrapolation   | Combination of steps | High | Error reduction |
| Spline Differentiation     | Differentiate spline | High | Smooth data sets |

```julia

```