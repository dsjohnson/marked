       SUBROUTINE MSP(P,N,M,F,T,PMAT)
       IMPLICIT DOUBLE PRECISION (A-H,O-Z)
       INTEGER N,F(N),T,INDEX,I,J,K,L,M
       DOUBLE PRECISION PMAT(N,T,M,M), P(N,(M-1)*(T-1))
C      Zero out values       
       DO 4 I=1,N
       DO 3 J=1,T
       DO 2 K=1,M
       DO 1 L=1,M
          PMAT(I,J,K,L)=0.0D0
  1    CONTINUE
  2    CONTINUE
  3    CONTINUE
  4    CONTINUE
C      Loop over each capture history and from first to T-1 occasions
       DO 25 I=1,N
       DO 20 J=F(I),T-1
C         For first occasion p=1   
          IF(J.EQ.F(I)) THEN
                DO 5 K=2,M
                  PMAT(I,J,K,K-1)=1.0D0 
  5             CONTINUE
                PMAT(I,J,1,M)=1.0D0
           ENDIF
C          For remaining occasions setup matrix using p and 1-p
           INDEX=(J-1)*(M-1)
           DO 9 K=2,M
              INDEX=INDEX+1
              PMAT(I,J+1,K,K-1)=P(I,INDEX) 
  9        CONTINUE
           DO 11 K=1,M-1
              PMAT(I,J+1,1,K)=1-PMAT(I,J+1,K+1,K) 
 11        CONTINUE
           PMAT(I,J+1,1,M)=1.0D0
 20    CONTINUE
 25    CONTINUE
       RETURN
       END
  