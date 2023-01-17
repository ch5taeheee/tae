2023-0116-01)�Լ�(User Defined Function : Function)
 - ���ν����� �ٸ� ���� ��ȯ���� �����ϴ� �� -- �Լ����� ���� ��ȯ��. select �� where insert �� update �ȿ� ���. out �Ű������� ���x
(�������)
    CREATE [OR REPLACE] FUNCTION �Լ���[(
        �Ű������� ��� ������Ÿ�� [:= ����Ʈ ��][,]-- ; ���� ����.
                    :
        �Ű������� ��� ������Ÿ�� [:= ����Ʈ ��])]
        RETURN ������Ÿ�� --���� �ƴ϶� Ÿ���� ������ ��
    IS|AS
        ����� --����, ���, Ŀ�� 
    BEGIN
        �����(�ݵ�� �ϳ� �̻��� 
        RETURN expr; --���� ��ȯ�� ���⿡�� ��. 
        �� �����ؾ� ��)
        
        [EXCEPTION
            ����ó����]
    END;
    
��뿹) �⵵�� ���� ������ �Ⱓ�� �Է¹޾� �ش� �Ⱓ �� ���Ÿ� ���� ���� �� ȸ�������� ����Ͻÿ�.
    SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_ADD1|| ' ' || MEM_ADD2 AS �ּ�, 
           MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
       WHERE MEM_ID = (�Լ� : �⵵�� ���� ������ �Ⱓ�� �Է¹޾� �ش� �Ⱓ �� ���Ÿ� ���� ���� �� ȸ����ȣ)
       
       (�Լ� : �⵵�� ���� ������ �Ⱓ�� �Է¹޾� �ش� �Ⱓ �� ���Ÿ� ���� ���� �� ȸ����ȣ)
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
         
(����)
    SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_ADD1|| ' ' || MEM_ADD2 AS �ּ�, 
           MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
       WHERE MEM_ID = fn_max_sum('202005');
       
 ��뿹) ��ǰ�ڵ带 �Է¹޾� 2020�� �ش� ��ǰ�� ���Լ��� ���踦 ��ȯ�ϴ� �Լ��� �ۼ�
 (�Լ� : ���Լ�������)
    CREATE OR REPLACE FUNCTION FN_GETQTY_BUYPROD(
       P_PID IN PROD.PROD_ID%TYPE,
       P_PERIOD IN CHAR)
       RETURN NUMBER
    IS
        L_TOT NUMBER := 0; -- ���Լ��� ����
        L_SDATE DATE := TO_DATE(P_PERIOD ||'01'); --�ش� ���� 1��
        L_EDATE DATE := LAST_DAY(L_SDATE);
    BEGIN
        SELECT SUM(BUY_QTY) INTO L_TOT
            FROM BUYPROD
           WHERE BUY_PROD = P_PID
            AND BUY_DATE BETWEEN L_SDATE AND L_EDATE;
            --EXTRACT(YEAR FROM BUY_DATE) = 2020;
        RETURN L_TOT;
    END;
        
 (����)
    SELECT PROD_ID AS ��ǰ�ڵ�, 
           PROD_NAME AS ��ǰ��,
           NVL(FN_GETQTY_BUYPROD(PROD_ID,'202002'),0) AS ���Լ���
        FROM PROD
      WHERE PROD_ID IN(SELECT BUY_PROD
                          FROM BUYPROD
                         WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201')));
                         
 ��뿹) ���ڿ� ȸ����ȣ�� �Է¹޾� ��ٱ��Ϲ�ȣ�� �����Ͽ� ��ȯ�ϴ� �Լ� �ۼ�
    -- �ش� ���� �ǸŰǼ� 
    -- 0 �̸� �ش糯¥ ||'00001'
    -- 1 �̻��̸� ���� �ԷµǾ� �ִ� ȸ����ȣ�� ���� ū CART_NO�� ������ �ִ� ȸ����ȣ�� �Ȱ����� ȸ����ȣ�� �״��, ȸ����ȣ�� �ٸ��� +1
    
    CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO(
        P_DAY IN CHAR, 
        P_MID IN MEMBER.MEM_ID%TYPE)
        RETURN CART.CART_NO%TYPE
    IS L_MID MEMBER.MEM_ID%TYPE;
       L_CARTNO CART.CART_NO%TYPE;
       L_CNT NUMBER:=0; -- �ش� ���� �ڷ�� 
    
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
           -- �� �Ʒ� �ΰ��� �ϸ� �׷� ���̷� �ؾ���. �ƴ� �������� �׳� ���� ��
          SELECT DISTINCT CART_MEMBER INTO L_MID --DISTINCT 
            FROM CART
           WHERE L_CARTNO=CART_NO;
           
           IF L_MID != P_MID THEN
              L_CARTNO := L_CARTNO +1;
            END IF;
       END IF;
       RETURN L_CARTNO;
    END;
    
 (����) 
    SELECT FN_CREATE_CARTNO('20200402', 'a001') FROM DUAL;
    
    SELECT FN_CREATE_CARTNO('20200408', 'k001') FROM DUAL;
    
    SELECT FN_CREATE_CARTNO('20200408', 'm001') FROM DUAL;
    
    SELECT FN_CREATE_CARTNO('20200408', 'f001') FROM DUAL;
    
    SELECT FN_CREATE_CARTNO(TO_CHAR(SYSDATE,'YYYYMMDD'),'doo1') FROM DUAL;
    

(����)
    ��ٱ��Ͽ� ���� �ڷḦ �Է��Ͻÿ�.
    
    [�ڷ�]
    ȸ����ȣ  ��ǰ��ȣ    ��������    ����
    ------------------------------------
    d001   'p20200009'  20230116    5
    d001   'p30200021'  20230116    10
    
 INSERT INTO CART VALUES('d001',FN_CREATE_CARTNO('20230116','d001'),'P202000009',5);
 INSERT INTO CART VALUES('d001',FN_CREATE_CARTNO('20230116','d001'),'P302000021',10);
    
    
    
 
       
       

       
       
 
       
       
       
          
