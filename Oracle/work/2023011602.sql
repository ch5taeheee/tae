2023-0116-02)Ʈ����(TRIGGER) --Ŀ��, �ѹ� ���� �� �� X. �Լ�, ���ν����� ���� O �ۿ��� Ŀ��
 - Ư�����̺��� ������ ����Ǹ� �̸� �̺�Ʈ�� �ٸ� ���̺��� �ڵ����� ����ǵ��� ����� �����ϴ� ���ν����� ����
 -- �� Ʈ������ ������ �Ϸ�Ǿ� �� �� ���� Ʈ���� ȣ��, �߰��� ȣ���ϸ� ���� �߻�
 (�������)
    CREATE OR REPLACE TRIGGER Ʈ���Ÿ� -- ���ν������� ��ȯ���� X
        timming [BEFORE|AFTER] event[INSERT|UPDATE|DELETE] 
        ON ���̺��
        [FOR EACH ROW]
        [WHEN ����]
    [DECLARE] -- ����, ���, Ŀ��
        ���𿵿�;
      BEGIN 
        ���࿵�� - Ʈ���� ����;
      END;
      
 . timming : Ʈ���� ���� ���� ����
    - BEFORE : �̺�Ʈ�� �߻��ϱ� ���� Ʈ���� ���� ����
    - AFTER : �̺�Ʈ�� �߻��� �� Ʈ���� ���� ����
 . event : Ʈ���� ������ ������ �����ϴ� ��������
    - 'OR' ������ ��� ���� EX) INSERT OR UPDATE OR DELETE
 . FOR EACH ROW : ����� Ʈ���� �ۼ��� ���, �����ϸ� ������� Ʈ���� 
 . WHEN ���� : Ʈ���� �߻��� ������ �� �� ��ü������ ����ϸ� ����� Ʈ���ſ����� ��� ����
 
 1) ������� Ʈ����
  - 'FOR EACH ROW' �� ������ ���� Ʈ����
  - �̺�Ʈ�� ��� ���տ� ������� 1���� Ʈ���� �߻�
  
 ��뿹) �з����̺��� �з���ȣ 'P601' �ڷḦ �����Ͻÿ�. ���� �� '�ڷ������ ���������� ����Ǿ����ϴ�.' ��� �޽����� ����ϴ� Ʈ���Ÿ� �ۼ��Ͻÿ�.
       => �̺�Ʈ �߻� �� COMMIT �̳� �˻������ ����Ǿ�� �޽����� ��µ�.
       
        CREATE OR REPLACE TRIGGER tg_message_out
            AFTER DELETE ON LPROD
        BEGIN
            DBMS_OUTPUT.PUT_LINE('�ڷ������ ���������� ����Ǿ����ϴ�.');
        END;
        
        DELETE FROM LPROD
            WHERE LPROD_GU = 'P601';
        COMMIT; --������� Ʈ���Ŵ� COMMIT ����
        
        
        DELETE FROM LPROD
            WHERE LPROD_ID > 9;
            
        SELECT * FROM LPROD;
        
 2) ����� Ʈ����
  - 'FOR EACH ROW' �� ���� Ʈ����
  - �̺�Ʈ�� ��� ���տ� ���Ե� ���� ����ŭ Ʈ���� �߻�
  
  (1) �ǻ緹�ڵ�
  -------------------------------------------------------------------------------------------------------
  �ǻ緹�ڵ�         �ǹ�
  -------------------------------------------------------------------------------------------------------
  :NEW              �̺�Ʈ�� INSERT, UPDATE�� ���Ǹ� ����(����)�� �ϱ� ���� �ԷµǴ� ������ ���� ��Ī
                    DELETE�� ���Ǹ� ��� �÷��� NULL���� ����
  -------------------------------------------------------------------------------------------------------
  :OLD              �̺�Ʈ�� DELETE, UPDATE�� ���Ǹ� ����(����)�� �ϱ� ���� ������ ����Ǿ� �ִ� ������ ���� ��Ī
                    INSERT�� ���Ǹ� ��� �÷��� NULL���� ����
  -------------------------------------------------------------------------------------------------------

  (2) Ʈ���� �Լ�
  -------------------------------------------
  �Լ�               �ǹ�
  -------------------------------------------
  INSERTING         �̺�Ʈ�� INSERT�̸� ��
  UPDATING          �̺�Ʈ�� UPDATE�̸� ��
  DELETING          �̺�Ʈ�� DELETE�̸� ��
  
  => Ʈ���� �̺�Ʈ ��� �� OR �����ڸ� ����� ��� �̺�Ʈ �������� ����.
  
 ��뿹) �����ڷḦ �������̺� �����ϰ� ���������̺��� �����ϴ� Ʈ���� �ۼ�
 
    CREATE OR REPLACE TRIGGER TG_UPDATE_REMAIN
        AFTER INSERT ON BUYPROD -- ����ó�� ���� �� Ʈ���Ÿ� �߻��ض�. Ʈ���Ŵ� BUYPROD �μ�Ʈ ���� �ڵ����� �����ϹǷ� Ʈ���� �Լ� �ʿ� ����.
        FOR EACH ROW --������ X
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
    
 ��뿹) ���ó�¥��(20200820)�� ������ ���� �����ڷᰡ �߻��Ǿ���. �̸� ó���Ͻÿ�.
        [�����ڷ�] 
        1) ȸ����ȣ : r001  5906 + 485 = 6391
        ---------------------
        ���Ի�ǰ�ڵ�      ����      
        ---------------------
         P101000003      5              15	72	3	84	2020/06/12	P101000003 80 400
         P302000001      3              11	523	8	526	2020/07/31	P302000001 21 63
         P201000011      2              35	36	2	69	2020/07/31	P201000011 11 22 
         
        CREATE OR REPLACE TRIGGER TG_CART_INSERT
            AFTER INSERT ON CART 
            FOR EACH ROW
        DECLARE -- ���� ����
            L_MILE NUMBER := 0;
        BEGIN
            UPDATE REMAIN -- ��� ����
                SET REMAIN_O = REMAIN_O + (:NEW.CART_QTY),
                    REMAIN_J_99 = REMAIN_J_99 -(:NEW.CART_QTY),
                    REMAIN_DATE = TO_DATE(SUBSTR(:NEW.CART_NO,1,8))
            WHERE REMAIN_YEAR = '2020' --������Ѵ�.
              AND PROD_ID = (:NEW.CART_PROD);
                    
            SELECT PROD_MILEAGE * (:NEW.CART_QTY)
                INTO L_MILE
                FROM PROD 
                WHERE PROD_ID = (:NEW.CART_PROD) ;-- ���ԵǾ��� ����ǰ�ڵ�� ��ǰ���̺��� ��ǰ�ڵ�� 
            
            UPDATE MEMBER -- ���ϸ���
                SET MEM_MILEAGE = MEM_MILEAGE + L_MILE
            WHERE MEM_ID = :NEW.CART_MEMBER;
        END;
        
        INSERT INTO CART VALUES('r001', FN_CREATE_CARTNO(TO_CHAR(SYSDATE,'YYYYMMDD'),'r001'),'P101000003',5);
        INSERT INTO CART VALUES('r001', FN_CREATE_CARTNO(TO_CHAR(SYSDATE,'YYYYMMDD'),'r001'),'P130200001',3);
        INSERT INTO CART VALUES('r001', FN_CREATE_CARTNO(TO_CHAR(SYSDATE,'YYYYMMDD'),'r001'),'P201000011',2);
        
(��뿹) ��ٱ������̺� �ڷᰡ ����(�ű��Ǹŵ��), ����(�Ǹż��ɺ���), ����(������ҳ� ��ü��ǰ) ���� �۾��� ����� �� 
        ���������̺�� ȸ�����̺��� �ڷḦ �����ϴ� Ʈ���� �ۼ� -- ���, ���� 
    
        CREATE OR REPLACE TRIGGER TG_CHANGE_CART
            AFTER INSERT OR UPDATE OR DELETE ON CART
            FOR EACH ROW
            
        DECLARE 
            L_MILE NUMBER := 0; -- ���ϸ��� ����
            L_QTY NUMBER := 0; -- �Ǹż���
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
            
            ����   ����   ����    �����
EX) 2020	15	    72	    8	    79	2020/08/20	P101000003

'j001' ȸ���� 'P101000003' ��ǰ�� 20�� ����
-> CART �� ����
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
        
            
        
       