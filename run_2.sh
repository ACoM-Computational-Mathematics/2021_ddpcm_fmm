cd /home/michele/git_repo/2021_ddpcm_fmm
# Set parallelism level
j=10
## Run large_fmm tests
make -C experiments/large_fmm_vdw -j$j
