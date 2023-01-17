2023-0103-02)테이블 조인(JOIN)
 - 관계형 데이터베이스의 테이블은 최소한의 데이터만 저장
 - 여러 정보가 필요한 경우 복수개의 테이블로부터 정보를 추출해야하고 이를 수행하기 위하여 테이블 사이에 관계가 형성되어야 함. 
 - 이렇게 형성된 관계를 활용하여 필요한 정보를 복수개의 테이블에서 추출하는 연산이 JOIN임.
 - 조인의 종류
    . 사용되는 연산자에 따라 : 동등조인(=)과 비동등 조인
    . 조인조건에 따라 : 내부조인(조인조건을 만족하는 조건만 출력, 조건 만족하지 않은 것은 무시.), 
                      외부조인(OUTER 조인: 조인조건을 만족하지 않는 조건을 기준), 
                      카타시안 조인(CROSS조인, 조인조건이 완전히 생략되어진 경우, 잘못 기술한 경우)
    . 조인 대상에 따라 : 셀프조인 (별칭부여해서 조인,한 테이블에 별칭이 다르면 서로 다른 테이블로 구분)
    . 기타 : ANSI 조인
    
1. Cartesian Product(Cross Join)
  - 조인조건이 없거나 조인조건이 잘못된 경우
  - 반드시 필요한 경우가 아니면 수행해서는 안 됨.
  - 최악의 경우 조인에 참여하는 테이블에 행들은 곱해지고 열들은 더해지는 만큼의 결과가 나온다.(최대한 지양)
  
(일반 사용형식)
    SELECT 컬럼list -- 컬럼리스트는 ,로 
      FROM 테이블명1 [별칭1],테이블명2 [별칭2][,테이블명3 [별칭3],...] --아주 쉬운 글자, 단어를 사용해라. 대부분 알파벳
      --(.) 참조연산자는 SELECT나 WHERE에서 사용, FROM은 테이블을 선언하는 거니 . 사용하는 거 아님.
      
 (ANSI CROSS JOIN) -- ANSI 는 FROM 절에서 테이블은 딱 하나 나옴.
     SELECT 컬럼list
      FROM 테이블명1 [별칭1]
       CROSS JOIN 테이블명2 [별칭2]
       
 
 SELECT COUNT(*)
  FROM BUYPROD, CART, PROD;
  
 SELECT COUNT(*)
  FROM BUYPROD
    CROSS JOIN CART
    CROSS JOIN PROD;
    
2. 내부조인
  - 조인조건을 만족하는 자료만 연산에 참여하고 만족하지 않는 자료는 무시함.
  
 (일반조인형식)
    SELECT 컬럼list
      FROM 테이블명1 [별칭1], 테이블명2 [별칭2] [,테이블명3 [별칭3],...]
     WHERE 조인조건1
       [AND 조인조건2]
            :
       [AND 일반조건] 
 . 사용된 테이블이 n개일 때 조인조건은 최소 n-1개 이상이어야 함. -- 순서는 상관x, 개수는 최소 n -1 
       
 (ANSI조인형식)
    SELECT 컬럼list
      FROM 테이블명1 [별칭1]
       INNER JOIN 테이블명2 [별칭2] ON(조인조건1 [AND 일반조건])
       INNER JOIN 테이블명3 [별칭3] ON(조인조건2 [AND 일반조건]) --3은 1,2의 결과와 조인되어짐.
            :
       [WHERE 일반조건n]
        . '테이블명1'과 '테이블명2'는 반드시 직접 조인 가능해야함
        . '일반조건1'은 테이블명2에 관련된 조건
        . WHERE 절의 일반조건은 모든 테이블에 영향을 미치는 조건이어야 함.
        . 두 번째 INNER JOIN절 부터는 위의 조인 결과와 조인이 수행됨.
        
사용예) 2020년 6월 제품별 매입집계를 조회하시오.
        Alias는 상품번호, 상품명, 매입수량, 매입금액이며 매입단가는 PROD 테이블의 단가를 활용한다.
        
