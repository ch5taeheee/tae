2023-0103-01) NULL 처리함수
 - 오라클의 모든 타입의 기본 초기값은 NULL임
 - NULL값과 연산의 결과는 모두 NULL임
 - NULL 값을 처리하기 위한 함수 : NVL, NVL2, NULLIF 등이 제공
 
 1. NVL(co1,val)
    . 'col' 값이 NULL이면 'val'을 반환하고 NULL이 아니면 'col' 값을 반환
    . 'col'과 'val'의 자료 타입은 반드시 일치해야함. -- 다르면 오류 발생
    
사용예) 사원테이블에서 사원들의 보너스를 계산하고 지급액을 출력하시오. 
       보너스 = 본봉 * 영업실적의 50%
       지급액 = 본봉 + 보너스
       Alias는 사원번호, 사원명, 영업실적, 보너스, 지급액 
       
       SELECT EMPLOYEE_ID AS 사원번호,
              LAST_NAME AS 사원명,
              NVL(TO_CHAR(COMMISSION_PCT,'0.99'),'영업실적 없음') AS 영업실적,
              SALARY AS 본봉,
              ROUND(NVL((SALARY * COMMISSION_PCT *0.5),0))AS 보너스,
              SALARY + ROUND(NVL((SALARY * COMMISSION_PCT *0.5),0)) AS 지급액
          FROM HR.EMPLOYEES;
          
사용예) 2020년 7월 모든 상품별 판매수량합계, 판매금액합계를 조회하시오. --모든 OUTER JOIN
        SELECT B.PROD_ID AS 상품코드, 
               B.PROD_NAME AS 상품명, 
               NVL(SUM(A.CART_QTY),0) AS 수량합계, 
               NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS 금액합계 
          FROM CART A
          RIGHT OUTER JOIN PROD B ON(A.CART_PROD=B.PROD_ID AND A.CART_NO LIKE '202007%')
          GROUP BY B.PROD_ID,B.PROD_NAME
          ORDER BY 1;
          
2. NVL2(col,val1,val2)
    . 'col' 값이 NULL이면 val2를 반환하고, NULL이 아니면 val1을 반환함.
    . val1과 val2는 반드시 같은 타입이어야 함. 

사용예) 사원테이블에서 각 사원의 관리자(상사) 사원명을 출력하시오. 단, 관리자(상사) 사원번호가 NULL인 사원은 'CEO  사원' 이라고 출력하시오. 
        Alias는 사원번호, 사원명, 관리자 사원번호, 관리자 사원명
        
        SELECT EMPLOYEE_ID AS 사원번호, 
               LAST_NAME AS 사원명,
               MANAGER_ID AS 관리자사원번호,
               NVL2(MANAGER_ID, TO_CHAR(MANAGER_ID), 'CEO사원')  AS 관리자사원명
            FROM HR.EMPLOYEES;
            
사용예) 상품테이블에서 상품의 색상정보를 조회하여 색상정보가 있으면 'A 창고물품', 없으면 'C 창고물품'을 비고란에 출력하시오.
    SELECT PROD_ID, 
        PROD_NAME, 
        PROD_COLOR, 
        NVL2(PROD_COLOR,'A 창고물품' ,'C 창고물품') 
      FROM PROD;
      
***PROD테이블에서 분류코드가 'P301'에 속한 상품의 매출단가를 매입단가와 같도록 조정하시오. --거래판매중단
        UPDATE PROD 
          SET PROD_PRICE = PROD_COST
          WHERE UPPER(PROD_LGU) = 'P301'
          SELECT * FROM PROD;
          
 3. NULLIF(col1,col2)
  . 'col1'과 'col2'가 같은 값이면 NULL을 출력하고 다른 값이면 coll을 출력함.
  
(사용예) 상품테이블에서 매입단가와 매출단가가 동일하면 비고란에 '단종 예정 상품'을 출력하고 같지 않으면 '정상 상품'을 출력하시오.
        Alias는 상품코드, 상품명, 비고
        SELECT PROD_ID AS 상품코드,
               PROD_NAME AS 상품명,
               NVL(TO_CHAR(NULLIF(PROD_PRICE,PROD_COST),'9,999,999'),'단종예정상품') AS  비고
            FROM PROD;
        
        SELECT PROD_ID AS 상품코드,
               PROD_NAME AS 상품명,
               NVL2(TO_CHAR(NULLIF(PROD_PRICE,PROD_COST),'9,999,999'),'정상상품', '단종예정상품') AS  비고
            FROM PROD;
            
                
            
4. IS NULL과 IS NOT NULL
 - NULL값의 비교는 '=' 연산자로 판단할 수 없음.
 - 반드시 IS NULL, IN NOT NULL 연산자로 판단해야함.
 - 널 값인지 아닌지 비교할 때는
 
 사용예) 사원테이블에서 COMMISSION_PCT가 NULL이 아닌 사원수를 조회하시오.
    SELECT COUNT(*)
        FROM HR.EMPLOYEES
        WHERE COMMISSION_PCT IS NOT NULL;
       -- WHERE COMMISSION_PCT != NULL;
            


