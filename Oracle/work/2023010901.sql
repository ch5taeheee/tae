2023-0109-01)
**서브쿼리를 이용한 테이블 생성
 - 기존의 테이블을 복사하여 구조와 데이터만 복사 --컬럼과 데이터만 복사됨.
 - 제약조건은 복사되지 않음.(NULL 속성은 복사)
 - 단순 백업 또는 테이블 수정 등의 용도로 사용
 
(사용형식)
    CREATE TABLE 테이블명 [(컬럼 list)] --(컬럼리스트 생략 가능) 컬럼 LIST : 새롭게 사용되어질 컬럼명 = 서브쿼리의 SELECT 절과 똑같아야 함. 컬럼의 개수가 일치해야 함. 서브쿼리는 가로 안 붙인다.(INSERT문도)
    AS 
      서브쿼리;
    
    . 서브쿼리의 결과가 '테이블'로 생성됨.
    --식별자 관계는 직선, 비식별 관계는 점선, 자식이 갈고리 모양
    
 (사용예) 재고수불테이블의 2020년 자료를 검색하여 T_REMAIN 테이블로 생성하시오. 
    CREATE TABLE T_REMAIN
    AS
      SELECT REMAIN_YEAR,PROD_ID, REMAIN_J_00,REMAIN_I,REMAIN_O,REMAIN_J_99
      FROM REMAIN
      WHERE REMAIN_YEAR = '2020'
      ORDER BY PROD_ID;
      
**집합연산자 
 - 조회(SELECT문)의 결과를 대상으로 연산하는 연산자 --SELECT의 결과를 VIEW, 커서 라고 함. 
 - UNION, UNION ALL(합집합),INTERSECT(교집합), MINUS(차집합) 제공 --(차집합 : A-B / B-A) / 조인을 줄일 수 있대~ / (UNION : 중복을 배제한 합집합, 중복된 부분이 한번만 )
 - 각각 사용되는 SELECT문의 컬럼의 갯수와 타입이 일치해야함.
 - ORDER BY절은 맨 마지막 SELECT문에만 사용가능
 - BLOB, CLOB, BFILE, LONG 타입은 집합연산에 사용할 수 없음.
 
 -- 컬럼의 제목이 전체의 제목?
 
 1) UNION
 - 중복이 배제된 합집합의 결과를 반환 
 
 (사용예) 회원테이블에서 직업이 '자영업'인 회원과 여성회원의 회원번호, 회원명, 마일리지를 조회하시오. 
 
 (직업이 자영업인 회원)
 SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_MILEAGE AS 마일리지
   FROM MEMBER
  WHERE MEM_JOB = '자영업' 
  UNION
 -- (여성회원)
 SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_MILEAGE AS 마일리지
   FROM MEMBER
  WHERE SUBSTR(MEM_REGNO2,1,1) IN ('2','4')
  
 --  SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_MILEAGE AS 마일리지
 --  FROM MEMBER
 --  WHERE SUBSTR(MEM_REGNO2,1,1)='2' AND SUBSTR(MEM_REGNO2,1,1)='4'
 
  SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_MILEAGE AS 마일리지
   FROM MEMBER
  WHERE MEM_JOB = '자영업' 
  UNION ALL
 SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_MILEAGE AS 마일리지
   FROM MEMBER
  WHERE SUBSTR(MEM_REGNO2,1,1) IN ('2','4')
  ORDER BY 1;
  
 (사용예) 2020년 4월 제품별 매입수량집계와 매출수량집계를 구해보자. 
        출력 : 상품번호, 상품명, 매입수량집계, 매출수량집계
 (2020년 4월 제품별 매입수량집계)
 
    SELECT A.BUY_PROD AS 상품번호,
           B.PROD_NAME AS 상품명,
           SUM(A.BUY_QTY) AS 수량집계
        FROM BUYPROD A, PROD B
       WHERE A.BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200430')
            AND A.BUY_PROD = B.PROD_ID
       GROUP BY A.BUY_PROD, B.PROD_NAME
       
       SELECT TA.A1 AS 상품코드,
              TA.A2 AS 상품명,
              TA.A3 AS 매입수량,
              0 AS 매출수량 --매출수량 없으니까 0으로 놈.
           FROM ( SELECT A.BUY_PROD AS A1,
                         B.PROD_NAME AS A2,
                         SUM(A.BUY_QTY) AS A3
                    FROM BUYPROD A, PROD B
                    WHERE A.BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200430')
                    AND A.BUY_PROD = B.PROD_ID
                    GROUP BY A.BUY_PROD, B.PROD_NAME
       
  
 (2020년 4월 제품별 매출수량집계)
    SELECT A.CART_PROD AS 상품번호,
           B.PROD_NAME AS 상품명,
           SUM(A.CART_QTY) AS 수량집계
        FROM CART A, PROD B
       WHERE A.CART_NO LIKE '202004%'
            AND A.CART_PROD = B.PROD_ID
       GROUP BY A.CART_PROD, B.PROD_NAME


       SELECT TA.A1 AS 상품코드,
              TA.A2 AS 상품명,
              TA.A3 AS 매입수량,
              0 AS 매출수량 --매출수량 없으니까 0으로 놈.
           FROM ( SELECT A.BUY_PROD AS A1,
                         B.PROD_NAME AS A2,
                         SUM(A.BUY_QTY) AS A3
                    FROM BUYPROD A, PROD B
                    WHERE A.BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200430')
                    AND A.BUY_PROD = B.PROD_ID
                    GROUP BY A.BUY_PROD, B.PROD_NAME )TA
    UNION 
        SELECT TB.B1 AS 상품코드,
               TB.B2 AS 상품명,
               0 AS 매입수량,
               TB.B3 AS 매출수량
           FROM (SELECT A.CART_PROD AS B1,
                        B.PROD_NAME AS B2,
                        SUM(A.CART_QTY) AS B3
                        FROM CART A, PROD B
                         WHERE A.CART_NO LIKE '202004%'
                        AND A.CART_PROD = B.PROD_ID
                        GROUP BY A.CART_PROD, B.PROD_NAME )TB
 
 3) INTERSECT(교집합)
  - 복수개의 SELECT문의 결과 중 교차부분(중복)만 반환하는 연산자
  
 (사용예) 장바구니테이블에서 2020년 4월, 2020년 5월, 2020년 6월 모두 판매된 상품의 상품번호, 상품명, 분류명을 출력하시오. -- 판매수량은 안 된다. 
   --별칭은 필요X 첫번째 사용
 SELECT DISTINCT A.CART_PROD AS 상품번호, 
        B.PROD_NAME AS 상품명, 
        C.LPROD_NM AS 분류명
   FROM CART A, PROD B, LPROD C
  WHERE A.CART_PROD = B.PROD_ID AND B.PROD_LGU = C.LPROD_GU
        AND A.CART_NO LIKE '202004%'
