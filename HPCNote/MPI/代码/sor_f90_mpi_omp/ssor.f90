
! Solve Laplace equation using Successive Over Relaxation
! and Chebyshev Acceleration (see Numerical Recipe for detail)
! Kadin Tseng, Boston University, January 2000

PROGRAM sor_serial
USE types_module
USE sor_module
TYPE (redblack) :: c, n, e, w, s
  integer i, j
  write(*,"('Enter size of interior points, m : ')",advance='NO')
  read(*,*)m

p = 1
k = 0
iter = 0
gdel = 1.0

rhoj = 1.0d0 - pi*pi*0.5/(m+2)**2
rhojsq = rhoj*rhoj
mp = m/p
ALLOCATE (vnew(m/2,mp/2), v(0:m+1,0:mp+1))

CALL cpu_time(start_time)    ! start timer, measured in seconds

CALL bc(v, m, mp, k, p)     ! set up boundary conditions

CALL neighbors(k, below, above, p)  ! determines domain border flag

c = news(v, m, mp, 0, 0)         ! i+0,j+0  center
n = news(v, m, mp, 0, 1)         ! i+0,j+1  north
e = news(v, m, mp, 1, 0)         ! i+1,j+0  east
w = news(v, m, mp,-1, 0)         ! i-1,j+0  west
s = news(v, m, mp, 0,-1)         ! i+0,j-1  south

omega = 1.0d0
CALL update_u(c%red, n%red, e%red, w%red, s%red, &
              vnew, m, mp, omega, delr)   ! update red
omega = 1.0d0/(1.0d0 - 0.50d0*rhojsq)
CALL update_u(c%black, n%black, e%black, w%black, s%black, &
              vnew, m, mp, omega, delb)   ! update black
DO WHILE (gdel > tol)
  iter = iter + 1    ! increment iteration counter
  IF(iter > MAXSTEPS) THEN
    WRITE(*,*)'Iteration terminated (exceeds 5000)'
    STOP                            ! nonconvergent solution
  ENDIF
  omega = 1.0d0/(1.0d0 - 0.25d0*rhojsq*omega)
  CALL update_u(c%red, n%red, e%red, w%red, s%red, &
              vnew, m, mp, omega, delr)   ! update red
  omega = 1.0d0/(1.0d0 - 0.25d0*rhojsq*omega)
  CALL update_u(c%black, n%black, e%black, w%black, s%black, &
              vnew, m, mp, omega, delb)   ! update black
  gdel = (delr + delb)*4.d0

  if(MOD(iter,INCREMENT)==0) then
    WRITE(*,'(i5,2d13.5)')iter,gdel,omega
  endif

ENDDO

CALL cpu_time(end_time)          ! stop timer

  PRINT *,' '
  PRINT *,'###########################################'
  PRINT *,'Matrix size m =',m
  PRINT *,'Total cpu time =',end_time - start_time,' x',p
  PRINT *,'Stopped at iteration =',iter
  PRINT *,'The maximum error =',gdel
  PRINT *,'###########################################'
  PRINT *,' '

  OPEN(unit=40, file=outfile, form='formatted', status='unknown')
  WRITE(40,"(3i5)")m+2,mp+2,P
  close(40)
  WRITE(outfile, "('plots.',i1)")K
  OPEN(unit=41, file=outfile, form='formatted', status='unknown')
  WRITE(41,"(6e13.4)")v
  close(41)

DEALLOCATE (vnew, v)

END PROGRAM sor_serial
