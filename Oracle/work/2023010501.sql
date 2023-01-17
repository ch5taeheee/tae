2023-0105-01)SUBQUERY
 - 쿼리 안에 포함된 또 다른 쿼리를 서브쿼리라 한다. 
 - 서브쿼리는 알려지지 않은 조건에 의한 연산을 수행할 때 사용됨.
 - 수행해야 할 JOIN의 수를 줄일 수 있음.
 - 서브쿼리는 '()'안에 기술. 단, INSERT INTO 절에 사용되는 서브쿼리는 '( )' 없이 사용
 - 서브쿼리는 연산자 오른쪽에 위치해야 함. 
 - 서브쿼리의 분류
  . 일반 서브쿼리, INLINE VIEW, 중첩서브쿼리 --FROM절에 나오는 서브쿼리는 100% 독립 실행되어져야 함. 
  . 연관서브쿼리, 비연관성 서브쿼리
  . 단일행/다중행, 단일열/다중열 서브쿼리
  
 (사용예) 사원들의 평균급여(서브쿼리)보다 많은 급여를 받는 사원의 사원번호, 사원명, 급여를 출력하시오.(메인쿼리)
 (메인쿼리 : 사원의 사원번호, 사원명, 급여를 출력)
  SELECT EMPLOYEE_ID AS 사원번호, 
         LAST_NAME AS 사원명, 
         SASARY AS 급여
    FROM HHR.EMPLOYEES 
  WHERE SALARY >= (서브쿼리);
  
(서브쿼리 : 사원들의 평균급여) 
 SELECT AVG(SALARY) FROM HR.EMPLOYEES;
 
(결합) 
1.  SELECT EMPLOYEE_ID AS 사원번호, 
         LAST_NAME AS 사원명, 
         SALARY AS 급여
    FROM HR.EMPLOYEES 
  WHERE SALARY >= (SELECT AVG(SALARY) FROM HR.EMPLOYEES);
  
2.  SELECT A.EMPLOYEE_ID AS 사원번호,               --인라인뷰 서브쿼리 / 실행횟수 1번
        A.LAST_NAME AS 사원명, 
        A.SALARY AS 급여
    FROM HR.EMPLOYEES A ,(SELECT AVG(SALARY)AS ASAL FROM HR.EMPLOYEES)B
    WHERE A.SALARY > B.ASAL
    
    
 (사용예) 각 부서의 최대급여와 동일한 급여를 받는 사원들의 사원번호, 사원명, 부서코드, 부서명을 출력 하시오.
 (메인쿼리 : 사원들의 사원번호, 사원명, 부서코드, 부서명을 출력)
1.   SELECT 사원번호, 사원명, 부서코드, 부서명
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
      WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        AND (A.DEPARTMENT_ID,A.SALARY) IN(서브쿼리)
        
 (서브쿼리 : 각 부서별 최대급여)
  SELECT DEPARTMENT_ID,
         MAX(SALARY)
    FROM HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID
   
 (결합) 
  SELECT A.EMPLOYEE_ID AS 사원번호, 
         A.LAST_NAME AS 사원명, 
         A.SALARY AS 급여,
         B.DEPARTMENT_ID AS 부서코드, 
         B.DEPARTMENT_NAME AS 부서명
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
      WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        AND (A.DEPARTMENT_ID,A.SALARY) IN(SELECT DEPARTMENT_ID,   -- 여러 컬럼의 값을 비교할 때 () 묶는다. 뀨~~
                                                 MAX(SALARY)
                                             FROM HR.EMPLOYEES
                                            GROUP BY DEPARTMENT_ID)
       ORDER BY 4;
        
 SELECT EMPLOYEE_ID,
        SALARY
   FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID = 50
   ORDER BY 2 DESC;

 (사용예)직무변동 테이블(job_history)에 있는 부서코드의 같은 부서의 부서코드, 부서명을 조회하시오.
    SELECT A.DEPARTMENT_ID AS 부서코드,
           A.DEPARTMENT_NAME AS 부서명
     FROM HR.DEPARTMENTS A
    WHERE A.DEPARTMENTS_ID = (서브쿼리 : 직무변동테이블에 있는 부서코드)
 (IN 연산자)
    SELECT A.DEPARTMENT_ID AS 부서코드,
           A.DEPARTMENT_NAME AS 부서명
     FROM HR.DEPARTMENTS A
    WHERE A.DEPARTMENT_ID IN (SELECT DISTINCT DEPARTMENT_ID
                                  FROM HR.JOB_HISTORY);
 (EXISTS 연산자) --서브쿼리 결과가 하나라도 있으면 참, 없으면 거짓 출력된 결과는 상관 없음. 
     SELECT A.DEPARTMENT_ID AS 부서코드,
           A.DEPARTMENT_NAME AS 부서명
       FROM HR.DEPARTMENTS A
      WHERE EXISTS ( SELECT  1 --1이 의미하는 것? 1출력하라... 출력하면 전체 조건이 참. 출력 안 하면 거짓
                        FROM HR.JOB_HISTORY B 
                       WHERE B.DEPARTMENT_ID = A.DEPARTMENT_ID) --서브쿼리에 * 잘 안 씀.
                       
 (사용예) 2020년 5월 매출액이 많은 5명의 회원을 조회하고 그 회원들의 회원번호, 회원명, 주소, 마일리지를 출력하시오. --많은 순으로 정렬해서 위에서 잘라라
 
 (1) 2020년 5월 회원별 구매금액합계를 조회하고 구매금액합계가 많은 회원 순으로 출력 --FROM절에 서브쿼리 
    SELECT D.MEM_ID AS 회원번호,
           D.MEM_NAME AS 회원명,
           D.MEM_ADD1||' '||D.MEM_ADD2 AS 주소,
           D.MEM_MILEAGE AS 마일리지,
           C.CSUM AS 구매금액합계
      FROM (SELECT A.CART_MEMBER AS CID,
                  SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM
             FROM CART A, PROD B
            WHERE B.PROD_ID = A.CART_PROD AND A.CART_NO LIKE '202005%'    
            GROUP BY A.CART_MEMBER
            ORDER BY 2 DESC)C, MEMBER D
     WHERE D.MEM_ID = C.CID 
      AND ROWNUM <=5;
      
**재고수불테이블 생성
 1) 테이블명 : REMAIN
 2) 컬럼
 -------------------------------------------------------------------------------------
 컬럼명             데이터타입           NOT NULL 여부         PK/FK          DEFAULT값     
--------------------------------------------------------------------------------------
REMAIN_YEAR         CHAR(4)                                  PK
PROD_ID             VARCHAR2(10)                             PK&FK
REMAIN_J_00         NUMNER(5)                                                   0      -- 기초 재고 한번 정해지면
REMAIN_J_I          NUMNER(5)                                                   0      -- 입고
REMAIN_J_O          NUMNER(5)                                                          -- 출고
REMAIN_J_99         NUMNER(5)                                                          -- 현재고 (입고 + 재고 - 출고)
REMAIN_DATE         DATE                                                               -- 데이터 변동이 되어진 날짜


    

 
 
 
 








