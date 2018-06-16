
INC	:= -I$(CUDA_HOME)/include -I$(CUDA_HOME)/samples/common/inc/ -I.
LIB	:= -L$(CUDA_HOME)/lib64 -lcudart

NVCCFLAGS	:= -lineinfo -arch=sm_20 --ptxas-options=-v --use_fast_math

laplace3d:	laplace3d.cu laplace3d_gold.cpp laplace3d_kernel.h Makefile
		nvcc laplace3d.cu laplace3d_gold.cpp -o laplace3d \
		$(INC) $(NVCCFLAGS) $(LIB)

clean:
		rm -f laplace3d
