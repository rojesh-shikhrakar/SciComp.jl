### Tuples (): Immutable Ordered Collection

```julia
vegetables = ("Tomato", "Spinach", "Carrot")
vegetables[1]  # indexing starts from 1
```

```text
"Tomato"
```

```julia
# Named tuple: each element has a unique name,
vegetables = (fruit="Tomato", leaf="Spinach", root="Carrot")
vegetables.fruit
```

```text
"Tomato"
```

### Arrays [] : Mutable Ordered Collection

Arrays starts from 1 rather than 0.

```julia
a = Vector{Float64}(undef,5)  # define 5-length undefined varaible with Float Data type, raises UndefRefError if accessed before giving a value
typeof(a), size(a)   # type and dimension

```

```text
(Vector{Float64}, (5,))
```

```julia
rowvector = [1 2 3]       # space separator, type is Matrix{Int64}
columnvector = [1, 2, 3]   # , or ; or Enter as separator type is Vector{Int64}

a = [1
    2
    3]

size([1 2 3]), size([1,2,3]), size([1;2;3]) ,size(a)
```

```text
((1, 3), (3,), (3,), (3,))
```

```julia
1 ∈ a  # 1 in a
```

```text
true
```

```julia
arr1 = [1, 2,3, 4, 5]

@show push!(arr1,9, 10)   # enqueues an item, adds item(s) to the end of the ordered collection
@show pop!(arr1)      # dequeue removes last element
@show arr1
@show append!(arr1, [9])

@show pushfirst!(arr1, 5)  # add item(s) to the begginging of collection (known as unshift)
@show popfirst!(arr1)      # remove first item from collection   (known as shift)
@show arr1
@show popat!(arr1, 3)  # remove item from an index and subsequent items are shifted to fill the gap
@show arr1
@show insert!(arr1, 3, 3)  # insert at an index
@show deleteat!(arr1, 6)    # inverse is keepat! keeps at the place and deletes everywhere else

@show splice!(arr1, 3)        # remove at index, return the item, shift the subsequent item left 
@show arr1
@show splice!(arr1, 5, -1)    # replacement value is spliced in place of the removed item and the subsequent item
@show arr1
@show splice!(arr1, 1, [-1,-2,-3]) 
@show arr1;
```

```julia
a = Vector{Float64}(undef,5)        # 1D array
b = Matrix{Float64}(undef,4,2)      # 2D array 
c = Array{Float64}(undef, 4,5,6,7)  # 4D array --> ND array

array2d = [[1, 2, 3], [4, 5], [6, 7, 8, 9]]  # not a Matrix but Vector{Vector{Int64}},  access with array2d[2,2]
```

```text
3-element Vector{Vector{Int64}}:
 [1, 2, 3]
 [4, 5]
 [6, 7, 8, 9]
```

```julia
z = [1 2 3; 4 5 6;  7 8 9]  # In array expression, use ; or enter to separate rows
z[2,2]   # define matrix for matrix indexing
```

```text
5
```

### Dictionary: mutable unordered Associative key-value pair

- Unordered can't be indexed, accessed through keys

```julia
d1 = Dict{String,Integer}("a"=>1, "b" => 2)  # can specify types in advance, but not required
d2 = symdict = Dict(:x => 1, :y => 3, :z => 6)  # can use symbol, but don't mix. cannot convert object of type symbol to String

d1["a"], d2[:x]   # for fail-safe default can use try-catch error of type KeyError
get(d1, "c", 0)  # fail safe default,
d1["b"] = 33     # dict are mutable

# Membership
"a" ∈ keys(d1)  # abstract collection contains pair so check in keys or values
haskey(d1,"x")   # or use Has Key function  
("a" => 1) in d1  # or compare with dict like object
```

```text
true
```

```julia
# data is not in a predifined sequece, always provide the key

pop!(d1,"a")  
push!(d1,"c" => 2)
delete!(d1, "b")

merge(d1, d2)
```

```text
Dict{Any, Integer} with 4 entries:
  "c" => 2
  :y  => 3
  :z  => 6
  :x  => 1
```

```julia
findmax(d2)   # inverse, findmin, returns value and key
```

```text
(6, :z)
```

```julia
similar(arr1)
zero(arr1)

zero(10.0)  # zero of type of 10.0
one(Int64)  # one of type Int64
```

```text
1
```

### Sets: Mutable, Unordered Collection

```julia
primes = Set{Int64}()
colors = Set(["red","green","blue","yellow"])  # automatic typing
```

```text
Set{String} with 4 elements:
  "yellow"
  "blue"
  "green"
  "red"
```

```julia
push!(colors, "black") 
push!(colors, "black") 
```

```text
Set{String} with 5 elements:
  "yellow"
  "blue"
  "green"
  "black"
  "red"
```

```julia
"green" ∈ colors  # in,
```

```text
true
```

```julia
# union(), intersect(), and setdiff()  => can also be applied to dict but return will be pairs rather than Dict

```

### Ranges : Lazy interval of numbers

```julia
r = 1:0.5:5
arr = collect(r)
```

```text
9-element Vector{Float64}:
 1.0
 1.5
 2.0
 2.5
 3.0
 3.5
 4.0
 4.5
 5.0
```

```julia
# findfirst(), findall(), indexin()

```