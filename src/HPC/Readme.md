# High-Performance Computing (HPC)

Scientific computation requires massive computational resources because the problems it tackles—like simulating the climate, modeling the universe, or analyzing genomic data, are far too complex (simulating billions of particles), large-scale, and time-sensitive (e.g., predicting hurricanes or pandemics) for ordinary computers. Furthermore, scientific models often need extremely fine resolution. A weather model at kilometer-scale resolution involves trillions of grid points, each requiring calculations at every time step. These tasks demand enormous processing power, memory, and parallelization to handle the scale of data and calculations involved, often clusters of machines, specialized processors, and advanced software. Modern HPC is not just about parallelism and fast computers but a blend of hardware, system-level computing, algorithms, and software engineering.

## History of HPC

HPC grew out of the need to solve problems too big for conventional computers, starting with military and scientific demands in the mid-20th century, and evolving through supercomputers, clusters, and GPUs into today’s exascale systems.

- ENIAC (completed in 1945) was the first programmable, electronic, general-purpose digital computer, developed by John Mauchly and J. Presper Eckert. It used to calculate artillery firing tables for the United States Army during World War II.
- The first era of HPC (1970s–1990s) was dominated by specialized vector supercomputers, such as Cray-1, Cray X-MP, Fujitsu VP series, NEC SX series. These costly machines processed entire vectors (arrays of numbers) in a single instruction, accelerating scientific workloads like dense linear algebra.
- The second major shift (1990s–2000s) came with commodity clusters democratizing. HPC universities and small labs could build powerful machines without exotic hardware.
  - Multiple off-the-shelf CPUs connected via fast networks.
  - Message Passing Interface (MPI) became the standard.
  - Distributed memory systems replaced monolithic supercomputers.
  - Large scientific codes (CFD, weather modeling, astrophysics) adopted MPI + C/Fortran as standard practice.
- GPU Revolution (2006–present): The emergence of NVIDIA’s CUDA platform unlocked an entirely new level of parallelism. GPUs introduced heterogeneous computing: powerful for certain workloads, but requiring specialized programming.
  - Thousands of lightweight cores
  - Tremendous floating-point throughput
  - Massive memory bandwidth
  - Energy efficiency per operation
  Many domain have been transformed by GPUs such as Molecular dynamics (AMBER, GROMACS), Machine learning (deep learning), Sparse linear algebra, Image and signal processing
- Exascale Computing (2020s–future): Exascale refers to systems capable of $10^18$ floating-point ops/sec (1 exaFLOP). Frontier and Aurora (USA), Fugaku (Japan, pre-exascale). Enabled climate prediction at kilometer-scale resolution, genomics running at national scale and AI foundation models with trillions of parameters.
  - Hybrid architectures (CPUs + GPUs + accelerators)
  - Advanced interconnects (InfiniBand HDR/NDR, custom links)
  - Extremely tight power constraints
  - Software tuning at all layers

---

## Types of HPC Workloads

HPC is no longer just for physics laboratories; it powers **AI, biotech, finance, and cybersecurity**. Modern HPC supports a diverse set of computational domains:

- Scientific Computing: Solving large linear systems, Simulating differential equations, Quantum simulations, etc. These problems often demand extreme numerical precision and scalability.
- Physics & Engineering Simulations: High-resolution simulations of Fluid dynamics (CFD), Structural mechanics, Thermodynamics, Electromagnetics. Such simulations often run on distributed clusters using MPI + GPUs for acceleration.
- Weather and Climate Modeling: One of the biggest HPC consumers globally. Used for climate projections at global scale, storm/hurricane prediction, ocean circulation modeling. These workloads require fast interconnects and massive parallelization.
- Optimization & Machine Learning: AI and large-scale optimization have become major HPC drivers. It involves training large deep learning models using large-scale gradient optimization, reinforcement learning, bayesian inference. Most modern AI workloads run primarily on GPUs.
- Genomics & Bioinformatics: Massive sequencing pipelines require HPC for Genome assembly, variant calling, alignment at population scale. Modern workloads deal with terabytes of data per experiment.
- Graph Analytics: Key in social network analysis, cybersecurity, recommendation systems. Examples PageRank, BFS on massive graphs, Social influence propagation. Often run on GPU-optimized graph engines.

## HPC Software Stack

