# Solver
EXE=../../../ddPCM/build/tests/main
# Inputs geometries
INPUTS=2rvd.inp 2mlt_monomer.inp 1ejg.inp 2mlt.inp
# Possible values of lmax (model degrees) to check
LMAXS:=6 8 10 12
# Degree of FMM harmonics
PMAX:=40
# Number of Lebedev grids
NGRID:=590
# Dense outputs
DENSE:=$(foreach lmax, $(LMAXS), $(foreach input, $(INPUTS:.inp=), \
	   $(input).$(lmax).dense))
# FMM outputs
FMM:=$(foreach lmax, $(LMAXS), $(foreach input, $(INPUTS:.inp=), \
	   $(input).$(lmax).fmm))
# Simple `make` will do everything
.DEFAULT_GOAL:=all

# Standard trick to ignore file "all" to build target "all"
.PHONY:	all dense fmm clean

# All jobs
all:	dense fmm
	# All targets
	echo $(DENSE)
	echo $(FMM)

# Dense jobs
dense:	$(DENSE)

# FMM jobs
fmm:	$(FMM)

# Set parameters of each dense test
%.dense %.fmm:	ARGV=$(subst ., ,$*)
%.dense %.fmm:	INPUT=$(firstword $(ARGV)).inp
%.dense %.fmm:	LMAX=$(word 2, $(ARGV))
%.dense %.fmm:	OUTPUT=$@
%.dense %.fmm:	TMP1=$@.tmp1
%.dense %.fmm:	TMP2=$@.tmp2
%.dense:	FMM=0
%.fmm:		FMM=1
%.dense:	PMAX=0
%.fmm:		PMAX=40

# Recipe to prepare dense and fmm results
%:
	@echo Running experiment with input $(INPUT) lmax=$(LMAX) fmm=$(FMM)
	@echo "1 ! Print flag" > $(TMP1)
	@echo "1 ! Number of OpenMP threads" >> $(TMP1)
	@echo "2 ! Model (2=PCM)" >> $(TMP1)
	@echo "$(LMAX) ! Max.degree of modeling harmonics" >> $(TMP1)
	@echo "$(NGRID) ! Number of Lebedev grid points" >> $(TMP1)
	@echo "78.3553 ! Dielectric permittivity" >> $(TMP1)
	@echo "0.0 ! Shift of the regularization" >> $(TMP1)
	@echo "0.1 ! Regularization parameter" >> $(TMP1)
	@echo "0.0 ! Debye H\"{u}ckel parameter (ignored in PCM)" >> $(TMP1)
	@echo "1 ! Jacobi/DIIS iterative solver" >> $(TMP1)
	@echo "1d-14 ! Relative threshold for the iterative solver" >> $(TMP1)
	@echo "1000 ! Maximal number of iterations" >> $(TMP1)
	@echo "25 ! Number of DIIS extrapolation points" >> $(TMP1)
	@echo "1 ! whether or not to compute forces" >> $(TMP1)
	@echo "$(FMM) ! Whether or not to use the FMM" >> $(TMP1)
	@echo "$(PMAX) ! Multipole harmonics of the FMM" >> $(TMP1)
	@echo "$(PMAX) ! Local harmonics of the FMM" >> $(TMP1)
	@echo "0 ! Whether or not to precompute FMM translations" >> $(TMP1)
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
	rm -rf *.tmp1 *.tmp2 *.dense *.fmm
