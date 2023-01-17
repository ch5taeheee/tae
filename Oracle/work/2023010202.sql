2023-0102-02) ROLLUP과 CUBE
 - GROUP BY 절에 사용하여 다양한 집계결과를 반환
1. ROLLUP
 - GROUP BY 절에 사용하여 레벨별 집계를 반환
 (사용형식)
  GROUP BY ROLLUP(컬럼명1, 컬럼명 2,...컬럼명n)
  . 가장 하위레벨 : '컬럼명1, 컬럼명 2,...컬럼명n'을 기준으로 집계 반환
    그 이후 부터 ROLLUP(컬럼명1, 컬럼명 2,...컬럼명n)의 오른쪽부터 컬럼명을 하나씩 제거한 기준으로 
    집계를 반환하여 가장 상위레벨은 모든 컬럼명을 제거한 집계(전체집계)를 반환한다.
    즉, 사용된 컬럼이 n개일 때 n+1개의 집계의 종류를 반환
    
 (사용예) 매출테이블에서 2020년 월별, 회원별, 제품별 집계를 구하시오. (GROUP BY 만 사용)
 --GROUP BY 절의 한계 공통된 집계만 나옴.
    SELECT SUBSTR(CART_NO,5,2) AS 월, 
           CART_MEMBER AS 회원번호, 
           CART_PROD AS 제품번호, 
           SUM(CART_QTY) AS 매출수량집계
        FROM CART
        WHERE SUBSTR(CART_NO,1,4) = '2020'
        GROUP BY SUBSTR(CART_NO,5,2), CART_MEMBER,CART_PROD
        ORDER BY 1;
        
 --(ROLLUP 사용) 
     SELECT SUBSTR(CART_NO,5,2) AS 월, 
           CART_MEMBER AS 회원번호, 
           CART_PROD AS 제품번호, 
           SUM(CART_QTY) AS 매출수량집계
        FROM CART
        WHERE SUBSTR(CART_NO,1,4) = '2020'
        GROUP BY ROLLUP(SUBSTR(CART_NO,5,2), CART_MEMBER,CART_PROD)
        ORDER BY 1;
        
2. CUBE
  - GROUP BY 절에서 사용하며 기술된 모든 컬럼을 조합 가능한 종류만큼의 집계종류를 반환
 (사용형식)
  GROUP BY CUBE(컬럼명1, 컬럼명2, ... 컬럼명n)
   . '컬럼명1, 컬럼명2,...컬럼명n' 으로 조합 가능한 종류는 2^n 만큼의 종류임
   
 (사용예) 매출테이블에서 2020년 월별, 회원별, 제품별 집계를 구하시오. 
 (GROUP BY 만 사용)
 
    SELECT SUBSTR(CART_NO,5,2) AS 월, 
           CART_MEMBER AS 회원번호, 
           CART_PROD AS 제품번호, 
           SUM(CART_QTY) AS 매출수량집계
        FROM CART
        WHERE SUBSTR(CART_NO,1,4) = '2020'
        GROUP BY SUBSTR(CART_NO,5,2), CART_MEMBER,CART_PROD
        ORDER BY 1;
        
 (CUBE만 사용)
    SELECT SUBSTR(CART_NO,5,2) AS 월, 
           CART_MEMBER AS 회원번호, 
           CART_PROD AS 제품번호, 
           SUM(CART_QTY) AS 매출수량집계
        FROM CART
        WHERE SUBSTR(CART_NO,1,4) = '2020'
        GROUP BY CUBE(SUBSTR(CART_NO,5,2), CART_MEMBER,CART_PROD)
        ORDER BY 1;
 

    

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 