INTERSECT     
 SELECT DISTINCT A.CART_PROD ,
        B.PROD_NAME, 
        C.LPROD_NM 
   FROM CART A, PROD B, LPROD C
  WHERE A.CART_PROD = B.PROD_ID AND B.PROD_LGU = C.LPROD_GU
        AND A.CART_NO LIKE '202005%'
 INTERSECT       
 SELECT DISTINCT A.CART_PROD, 
        B.PROD_NAME , 
        C.LPROD_NM
   FROM CART A, PROD B, LPROD C
  WHERE A.CART_PROD = B.PROD_ID AND B.PROD_LGU = C.LPROD_GU
        AND A.CART_NO LIKE '202006%'
  ORDER BY 1;
  
  => EXISTS 연산자 -- 무조건 서브쿼리
  
SELECT DISTINCT A.CART_PROD AS 상품번호, 
        B.PROD_NAME AS 상품명, 
        C.LPROD_NM AS 분류명
   FROM CART A, PROD B, LPROD C
  WHERE A.CART_PROD = B.PROD_ID AND B.PROD_LGU = C.LPROD_GU
        AND A.CART_NO LIKE '202004%'
AND EXISTS( SELECT 1 -- WHERE 존재하면 참 (1), 거짓 (0) 1이 출력되면 행이 출력됨
                   FROM CART D
                   WHERE D.CART_PROD = A.CART_PROD --4월달의 판매되어진 상품코드 A, 5월달 D
                        AND D.CART_NO LIKE '202005%' 
AND EXISTS( SELECT 1 -- 조건 만족하지 않으면 아무것도 출력 X , 행 존재하지 않아 ? FALSE
                   FROM CART E
                   WHERE E.CART_PROD = D.CART_PROD --4월달 A, 6월달 E
                        AND E.CART_NO LIKE '202006%' ))
                        
4) MINUS(차집합) -- = NOT EXISTS
 - 두 결과 집합의 뺄셈 결과를 반환
 - 사용되는 위치에 따라 결과가 상이

 (사용예) 장바구니테이블에서 2020년 6월과 7월 매출 중 7월에만 판매된 상품정보를 조회하시오.
         Alias 는 상품번호, 상품명
    
 (7월 판매된 상품)        
    SELECT DISTINCT A.CART_PROD AS 상품번호, B.PROD_NAME AS 상품명
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '202007%'
        AND A.CART_PROD = B.PROD_ID
 (6월 판매된 상품)
    SELECT DISTINCT A.CART_PROD AS 상품번호, B.PROD_NAME AS 상품명
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '202006%'
        AND A.CART_PROD = B.PROD_ID
 
 (결합)
    SELECT DISTINCT A.CART_PROD AS 상품번호, B.PROD_NAME AS 상품명
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '202007%'
        AND A.CART_PROD = B.PROD_ID
        AND NOT EXISTS (SELECT 1 
                        FROM CART C
                        WHERE C.CART_NO LIKE '202006%' 
                        AND A.CART_PROD = C.CART_PROD)
     ORDER BY 1;
(결합 : MINUS를 이용)        
    SELECT DISTINCT A.CART_PROD AS 상품번호, B.PROD_NAME AS 상품명
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '202007%'
        AND A.CART_PROD = B.PROD_ID
  MINUS       
    SELECT DISTINCT A.CART_PROD AS 상품번호, B.PROD_NAME AS 상품명
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '202006%'
        AND A.CART_PROD = B.PROD_ID
     ORDER BY 1;
 