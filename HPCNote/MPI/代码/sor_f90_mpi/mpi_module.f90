MODULE mpi_module
  USE types_module
  IMPLICIT NONE
  INCLUDE "mpif.h"  !! This brings in pre-defined MPI constants, ...
  PUBLIC

CONTAINS

  SUBROUTINE update_bc_2( v, m, mp, k, below, above )
    INCLUDE "mpif.h"
    INTEGER :: m, mp, k, below, above, ierr
    REAL(real8), dimension(0:m+1,0:mp+1) :: v
    INTEGER status(MPI_STATUS_SIZE)
 
    CALL MPI_SENDRECV(                                       &
              v(1,mp  ), m, MPI_DOUBLE_PRECISION, above, 0,  &
              v(1,   0), m, MPI_DOUBLE_PRECISION, below, 0,  &
              MPI_COMM_WORLD, status, ierr )
    CALL MPI_SENDRECV(                                       &
              v(1,   1), m, MPI_DOUBLE_PRECISION, below, 1,  &
              v(1,mp+1), m, MPI_DOUBLE_PRECISION, above, 1,  &
              MPI_COMM_WORLD, status, ierr )
    RETURN
  END SUBROUTINE update_bc_2

  SUBROUTINE update_bc_1(v, m, mp, k, below, above)
    IMPLICIT NONE
    INCLUDE 'mpif.h'
    INTEGER :: m, mp, k, ierr, below, above
    REAL(real8), DIMENSION(0:m+1,0:mp+1) :: v
    INTEGER status(MPI_STATUS_SIZE)

! Select 2nd index for domain decomposition to have stride 1
! Use odd/even scheme to reduce contention in message passing
    IF(mod(k,2) == 0) THEN     ! even numbered processes
      CALL MPI_Send( v(1,mp  ), m, MPI_DOUBLE_PRECISION, above, 0,  &
                     MPI_COMM_WORLD, ierr)
      CALL MPI_Recv( v(1,0   ), m, MPI_DOUBLE_PRECISION, below, 0,  &
                     MPI_COMM_WORLD, status, ierr)
      CALL MPI_Send( v(1,1   ), m, MPI_DOUBLE_PRECISION, below, 1,  &
                     MPI_COMM_WORLD, ierr)
      CALL MPI_Recv( v(1,mp+1), m, MPI_DOUBLE_PRECISION, above, 1,  &
                     MPI_COMM_WORLD, status, ierr)
    ELSE                         ! odd numbered processes
      CALL MPI_Recv( v(1,0   ), m, MPI_DOUBLE_PRECISION, below, 0,  &
                     MPI_COMM_WORLD, status, ierr)
      CALL MPI_Send( v(1,mp  ), m, MPI_DOUBLE_PRECISION, above, 0,  &
                     MPI_COMM_WORLD, ierr)
      CALL MPI_Recv( v(1,mp+1), m, MPI_DOUBLE_PRECISION, above, 1,  &
                     MPI_COMM_WORLD, status, ierr)
      CALL MPI_Send( v(1,1   ), m, MPI_DOUBLE_PRECISION, below, 1,  &
                     MPI_COMM_WORLD, ierr)
    ENDIF
    RETURN
  END SUBROUTINE update_bc_1

END MODULE mpi_module
