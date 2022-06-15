cd /home/michele/git_repo/2021_ddpcm_fmm
# Set parallelism level
j=20
# Run dense_vs_fmm tests
make -C experiments/dense_vs_fmm_vdw -j$j
## Run fmm_vs_fmm tests
# make -C experiments/fmm_vs_fmm_vdw -j$j
