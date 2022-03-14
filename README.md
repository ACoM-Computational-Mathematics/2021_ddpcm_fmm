# 2021_ddpcm_fmm

Data and plots for the paper about FMM-accelerated DDPCM

# How to execute numerical tests
1. Compile ddX with the script `build.sh`
2. Run tests with the script `run.sh`. You can choose parallelism of
    the Makefile system by changing a single parameter inside `run.sh`.

# Directories and scripts

1. `ddX`: github commit with actual ddX version.
2. `experiments`: test scripts and results.
3. `geometries`: list of test molecules.
4. `plots`: jupyter notebook with plots.
5. `build.sh`: pulls ddX software and compiles it inplace.
6. `run.sh`: executes all currently unfinished tests, whose output is not
    yet generated/
