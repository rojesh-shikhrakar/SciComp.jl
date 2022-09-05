# Julia Programming Language

Julia Manifesto, Why they created Julia: "We want a language that’s 
- open source, with a liberal license. 
- We want the speed of C with 
- the dynamism of Ruby. 
- We want a language that’s homoiconic, with true macros like Lisp, 
- but with obvious, familiar mathematical notation like Matlab. 
- We want something as usable for general programming as Python, 
- as easy for statistics as R, 
- as natural for string processing as Perl, 
- as powerful for linear algebra as Matlab, 
- as good at gluing programs together as the shell. 
- Something that is dirt simple to learn, yet keeps the most serious hackers happy. 
- We want it interactive and we want it compiled."

But basically Julia attempts to solve the "Two-Language" problem allowing to coding everything in a single language balancing both performance (as in C or Fortran) and productivity (as in Python). It is a strongly typed dynamic functional language.

Download and Install Julia from https://julialang.org/downloads/

Check [Official Julia Documentation](https://docs.julialang.org) learn about Julia in depth.

## Running Julia

- Julia REPL (Read-Evaluate-Print-Loop)
    - REPL + Editor + [Revise](https://timholy.github.io/Revise.jl/stable/)
- Directly run Julia Script from cmd: `julia script.jl arg1 arg2...`
- IDE
    - [Juno IDE](http://junolab.org/)
    - [VS Code](https://github.com/julia-vscode/julia-vscode)
- Jupyter Notebook(Lab) with [IJulia](https://github.com/JuliaLang/IJulia.jl) for literate programming (i.e. text, links, figures, math and code are juxtaposed together)
- Pluto Notebook for reactive literate programming using [Pluto.jl](https://github.com/fonsp/Pluto.jl)
- Online Environments:
    - [JuliaHub](https://juliahub.com/lp/) : Cloud Platform for HPC
    - [replit](https://replit.com/languages/julia): Online Editor, REPL
    - [labstack](https://code.labstack.com/julia): Editor

## Using Julia REPL
- `julia>` : Julia REPL to interact with Julia Engine
- `shell>` : Enter through ";" for using shell command at REPL
- `help>` : Enter through "?" for using help, search through documentation
- `(ENVNAME) pkg>` Enter through "]" for using Package Manager to activate the environment, add and update packages
- `(reverse-i-search)` Enter through "^R" (Ctrl+R) for using previous commands matching a pattern
- forward-i-search

Other common commands
- "^L" (Ctrl+L) clear screen
- "^D" (Ctrl+D) exit REPL
- "^C" (Ctrl+C) abort

; at the end of expression prevents REPL output

One can access REPL through Julia cell as well


## References

- [MIT Introduction to Computational Thinking](https://computationalthinking.mit.edu/) talks about CS, Maths Applications using Julia.