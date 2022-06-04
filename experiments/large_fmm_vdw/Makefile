# Solver
EXE=../../ddX/build/src/ddx_driver
# Directory with input geometries
INPUT_DIR=../../geometries
# Inputs geometries
INPUTS=3kqz_vdw.inp 3jb4_vdw.inp
# Number of Lebedev grids
NGRID:=590
# Possible PMAX for LMAX=6
PMAX6:=6
# Outputs for LMAX=6
FMM6:=$(foreach pmax, $(PMAX6), $(foreach input, $(INPUTS:.inp=), \
	   $(input).6.$(pmax).fmm))
# Possible PMAX for LMAX=8
PMAX8:=8
# Outputs for LMAX=8
FMM8:=$(foreach pmax, $(PMAX8), $(foreach input, $(INPUTS:.inp=), \
	   $(input).8.$(pmax).fmm))
# Possible PMAX for LMAX=10
PMAX10:=10
# Outputs for LMAX=10
FMM10:=$(foreach pmax, $(PMAX10), $(foreach input, $(INPUTS:.inp=), \
	   $(input).10.$(pmax).fmm))
# Possible PMAX for LMAX=12
PMAX12:=12
# Outputs for LMAX=12
FMM12:=$(foreach pmax, $(PMAX12), $(foreach input, $(INPUTS:.inp=), \
	   $(input).12.$(pmax).fmm))
# All outputs
FMM=$(FMM6) $(FMM8) $(FMM10) $(FMM12)
# Simple `make` will do everything
.DEFAULT_GOAL:=all

# Standard trick to ignore file "all" to build target "all"
.PHONY:	all clean

# All jobs
all:	$(FMM)
	@echo $(FMM)

# Set parameters of each dense test
%.fmm:	ARGV=$(subst ., ,$*)
%.fmm:	INPUT=$(INPUT_DIR)/$(firstword $(ARGV)).inp
%.fmm:	LMAX=$(word 2, $(ARGV))
%.fmm:	PMAX=$(word 3, $(ARGV))
%.fmm:	OUTPUT=$@
%.fmm:	TMP1=$@.tmp1
%.fmm:	TMP2=$@.tmp2

# Recipe to prepare fmm results
%.fmm:	$(EXE) $(INPUT)
	@echo Running experiment with input $(INPUT) lmax=$(LMAX) pmax=$(PMAX)
	@echo "2 ! Print flag" > $(TMP1)
	@echo "1 ! Number of OpenMP threads" >> $(TMP1)
	@echo "2 ! Model (2=PCM)" >> $(TMP1)
	@echo "$(LMAX) ! Max.degree of modeling harmonics" >> $(TMP1)
	@echo "$(NGRID) ! Number of Lebedev grid points" >> $(TMP1)
	@echo "2.0 ! Dielectric permittivity" >> $(TMP1)
	@echo "0.0 ! Shift of the regularization" >> $(TMP1)
	@echo "0.1 ! Regularization parameter" >> $(TMP1)
	@echo "0.0 ! Debye H\"{u}ckel parameter (ignored in PCM)" >> $(TMP1)
	@echo "1 ! Jacobi/DIIS iterative solver" >> $(TMP1)
	@echo "1d-8 ! Relative threshold for the iterative solver" >> $(TMP1)
	@echo "10000 ! Maximal number of iterations" >> $(TMP1)
	@echo "25 ! Number of DIIS extrapolation points" >> $(TMP1)
	@echo "1 ! whether or not to compute forces" >> $(TMP1)
	@echo "1 ! Whether or not to use the FMM" >> $(TMP1)
	@echo "$(PMAX) ! Multipole harmonics of the FMM" >> $(TMP1)
	@echo "$(PMAX) ! Local harmonics of the FMM" >> $(TMP1)
	@cat $(INPUT) >> $(TMP1) # copy geometry into input
	@# Run solver
	@$(EXE) $(TMP1) >> $(TMP2)
	@# Copy input and output to a single file
	@echo "=====INPUT=====" > $(OUTPUT)
	@cat $(TMP1) >> $(OUTPUT)
	@echo "=====OUTPUT=====" >> $(OUTPUT)
	@cat $(TMP2) >> $(OUTPUT)
	@# Clean up temporaries
	@rm $(TMP1) $(TMP2)

clean:
	rm -rf *.tmp1 *.tmp2 *.fmm
