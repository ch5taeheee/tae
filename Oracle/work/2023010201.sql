2023-0102-01) 그룹함수
  - 하나 이상의 행을 그룹으로 분리하여 각 그룹별 합(SUM), 평균(AVG), 자료의 수(COUNT), 최대값(MAX), 최소값(MIN)을 반환
  - 그룹함수와 일반 컬럼이 SELECT절에 같이 사용되면 반드시 GROUP BY 절을 기술해야함. 
  - GROUP BY 절에는 SELECT절의 그룹함수를 제외한 사용된 모든 일반 컬럼을 기술해야 하며, 필요하다면 SELECT절에 없는 칼럼도 사용 가능.
  - 그룹함수만 SELECT 절에 사용되면 GROUP BY절을 기술해서는 안됨.
  - 그룹함수는 그룹함수를 포함할 수 없으나, 일반함수는 그룹함수에 포함되거나 포함할 수 있음.
 
  -- NULL 값은 카운터에서 빠짐. *을 쓰면 전체 다 계산 COUNT : 자료의 수, 행의 수
  
 (사용형식)
    SELECT [일반 컬럼, ]
           SUM(expr) | AVG(expr) | MAX(expr) | MIN(expr) | COUNT(*|COL)
     FROM 테이블명
    [WHERE 조건]                                      -- WHERE 
    [GROUP BY 컬럼명1[,컬럼명2,...]]
    [HAVING 조건]                                     -- HAVING 그룹함수 자체에 조건이 부여되어 질 때 사용 ex) 합이 50 이상일 때
    [ORDER BY 컬럼명|컬럼INDEX [ASC|DESC][,   ];
    
    - COUNT(*|COL) : '*'를 사용하면 값이 NULL이어도 출력
    - HAVING 조건 : 조건에 그룹함수가 사용된 경우 
    
 사용예) 사원테이블에서 전체 사원의 급여합계, 평균급여, 인원수, 최대급여, 최소급여를 조회하시오. -- gruob by x (--별)
 
         SELECT SUM(SALARY) AS 급여합계,
                ROUND(AVG(SALARY)) AS 평균합계,
                COUNT(*)AS 인원수, --전체 NULL일 때도 카운트 됨. 
                MAX(SALARY) AS 최대급여,
                MIN(SALARY) AS 최소급여
            FROM HR.EMPLOYEES;
 
 사용예) 사원테이블에서 각 부서별 평균 급여, 인원수, 최대급여, 최소급여를 조회하시오. --부서별, 부서번호를 앞에 써라. 
 
          SELECT DEPARTMENT_ID AS 부서번호, 
                 ROUND(AVG(SALARY)) AS 평균급여,
                 COUNT(*) AS 인원수,
                 MAX(SALARY) AS 최대급여,
                 MIN(SALARY) AS 최소급여
            FROM HR.EMPLOYEES
            GROUP BY DEPARTMENT_ID
            ORDER BY 1;
 
 사용예) 상품테이블에서 각 분류별 상품의 수를 조회하시오. (숙제)
 
        SELECT PROD_LGU AS 분류코드,
               COUNT(PROD_ID) AS 상품수
            FROM PROD
            GROUP BY PROD_LGU
            ORDER BY 1;
 
 사용예) 회원테이블에서 성별 평균 마일리지를 조회하시오.
 
        SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '남성회원' ELSE '여성회원' END AS 성별, 
               ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지 
           FROM MEMBER
           GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '남성회원' ELSE '여성회원' END ;
           
 
 사용예) 2020년 월별 매입현황(매입수량합계, 매입금액합계)을 조회하시오.
 
        SELECT EXTRACT(MONTH FROM BUY_DATE) AS 월, 
        SUM(BUY_QTY) AS 매입수량합계, 
        SUM(BUY_QTY * BUY_COST) AS 매입금액합계
        FROM BUYPROD
        WHERE EXTRACT(YEAR FROM BUY_DATE) = 2020
        GROUP BY EXTRACT(MONTH FROM BUY_DATE)
        ORDER BY 1;
        
 
 사용예) 2020년 월별로 매출현황을 조회하시오. (숙젭)
        
     SELECT SUBSTR(A.CART_NO,5,2) ||'월' AS 월,
          
           SUM(B.PROD_PRICE * A.CART_QTY) AS 매출현황
        FROM CART A, PROD B
        WHERE SUBSTR(A.CART_NO,1,4) ='2020'
        GROUP BY  SUBSTR(A.CART_NO,5,2)
        ORDER BY 1;       
        
 사용예) 2020년 월별, 회원별, 매출현황을 조회하시오.
 
        SELECT SUBSTR(CART_NO, 5,2)||'월' AS 월, 
               CART_MEMBER AS 회원번호,
               SUM(CART_QTY) AS 매출수량집계 
         FROM CART
            WHERE CART_NO LIKE '2020%' 
            GROUP BY SUBSTR(CART_NO,5,2), CART_MEMBER -- SUBSTR(CART_NO,1,4) = '2020'
            ORDER BY 1;
 
 사용예) 사원테이블에서 각 부서의 인원이 5명 이상인 부서의 부서번호, 인원수, 평균재직년수를 조회하시오. 
 
         SELECT DEPARTMENT_ID AS 부서번호,
                COUNT(*) AS 인원수,
                TRUNC(AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE))) AS 평균재직년수
            FROM HR.EMPLOYEES
            GROUP BY DEPARTMENT_ID 
            HAVING COUNT(*) >= 5 -- 그룹의 조건은 해빙에서.
            ORDER BY 1;
 
 사용예) 2020년 5월 매입액 합계가 50만원 이상인 상품번호, 매입수량합계, 매입금액 합계를 조회하시오. 
 
  
      --(X) 
        SELECT BUY_PROD AS 상품번호,
               SUM(BUY_QTY) AS 매입수량합계,
               SUM(BUY_QTY * BUY_COST) AS 매입금액
          FROM BUYPROD
             WHERE  EXTRACT(YEAR FROM BUY_DATE)=2020 AND EXTRACT(MONTH FROM BUY_DATE)=05 AND (BUY_QTY * BUY_COST)>=500000 --X
             GROUP BY BUY_PROD
             ORDER BY 1;
            
              
        SELECT BUY_PROD AS 상품번호,
               SUM(BUY_QTY) AS 매입수량합계,
               SUM(BUY_QTY * BUY_COST) AS 매입금액
          FROM BUYPROD
            WHERE  EXTRACT(YEAR FROM BUY_DATE)=2020 AND EXTRACT(MONTH FROM BUY_DATE)=05 
            GROUP BY BUY_PROD
            HAVING SUM(BUY_QTY * BUY_COST)>=500000
            ORDER BY 1;
            
        SELECT BUY_PROD AS 상품번호,
               SUM(BUY_QTY) AS 매입수량합계,
               SUM(BUY_QTY * BUY_COST) AS "매입금액 합계"
            FROM BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE('20200501') AND TO_DATE('20200531')
        GROUP BY BUY_PROD
        HAVING SUM(BUY_QTY * BUY_COST) >= 1000000
        ORDER BY 3 DESC;
        
        
--------------------------------------------------------------------------------------------------------------------------------        
        
    SELECT DEPARTMENT_ID,
           COUNT(*)
        FROM HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ORDER BY 1;
        
        
    SELECT DEPARTMENT_ID,
           COUNT(COMMISSION_PCT) -- 특정한 컬럼명을 사용하면 NULL값은 카운팅이 되지 않는다. 
        FROM HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ORDER BY 1;        
                            
                                 -- 널값을 넣어. 왜?아웃라인? 
                                 -- * 는 NULL 값을 넣음. 해당되어지는 컬럼에 널값이 들어와도 1로 취급
                                 
           
              
             
              
              
             
         
         
 
 
 
 
 
    