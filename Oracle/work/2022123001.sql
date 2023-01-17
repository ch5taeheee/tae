2022-1230-01)날짜함수-

1. ADD MONTHS(d,n) -(**)
 - 주어진 날짜자료 d에 n개월을 더한 날짜 반환
 (사용예) HR계정의 입사일(HIRE_DATE)에 10년(120개월)을 더한 날짜로 변경하시오.
    UPDATE HR.EMPLOYEES
        SET HIRE_DATE = ADD_MONTHS(HIRE_DATE,120);
        
        SELECT * FROM HR.EMPLOYEES;
        
        COMMIT;
        
2. NEXT_DAY(d,c), LAST_DAY(d) - (***)
 - NEXT_DAY : 주어진 날짜 d로부터 다가올 'c'요일의 날짜 반환
    'c'는 '월요일', '월', '화요일', '화'...'일요일','일'등 요일 기술
 - LAST_DAY : 주어진 날짜 d에 포함된 월의 마지막 일자의 날짜를 반환
    주로 입력 받는 임의의 월의 마지막 일자나 3월의 마지막 일자를 구할 때 사용
 (사용예) 2020년 2월 상품별 매입집계를 조회하시오. 
    Alias는 상품코드, 매입수량합계, 매입금액합계
    SELECT BUY_PROD AS 상품코드, 
           SUM(BUY_QTY) AS 매입수량합계, 
           SUM(BUY_QTY * BUY_COST) AS 매입금액합계 
        FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201')) 
     GROUP BY BUY_PROD
     ORDER BY 1;
     
     SELECT NEXT_DAY(SYSDATE,'화요일'),
            NEXT_DAY(SYSDATE,'화'),
            NEXT_DAY(TO_DATE('19990813'),'화요일')
        FROM DUAL;
            
3. MONTHS_BETWEEN(d1,d2)
 - 두 날짜 d1과 d2 사이의 월수를 반환
 
 (사용예) 사원테이블에서 월까지 포함된 근속년수를 출력하시오.
        Alias는 사원번호, 사원명, 입사일, 근속년수 
     SELECT EMPLOYEE_ID AS 사원번호, 
            LAST_NAME AS 사원명,  
            HIRE_DATE AS 입사일, 
            ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) AS 개월수,
           TRUNC(ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))/12) ||'년'||
           MOD(ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)),12)||'월' AS 근속년수
     FROM HR.EMPLOYEES;
     
4. MONTHS(FMT FROM d1) -(****)
 - 날짜자료 d1에 포함된 fmt요소를 반환
 - fmt는 'YEAR','MONTH','DAY','HOUR','MINUTE','SECOND' 중 하나이며 반환되는 데이터는 숫자형임
 
 (사용예) 사원테이블에서 년도별 입사인원분포를 조회하시오.
        Alias는 년도, 입사사원수
        SELECT EXTRACT(YEAR FROM HIRE_DATE) AS 년도,    --카운트랑 일반함수 그룹 써야한다.
               COUNT(*) AS 입사사원수 
         FROM HR.EMPLOYEES
         GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
         ORDER BY 1;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
 
        