2023-0106-01) DML 명령과 서브쿼리
1. INSERT문에 사용하는 서브쿼리 
 - VALUES절 생략
 - 서브쿼리를 '( )'안에 기술하지 않음.
 
 (사용예) 재고수불테이블에 기초자료를 입력하시오.
         년도 : '2020', PROD_ID는 PROD테이블의 상품코드, 
         기초재고 : 상품테이블의 적정재고(PROD_PROPERSTOCK)
         
 INSERT INTO REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_J_99,REMAIN_DATE)  
    SELECT '2020',PROD_ID,PROD_PROPERSTOCK,PROD_PROPERSTOCK,TO_DATE('20200101')
      FROM PROD;
      
      SELECT * FROM REMAIN;
      
      COMMIT;
      
2. UPDATE문에 사용하는 서브쿼리                                                 --WHERE 행 어떤 상품 결정 SET 변경시킬 값 결정
 - SET 절에서 변경할 값을 설정
 - WHERE 절에서 변경할 항목(행)을 결정
 
 (사용예) 매입테이블에서 2020년 1월 제품별 매입수량을 구하고 재고 수불테이블의 매입수량을 변경하시오.
 
 UPDATE REMAIN A 
    SET REMAIN_I = (서브쿼리)
 
 (1) 2020년 1월 제품별 매입수량집계
 
  SELECT BUY_PROD, 
         SUM(BUY_QTY) 
      FROM BUYPROD 
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')   -- 날짜형은 BETWEEN 써라
     GROUP BY  BUY_PROD
     
 (2) 2020년 1월 매입상품코드 조회 => UPDATE문 WHERE 절 -- 매입된 상품만 업데이트 시켜야함.  WHERE 절에서 
   SELECT DISTINCT BUY_PROD
       FROM BUYPROD 
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')  

-- 한 컬럼씩 다 업데이트     
 UPDATE REMAIN A 
    SET A.REMAIN_I, = (SELECT A.REMAIN_I + B.SQTY                         -- A. 누적  B.추가 누적 안하면 존재 데이터에 덮어씌워진다.
                         FROM(SELECT BUY_PROD, 
                                     SUM(BUY_QTY) AS SQTY 
                                 FROM BUYPROD 
                                WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')  
                                 GROUP BY  BUY_PROD) B
                         WHERE A.PROD_ID = B.BUY_PROD),
        A.REMAIN_J_99 = (SELECT A.REMAIN_J_99 + B.SQTY                        -- 현재고도 바뀜.
                         FROM(SELECT BUY_PROD, 
                                     SUM(BUY_QTY) AS SQTY 
                                 FROM BUYPROD 
                                WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')  
                                 GROUP BY  BUY_PROD) B
                         WHERE A.PROD_ID = B.BUY_PROD),
                         
-- 완성본(3개의 컬럼을 한 번에)                         
  UPDATE REMAIN A 
    SET(A.REMAIN_I, A.REMAIN_J_99, A.REMAIN_DATE) =  -- 값을 결정할 때 쓰는 조건
        (SELECT A.REMAIN_I + B.SQTY, A.REMAIN_J_99 + B.SQTY, TO_DATE('20200131')                     
            FROM(SELECT BUY_PROD, 
                      SUM(BUY_QTY) AS SQTY 
                  FROM BUYPROD 
                  WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')  
                  GROUP BY  BUY_PROD) B
            WHERE A.PROD_ID = B.BUY_PROD)  -- 여기까지만 하면 모든 데이터가 업데이트 됨. NULL
   WHERE A. PROD_ID IN(SELECT DISTINCT BUY_PROD --2020년 1월 매입발생된 코드만 꺼내서 업데이트 할 항목 결정
                        FROM BUYPROD 
                        WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
                        
SELECT * FROM REMAIN;
        
** 상품테이블의 상품별 마일리지를 판매이익의 0.1%로 변경하시오. 판매가 - 매입가 *0.0001

    UPDATE PROD
    SET PROD_MILEAGE=ROUND((PROD_PRICE - PROD_COST) * 0.001);
    
    SELECT PROD_ID, PROD_MILEAGE FROM PROD;
    
** MEMBER 테이블의 모든 회원의 마일리지를 0으로 변경 
    UPDATE MEMBER
    SET MEM_MILEAGE = 0;
    
    COMMIT;
    
(사용예) 회원들의 구매실적에 따른 마일리지를 계산하여 회원테이블을 갱신하시오. -- (숙제)

SELECT A.CART_MEMBER,
       SUM(A.CART_QTY * B.PROD_MILEAGE)
    FROM  CART A, PROD B
    WHERE B.PROD_ID = A.CART_PROD
    GROUP BY A.CART_MEMBER 

    
    UPDATE MEMBER
    SET MEM_MILEAGE = (SELECT AR
                        FROM(SELECT A.CART_MEMBER AS AE,
                                    SUM(A.CART_QTY * B.PROD_MILEAGE) AS AR
                                FROM  CART A, PROD B
                                 WHERE B.PROD_ID = A.CART_PROD
                                 GROUP BY A.CART_MEMBER) C -- 회원번호와 마일리지 합계
                         WHERE MEM_ID = C.AE)
    WHERE MEM_ID IN(SELECT CART_MEMBER FROM CART)
    
 --2020년도   
    UPDATE MEMBER
    SET MEM_MILEAGE = (SELECT AR
                        FROM(SELECT A.CART_MEMBER AS AE,
                                    SUM(A.CART_QTY * B.PROD_MILEAGE) AS AR
                                FROM  CART A, PROD B
                                 WHERE B.PROD_ID = A.CART_PROD
                                 AND A.CART_NO LIKE '2020%'
                                 GROUP BY A.CART_MEMBER) C -- 회원번호와 마일리지 합계
                         WHERE MEM_ID = C.AE)
    WHERE MEM_ID IN(SELECT DISTINCT CART_MEMBER FROM CART WHERE CART_NO LIKE '2020%')
    
    
    
    SELECT *FROM MEMBER
     
     select mem_id, mem_milEagE
     from meMBER
     order by 1;
     
     SELECT CART_MEMBER ,SUM(CART_QTY*PROD_MILEAGE)
FROM CART , PROD
WHERE CART_PROD = PROD_ID AND CART_MEMBER = 'b001'
group by CART_MEMBER
     
     
  
                            

    
      
 
 
    
    
    
    
    
    
    
    
    
    
    
    
    

         

   
 
 

 
 
 
 
 
 
 