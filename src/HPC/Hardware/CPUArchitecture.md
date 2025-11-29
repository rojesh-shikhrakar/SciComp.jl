# CPU Architecture

Modern High-Performance Computing (HPC) is deeply tied to processor architecture. To write efficient Julia (or C/C++/Rust) code, you must understand how CPUs execute instructions, how memory is organized, and how to exploit parallelism at the hardware level.

CPU performance is determined by an interplay of two major factors:

- Latency (nanoseconds or CPU clock cycles) — How long a single operation takes to complete. i.e. delay between initiating an operation and receiving its result. Eg: Time to load value to DRAM, Time for a CPU to execute a floating-point addition, Time for a branch to be resolved.
  - Often dominated by memory, not computation. Register access is ~1 cycle, L1 cache ~4 cycles, L2 ~12 cycles, L3 ~40 cycles, DRAM ≥ 100 cycles but integer addition takes ~1 cycle, floating point (IEEE 754) addition ~3-5 cycles (3-5 steps)
- Throughput — How many operations can be completed per unit time or per cycle, especially when independent operations can be performed in parallel.

Understanding these is essential to writing fast code.
