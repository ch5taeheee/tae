2023-0116-02)트리거(TRIGGER) --커밋, 롤백 절대 못 씀 X. 함수, 프로시져는 가능 O 밖에서 커밋
 - 특정테이블의 내용이 변경되면 이를 이벤트로 다른 테이블이 자동으로 변경되도록 기능을 수행하는 프로시져의 일종
 -- 한 트리거의 동작이 완료되어 진 후 다음 트리거 호출, 중간에 호출하면 오류 발생
 (사용형식)
    CREATE OR REPLACE TRIGGER 트리거명 -- 프로시져명은 반환값이 X
        timming [BEFORE|AFTER] event[INSERT|UPDATE|DELETE] 
        ON 테이블명
        [FOR EACH ROW]
        [WHEN 조건]
    [DECLARE] -- 변수, 상수, 커서
        선언영역;
      BEGIN 
        실행영역 - 트리거 본문;
      END;
      
 . timming : 트리거 수행 시점 설정
    - BEFORE : 이벤트가 발생하기 전에 트리거 본문 실행
    - AFTER : 이벤트가 발생한 후 트리거 본문 실행
 . event : 트리거 본문의 실행을 유발하는 원인행위
    - 'OR' 연산자 사용 가능 EX) INSERT OR UPDATE OR DELETE
 . FOR EACH ROW : 행단위 트리거 작성시 기술, 생략하면 문장단위 트리거 
 . WHEN 조건 : 트리거 발생의 원인을 좀 더 구체적으로 기술하며 행단위 트리거에서만 사용 가능
 
 1) 문장단위 트리거
  - 'FOR EACH ROW' 가 사용되지 않은 트리거
  - 이벤트의 결과 집합에 관계없이 1번만 트리거 발생
  
 사용예) 분류테이블에서 분류번호 'P601' 자료를 삭제하시오. 삭제 후 '자료삭제가 정상적으로 수행되었습니다.' 라는 메시지를 출력하는 트리거를 작성하시오.
       => 이벤트 발생 후 COMMIT 이나 검색명령이 수행되어야 메시지가 출력됨.
       
        CREATE OR REPLACE TRIGGER tg_message_out
            AFTER DELETE ON LPROD
        BEGIN
            DBMS_OUTPUT.PUT_LINE('자료삭제가 정상적으로 수행되었습니다.');
        END;
        
        DELETE FROM LPROD
            WHERE LPROD_GU = 'P601';
        COMMIT; --문장단위 트리거는 COMMIT 하자
        
        
        DELETE FROM LPROD
            WHERE LPROD_ID > 9;
            
        SELECT * FROM LPROD;
        
 2) 행단위 트리거
  - 'FOR EACH ROW' 가 사용된 트리거
  - 이벤트의 결과 집합에 포함된 행의 수만큼 트리거 발생
  
  (1) 의사레코드
  -------------------------------------------------------------------------------------------------------
  의사레코드         의미
  -------------------------------------------------------------------------------------------------------
  :NEW              이벤트가 INSERT, UPDATE에 사용되며 삽입(갱신)을 하기 위해 입력되는 데이터 행을 지칭
                    DELETE시 사용되면 모든 컬럼이 NULL값을 가짐
  -------------------------------------------------------------------------------------------------------
  :OLD              이벤트가 DELETE, UPDATE에 사용되며 삭제(갱신)을 하기 위해 기존에 저장되어 있던 데이터 행을 지칭
                    INSERT시 사용되면 모든 컬럼이 NULL값을 가짐
  -------------------------------------------------------------------------------------------------------

  (2) 트리거 함수
  -------------------------------------------
  함수               의미
  -------------------------------------------
  INSERTING         이벤트가 INSERT이면 참
  UPDATING          이벤트가 UPDATE이면 참
  DELETING          이벤트가 DELETE이면 참
  
  => 트리거 이벤트 기술 시 OR 연산자를 사용한 경우 이벤트 본문에서 사용됨.
  
 사용예) 매입자료를 매입테이블에 저장하고 재고수불테이블을 변경하는 트리거 작성
 
    CREATE OR REPLACE TRIGGER TG_UPDATE_REMAIN
        AFTER INSERT ON BUYPROD -- 매입처리 끝난 후 트리거를 발생해라. 트리거는 BUYPROD 인서트 다음 자동으로 실행하므로 트리거 함수 필요 없음.
        FOR EACH ROW --빠지면 X
    BEGIN 
        UPDATE REMAIN A
            SET A.REMAIN_I = A.REMAIN_I + (:NEW.BUY_QTY),
                A.REMAIN_J_99 = A.REMAIN_J_99 + (:NEW.BUY_QTY),
                A.REMAIN_DATE = (:NEW.BUY_DATE)
        WHERE A.PROD_ID = :NEW.BUY_PROD;
    END;
    
    INSERT INTO BUYPROD VALUES(TO_DATE('20200612'),'P101000003',15,410000);
    
    15	57	3	69
        15      15
        72      84
    
 사용예) 오늘날짜에(20200820)에 다음과 같은 매출자료가 발생되었다. 이를 처리하시오.
        [매출자료] 
        1) 회원번호 : r001  5906 + 485 = 6391
        ---------------------
        구입상품코드      수량      
        ---------------------
         P101000003      5              15	72	3	84	2020/06/12	P101000003 80 400
         P302000001      3              11	523	8	526	2020/07/31	P302000001 21 63
         P201000011      2              35	36	2	69	2020/07/31	P201000011 11 22 
         
        CREATE OR REPLACE TRIGGER TG_CART_INSERT
            AFTER INSERT ON CART 
            FOR EACH ROW
        DECLARE -- 변수 선언
            L_MILE NUMBER := 0;
        BEGIN
            UPDATE REMAIN -- 재고 수정
                SET REMAIN_O = REMAIN_O + (:NEW.CART_QTY),
                    REMAIN_J_99 = REMAIN_J_99 -(:NEW.CART_QTY),
                    REMAIN_DATE = TO_DATE(SUBSTR(:NEW.CART_NO,1,8))
            WHERE REMAIN_YEAR = '2020' --써줘야한다.
              AND PROD_ID = (:NEW.CART_PROD);
                    
            SELECT PROD_MILEAGE * (:NEW.CART_QTY)
                INTO L_MILE
                FROM PROD 
                WHERE PROD_ID = (:NEW.CART_PROD) ;-- 매입되어지 ㄴ상품코드와 상품테이블의 상품코드와 
            
            UPDATE MEMBER -- 마일리지
                SET MEM_MILEAGE = MEM_MILEAGE + L_MILE
            WHERE MEM_ID = :NEW.CART_MEMBER;
        END;
        
        INSERT INTO CART VALUES('r001', FN_CREATE_CARTNO(TO_CHAR(SYSDATE,'YYYYMMDD'),'r001'),'P101000003',5);
        INSERT INTO CART VALUES('r001', FN_CREATE_CARTNO(TO_CHAR(SYSDATE,'YYYYMMDD'),'r001'),'P130200001',3);
        INSERT INTO CART VALUES('r001', FN_CREATE_CARTNO(TO_CHAR(SYSDATE,'YYYYMMDD'),'r001'),'P201000011',2);
        