(일반조인) SELECT B.PROD_ID AS 상품번호, 
                 B.PROD_NAME AS 상품명, 
                 SUM(A.BUY_QTY) AS 매입수량, 
                 SUM(A.BUY_QTY * B.PROD_COST) AS 매입금액
            FROM BUYPROD A, PROD B
            WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630') --일반조건
                AND A.BUY_PROD = B.PROD_ID -- 조인조건
            GROUP BY B.PROD_ID,B.PROD_NAME
            ORDER BY 1;
            
(ANSI조인)
        1.  SELECT B.PROD_ID AS 상품번호, 
                 B.PROD_NAME AS 상품명, 
                 SUM(A.BUY_QTY) AS 매입수량, 
                 SUM(A.BUY_QTY * B.PROD_COST) AS 매입금액
            FROM BUYPROD A
            INNER JOIN PROD B ON (A.BUY_PROD=B.PROD_ID AND
                A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'))
            GROUP BY B.PROD_ID,B.PROD_NAME
            ORDER BY 1;
            
            
        2.  SELECT B.PROD_ID AS 상품번호, 
                 B.PROD_NAME AS 상품명, 
                 SUM(A.BUY_QTY) AS 매입수량, 
                 SUM(A.BUY_QTY * B.PROD_COST) AS 매입금액
            FROM BUYPROD A
            INNER JOIN PROD B ON (A.BUY_PROD=B.PROD_ID )
                WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
            GROUP BY B.PROD_ID,B.PROD_NAME
            ORDER BY 1;
        
        
(사용예) 분류코드가 'P302'인 제품정보를 조회하시오.
        Alias는 상품번호, 상품명, 분류코드, 분류명, 거래처명
        
       1. SELECT A.PROD_ID AS 상품번호,
               A.PROD_NAME AS 상품명,
               A.PROD_LGU AS 분류코드,
               B.LPROD_NM AS 분류명,
               C.BUYER_NAME AS 거래처명
            FROM PROD A,LPROD B, BUYER C
            WHERE A.PROD_LGU = 'P302' AND A.PROD_LGU =B.LPROD_GU AND A.PROD_BUYER = C.BUYER_ID
            
 --  1. SELECT A.PROD_ID AS 상품번호,
               A.PROD_NAME AS 상품명,
               A.PROD_LGU AS 분류코드,
               B.LPROD_NM AS 분류명,
               C.BUYER_NAME AS 거래처명
            FROM PROD A,LPROD B, BUYER C
            WHERE A.PROD_LGU = 'P302' --일반조건
                AND A.PROD_LGU =B.LPROD_GU --조인 조건
                AND A.PROD_BUYER = C.BUYER_ID            
               
       2.  SELECT A.PROD_ID AS 상품번호,
               A. PROD_NAME AS 상품명,
               A.PROD_LGU AS 분류코드,
               B.LPROD_NM AS 분류명,
               C.BUYER_NAME AS 거래처명
            FROM PROD A
            INNER JOIN LPROD B ON(A.PROD_LGU=B.LPROD_GU)
            INNER JOIN BUYER C ON(A.PROD_BUYER = C.BUYER_ID)
            WHERE A.PROD_LGU = 'P302'
            
            
 (사용예) 2020년 상반기 제품별 매출현황을 조회하시오.
        Alias는 상품코드, 상품명, 매출수량합계, 매출금액합계
        
   1.     SELECT A.PROD_ID AS 상품코드,
               A.PROD_NAME AS 상품명, 
               SUM(B.CART_QTY) AS 매출수량합계,
               SUM(B.CART_QTY * A.PROD_COST)AS 매출금액합계
        FROM PROD A, CART B 
            WHERE A.PROD_ID = B.CART_PROD AND SUBSTR(B.CART_NO,1,8) BETWEEN '20200101' AND '20200630'
            GROUP BY A.PROD_ID, A.PROD_NAME
            ORDER BY 1;
            
   2.    SELECT A.PROD_ID AS 상품코드,
               A.PROD_NAME AS 상품명, 
               SUM(B.CART_QTY) AS 매출수량합계,
               SUM(B.CART_QTY * A.PROD_COST)AS 매출금액합계
        FROM PROD A
        INNER JOIN CART B ON(A.PROD_ID = B.CART_PROD)
         WHERE A.PROD_ID = B.CART_PROD AND SUBSTR(B.CART_NO,1,8) BETWEEN '20200101' AND '20200630'
            GROUP BY A.PROD_ID, A.PROD_NAME
            ORDER BY 1;
        
                      
 (사용예) 2020년 상반기 거래처별 매출액집계를 조회하시오.
         Alias는 거래처코드, 거래처명, 매출금액합계
         
 1.       SELECT A.BUYER_ID AS 거래처코드,
               A.BUYER_NAME AS 거래처명,
               SUM(C.CART_QTY * B.PROD_PRICE) AS 매출금액합계
          FROM BUYER A, PROD B, CART C
            WHERE B.PROD_BUYER = A.BUYER_ID AND C.CART_PROD = B.PROD_ID
            AND SUBSTR(C.CART_NO,1,8) BETWEEN '20200101' AND '20200630'
            GROUP BY A.BUYER_NAME,A.BUYER_ID
            ORDER BY 1;
            
 2.       SELECT A.BUYER_ID AS 거래처코드,
               A.BUYER_NAME AS 거래처명,
               SUM(C.CART_QTY * B.PROD_PRICE) AS 매출금액합계
           FROM BUYER A
             INNER JOIN PROD B ON (B.PROD_BUYER = A.BUYER_ID)
             INNER JOIN CART C ON (C.CART_PROD = B.PROD_ID)
                        AND SUBSTR(C.CART_NO,1,8) BETWEEN '20200101' AND '20200630'
                 GROUP BY A.BUYER_NAME,A.BUYER_ID
                 ORDER BY 1;
           
                    
사용예) HR계정에서 미국 이외의 부서에 근무하는 사원을 조회하시오.
      Alias는 사원번호, 사원명, 부서명, 주소, 직무명
      주소는 거리명 도시명 주명 국가코드 순으로 출력하시오.
      
 1.     SELECT A.EMPLOYEE_ID AS 사원번호,
             A.LAST_NAME AS 사원명,
             B.DEPARTMENT_ID AS 부서명,
             C.STREET_ADDRESS ||' '|| C.CITY ||' '|| C.STATE_PROVINCE ||' '|| C.COUNTRY_ID AS 주소,
             B.DEPARTMENT_NAME AS 직무명
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.JOBS D
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID AND  B.LOCATION_ID = C.LOCATION_ID AND A.JOB_ID = D.JOB_ID
            AND  C.COUNTRY_ID != 'US'
            ORDER BY B.DEPARTMENT_ID;
            
            
