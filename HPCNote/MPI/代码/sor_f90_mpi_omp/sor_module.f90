MODULE sor_module
  USE jacobi_module

  TYPE oddeven
    REAL(real8), DIMENSION(:,:), POINTER :: odd
    REAL(real8), DIMENSION(:,:), POINTER :: even
  END TYPE oddeven

  TYPE redblack
    TYPE (oddeven) :: red, black
  END TYPE redblack

  REAL(real8), PARAMETER :: pi=3.141593d0
  REAL(real8) :: omega, rhoj, rhojsq, delr, delb

CONTAINS
 
  FUNCTION news(v, m, mp, i, j)
    INTEGER :: m, mp, i, j
    REAL(real8), DIMENSION(0:m+1,0:mp+1), TARGET :: v
    TYPE (redblack) :: news
    news%black%odd  => v(i+1:i+m:2,j+2:j+mp:2)
    news%black%even => v(i+2:i+m:2,j+1:j+mp:2)
    news%red%odd    => v(i+1:i+m:2,j+1:j+mp:2)
    news%red%even   => v(i+2:i+m:2,j+2:j+mp:2)
  END FUNCTION news
 
  SUBROUTINE update_u(c, n, e, w, s, vnew, m, mp, omega, del)
    IMPLICIT NONE
    INTEGER m, mp,i,j!apple i,j
    REAL(real8) :: omega, del
    REAL(real8), DIMENSION(1:m/2,1:mp/2) :: vnew
    TYPE (oddeven) :: c, n, e, w, s
    REAL(real8) ::up    !apple
	del=0.0d0
	!$omp parallel do private(i,up) reduction(+:del)
	do j=1,mp/2
		do i=1,m/2
			up = (n%odd(i,j)  + e%odd(i,j)  + w%odd(i,j)  + s%odd(i,j) )*0.25d0
    		c%odd(i,j)  = (1.0d0 - omega)*c%odd(i,j)  + omega*up
			del=del+dabs(up-c%odd(i,j))
		end do
	end do
	!$omp end parallel

	!$omp parallel do private(i,up) reduction(+:del)
	do j=1,mp/2
		do i=1,m/2
    		up = (n%even(i,j) + e%even(i,j) + w%even(i,j) + s%even(i,j))*0.25d0
    		c%even(i,j) = (1.0d0 - omega)*c%even(i,j) + omega*up 
			del=del+dabs(up-c%even(i,j))		
		end do
	end do
	!$omp end parallel do
	   
  END SUBROUTINE update_u
END MODULE sor_module
