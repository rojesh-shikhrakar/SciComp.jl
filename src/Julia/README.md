# Introduction to Julia

## Julia Manifesto
Why they created Julia: "We want a language that’s

- open source, with a liberal license.
- We want the speed of C with
- the dynamism of Ruby.
- We want a language that’s homo-iconic, with true macros like Lisp,
- but with obvious, familiar mathematical notation like Matlab.
- We want something as usable for general programming as Python,
- as easy for statistics as R,
- as natural for string processing as Perl,
- as powerful for linear algebra as Matlab,
- as good at gluing programs together as the shell.
- Something that is dirt simple to learn, yet keeps the most serious hackers happy.
- We want it interactive and we want it compiled."

But basically Julia attempts to solve the "Two-Language" problem allowing to coding everything in a single language balancing both performance (as in C or Fortran) and productivity (as in Python).

## Setup

You can directly download and install required Julia version from
[Download and Install Julia](https://julialang.org/downloads/) available for Windows, Linux and OSX.

[Juliaup](https://github.com/JuliaLang/juliaup) is the recommended method that allows to install and manage multiple julia versions in the system.

[Official Julia Documentation](https://docs.julialang.org) learn about Julia in depth.

## Running Julia

- **Julia REPL** (Read-Evaluate-Print-Loop)
  - REPL + Editor + [Revise](https://timholy.github.io/Revise.jl/stable/): revise allows to changes in packages, source code and even change of git branch switch without needing to restart the REPL
- Run Julia Script from cmd: `julia script.jl arg1 arg2...`, these args are available to julia from the global constant `ARGS`
- **IDE**: [VS Code](https://github.com/julia-vscode/julia-vscode)
- **Jupyter Notebook(Lab)** with [IJulia](https://github.com/JuliaLang/IJulia.jl) for literate programming (i.e. text, links, figures, math and code are juxtaposed together)
- **Pluto Notebook** for reactive literate programming using [Pluto.jl](https://github.com/fonsp/Pluto.jl)

## Using Julia REPL

- `julia>` : Julia REPL to interact with Julia Engine
- `shell>` : Enter through ";" for using shell command at REPL, but ; at the end of expression prevents REPL output
- `help>` : Enter through "?" for using help, search through documentation
- `(reverse-i-search)` Enter through "^R" (Ctrl+R) for using previous commands matching a pattern
- `(ENVNAME) pkg>` Enter Package Manager [Pkg.jl](https://pkgdocs.julialang.org/) through "]"  or `using Pkg` or `import Pkg`
    - activate the environment: `]activate EnvPath` or usually `.` for current folder,
    - install a package: `]add Distributions` or `Pkg.add("Distributions"),
    - use the package `using Distributions` gets alls the exported functions to julia namespace or just selected function `using Pkg:Normal`, or use `import Distributions` will only bring Pkg to namespace, use dot "." operator to access the functions inside the module
    - update a package: `]up Distributions` or just `]up`  to update all packages
    - remove a package: `]remove Distributions`
    - clone a package repo locally for development: `]dev Example`
    - checkout more with :`]?`

Other common commands

- "^L" (Ctrl+L) clear screen
- "^D" (Ctrl+D) exit REPL
- "^C" (Ctrl+C) abort or interrupt current command

```julia
# activate the environment
import Pkg      # Or use ] to activate Package in REPL
Pkg.activate(; temp=true)  # Delete the environment when session ends
Pkg.instantiate()
```

## References

- [MIT Introduction to Computational Thinking](https://computationalthinking.mit.edu/) talks about CS, Maths Applications using Julia.