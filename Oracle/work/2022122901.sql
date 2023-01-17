2022-1229-01)숫자함수
1. ABS(n), SIGN(n), SQRT(n), POWER(n,b)
 - 수학적 연산결과를 반환
 - ABS : 절대값, SIGN : 데이터의 부호에 따라(-1,0,1) 반환,
 - SQRT : 평방근, POWER: n의 b승 값, 이 밖에도 삼각함수나 지수함수 등 여러가지가 지원됨.
 
 (사용예) SELECT ABS(-200),ABS(200), 
                SIGN(-19000), SIGN(0), SIGN(0.00001),
                SQRT(3.3), POWER(2,20)
                FROM DUAL;
                
2. GREATEST(n1,n2[,n3,...]), LEAST(n1,n2[,n3,...]) -- 행중에서  -- 맥스랑 미니멈은 열 중에서 
 - 주어진 값 중 가장 큰 값(GREATEST), 제일 작은 값(LEAST) 반환
 - GREATEST와 LEAST는 행으로(가로로) 나열된 값 중 가장 작은 값이고 MAX와 MIN은 하나의 열(종)에서 가장 큰 값 또는 작은 값을 반환
 
 (사용예)
    SELECT PROD_COST,
           PROD_PRICE,
           PROD_SALE,
           GREATEST(PROD_COST,PROD_PRICE, PROD_SALE),
           LEAST(PROD_COST,PROD_PRICE, PROD_SALE)
        FROM PROD;
        
    SELECT MAX(PROD_COST)
        FROM PROD;

    SELECT GREATEST('홍', 1200, '*' )FROM DUAL;
    
    SELECT ASCII('홍'),
           ASCII(1200),
           ASCII('*')
     FROM DUAL;
     
문제] 회원테이블에서 마일리지가 1000미만인 회원들의 마일리지는 1000으로 변경하시오.
      Alias는 회원번호, 회원명, 원본마일리지, 변경마일리지이다. 
      
      SELECT MEM_ID AS 회원번호, 
             MEM_NAME AS 회원명, 
             MEM_MILEAGE AS 원본마일리지, 
             GREATEST(MEM_MILEAGE,1000) AS 변경마일리지
        FROM MEMBER
        
2. ROUND(n,[,1]), TRUNC(n [,1]) - (****)
 - 반올림(ROUND)와 자리버림(TRUNC)을 수행
 - 주어진 수 n의 소숫점 이하 loc + 1번째 자리에서 반올림(자리버림)하여 loc번째 자리까지 표현
 - 1이 생략되면 0으로 간주함
 - 1이 음수이면 정수부분 해당위치(loc wk자리)에서 반올림(자리버림) 수행
 
 (사용예) 사원테이블에서 각 부서별 평균임금을 조회하시오.
         Alias 부서번호, 부서명, 평균임금이고 부서코드 순으로 출력하고 평균임금은 소수 2자리까지 나타내시오.
         
     SELECT A.DEPARTMENT_ID AS 부서번호,
            B.DEPARTMENT_NAME AS 부서명,
            ROUND(AVG(SALARY),2) AS 평균임금
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B              -- FROM 절에서 테이블의 별칭 / (테이블명 별칭 ) .은 SELECT나 WHERE절에서 
          WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID               -- 조인조건
          GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
          ORDER BY 1;
 
 (사용예) 회원테이블에서 회원들의 연령별 평균마일리지를 조회하시오. -- GROUP 쓰세요. 
         Alias는 연령대, 회원수, 평균마일리지이며 평균마일리지는 소숫점없이 절삭하여 출력하시오. 
         
         SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE) -EXTRACT(YEAR FROM MEM_BIR),-1)AS 연령대, 
                COUNT(*)AS 회원수, 
                TRUNC(AVG(MEM_MILEAGE)) AS 평균마일리지
            FROM MEMBER
                GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE) -EXTRACT(YEAR FROM MEM_BIR),-1)
                ORDER BY 1;
                
4. FLOOR(n), CEIL(n) -(**)
 - 가장 가까운 정수(인접수)를 반환
 - FLOOR : n과 같거나(n이 정수인 경우) 작은 수 중 가장 큰 정수 반환
 - CEIL : n과 같거나(n이 정수인 경우) 큰 수 중 가장 작은 정수 반환
 - 급여나 세금과 같은 통화에 주로 사용
 
(사용예) 
    SELECT FLOOR(10),FLOOR(10.5), FLOOR(-10.5), 
           CEIL(10), CEIL(10.5), CEIL(-10.5)
        FROM DUAL;
        
5. MOD(n1, n2) -(***) , REMAINDER(n1,n2) -(*)
 - 나머지를 반환
 - 나머지를 구하는 내부 알고리즘이 다름
 - MOD(n1,n2) : n1 - n3*FLOOR(n1/n2)
   REMAINDER(n1,n2) : n1 - n3*ROUND(n1/n2)
 - ex)
    MOD(22,4) = 22 - 4 * FLOOR(22/4)
                22 - 4 * FLOOR(5.5)
                22 - 4 * 5
                = 2
    REMAINDER(22,4) : 22 - 4 * ROUND(22/4)
                      22 - 4 * ROUND(5.5)
                      22 - 24
                      = -2
    MOD(21,4) :  22 - 4 * FLOOR (21/4)
                 22 - 4 * FLOOR(5.25) 
                 21 - 4 * 5
                 => 1
    REMAINDER(21,4) : 21 - 4 * ROUND(21/4) --0.5를 넘어서지 않으면 MOD랑 똑같음 / 짝수, 홀수, 배수 , 윤년, 평년
                      21 - 4 * 5
                      => 1
 
 (사용예) 서시 1년 1월 1일 부터 오늘까지 경과된 일수
     SELECT CASE WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=0 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'일은 일요일'
                 WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=1 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'일은 월요일'
                 WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=2 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'일은 화요일'
                 WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=3 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'일은 수요일'
                 WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=4 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'일은 목요일'
                 WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=5 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'일은 금요일'
                 WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=6 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'일은 토요일'
            END AS 요일
        FROM DUAL;
        
       SYSDATE
       
6. WIDTH_BUCKET(n, min, max, b) - (**) 
 - min에서 max 까지를 b개의 구간으로 분할하고 n이 그 구간 중 어느 구간에 속하는지 반환
 - 만약 n이 각 구간의 상한값과 같은 값이면 n은 그 다음 구간에 속한 값으로 간주
   즉, 구간 하한값 <= n < 구간 상한값인 구간의 순번을 반환
 - n이 MIN보다 작으면 0구간, MAX보다 크거나 같으면 B+1구간을 반환

 (사용예) 회원테이블에서 마일리지 1000~8000을 3개의 구간으로 나누고 각 회원들의 구간 값을 조회하시오. 
         Alias는 회원번호, 회원명, 마일리지, 구간값
         
         SELECT MEM_ID AS 회원번호,
                MEM_NAME AS 회원명,
                MEM_MILEAGE AS 마일리지,
                WIDTH_BUCKET(MEM_MILEAGE,1000,8700,3) AS 구간값
            FROM MEMBER;
            
            숙제) 가장 많은 마일리지가 1등급 적은 마일리지가 3등급
            
                SELECT MEM_ID AS 회원번호,
                MEM_NAME AS 회원명,
                MEM_MILEAGE AS 마일리지,
                5- WIDTH_BUCKET(MEM_MILEAGE,1000,8700,3) AS 구간값
            FROM MEMBER;
        
        
            
            
            
      

     
     
    