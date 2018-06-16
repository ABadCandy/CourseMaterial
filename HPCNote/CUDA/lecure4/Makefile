
INC	:= -I$(CUDA_HOME)/include -I$(CUDA_HOME)/samples/common/inc/ -I.
LIB	:= -L$(CUDA_HOME)/lib64 -lcudart -lcublas -lcufft

NVCCFLAGS	:= -lineinfo -arch=sm_20 --ptxas-options=-v --use_fast_math

both:		simpleBLAS simpleFFT

simpleBLAS:	simpleBLAS.cpp Makefile
		g++ simpleBLAS.cpp -o simpleBLAS $(INC) $(LIB)

simpleFFT:	simpleFFT.cu Makefile
		nvcc simpleFFT.cu -o simpleFFT $(INC) $(NVCCFLAGS) $(LIB)

clean:
		rm -f simpleBLAS simpleFFT
