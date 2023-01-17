2023-0104-01) 외부조인
 - 조인에 참여하는 테이블 중 데이터의 종류가 더 많은 쪽을 기준으로 수행하는 조인
 - 조인조건 기술시 부족한 테이블의 컬럼에 외부조인 연산자 '(+)'를 추가함.
 - 외부조인 조건이 하나 이상 존재하는 경우 모든 외부조인 조건에 '(+)'를 붙여야 함. 
 - 한번에 한 테이블에만 외부조인을 할 수 있다. 즉, A, B, C 테이블이 외부조인하는 경우
   A = B (+) AND C = B (+)는 허용되지 않음(단, A=B{+) AND B=C(+)는 허용됨)
 - 외부조인 조건은 OR 연산자와 IN 연산자를 사용할 수 없음.
 
   (일반 외부조인 사용형식)
   SELECT 컬럼list
      FROM 테이블명1 [별칭1], 테이블명2 [별칭2][, 테이블명3 [별칭3],...]
    WHERE [별칭1].컬럼명 = [별칭2]컬럼명2(+)
      [AND [별칭3].컬럼명(+) = [별칭2]컬럼명2]
                    :
                    
   . 외부조인 조건과 일반조건이 같이 사용되면 내부조인결과를 출력 => 해결책으로 
     1) ANSI 외부조인 사용
     2) 서브쿼리를 사용한 외부조인 사용 --일반조건을 서브쿼리로 미리 실행하고 외부조인을 사용 
     3) 
     
   (ANSI OUTER JOIN) 
   SELECT 컬럼list
      FROM 테이블명1 [별칭1]
    LEFT|RIGHT|FRLL OUTER JOIN 테이블명2 [별칭2] ON(조인조건 [AND 일반조건])
                        :
    [WHERE 일반조건]
    
     . WHERE 일반조건을 사용하면 내부조인결과를 출력할 수 있음.
     . LEFT : 테이블명1의 종류가 테이블명2의 종류보다 많은 경우 
     . RIGHT : 테이블명1의 종류가 테이블명2의 종류보다 적은 경우 
     . FULL : 테이블명과 테이블명2 양쪽 모두 부족한 경우
     
 (사용예) 상품테이블과 분류테이블을 이용하여 모든 분류별 상품의 수를 조회하시오.
        Alias는 분류코드, 분류명, 상품의 수
        
 1.       SELECT --A.PROD_LGU AS 분류코드, 
               B.LPROD_GU AS 분류코드,
               B.LPROD_NM AS 분류명,
               COUNT(PROD_ID) AS "상품의 수"
          FROM PROD A, LPROD B
          WHERE A.PROD_LGU(+) = B.LPROD_GU
          GROUP BY B.LPROD_GU,B.LPROD_NM
          ORDER BY 1;
          
 2.      SELECT B.LPROD_GU AS 분류코드,
                B.LPROD_NM AS 분류명,
                COUNT(PROD_ID) AS "상품의 수"
          FROM PROD A 
          RIGHT OUTER JOIN LPROD B ON A.PROD_LGU = B.LPROD_GU
           GROUP BY B.LPROD_GU,B.LPROD_NM
          ORDER BY 1;
          
 (사용예) 장바구니와 회원테이블을 이용하여 전체 회원들에 대하여 구매현황을 조회하시오. 
         Alias는 회원번호, 회원명, 구매금액 
         
1.      SELECT A.MEM_ID AS 회원번호,
               A.MEM_NAME AS 회원명,
              NVL( SUM(C.PROD_PRICE * B.CART_QTY),0) AS 구매금액
          FROM MEMBER A, CART B, PROD C
         WHERE A.MEM_ID = B.CART_MEMBER(+)
         AND B.CART_PROD = C.PROD_ID(+)
          GROUP BY A.MEM_ID, A.MEM_NAME;
          
2.     SELECT A.MEM_ID AS 회원번호,
               A.MEM_NAME AS 회원명,
              NVL(SUM(C.PROD_PRICE * B.CART_QTY),0) AS 구매금액
          FROM MEMBER A
          LEFT OUTER JOIN CART B ON A.MEM_ID = B.CART_MEMBER
          LEFT OUTER JOIN PROD C ON B.CART_PROD = C.PROD_ID
          GROUP BY A.MEM_ID, A.MEM_NAME;
          
 (사용예) 2020년 3월 모든 거래처별 매입집계를 조회하시오. // 
         Alias는 거래처코드, 거래처명, 매입금액
         
1.        SELECT A.BUYER_ID AS 거래처코드,
                A.BUYER_NAME AS 거래처명,
                SUM(B.BUY_QTY * C.PROD_COST) AS 매입금액
          FROM BUYER A, BUYPROD B, PROD C
          WHERE A.BUYER_ID = C.PROD_BUYER(+)
             AND C.PROD_ID = B.BUY_PROD (+)
            AND B.BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
          GROUP BY A.BUYER_ID, A.BUYER_NAME
          
