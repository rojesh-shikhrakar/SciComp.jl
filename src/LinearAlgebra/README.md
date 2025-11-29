# Linear Algebra

Linear Algebra is not just about manipulating vectors, it is the mathematics of structure and predictability: how quantities combine, transform, and balance in ways that remain consistent. It's about:
- Structure: How things relate. For example, in a network graph, the adjacency matrix encodes which nodes are connected.
- Composition: How systems combine. For example, vectors and matrices can be combined as well as decomposed into components
- Balance: How systems remain consistent. For example, Solving 𝐴𝑥=𝑏 in equilibrium models ensures supply equals demand.
- Transformation: How things change predictably. For example Rotating a vector in 2D with a rotation matrix always preserves its length.
- Symmetry: How invariants reveal deeper truths. For example Eigenvalues of a symmetric matrix remain unchanged under orthogonal transformations.

It has evolved through time from proportionality --> geometric intuition --> algebraic manipulation --> abstract structure --> computational realization.

The word linear (Lt: "linea") means thread or line; line being a fundamental geometric object that is straight, predictable, and additive.

Linearity means predictability through **proportion**. i.e. If inputs combine in simple additive ways, the system is linear.

Let's consider an example $f(x) = 3x + 2$ is a linear function with first degree power and constant coefficient and has a straight graph.

If $f(x)$ is linear, then it satisfy:

- Additivity: $f(x_1 + x_2) = f(x_1) + f(x_2)$
    - $f(x_1 + x_2) = 3(x_1 + x_2) + 2 = (3x_1 + 2) + (3x_2)$
- Homogeneity: $f(kx) = k f(x)$
    -  $f(kx) = 3(kx) + 2 = k(3x) + 2$

Note: Here the constant term slightly shifts the value, however the values are increasing proportionally. 

Linear equations that involves simple linear relationship between variables are very common and widely used in every domain of science and engineering. A linear equation is an equation of form $ax + b = 0$ where a and b are constants and x is a variable with degree one. A collection of one or more linear equations involving the same variables (system of linear equations) can be used to model and solve many problems involving linear relationships. Linear algebra is the branch of mathematics that studies linear equations, matrices, vectors, scalar products, and linear transformations and provides powerful foundation for many advance topics.

However, linear equations cannot capture all the complexity and diversity of reality. Many phenomena are nonlinear, which means that they cannot be described by a simple linear equation.

What almost never happens on a computer:

- Matrix inverses
- free variables and pivot variables
- Echelon forms
- determinants (have immense theoretical value)
- Representation of large matrices as tables of numbers

What happens in computer

- structured matrices, many times in sparse forms
- SVD, and eigen values


We denote $ \mathbb K$ the field of either real numbers $ \mathbb R$ or complex numbers $ \mathbb C$. 

$ \mathbb K ^{m \times n} = \text{vectors space of } m \times n \text{ matrices}$


$ \mathbb K ^{m \times 1}$ is column vectors generally refered vectors.

$ \mathbb K ^{1 \times n}$ is row vectors or co-vectors

## References

- [MIT 18.06 Linear Algebra](http://web.mit.edu/18.06) and [Git Course repo](https://github.com/mitmath/1806)
- [VMLS text](http://vmls-book.stanford.edu/vmls.pdf) and [VMLS Julia Companion](http://vmls-book.stanford.edu/vmls-julia-companion.pdf)