(사용예) 장바구니테이블에 자료가 삽입(신규판매등록), 갱신(판매수령변경), 삭제(구매취소나 전체반품) 등의 작업이 진행된 후 
        재고수불테이블과 회원테이블의 자료를 변경하는 트리거 작성 -- 출고, 현재 
    
        CREATE OR REPLACE TRIGGER TG_CHANGE_CART
            AFTER INSERT OR UPDATE OR DELETE ON CART
            FOR EACH ROW
            
        DECLARE 
            L_MILE NUMBER := 0; -- 마일리지 변경
            L_QTY NUMBER := 0; -- 판매수량
            L_PID PROD.PROD_ID%TYPE;
            L_MID MEMBER.MEM_ID%TYPE;
            L_DATE DATE;
            
        BEGIN
            IF INSERTING THEN
                L_QTY := (:NEW.CART_QTY);
                L_PID := (:NEW.CART_PROD);
                L_MID := (:NEW.CART_MEMBER);
                L_DATE := TO_DATE(SUBSTR(:new.CART_NO,1,8));
                
            ELSIF UPDATING THEN
                L_QTY := (:NEW.CART_QTY) - (:OLD.CART_QTY);
                L_PID := (:NEW.CART_PROD);
                L_MID := (:NEW.CART_MEMBER);
                L_DATE := TO_DATE(SUBSTR(:new.CART_NO,1,8));         
                
            ELSIF DELETING THEN
                L_QTY := (-:OLD.CART_QTY);
                L_PID := (:OLD.CART_PROD);
                L_MID := (:OLD.CART_MEMBER);
                L_DATE := TO_DATE(SUBSTR(:OLD.CART_NO,1,8));                   
            END IF;
            
            UPDATE REMAIN A
                SET A.REMAIN_O = A.REMAIN_O + L_QTY,
                    A.REMAIN_J_99 = A.REMAIN_J_99 - L_QTY,
                    A.REMAIN_DATE = L_DATE
              WHERE A.PROD_ID = L_PID;
              
              SELECT PROD_MILEAGE * L_QTY INTO L_MILE
                FROM PROD
               WHERE PROD_ID = L_PID;
               
            UPDATE MEMBER
                SET MEM_MILEAGE = MEM_MILEAGE + L_MILE
             WHERE MEM_ID = L_MID;
        END;
            
            기초   매입   매출    현재고
EX) 2020	15	    72	    8	    79	2020/08/20	P101000003

'j001' 회원이 'P101000003' 제품을 20개 구입
-> CART 에 저장
EX) 2020	15	    72	    28	    59	2020/08/20	P101000003 -- insert
                            38      49 -- UPDATE
            15	    72	    58	    29 -- UPDATE               
            15	    72	    28	    59 -- DELETE
        INSERT INTO CART VALUES ('j001',FN_CREATE_CARTNO(TO_CHAR(SYSDATE,'YYYYMMDD'),'j001'),'P101000003',20);
        
        UPDATE CART 
            SET CART_QTY =10
           WHERE CART_NO = '2020082000002'
            AND CART_MEMBER = 'j001'
            AND CART_PROD = 'P101000003';
    

        UPDATE CART 
            SET CART_QTY =30
           WHERE CART_NO = '2020082000002'
            AND CART_MEMBER = 'j001'
            AND CART_PROD = 'P101000003';
            
        DELETE CART 
            WHERE CART_NO = '2020082000002'
            AND CART_PROD = 'P101000003';
        
            
        
       