# Control Flow

## Conditionals

```julia
N=10

if (N % 3 == 0) && (N % 5 == 0)
    println("FizzBuzz")
elseif N % 3 == 0
    println("Fizz")
elseif N % 5 == 0
    println("Buzz")
else
    println(N)
end
```

### Ternary operators: a ? b : c
space required between operators

if a
    b
else
    c
end

```julia
x, y = 10, 3
(x > y) ? x : y   # return the larger number
```

```text
true
```

```julia
l(a, b) = length(a) > length(b) ? a : b  # return the longer string/ collection
```

```text
l (generic function with 1 method)
```

### Short-circuit evaluation (Boolean switching expressions): 

**a && b**

if a is false, return false \\
if a is true, return b without needing to evaluate to true or false,

b is commonly used as an error

**a || b**

if a is true, return true
if a is false, return b

```julia
x=2
(x > 0) && error("x cannot be greater than 0")
```

```julia
isodd(1000004) || @warn("That's odd!")
```

```julia
true || println("hi")
```

```text
true
```

### Conditional Evaluation for Logical Indexing

```julia
arr[2 .<= arr .<= 4] .= 0  # logical indexing with broadcasted assignment
arr
```

## Loops

### While Loops

```julia
t = 0
while t<5
    println(t)
    t+=1 # t = t + 1
end
```

### For Loop

```julia
counter = 0
k = 0
for i in 1:10
    k, l = 17 ,18
    k += 1  # variables inside a loop has a local scope
    global counter  # global keyword to force the variable to be available outside the loop once it's been created
    counter += 1
end 
counter
k, l  # k is defined but l not defined

# best practise: create variable within a function where the loop can access the scope of the function
function f()
   counter = 0
   for i in 1:10
      counter += 1
   end
   return counter
end
```

```julia
# Multiple, Nested for loop at a time,
for i in 1:3, j in ['a','b','c']
    println(i,j)
end
```

```julia
A = [1,2,3]
for i in eachindex(A)   # more efficient than doing i = 1:length(A)
   # do something with i or A[i]
end

```

```julia
m, n = 10, 10
B = fill(0, (m, n))

for i in 1:m, j in 1:n
    B[i, j] = i + j
end
B
```

```text
10×10 Matrix{Int64}:
  2   3   4   5   6   7   8   9  10  11
  3   4   5   6   7   8   9  10  11  12
  4   5   6   7   8   9  10  11  12  13
  5   6   7   8   9  10  11  12  13  14
  6   7   8   9  10  11  12  13  14  15
  7   8   9  10  11  12  13  14  15  16
  8   9  10  11  12  13  14  15  16  17
  9  10  11  12  13  14  15  16  17  18
 10  11  12  13  14  15  16  17  18  19
 11  12  13  14  15  16  17  18  19  20
```

```julia
z = 11
for i in 1:10
    m = (@isdefined m ) ? m : 1
    m += 1
end
println(z)
```

## Comprehensions

### Array Comprehension

```julia
C = [i + j for i in 1:m, j in 1:n]
```

```text
20×10 Matrix{Int64}:
  2   3   4   5   6   7   8   9  10  11
  3   4   5   6   7   8   9  10  11  12
  4   5   6   7   8   9  10  11  12  13
  5   6   7   8   9  10  11  12  13  14
  6   7   8   9  10  11  12  13  14  15
  7   8   9  10  11  12  13  14  15  16
  8   9  10  11  12  13  14  15  16  17
  9  10  11  12  13  14  15  16  17  18
 10  11  12  13  14  15  16  17  18  19
 11  12  13  14  15  16  17  18  19  20
 12  13  14  15  16  17  18  19  20  21
 13  14  15  16  17  18  19  20  21  22
 14  15  16  17  18  19  20  21  22  23
 15  16  17  18  19  20  21  22  23  24
 16  17  18  19  20  21  22  23  24  25
 17  18  19  20  21  22  23  24  25  26
 18  19  20  21  22  23  24  25  26  27
 19  20  21  22  23  24  25  26  27  28
 20  21  22  23  24  25  26  27  28  29
 21  22  23  24  25  26  27  28  29  30
```

### Dictionary Comprehension

```julia
Dict(i => i^2 for i in 1:10)

Dict((i,j) => i+j for i in 1:10,j in 1:10 )
```