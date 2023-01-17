2022-1227-01) 기타연산자
1. IN 연산자 --'='가 내포되어 있음 / 검사할때 효율적 / >,< 쓸 수 없다.
    - 주어진 복수개의 값 중 어느 하나와 일치하면 전체 결과로 참(TRUE)을 반환
    - OR 연산자와 호환
    - =ANY, =SOME과 같은 기능 제공 -- '='가 내포되어 있지 않음 / >,< 쓸 수 있다.
 (사용형식)
    expr IN(값1[,값2,...])
     . 'expr' 값이 '값1',...'값n' 중 어느 하나와 일치하면 조건식 전체가 참이됨.
     . '값1[,값2,...]' 이 불연속적인 값인 경우 효율적
     
 (사용예) 사원테이블에서 10, 90, 110번 부서에 속한 사원들의 사원번호, 사원명, 입사일, 직무코드를 조회하시오.
    (OR 연산자 사용)
    select EMPLOYEE_ID AS 사원번호, 
           LAST_NAME AS 사원명, 
           HIRE_DATE AS 입사일, 
           DEPARTMENT_ID AS 부서코드,
           JOB_ID AS 직무코드
        from HR.EMPLOYEES
            WHERE DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 90 OR DEPARTMENT_ID = 110;
            
     (IN 연산자 사용)
    select EMPLOYEE_ID AS 사원번호, 
           LAST_NAME AS 사원명, 
           HIRE_DATE AS 입사일, 
           DEPARTMENT_ID AS 부서코드,
           JOB_ID AS 직무코드
        from HR.EMPLOYEES
            WHERE DEPARTMENT_ID IN(10,90,110);
            
     (=SOME, =ANY 연산자 사용)
    select EMPLOYEE_ID AS 사원번호, 
           LAST_NAME AS 사원명, 
           HIRE_DATE AS 입사일, 
           DEPARTMENT_ID AS 부서코드,
           JOB_ID AS 직무코드
        from HR.EMPLOYEES
            WHERE DEPARTMENT_ID =SOME(10,90,110);           
                  
 (사용예) 2020년 5월 구매액이 많은 5명의 회원번호, 회원명, 주소, 마일리지, 직업을 조회하시오.
  SELECT MEM_ID AS 회원번호, 
         MEM_NAME AS 회원명, 
         MEM_ADD1||' ' ||MEM_ADD2 AS 주소, 
         MEM_MILEAGE AS 마일리지, 
         MEM_JOB AS 직업
    FROM MEMBER
   WHERE MEM_ID IN(SELECT C.MID AS CMID
                     FROM(SELECT A.CART_MEMBER AS MID,
                                 SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
                             FROM CART A, PROD B
                            WHERE SUBSTR(A.CART_NO,1,6)='202005'
                            GROUP BY A.CART_MEMBER
                            ORDER BY 2 DESC) C
                      WHERE ROWNUM <=5);
                      
2. ANY(SOME) 연산자 -- 어느하나라도 만족하면 
 - IN 연산자와 유사하나 ANY(SOME)에는 '=' 기능이 없음.
 (사용형식)
    expr 관계연산자ANY(값1 [,값2, ...]) --<,>,...
    . 'expr' 값 중 어느 하나라도 ANY앞에 기술된 '관계연산자'를 만족하면 전체 결과로 참(TRUE)을 반환
    
 (사용예) 회원 중 직업이 '학생'인 회원들보다 적지 않은 마일리지를 보유한 회원들의 회원번호, 회원명, 직업, 마일리지를 조회하시오.
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_JOB AS 직업, 
           MEM_MILEAGE AS 마일리지
        FROM MEMBER
        WHERE MEM_MILEAGE > ANY(700,2200,2700) -- ALL을 사용하면 2700보다 큰 값들만..
        
3. ALL 연산자
 - ANY(SOME) 과 유사한 사용방법
 - 주어진 값을 모두 동시에 만족할 때 전체가 참이되는 연산자
 - ALL연산자와 '='연산자는 동시 사용될 수 없음
  (사용형식)
    expr ALL(값1[, 값2,...])
     . 'expr' 값이 모든 '값'과 ALL 앞에 기술된 관계연산자를 만족하면 참(TRUE)을 반환
     
  (사용예) 회원 중 직업이 '학생'인 회원들보다 적지 않은 마일리지를 보유한 회원들의 회원번호, 회원명, 직업, 마일리지를 조회하시오.
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_JOB AS 직업, 
           MEM_MILEAGE AS 마일리지
        FROM MEMBER
        WHERE MEM_MILEAGE > ALL(700,2200,2700)
        ORDER BY 4 ;
        
4. EXISTS 연산자
 - EXISTS 연산자는 반드시 서브쿼리와 같이 사용해야 함.
 
