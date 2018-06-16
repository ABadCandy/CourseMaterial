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
    INTEGER m, mp
    REAL(real8) :: omega, del
    REAL(real8), DIMENSION(1:m/2,1:mp/2) :: vnew
    TYPE (oddeven) :: c, n, e, w, s
    vnew = (n%odd  + e%odd  + w%odd  + s%odd )*0.25d0
    c%odd  = (1.0d0 - omega)*c%odd  + omega*vnew
    del = sum(dabs(vnew-c%odd))
    vnew = (n%even + e%even + w%even + s%even)*0.25d0
    c%even = (1.0d0 - omega)*c%even + omega*vnew
    del = del + sum(dabs(vnew-c%even))
  END SUBROUTINE update_u
END MODULE sor_module
