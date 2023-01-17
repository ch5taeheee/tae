2023-0116-01)함수(User Defined Function : Function)
 - 프로시져와 다른 점은 반환값이 존재하는 것 -- 함수명을 통해 반환함. select 나 where insert 나 update 안에 사용. out 매개변수는 사용x
(사용형식)
    CREATE [OR REPLACE] FUNCTION 함수명[(
        매개변수명 모드 데이터타입 [:= 디폴트 값][,]-- ; 없이 끝남.
                    :
        매개변수명 모드 데이터타입 [:= 디폴트 값])]
        RETURN 데이터타입 --값이 아니라 타입이 나오는 거
    IS|AS
        선언부 --변수, 상수, 커서 
    BEGIN
        실행부(반드시 하나 이상의 
        RETURN expr; --실제 반환은 여기에서 함. 
        이 존재해야 함)
        
        [EXCEPTION
            예외처리부]
    END;
    
사용예) 년도와 월로 구성된 기간을 입력받아 해당 기간 중 구매를 가장 많이 한 회원정보를 출력하시오.
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_ADD1|| ' ' || MEM_ADD2 AS 주소, 
           MEM_MILEAGE AS 마일리지
        FROM MEMBER
       WHERE MEM_ID = (함수 : 년도와 월로 구성된 기간을 입력받아 해당 기간 중 구매를 가장 많이 한 회원번호)
       
       (함수 : 년도와 월로 구성된 기간을 입력받아 해당 기간 중 구매를 가장 많이 한 회원번호)
         CREATE OR REPLACE FUNCTION fn_max_sum(
            P_PERIOD IN VARCHAR2)
            RETURN MEMBER.MEM_ID%TYPE
         IS
            L_PERIOD VARCHAR2(7) := P_PERIOD||'%';
            L_CID MEMBER.MEM_ID%TYPE;
         BEGIN
            SELECT C.CID INTO L_CID
                FROM (SELECT A.CART_MEMBER AS CID,
                             SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM
                        FROM CART A, PROD B
                       WHERE A.CART_PROD = B.PROD_ID
                         AND A.CART_NO LIKE L_PERIOD
                       GROUP BY A.CART_MEMBER
                       ORDER BY 2 DESC)C
                WHERE ROWNUM =1;
                
           RETURN L_CID;
         END;
         
(실행)
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_ADD1|| ' ' || MEM_ADD2 AS 주소, 
           MEM_MILEAGE AS 마일리지
        FROM MEMBER
       WHERE MEM_ID = fn_max_sum('202005');
       
 사용예) 상품코드를 입력받아 2020년 해당 상품의 매입수량 집계를 반환하는 함수를 작성
 (함수 : 매입수량집계)
    CREATE OR REPLACE FUNCTION FN_GETQTY_BUYPROD(
       P_PID IN PROD.PROD_ID%TYPE,
       P_PERIOD IN CHAR)
       RETURN NUMBER
    IS
        L_TOT NUMBER := 0; -- 매입수량 집계
        L_SDATE DATE := TO_DATE(P_PERIOD ||'01'); --해당 월의 1일
        L_EDATE DATE := LAST_DAY(L_SDATE);
    BEGIN
        SELECT SUM(BUY_QTY) INTO L_TOT
            FROM BUYPROD
           WHERE BUY_PROD = P_PID
            AND BUY_DATE BETWEEN L_SDATE AND L_EDATE;
            --EXTRACT(YEAR FROM BUY_DATE) = 2020;
        RETURN L_TOT;
    END;
        
 (실행)
    SELECT PROD_ID AS 상품코드, 
           PROD_NAME AS 상품명,
           NVL(FN_GETQTY_BUYPROD(PROD_ID,'202002'),0) AS 매입수량
        FROM PROD
      WHERE PROD_ID IN(SELECT BUY_PROD
                          FROM BUYPROD
                         WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201')));
                         
 사용예) 일자와 회원번호를 입력받아 장바구니번호를 생성하여 반환하는 함수 작성
    -- 해당 일의 판매건수 
    -- 0 이면 해당날짜 ||'00001'
    -- 1 이상이면 현재 입력되어 있는 회원번호와 가장 큰 CART_NO를 가지고 있는 회원번호가 똑같으면 회원번호는 그대로, 회원번호가 다르면 +1
    
    CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO(
        P_DAY IN CHAR, 
        P_MID IN MEMBER.MEM_ID%TYPE)
        RETURN CART.CART_NO%TYPE
    IS L_MID MEMBER.MEM_ID%TYPE;
       L_CARTNO CART.CART_NO%TYPE;
       L_CNT NUMBER:=0; -- 해당 일의 자료수 
    
    BEGIN
       SELECT COUNT(*) INTO L_CNT
          FROM CART 
         WHERE SUBSTR(CART_NO,1,8)=P_DAY;
         
       IF L_CNT =0 THEN
          L_CARTNO:= P_DAY||TRIM('00001');
       ELSE 
          SELECT MAX(CART_NO) INTO L_CARTNO
            FROM CART
           WHERE SUBSTR(CART_NO,1,8)=P_DAY;
           -- 위 아래 두개를 하면 그룹 바이로 해야함. 아님 서브쿼리 그냥 나눠 써
          SELECT DISTINCT CART_MEMBER INTO L_MID --DISTINCT 
            FROM CART
           WHERE L_CARTNO=CART_NO;
           
           IF L_MID != P_MID THEN
              L_CARTNO := L_CARTNO +1;
            END IF;
       END IF;
       RETURN L_CARTNO;
    END;
    
 (실행) 
    SELECT FN_CREATE_CARTNO('20200402', 'a001') FROM DUAL;
    
    SELECT FN_CREATE_CARTNO('20200408', 'k001') FROM DUAL;
    
    SELECT FN_CREATE_CARTNO('20200408', 'm001') FROM DUAL;
    
    SELECT FN_CREATE_CARTNO('20200408', 'f001') FROM DUAL;
    
    SELECT FN_CREATE_CARTNO(TO_CHAR(SYSDATE,'YYYYMMDD'),'doo1') FROM DUAL;
    

(실행)
    장바구니에 다음 자료를 입력하시오.
    
    [자료]
    회원번호  상품번호    구입일자    수량
    ------------------------------------
    d001   'p20200009'  20230116    5
    d001   'p30200021'  20230116    10
    
 INSERT INTO CART VALUES('d001',FN_CREATE_CARTNO('20230116','d001'),'P202000009',5);
 INSERT INTO CART VALUES('d001',FN_CREATE_CARTNO('20230116','d001'),'P302000021',10);
    
    
    
 
       
       

       
       
 
       
       
       
          
