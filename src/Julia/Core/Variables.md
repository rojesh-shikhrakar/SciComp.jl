# Variables and Literals

Literal is a notation for representing a fixed value in source code. Literal can be atomic values like Int, Float, Bool,..., Compound values such as collections like array, dictionary, tuples, range ..., or functions

Variables consist of a name, value, values type (only values have type), reference (pointer) to the address
Variable name can be almost any string that starts with a letter and continues with letters (including unicode letters), numbers or a few other characters.

```julia
σ²₀ = 75.0  # type automatically inferred as Float64
print(typeof(σ²₀))
1.0 isa Float64  # sames as isa(1.0, Float64)
75.0::Float64  # also as type assertion, returns the value if of the type else raise typeassert error

list =  ['a', "αβγδ", 1, 1.0, NaN, Inf, true ]  # list is not a reserved word

for i in list
  println(i, " is of type: ",typeof(i))  # finds type of the variable
end

pointer(a) # pointer through C Interface, native address of an array or string, pointer_from_objref for objects as Ptr
```

Widely observed Community Standards for naming:
- type names and module names use CamelCase, eg: SparseArrays
- functions are lowercase, without underscore when readable  eg: haskeys, sometimes _ are used as separators
- Underscores are also used to indicate a combination of concepts eg: remotecall_fetch 
- conciseness is valued, but avoid abbreviation (indexin rather than indxin) 
- "!" suffix on a function name, represent mutating functions that changes the first argument inplace, allows to reduce the number of memory allocations

https://docs.julialang.org/en/v1/manual/style-guide/index.html

Julia behaves as a dynamically typed language allowing type to be ignored in  most of the time (duck-typing), but it is important during debugging as Julia is very sensitive to type. Every object has a type, if we don't specify the type it has the type Any. 

All the types that are instantiated as values are of concrete types. i.e, they have no subtypes. 

Julia defines a supertype for every type (except the type Any) to group types together into a tree of types. (i.e every type has exactly one direct supertype which allows any to trace any two types back to their lowest common supertype).

```julia
# Integer Int, UInt (unsinged) comes in 8, 16, 32, 64 and 128 bits
sizeof(Int64) # default is Int64 based on Sys.WORD_SIZE target system

# can be writtern as binary(0b), octal(0o), and hexadecimal (0x) format
x = 0x1A9f + 0o0127 + 0b101010  # unsigned, sized determined by numbers of values
y = -0x4 # using - sign with these formats produces an two's complement of the value

typemin(Int32), typemax(Int32)  # range of numbers you can fit in a data type

# overflow checking is not automatic
x =typemax(Int64) +1  # results in a wraparound behavior from modular arithmetic
# for Int8, 16, 32 they are promoted ?
```

```julia
# Float16(half), Float32(single), Float64(double-precision) default
x, y = 1. , Float16(1e-5)

0.0 == -0.0  # has two zeros positive and negative with different bitstring()

# Special Floats, (+/-) Inf16, Inf32, Inf (64bit) and NaN16, NaN32, NaN (64bit) 
1/Inf == 0.0
1/0 == Inf  # 1 ÷ 0 throws DivideError
0/0, Inf/Inf, Inf-Inf # returns NaN, cannot compare NaN == NaN will alwasy be false

# round-off error (LSb) can lead to issues; it can accumalate over multiple computation
0.1 + 0.2 == 0.3  # false use ≈ \approx instead

# the distance between two adjacent representable floats known as machine epsilon (eps)
eps(Float32) # not constant, eps(1000.0) --> large and eps(1e-13) --> smaller
# can use nextfloat(x), prevfloat(x) 

# better to round to appropriate representable values
# RoundNearest is default roundmode, setrounding(type, roundmode) do...end to change round mode
```

```julia
# BigInt, BigFloat for computation with arbitrary precision Arithmetic
factorial(BigInt(77))
BigFloat(9)^1000
typeof(big(1))
```

```julia
5::Int + 5.0  #  Automatic type conversion through promote_type

# Type conversion with Capital letter functions 

Char(Int64('a') + Int64(2.0))     # character, Float to integer # Int64(1.3) --> inexact error, Int64("a") --> Character Conversion not possible
trunc(Int64, 3.99999)       # cuts off the fraction part
round(Int64, 1.3), floor(Int64, -1.3), ceil(Int64, -1.3)  # specify Int for conversion else 

Float64(1)  # integer to float

Bool(1) & Bool(0)    # Bool(2) or Bool("true") --> InexactError, any number or string doesn't mean true

string(true) *  string(32.2) * string(1,true)  # Note small caps, along with concatenation

# General method for type convertion: convert(Type, x)
convert(Float32, 2)

# Strings need to be parsed to Number
parse(Int64, "32")
parse(Float64, "3.14159") 


# Promotion
promote(true, BigInt(1)//3, 1.0)
```

```julia
# Rational Number represent exact ratios
p = 4//-20  # reduced to lowest term such that denominator is non-negative

numerator(p), denominator(p), float(p) 

2//3 == 6//9  # can perform arithmetic operation and comparison directly

- 5//0  # infinite rational values are valid but 0//0 or NaN values are not
```

```julia
# Complex numbers defined by im

z = (2+5im)*(2 - 3im)/(1+2im)^2  # Arithmetic Operation along with promotion mechanisms

# use complex(a,b) rather than a + b*im, to construct from variables directly without addition, multiplication operations

# sqrt(-1)  results in DomainError, use sqrt(-1+0im) instead
real(z), imag(z), cos(z), abs(z), con(z), angle(z) # in radians 

```

```julia
zero(Float16), one(Int16)  # return literal 0,1 corresponding to specified type
```

```julia
# Special Literals

Any  # all objects are of this type
Union{}  # subtype of all types, no object can have this type
Nothing  # type indicating nothing (absence of a value), a subtype of Any
nothing  # only instance of Nothing
Missing  # type indicating missing value (a value exists but is unknown), a subtype of Any
missing  # only instance of Missing

# Additionally #undef indicates an incompletely initialized object element 
```

```julia
# Characters are in '', not strings

Char(65), Char('\u3b1')  # 65 = A, 945=0x3b1 = α
```

```rust
```julia

isletter('❤'), isletter('α'), isascii('α'), isa(1.0, Float64)

```
```

```julia
# Strings is an immutable array of characters that can be indexed
# Escape characters: "\" (\n,\t,...) and "$" (Interpolation)
s1, s2 = "Hello ", "World"

# 3 ways for String concatenation
s3 = string(s1, s2)
s1 * s2   # not s1 + s2, mathematically concatenation in non-commutative  but + is
s1^2

methodswith(String) # String type have very large number of functions

name = "Rojesh"
print("Hello,\n $(name)" ) # without print \ escape is not printed in format
```

```julia
# string function allows concatenation in different ways with arrays under dot operations
string.(["a","b","c"], [1 2 3])
```