Understanding the HPC ecosystem requires looking at multiple layers: hardware, software, and workflow automation.

### Hardware Components

- CPUs: CPUs in HPC clusters typically have many cores, wide SIMD units, high clock speeds, large caches and NUMA memory layouts. Examples: AMD EPYC, Intel Xeon, ARM Neoverse.
- GPUs: GPUs are specialized throughput-oriented processors. NVIDIA (dominant, CUDA), AMD (ROCm ecosystem), Intel (Xe architecture, oneAPI) provide GPUs that excel at vectorized, parallel workloads.
- Memory Hierarchy: Understanding memory locality is foundational for writing efficient HPC code.
  - L1/L2/L3 CPU caches
  - DRAM (DDR5, HBM3)
  - GPU global memory
  - Shared memory on GPUs
  - Network-attached memory (emerging)
- Networking or Interconnection: Nodes in HPC clusters communicate through high-speed networks such as InfiniBand, Slingshot (HPE/Cray), NVLink/NVSwitch (GPU interconnect), Ethernet (used in cloud HPC). Low-latency communication is essential for distributed simulations.

### Software Components

- Operating Systems: Most clusters run on Linux (CentOS/Rocky, Ubuntu, SUSE), some may have Custom HPC-tuned kernels.
- Drivers & Firmware: Especially relevant for GPU compute, High-performance NICs, and special Storage devices/configurations.
- Compilers: GCC, Clang/LLVM, Intel oneAPI compilers, NVIDIA NVCC, PGI/NVIDIA HPC SDK are widely used.
- Performance Libraries enables high-performance on top of compiled programs: Such as BLAS/LAPACK, FFTW, cuBLAS, cuDNN, cuFFT, PETSc, Trilinos

### HPC Workflows

- Job Schedulers: Schedulers manage thousands of jobs across large clusters. Common systems:
  - **Slurm** (most widely used)
  - PBS Pro
  - Sun Grid Engine (SGE)
  - LSF
- Schedulers handle:
  - Resource allocation
  - Parallel job launch
  - Accounting & quotas
  - Job queues

- Distributed Filesystems: Large clusters require scalable filesystems to handle petabyte-scale data sets efficiently, such as:
  - Lustre
  - GPFS (IBM Spectrum Scale)
  - BeeGFS
  - Ceph
  - NFS for shared home directories

---

## HPC Toolchain for Julia

Julia is uniquely suited to HPC because it combines:

- High-level expressiveness
- JIT performance
- Seamless C/Fortran integration
- Native GPU capabilities
- Built-in distributed computing

### Installing Julia for HPC Clusters

1. **Module Systems**: Load Julia via:  `module load julia/1.11.0`
2. **Downloaded tarballs**: Install in `$HOME` or shared directory.
3. **Cluster-wide installation**: Administrators build optimized Julia binaries with BLAS/MKL support.
4. **Containerized installation**: Using Docker, Singularity/Apptainer.

### Essential Julia HPC Packages

- `PackageCompiler.jl`: Essential for improving startup performance in cluster workflows. It allows:
  - Creating custom system images
  - Reducing JIT latency
  - Ahead-of-time compilation
  - Packaging HPC applications into standalone executables
- `Revise.jl`: Used in workflow development:
  - Automatic module reloading
  - Reduces iteration time
  - Essential in interactive development
- `BenchmarkTools.jl`: Provides reliable micro-benchmarking and performance engineering.
  - Handles interpolation
  - Separates compilation time from execution time
  - Produces statistical summaries
- `CUDA.jl`: Enables GPU development in pure Julia. CUDA.jl brings Julia close to CUDA C++ performance with higher-level productivity.
  - Write custom kernels
  - Launch CUDA kernels
  - Use GPU arrays
  - Interface with cuBLAS, cuFFT
  - Profiling and debugging GPU code
- `MPI.jl`: Wrapper around the MPI standard. Allows Julia code to scale across thousands of nodes.
  - Supports point-to-point communication
  - Collectives
  - Non-blocking operations
  - Cartesian topologies

### Project Environments & Reproducibility

Julia ensures reproducibility via:

- `Project.toml` – package list
- `Manifest.toml` – exact dependency resolution
- Per-project environments:

```julia
] activate my_hpc_project
```

Reproducibility is essential for:

- Cluster workflows
- Scientific papers
- Long-running jobs
- Archiving experiments