2.        SELECT A.BUYER_ID AS 거래처코드,
                A.BUYER_NAME AS 거래처명,
                NVL(SUM(B.BUY_QTY * C.PROD_COST),0) AS 매입금액
          FROM BUYER A
          LEFT OUTER JOIN PROD C ON A.BUYER_ID = C.PROD_BUYER
          LEFT OUTER JOIN BUYPROD B ON (C.PROD_ID = B.BUY_PROD 
                                        AND B.BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331'))
          GROUP BY A.BUYER_ID, A.BUYER_NAME
          
 (사용예) 2020년 3월 제품별 매입집계를 조회하시오.
 
           SELECT BUY_PROD, 
                  SUM(BUY_QTY * BUY_COST) AS CSUM
              FROM BUYPROD 
             WHERE BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
             GROUP BY BUY_PROD
             
 (사용예) 2020년 3월 거래처별 매입집계를 조회하시오.
        Alias는 거래처코드, 거래처명, 매입금액
            SELECT A.BUYER_ID AS 거래처코드,
                   A.BUYER_NAME AS 거래처명,
                   NVL(SUM(C.CSUM),0) AS 매입금액
             FROM BUYER A, PROD B, 
                    (SELECT BUY_PROD,
                            SUM(BUY_QTY * BUY_COST) AS CSUM
                        FROM BUYPROD 
                        WHERE BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
                         GROUP BY BUY_PROD) C
                WHERE B.PROD_ID = C.BUY_PROD(+)
                AND A.BUYER_ID = B.PROD_BUYER(+)
                GROUP BY A.BUYER_ID,A.BUYER_NAME
                ORDER BY 1;
                
2-1) 2020년 3월 거래처별 매입집계를 조회(내부조인)

           SELECT C.PROD_BUYER AS CID, -- . 하면 반드시 별칭 써야함. 
                  SUM(A.BUY_QTY * C.PROD_COST) AS CSUM
              FROM BUYPROD A, BUYER B, PROD C
             WHERE A. BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
                AND A. BUY_PROD = C.PROD_ID
                AND C.PROD_BUYER = B.BUYER_ID
             GROUP BY C.PROD_BUYER
             
2-2) 2020년 3월 모든 거래처별 매입집계를 조회

       SELECT D.BUYER_ID AS 거래처코드,
                D.BUYER_NAME AS 거래처명,
                NVL(E.CSUM ,0) AS 매입금액
          FROM BUYER D,
                    (SELECT C.PROD_BUYER AS CID, -- . 하면 반드시 별칭 써야함. 
                             SUM(A.BUY_QTY * C.PROD_COST) AS CSUM
                        FROM BUYPROD A, BUYER B, PROD C
                        WHERE A. BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
                            AND A. BUY_PROD = C.PROD_ID
                            AND C.PROD_BUYER = B.BUYER_ID
                        GROUP BY C.PROD_BUYER) E
        WHERE D.BUYER_ID =E.CID(+)
        ORDER BY 1;
               
(사용예) 2020년 6월 모든 제품별 매출집계를 조회하시오.
        Alias 는 상품코드, 상품명, 매출수량, 매출금액이다.
        
1.        SELECT B.PROD_ID AS 상품코드,
               B.PROD_NAME AS 상품명,
               NVL(SUM(A.CART_QTY),0) AS 매출수량,
               NVL(SUM(B.PROD_PRICE*A.CART_QTY),0) AS 매출금액
         FROM CART A
         RIGHT OUTER JOIN PROD B ON (A.CART_PROD = B.PROD_ID AND SUBSTR(CART_NO,1,6) ='202006')
           GROUP BY B.PROD_ID,B.PROD_NAME
          ORDER BY 1;
          
2.         SELECT B.PROD_ID AS 상품코드,
               B.PROD_NAME AS 상품명,
               NVL(SUM(C.ASDD),0) AS 매출수량,
               NVL(SUM(B.PROD_PRICE*C.ASDD),0) AS 매출금액
         FROM PROD B, 
                    (SELECT A.CART_QTY AS ASDD, B.PROD_ID AS ASD
                    FROM CART A, PROD B
                    WHERE A.CART_PROD = B.PROD_ID AND SUBSTR(A.CART_NO,1,6) ='202006') C
            WHERE C.ASD(+) = B.PROD_ID
            GROUP BY B.PROD_ID,B.PROD_NAME
            ORDER BY 1;
------------------------------------------------------------------------------------------------------------            
 (SUBQUERY) 
 1.2020년 6월 상품별  매출수량, 매출금액 집계
 SELECT B.PROD_ID AS BID,
 B.PROD_NAME AS BNAME,
 NVL(SUM(A.CART_QTY),0) AS BMT,
 NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS BSUM
 FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
 AND A.CART_NO LIKE '202006%'
 GROUP BY B.PROD_ID, B.PROD_NAME
 
 (PROD와 외부조인)
 SELECT P.PROD_ID AS 상품코드, 
        P.PROD_NAME AS 상품명, 
        NVL(C.BMT,0) AS 매출수량,
        NVL(C.BSUM,0) AS 매출금액
 FROM PROD P,
     (SELECT B.PROD_ID AS BID,
                B.PROD_NAME AS BNAME,
                NVL(SUM(A.CART_QTY),0) AS BMT,
                NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS BSUM
                 FROM CART A, PROD B
                WHERE A.CART_PROD = B.PROD_ID
                AND A.CART_NO LIKE '202006%'
                GROUP BY B.PROD_ID, B.PROD_NAME) C
WHERE P.PROD_ID = C.BID(+)
ORDER BY 1;
-------------------------------------------------------------------------------------------------------------
 
            
            
    
       
         
         
         
    

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
