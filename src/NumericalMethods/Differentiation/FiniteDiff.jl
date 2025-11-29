using LinearAlgebra, Printf

# Finite difference approximations
forward_diff(f, x, h) = (f(x+h) - f(x)) / h
backward_diff(f, x, h) = (f(x) - f(x-h)) / h
central_diff(f, x, h) = (f(x+h) - f(x-h)) / (2h)

# Test function and exact derivative
f(x) = sin(x)
fprime(x) = cos(x)

# convergence table for a chosen x
function convergence_table(f, fprime, x; hvals = [10.0^-k for k in 1:12])
    println(@sprintf("%12s %12s %12s %12s","h","forward_err","central_err","rate_central"))
    prev_central_err = nothing
    for h in hvals
        ef = abs(forward_diff(f,x,h) - fprime(x))
        ec = abs(central_diff(f,x,h) - fprime(x))
        rate = prev_central_err === nothing ? "-" : @sprintf("%.2f", log(prev_central_err/ec)/log(2))
        println(@sprintf("%12.1e %12.3e %12.3e %12s", h, ef, ec, rate))
        prev_central_err = ec
    end
end

convergence_table(f, fprime, 1.3)

# central difference error decreasing ~(h^2) initially, then rising when rounding dominates.