2.     SELECT A.EMPLOYEE_ID AS 사원번호,
             A.LAST_NAME AS 사원명,
             B.DEPARTMENT_ID AS 부서명,
             C.STREET_ADDRESS ||' '|| C.CITY ||' '|| C.STATE_PROVINCE ||' '|| C.COUNTRY_ID AS 주소,
             B.DEPARTMENT_NAME AS 직무명
        FROM HR.EMPLOYEES A
         INNER JOIN HR.DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
         INNER JOIN HR.LOCATIONS C ON (B.LOCATION_ID = C.LOCATION_ID)
         INNER JOIN HR.JOBS D ON (A.JOB_ID = D.JOB_ID)
                    AND  NOT C.COUNTRY_ID = 'US' -- C.COUNTRY_ID <> 'US'
                    
3. 셀프조인
  - 동일한 테이블에 서로 다른 별칭을 부여하여 수행하는 조인 -- 서로 다른 별칭, 서로 다른 테이블로 간주.
  
(사용예) 신용환 회원의 마일리지보다 많은 마일리지를 보유한 회원들의 회원번호, 회원명, 마일리지를 조회하시오. 
        SELECT B.MEM_ID AS 회원번호, 
               B.MEM_NAME AS 회원명, 
               B.MEM_MILEAGE AS 마일리지
         FROM MEMBER A,MEMBER B
          WHERE A.MEM_NAME = '신용환' AND A.MEM_MILEAGE <= B.MEM_MILEAGE

 
  
                    
                    

                    


 
               
               
      
     
        
        
        
        
 