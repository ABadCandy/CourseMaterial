
! Solve Laplace equation using Successive Over Relaxation
! and Chebyshev Acceleration (see Numerical Recipe for detail)
! Kadin Tseng, Boston University, January 2000

PROGRAM sor
USE types_module
USE sor_module
USE mpi_module
TYPE (redblack) :: c, n, e, w, s
INTEGER, PARAMETER :: period=0, ndim=1
INTEGER :: grid_comm, me, iv, coord, dims, mph, mh
LOGICAL, PARAMETER :: reorder = .true.
CALL MPI_Init(ierr)                            ! starts MPI
CALL MPI_Comm_rank(MPI_COMM_WORLD, k, ierr)    ! get current process id
CALL MPI_Comm_size(MPI_COMM_WORLD, p, ierr)    ! get # procs from env or
                                               ! command line
IF(k == 0) THEN
  WRITE(*,"('Enter size of interior points, m : ')",advance='NO')
  READ(*,*)m
ENDIF
CALL MPI_Bcast(m, 1, MPI_INTEGER, 0, MPI_COMM_WORLD, ierr)

rhoj = 1.0d0 - pi*pi*0.5/(m+2)**2
rhojsq = rhoj*rhoj
mp = m/p

IF (mp < 2) THEN
  IF ( k == 0 ) THEN
    write(*,*)'The ratio of m to p (m/p) is less than 2'
    write(*,*)'Job terminated'
  ENDIF
  STOP
ENDIF

ALLOCATE (vnew(m/2,mp/2), v(0:m+1,0:mp+1))

CALL cpu_time(start_time)    ! start timer, measured in seconds

! create cartesian topology for matrix
dims = p
CALL MPI_Cart_create(MPI_COMM_WORLD, ndim, dims,  &
          period, reorder, grid_comm, ierr)
CALL MPI_Comm_rank(grid_comm, me, ierr)
CALL MPI_Cart_coords(grid_comm, me, ndim, coord, ierr)
iv = coord
CALL bc(v, m, mp, iv, p)     ! set up boundary conditions

CALL MPI_Cart_shift(grid_comm, 0, 1, below, above, ierr)

c = news(v, m, mp, 0, 0)         ! i+0,j+0  center
n = news(v, m, mp, 0, 1)         ! i+0,j+1  north
e = news(v, m, mp, 1, 0)         ! i+1,j+0  east
w = news(v, m, mp,-1, 0)         ! i-1,j+0  west
s = news(v, m, mp, 0,-1)         ! i+0,j-1  south

omega = 1.0d0
CALL update_u(c%red, n%red, e%red, w%red, s%red, &
              vnew, m, mp, omega, delr)   ! update red
CALL update_bc_2( v, m, mp, iv, below, above)
omega = 1.0d0/(1.0d0 - 0.50d0*rhojsq)
CALL update_u(c%black, n%black, e%black, w%black, s%black, &
              vnew, m, mp, omega, delb)   ! update black
CALL update_bc_2( v, m, mp, iv, below, above)
DO WHILE (gdel > TOL)
  iter = iter + 1    ! increment iteration counter
  IF(iter > MAXSTEPS) THEN
    WRITE(*,*)'Iteration terminated (exceeds 5000)'
    STOP                            ! nonconvergent solution
  ENDIF
  omega = 1.0d0/(1.0d0 - 0.25d0*rhojsq*omega)
  CALL update_u(c%red, n%red, e%red, w%red, s%red, &
              vnew, m, mp, omega, delr)   ! update red
  CALL update_bc_2( v, m, mp, iv, below, above)
  omega = 1.0d0/(1.0d0 - 0.25d0*rhojsq*omega)
  CALL update_u(c%black, n%black, e%black, w%black, s%black, &
              vnew, m, mp, omega, delb)   ! update black
  CALL update_bc_2( v, m, mp, iv, below, above)
  IF(MOD(iter,INCREMENT)==0) THEN
    del = (delr + delb)*4.d0
    CALL MPI_Allreduce( del, gdel, 1, MPI_DOUBLE_PRECISION, MPI_MAX,   &
           MPI_COMM_WORLD, ierr )  ! find global max error
    IF(k == 0) WRITE(*,'(i5,3d13.5)')iter,del,gdel,omega
  ENDIF
ENDDO

CALL cpu_time(end_time)          ! stop timer

IF(k == 0) THEN
  PRINT *,'#######################################'
  PRINT *,'Total cpu time =',end_time - start_time,' x',p
  PRINT *,'Stopped at iteration =',iter
  PRINT *,'The maximum error =',del
  OPEN(unit=40, file=outfile, form='formatted', status='unknown')
  WRITE(40,"(3i5)")m+2,mp+2,p
  CLOSE(40)
ENDIF

!WRITE(outfile, "('plots.',i1)")k
!OPEN(unit=41, file=outfile, form='formatted', status='unknown')
!WRITE(41,"(6e13.4)")v
!CLOSE(41)

DEALLOCATE (vnew, v)

CALL MPI_Finalize(ierr)

END PROGRAM sor
