2022-1223-01) 검색명령(SELECT)
 - 자료 조회기능 제공  
 (사용 형식)
    SELECT [DISTINCT] * | 컬럼명 [AS 별칭][,] 
            컬럼명 [AS 별칭][,]
             :
            컬럼명 [AS 별칭]
        FROM 테이블명 
       [WHERE 조건] -- select as별칭을 쓰지 X
       [ORDER BY 컬럼명|컬럼INDEX [ASC|DESC],...]; -- 컬럼이 n개인 경우 숫자로 표시 가능 ex) order by 1 , 
       . 'DISTINCT' : 중복 값 배제  -- 대표 컬럼 1개만
       . 필수 절은 SELECT절과 FROM절
       . !실행되는 순서 : FROM 절 -> WHERE 절 ->  ORDER BY 절 -> SELECT 절  -- 출력할 행 : WHERE
       .'컬럼INDEX' : SELECT절에서 컬럼이 기술된 순번
       .'ASC|DESC' : 정렬 방식( ASC : 오름차순 : 작은 값 -> 큰 값 순)
                             ( DESC : 내림차순 : 큰 값 -> 작은 값 순)
                     생략되면 ASC로 간주됨.
       . FROM 절에는 테이블이나 VIEW가 기술되어야 함. -- 두개 이상 오면 JOIN : 테이블에 원하는 자료가 다른 테이블에 있을 때
       
  (사용 예)
    SELECT A.MEM_ID AS 회원번호, A.MEM_NAME AS 회원명, A.MEM_MILEAGE AS 마일리지 --. : 소속을 나타내는 소속 연산자.
      FROM (SELECT MEM_ID , MEM_NAME, MEM_MILEAGE
                FROM MEMBER
              WHERE MEM_ADD1 LIKE '충남%' -- AND ROWNUM =1 을 여기다 적으면 26행
              ORDER BY 3 DESC) A 
      WHERE ROWNUM = 1; -- 가로 안에 넣으면 실행은 되는데 결과가 다르게 나옴
       
       -- SELECT A.M1 AS 회원번호, A.M2 AS 회원명, A.M3 AS 마일리지 --. : 소속을 나타내는 소속 연산자.
       -- FROM (SELECT MEM_ID AS M1 , MEM_NAME, MEM_MILEAGE
       
연산자
 - 산술연산자, 관계연산자, 논리연산자, 기타연산자 --나머지 연산자 X
 1) 산술연산자
  . 4칙연산을 수행하는 연산자(+, -, /,*)
  . 나머진 연산은 함수로 제공됨.
  
  (사용 예) 사원테이블에서 사원들의 영업실적(COMMISSION_PCT)에 따른 보너스를 계산하여 지급액을 조회하시오.
           보너스 = 영업실적코드 * 기본급
           지급액 = 기본급(SALARY) + 보너스
           Alias(별칭)는 사원번호, 사원명, 부서번호, 기본급, 보너스, 지급액이며 부서번호 순으로 출력/하되 같은 부서이면 지급액이 많은 사원순으로 출력
           
           SELECT EMPLOYEE_ID AS 사원번호, 
                  LAST_NAME AS 사원명, 
                  DEPARTMENT_ID AS 부서번호, 
                  SALARY AS 기본급, 
                  SALARY * COMMISSION_PCT AS 보너스, 
                  SALARY + (SALARY * COMMISSION_PCT) AS 지급액 
            FROM HR.EMPLOYEES ORDER BY 3; --  널 값과 연산되면 결과는 널 , 영업실적은 영업부만..
            
            SELECT EMPLOYEE_ID AS 사원번호, 
                  LAST_NAME AS 사원명, 
                  DEPARTMENT_ID AS 부서번호, 
                  SALARY AS 기본급, 
                  NVL(SALARY * COMMISSION_PCT,0) AS 보너스,
                  SALARY + NVL(SALARY * COMMISSION_PCT,0) AS 지급액 
            FROM HR.EMPLOYEES ORDER BY 3,6 DESC; --SALARY + NVL(SALARY * COMMISSION_PCT)) DESC;
 
 2) 관계 연산자
  . 자료 값의 크기를 비교하여 참(true)과 거짓(false)의 결과값을 반환
  . > , < , = , <= , >= , !=(<>) (><(X))
  . 주로 조건식에 사용됨
  
  
 (사용 예) 회원테이블에서 마일리지가 2000 이상인 회원정보를 조회하시오.
          Alias 는 회원번호, 회원명, 직업, 마일리지
          
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_JOB AS 직업, 
           MEM_MILEAGE AS 마일리지 
        FROM MEMBER 
            WHERE MEM_MILEAGE >= 2000
                ORDER BY 4 DESC;
          
 (사용 예) 회원테이블에서 여성회원정보를 조회하시오
          Alias 는 회원번호, 회원명, 주소, 마일리지
          
     SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_ADD1||' '||MEM_ADD2 AS 주소, 
           MEM_MILEAGE AS 마일리지 
        FROM MEMBER 
            WHERE SUBSTR(MEM_REGNO2,1,1)= '2' OR SUBSTR(MEM_REGNO2,1,1)= '4';
           
 (사용 예) 회원테이블에서 대전에 거주하는 여성회원정보를 조회하시오
          Alias 는 회원번호, 회원명, 주소, 마일리지
          
        SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_ADD1||' '||MEM_ADD2 AS 주소, 
           MEM_MILEAGE AS 마일리지 
        FROM MEMBER 
            WHERE MEM_ADD1 LIKE '대전%' 
            AND (SUBSTR(MEM_REGNO2,1,1)= '2' OR SUBSTR(MEM_REGNO2,1,1)= '4');
            
          
 (사용 예) 상품테이블에서 판매가가 50만원 이상인 상품들을 조회하시오  
          Alias 는 상품코드, 상품명, 분류코드, 판매가격
          
          SELECT * FROM PROD;
          
        SELECT PROD_ID AS 상품코드, 
           PROD_NAME AS 상품명, 
           PROD_LGU AS 분류코드, 
           PROD_PRICE AS 판매가격
        FROM PROD 
            WHERE PROD_PRICE >=500000 ;
          
          
 (사용 예) HR계정의 사원테이블에서 80번 부서에 속한 사원 정보를 조회하시오.
          Alias 는 사원번호, 사원명, 부서코드, 직무코드
        
        SELECT * FROM HR.EMPLOYEES;
          
        SELECT EMPLOYEE_ID AS 사원번호,
               LAST_NAME AS 사원명,
               DEPARTMENT_ID AS 부서코드,
               JOB_ID AS 직무코드
        FROM HR.EMPLOYEES
            WHERE DEPARTMENT_ID = 80;
            
            
 (사용 예) HR계정의 사원테이블에서 80번 부서에 속한 사원 중 근속년수가 15년 이상인 사원정보를 조회하시오.
          Alias 는 사원번호, 사원명, 입사일, 근속년수, 직무코드
          
          SELECT * FROM HR.EMPLOYEES;
          
           SELECT EMPLOYEE_ID AS 사원번호,
               LAST_NAME AS 사원명,
               HIRE_DATE AS 입사일,
               EXTRACT (YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS 근속년수,
               JOB_ID AS 부서코드,
               DEPARTMENT_ID AS 직무코드
        FROM HR.EMPLOYEES
            WHERE DEPARTMENT_ID = 80 
            AND (EXTRACT (YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)) >= 15;
            
 (사용 예) 회원테이블에서 회원이 보유한 마일리지가 
          0 ~ 3000 : '일반회원'
          3001 ~ 6000 : '우수회원'
          6001 이상 : 'VIP회원'  
          을 비고난에 출력하시오.
          Alias는 회원번호, 회원명, 마일리지, 비고
          
          select * from MEMBER;
          
        SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_MILEAGE AS 마일리지,
            CASE WHEN MEM_MILEAGE <= 3000 THEN
                      '일반회원'
                 WHEN MEM_MILEAGE <=6000 THEN
                      '우수회원'
                 ELSE 'VIP회원'
             END AS 비고
            FROM MEMBER ;
            
            
            
            
            
            
**표현식 CASE WHEN ~ THEN 사용
  . SELECT절에서만 사용
  . 
 (사용형식 -1)
  CASE WHEN 조건식1 THEN
            명령문1;
       WHEN 조건식2 THEN
            명령문2;
              :   
       ELSE 명령문n;
  END
  
  (사용형식 -2)
  CASE 조건식 WHEN 값1 THEN
             명령문1;
             WHEN 값2 THEN
             명령문2;
              :   
             ELSE 명령문n;
  END
  
  
 3) 논리 연산자
  . 복수개의 관계연산을 결합할 때 사용
  . NOT, AND, OR 사용
  
 (사용 예) 키보드로 임의의 년도를 입력받아 사용 해당년도가 윤년인지, 평년인지를 판단하시오.
 
  ACCEPT P_YEAR PROMPT '년도 입력 : ' 
  DECLARE
    L_YEAR NUMBER(4):='&P_YEAR';
    L_RES VARCHAR2(200);
  BEGIN
   IF (MOD(L_YEAR,4)=0 AND MOD(L_YEAR,100)!=0) OR MOD(L_YEAR,400)=0 THEN 
         L_RES:=L_YEAR||'년도는 윤년입니다.';
   ELSE 
         L_RES:=L_YEAR||'년도는 평년입니다.';
   END IF;
   DBMS_OUTPUT.PUT_LINE(L_RES);
  END;
  
  (사용 예) 회원테이블에서 20대이면서 마일리지가 3000이상인 회원의 회원번호, 회원명, 연령, 마일리지를 조회하시오.
           (나이는 주민등록번호를 사용할 것)
  
  SELECT * FROM MEMBER;
           
           
     SELECT MEM_ID AS 회원번호,
            MEM_NAME AS 회원명,
            MEM_REGNO1 AS 주민번호1,
        CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','2') THEN
              EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900)
        ELSE
              EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000)
        END AS 연령,
            MEM_MILEAGE AS 마일리지
        FROM MEMBER
            WHERE TRUNC(CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','2') THEN
                EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900)
            ELSE
                EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000)
              END,-1) = 20
        AND MEM_MILEAGE>=3000;
        
        
         SELECT MEM_ID AS 회원번호,
                MEM_NAME AS 회원명,
           CASE WHEN (SUBSTR(MEM_REGNO2, 1, 1)) IN('1','2') THEN 
                   EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER (SUBSTR(MEM_REGNO1, 1, 2) + 1900))
           ELSE 
                   EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER (SUBSTR(MEM_REGNO1, 1, 2) + 2000))
           END AS 연령,
                MEM_MILEAGE AS 마일리지
           FROM MEMBER
            WHERE trunc(CASE WHEN (SUBSTR(MEM_REGNO2, 1, 1)) IN('1','2') THEN 
                   EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER (SUBSTR(MEM_REGNO1, 1, 2) + 1900))
                 ELSE 
                   EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER (SUBSTR(MEM_REGNO1, 1, 2) + 2000))
                 END, -1) = 20
            AND MEM_MILEAGE >= 3000;
           
  
  
 
 
 
 
 
 

           



 
 
 
 
 
 
 
 