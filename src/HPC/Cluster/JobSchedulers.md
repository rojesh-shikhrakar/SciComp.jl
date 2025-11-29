# Job Schedulers

## Slurm

Most common scheduler today.

Key concepts:

- `sbatch` — submit batch jobs
- `srun` — run parallel tasks
- Resource flags: `--gres=gpu:1`, `--cpus-per-task=4`

## PBS

Older but still widely used.

Commands:

- `qsub`, `qstat`, `qdel`

## SGE

Used in many legacy clusters.

Commands:
- `qsub`, `qhost`, `qstat`

