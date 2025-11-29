## Functions : first class citizen in Julia

Variables have local so type-definition is allowed but not required.

By just by "convention", functions named followed by `!` are implemented to alter the contents while functions lacking `!` do not alter the content of the arguments. Called Mutating and Non-Mutating Functions. eg sort()

Three types of definition

```julia
function f(x::Number)::Int32  # takes in any number and return Int32
  trunc(real(x+2))  # last value returned by default, return keyword available, return multiple values as well
end
Z = f(2.5+3*im)
Z,typeof(Z)
```

```julia
function f(normarg, optionarg=0 ; keyarg = 4, s = "hello")  # default arguments are followed by keyword arguments separated by ;
  println("normal argument is $normarg")
  println("optional argument is $optionarg")
  return "keyword argument => $keyarg, s => $s"
end

f(keyarg=999, 1, 2)  # keyword arguments can be anywhere not just at the end
```

```julia
function f(args...)  # variable number of arguments, ... represent splat operator
    println("you supplied $(length(args)) arguments")
    for arg in args
       println(" argument ", arg)
    end
end

```

```julia
# use of splat operator for splicing the argument

function f(x, y)
   println("x $x y $y")
end

test((1,2)...)
```

### Inline functions

```julia
f(x,y=0) = 2x+y  # default value available
f(1,2)
```

```julia
# Julia functions have access to all variables that are visible at the level that the function is created
b = 4;
f(x) = b*x
f(6)
```

### Anonymous Functions

```julia
map(x -> x^2 + 2x - 1, [1,3,-1])
```

```julia
map((x,y,z) -> x + y + z, [1,2,3], [4, 5, 6], [7, 8, 9])  #can take multiple or 0 argument ()
```

### Do Blocks: to write longer anonymous function

```julia
smallprimes = [1,2,3,5,7,11,13,17,19,23];
findall(x -> isequal(13, x), smallprimes)


findall(smallprimes) do x
     isequal(x, 13) 
end
```

```julia
## generally a duck type method is also added as a fallback
f1(x) = x ^ 2
f1("A")
```