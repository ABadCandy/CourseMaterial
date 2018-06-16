##### User configurable options #####

ROOT=/usr/local/bin
OPTFLAGS    = -O3
CC          = $(ROOT)/mpicc $(OPTFLAGS)
CCC         = $(ROOT)/mpiCC $(OPTFLAGS)
F77         = $(ROOT)/mpif77 $(OPTFLAGS)
CLINKER     = $(ROOT)/mpicc $(OPTFLAGS)
CCLINKER    = $(ROOT)/mpiCC $(OPTFLAGS)
FLINKER     = $(ROOT)/mpif77 $(OPTFLAGS)
F90         = $(ROOT)/mpif90 $(OPTFLAGS) 
F90LINKER   = $(ROOT)/mpif90 $(OPTFLAGS)
MAKE        = make
SHELL       = /bin/sh
#

### End User configurable options ###

CFLAGS  =
FFLAGS =
LIBS =
FLIBS =
EXECS = ssor psor

default: $(EXECS)

all: $(EXECS)

ssor: types_module.o jacobi_module.o sor_module.o ssor.o cpu_time.o
	$(F90) -fopenmp -o $@ types_module.o jacobi_module.o sor_module.o ssor.o cpu_time.o $(OPTFLAGS) $(LIBS)

psor: types_module.o jacobi_module.o sor_module.o mpi_module.o psor.o cpu_time.o
	$(F90) -fopenmp -o $@ types_module.o jacobi_module.o sor_module.o mpi_module.o psor.o cpu_time.o $(LIBS)


clean:
	/bin/rm -f *.o *.mod *~ fort.4* $(EXECS)

.c.o:
	cc $(CFLAGS) -c $*.c
.f.o:
	$(F77) $(FFLAGS) -c $*.f
.f90.o:
	$(F90) $(FFLAGS) -c $*.f90
.SUFFIXES: .f90
