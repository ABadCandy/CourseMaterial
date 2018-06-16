MODULE jacobi_module
  USE types_module
  IMPLICIT NONE
  REAL(real8), DIMENSION(:,:), ALLOCATABLE         :: vnew
  REAL(real8), DIMENSION(:,:), ALLOCATABLE, TARGET :: v  ! solution array
  REAL(real8) :: del, gdel=1.0d0
  REAL(real4) :: start_time, end_time
  CHARACTER*40 :: outfile = 'plots'
  INTEGER :: p, ierr, below, above, k, m, mp, iter=0
  INTEGER, PARAMETER :: MAXSTEPS = 50000, INCREMENT = 100
  REAL(real8), PARAMETER :: TOL = 1.d-6
  PUBLIC

CONTAINS
  SUBROUTINE bc(v, m, mp, k, p)
! PDE: Laplacian u = 0;      0<=x<=1;  0<=y<=1
! B.C.: u(x,0)=sin(pi*x); u(x,1)=sin(pi*x)*exp(-pi); u(0,y)=u(1,y)=0
! SOLUTION: u(x,y)=sin(pi*x)*exp(-pi*y)
    IMPLICIT NONE
    INTEGER m, mp, k, p, j
    REAL(real8), DIMENSION(0:m+1,0:mp+1) :: v
    REAL(real8), DIMENSION(:,:), POINTER :: c
    REAL(real8), DIMENSION(0:m+1) :: y0

    y0 = sin(3.141593*(/(j,j=0,m+1)/)/(m+1))

    IF(p > 1) THEN
	  v=0.0d0
      IF (k == 0  ) v(:,   0)=y0
      IF (k == p-1) v(:,mp+1)=y0*exp(-3.141593)
    ELSE
   	v=0.0d0
	v(:,0)=y0
	v(:,m+1)=y0*exp(-3.141593)
    END IF
    RETURN
  END SUBROUTINE bc

  SUBROUTINE neighbors(k, below, above, p)
    IMPLICIT NONE
    INTEGER :: k, below, above, p

    IF(k == 0) THEN
      below = -1        ! tells MPI not to perform send/recv
      above = k+1
    ELSE IF(k == p-1) THEN
      below = k-1
      above = -1        ! tells MPI not to perform send/recv
    ELSE
      below = k-1
      above = k+1
    ENDIF

    RETURN
  END SUBROUTINE neighbors

  SUBROUTINE print_mesh(v,m,mp,k,iter)
  IMPLICIT NONE
  INTEGER :: m, mp, k, iter, i, out
  REAL(real8), DIMENSION(0:m+1,0:mp+1) :: v

    out = 20 + k
    do i=0,m+1
      write(out,"(2i3,i5,' => ',4f10.3)")k,i,iter,v(i,:)
    enddo
    write(out,*)'+++++++++++++++++++++++++++++++++++++++++++++++++++++++'

    RETURN
  END SUBROUTINE print_mesh
END MODULE jacobi_module