5. BETWEEN 연산자
 - 범위를 지정할 때 사용
 - 'AND' 연산자로 대신할 수 있음
 (사용형식)
    co1 BETWEEN 값1 AND 값2
    . 'co1'의 값이 '값1'부터 '값2' 사이의 값이면 참을 반환
    . '값1'과 '값2'는 같은 타입의 자료이어야 함.
    . 사용하는 자료는 오라클에서 허용하는 모든 자료타입
    
 (사용예) 사원테이블에서 40~70번 부서에 속한 사원정보 조회
         Alias는 사원번호, 사원명, 부서번호, 급여
(BETWEEN 연산자 사용)         
         select EMPLOYEE_ID AS 사원번호,
                LAST_NAME AS 사원명,
                DEPARTMENT_ID AS 부서번호,
                SALARY AS 급여
            FROM HR.EMPLOYEES
                WHERE DEPARTMENT_ID BETWEEN 40 AND 70
                ORDER BY 3;
                
(AND 연산자 사용)         
         select EMPLOYEE_ID AS 사원번호,
                LAST_NAME AS 사원명,
                DEPARTMENT_ID AS 부서번호,
                SALARY AS 급여
            FROM HR.EMPLOYEES
                WHERE DEPARTMENT_ID >=40 AND DEPARTMENT_ID <=70
                ORDER BY 3;                
             
 (사용예) 회원테이블에서 20대 ~ 40대 회원정보 조회
         Alias는 회원번호, 회원명, 나이, 마일리지
         나이순으로 출력하며 나이는 생년월일 컬럼으로 계산
         
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           EXTRACT (YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR)AS 나이, 
           MEM_MILEAGE AS 마일리지
        FROM MEMBER
        WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1) BETWEEN 20 AND 40    
        ORDER BY 3 ;
         
 (사용예) 매입테이블에서 2020년 2월 매입현황을 조회하시오.
         Alias는 일자, 상품코드, 매입수량, 단가, 금액
         SELECT *FROM BUYPROD;
         
    SELECT  BUY_DATE AS 일자, 
            BUY_PROD AS 상품코드, 
            BUY_QTY AS 매입수량, 
            BUY_COST AS 단가, 
            BUY_QTY * BUY_COST AS 금액
         FROM BUYPROD
        -- WHERE BUY_DATE BETWEEN '2020/02/01' AND '2020/02/29'
        WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201'));
        
6. LIKE 연산자
 - 패턴비교 연산
 - 패턴문자열(와일드카드)로 '%','_'가 사용
 (사용형식)
    expr LIKE '패턴문자열' -- expr은 반드시 문자열이어야 한다.
     . 문자열 비교 연산자
     . '%' : '%'가 사용된 위치의 문자열 이후의 모든 문자열과 대응
      ex) '김%' : '김'으로 시작하는 모든 문자열은 참의 결과를 반환
          '%김' : '김'으로 끝나는 모든 문자열과 대응
          '%김%' : 문자열 내부에 '김'이 있으면 참을 반환
          
     . '_' : '_'가 사용된 위치에서 한 글자와 대응
      ex) '김_' : '김'으로 시작하고 2글자인 문자열은 참(true)을 반환
          '_김' : '김'으로 끝나는 2글자의 문자열과 대응
          '_김_' : 문자열이 3글자로 구성되고 문자열 내부에 '김'이 있으면 참을 반환
          
 (사용예) 회원 중 '충남'에 거주하는 회원들의 정보를 조회하시오.
         Alias는 회원번호, 회원명, 주소, 마일리지
        select MEM_ID AS 회원번호, 
               MEM_NAME AS 회원명, 
               MEM_ADD1 AS 주소, 
               MEM_MILEAGE AS 마일리지 
            FROM MEMBER
             WHERE MEM_ADD1 LIKE '충남%';
         
         
 (사용예) 2020년 4월 매출현황을 조회하시오.
         Alias는 날짜, 상품코드, 매출수량
         
        SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS 날짜, 
               CART_PROD AS 상품코드, 
               CART_QTY AS 매출수량
            FROM CART
             WHERE CART_NO LIKE '202004%'
            

 (사용예) 2020년 4월 매입현황을 조회하시오.
         Alias는 날짜, 상품코드, 매입수량, 매입금액
                 
        SELECT BUY_DATE AS 날짜, 
               BUY_PROD AS 상품코드, 
               BUY_QTY AS 매입수량, 
               BUY_QTY * BUY_COST AS 매입금액
            FROM BUYPROD
            WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200430'); -- DATE는 LIKE 사용 X
    -- WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND LAST_DAY(TO_DATE('20200401')); -- DATE는 LIKE 사용 X
            

        

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            