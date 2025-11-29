# Data Structure and Algorithm

Algorithm is a well-defined outline or a finite set of sequential steps of a computational procedure to solve a class of problems. A computer program is an implementation of the algorithm in some programming language.
Algorithm is a computational procedure to solve a problem, it can be

- a mathematical abstraction (analogue) of computer program (written in a computer run on a computer)
- written in pseudocode (structured English) built on top of Model of computation

Data Structure is the organization of the data needed to solve the problem.

The choice of Algorithm and Data Structure

- helps improve space and runtime efficiency, and eventually scalability
- allows rapid prototyping to solve problem with simplicity and user friendliness
- improve performance related to User Friendliness (too long lag makes it less user friendly), also related to Security
- algorithm performance draws the line between feasible and not feasible. (If its not fast enough or uses too much memory it is not useable) => bring you to cutting edge of entrepreneurship
- Algorithms and data structure give language to talk about program behavior and Quantify the resource measure of the algorithm
- Efficiency is a concern for large scale problems (scalability): Solving Large Problems with Large Inputs
- Cases where the solution might not be really clear on how to do (or even to state clearly) such as Ml, CV, NLP, Playing Games

Examples

- Shortage Path between two points given map of all highways stored as a Graph data structure
- Best Assignment of Resources to People or Jobs to machines, Scheduling,
- Measuring Similarity of two Documents
- Human Genome
- Social Network in Facebook

## Algorithm Analysis

General Pseudocode Convention used for low-level Primitive operations when talking about Algorithm Analysis

- Data assignment: use = for assignment
- Arithmetic and logical operations: == for equality, (=,-,*,/) use standard mathematical symbols
- Programming Constructs
  - Conditionals: if ... then ... [else if ... ] [else ...]
    - Loops
      - While ... do ...
      - repeat ... until ...
      - for ... do ...
    - array indexing: A[i], A[i,j]
    - Methods
      - Declaration: **Algorithm** methodName(arg1, arg2)
      - calls: methodName(args)
      - returns: return value

Julia Code is very similar to Pseudocode

### Asymptotic Analysis How does runtime scales with input size ?

Ignore Machine dependent constants, look at the growth of the running $T(n)$ as $n -> \infty$ rather than actually running time.

Three Types of Analysis

- Worst-case (usually): $T(n)$ = max time on any input of size n
- Average-case (sometimes): $T(n)$ = expected time over all inputs of size n. (Expectation needs assumption of statistical distribution of time)
- Best-case (Not useful: eg sorting a sorted array)

Bounded From Above

Big-O : $f(n) = O(g(n)) \text{ or } f \preceq g, \quad \exists N,c \ : \ \forall n \geq N, f(n) \leq c \cdot g(n)$

- eg: $3n^2+5n+2 \leq 3n^2+5n^2+2n^2$ both are $O(n^2)$ as they have the same growth rate. Smaller items are general omited
- eg: $O(\log(n))$ is same for $\log_2(n)$, $\log_{10}(n)$, $\log_x(n)$  base doesn't matter as they only differ by a constant multiple
- since $n^a \prec n^b \quad \forall 0 <a<b : n=O(n^2),\  \sqrt(n) = O(n)$ O(n^2) grows faster
- also $n^a \prec b^n \quad \forall a> 0 b>0 : n^5=O((\sqrt2)^n),\  n^{100} = O(1.1^n)$
- also $(\log n)^a \prec n^b \quad \forall (a,b>0): (\log n)^3 = O(\sqrt(n)), n \log n = O(n^2)$

$$\log{n} \prec \sqrt{n} \prec n \prec n \log{n} \prec n^2 \prec 2^n$$

For function f,g : $\mathbb N \rightarrow \mathbb R^+$ we say that

- Big-Ω: $f(n) = \Omega(g(n)) \text{ or } f \succeq g \text{ if for some }c, f(n) \geq c \cdot g(n)$ f grows slower than g
- Big-Θ:$f(n) = \Theta(g(n)) \text{ or } f \asymp g \text{ if }, f = O(g) \text{ and } f= \Omega(g)$ f grows at the same rate as g
- little-o : $ f(n) = o(g(n)) \text{ or } f \prec g \text{ if } f(n)/g(n) \rightarrow 0 \text{ as } n \rightarrow \infty $ f grows slower than g

Big-O looks only asymptotic detail (useful for very large data) and loses important information about constant multiples. But change by a factor of 100 or 2 is still a big deal. Once we have a good asymptotic run time we can then look into other details such as benchmarking, interaction with memory hierarchy,...

## Table of Contents

- Arrays
- Linked List
- Maps and Hashing
- Recursive Algorithms
- Trees
- Graphs
- Search and Sort Algorithms
- Integer Arithmetics
- Numeric Methods and Algorithms
- Randomized Algorithms
- Incremental and Online Algorithms
- Dynamic Programming
- Optimization Algorithms
- Linear Programming
- Distributed Algorithms

## References

- [MIT 6.006 Introduction to Algorithms](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-006-introduction-to-algorithms-fall-2011/)
- [MIT 6.046 Design and Analysis of Algorithms](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-046j-design-and-analysis-of-algorithms-spring-2015/)
- [Harvard COMPSCI 224](http://people.seas.harvard.edu/~minilek/cs224/fall14/index.html)
- [UCSandiegoX DSA](https://www.edx.org/micromasters/ucsandiegox-algorithms-and-data-structures)
- [GTX DSA](https://www.edx.org/professional-certificate/gtx-data-structures-and-algorithms)
- [Algorithms](https://en.wikipedia.org/wiki/Algorithm)
