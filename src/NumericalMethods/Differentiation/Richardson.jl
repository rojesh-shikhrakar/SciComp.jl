# Richardson extrapolation for derivative (central diff)

function richardson_central(f, x, h)
    D_h   = central_diff(f, x, h)
    D_h2  = central_diff(f, x, h/2)
    # central has p = 2
    return (4 * D_h2 - D_h) / 3   # O(h^4)
end

# test & compare  central difference from (O(h^2)) to (O(h^4))
for h in [1e-1, 1e-2, 1e-3, 1e-4, 1e-5]
    d_r = richardson_central(f, 1.3, h)
    @printf("h=%8.1e  central_err=%8.1e  richardson_err=%8.1e\n",
            h, abs(central_diff(f,1.3,h) - cos(1.3)), abs(d_r - cos(1.3)))
end

# observe the Richardson extrapolated derivative has much smaller error for moderate (h)