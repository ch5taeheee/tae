2023-0113-01)���� ���ν���(Stored Procedure : Procedure)
 - ������ �̸� �����ϵǾ� ���� ������ ���·� ������ ����� ��� 
 - ����ڰ� ó����ƾ ����
 - �����ͺ��̽� ���α����� ���� ���ȼ� ���� -- ��� ������
 - ���� ��ȣ �ڷ� ���Ἲ ���� ����
 - ������ ó���ӵ� ��� 
 - ��Ʈ��ũ�� Ʈ���� ����
 
 -- ���ϰ��� �ִ� �Լ�, ���� ���ν���,
 -- ���ν����� �μ�Ʈ, ������Ʈ, ����Ʈ ���� �ǵ��� �� �� ���� ���� ���
 -- �ǵ��� �� ���� �� �Լ����
 
  1. ���� ���ν���(Stored Procedure : Procedure)
 - ���ν������� ���� ��ȯ ���� �������� �ʴ� ���
(�������) 
    CREATE [OR REPLACE] PROCEDURE ���ν�����[(
        �Ű������� mode Ÿ�Ը�[:=����Ʈ ��][,]
                    :
        �Ű������� mode Ÿ�Ը�[:=����Ʈ ��])]
    IS | AS --�͸����� DECLARE
        �����
    BEGIN -- ���������� �ƴ� �̻� SELECT INTO ��� ��.
        �����
        
        [EXCEPTION
            ����ó���� ]
    END [���ν�����];
    
    . 'mode' : �Ű������� ������ ���� IN(�Է¿�), OUT(��¿�), INOUT(����� ����) --����
    . Ÿ�Ը� : ũ�⸦ ����ϸ� ����
    . := ����Ʈ �� : ����ڰ� �Ű������� �����ϰ� ���� �������� ���� ��� ���޵� �⺻ ������
    
 (���ν��� ���� �������)
    EXEC | EXECUTE ���ν�����[(�Ű�����list)]; --EXEC OR EXECUTE ���� ��
    OR
    ���ν�����[{�Ű�����list)]; => �͸���, �ٸ� ���ν����� �Լ� ��� �����ϴ� ��� --��俣�� OUT/ �Ű������� ����� �� �� ��� ���.
    
 (��뿹) �⵵�� ���� �Է¹޾� �ش� �Ⱓ���� ������� ���踦 ���ϰ� ������ ���̺��� UPDATE�ϴ� ���ν����� �ۼ��Ͻÿ�.
       -- ���� PROC�� ���� , �Ű������� �Ķ���Ͷ�� �ؼ� P�� ����, ����� �����ǰų� �Ⱦ��� IN�� ���ɷ� ����?
         
         CREATE OR REPLACE PROCEDURE PROC_REMAIN_UPDATE(
            P_YEAR IN VARCHAR2,
            P_MONTH IN VARCHAR2) 
            
         IS
            L_PERIOD VARCHAR2(7):=P_YEAR ||P_MONTH || '%' ;
            L_DATE DATE:=LAST_DAY(TO_DATE(P_YEAR||P_MONTH||'01'));
            CURSOR CUR_CART01 IS 
            --�ش�Ⱓ���� ��ǰ�� ������� ����
             SELECT CART_PROD,
                    SUM(CART_QTY) AS SAMT
                 FROM CART
                WHERE CART_NO LIKE L_PERIOD
                GROUP BY CART_PROD;
         BEGIN
            --�ش�Ⱓ���� ��ǰ�� ������� ����
            FOR REC IN CUR_CART01 LOOP 
                UPDATE REMAIN A
                   SET A.REMAIN_O = A.REMAIN_O +REC.SAMT,
                       A.REMAIN_J_99 = A.REMAIN_J_99 - REC.SAMT,
                       A.REMAIN_DATE = L_DATE
                WHERE A.PROD_ID = REC.CART_PROD;
           END LOOP;
        COMMIT;
        EXCEPTION 
                WHEN OTHERS THEN -- ���� 
                 DBMS_OUTPUT.PUT_LINE('���ܹ߻� : '||SQLERRM);
                 ROLLBACK;
                 
         END PROC_REMAIN_UPDATE; -- END; �� ������ ������ ������ ���°� �� ����.
            
 (����)
  EXECUTE PROC_REMAIN_UPDATE('2020','04');
  
  SELECT * FROM REMAIN;
    
 (��뿹) �������̺��� 2020�� ���۳�¥�� �������ڸ� �Է¹޾� ��ǰ�� ���Լ��� ���踦 �����Ͽ� ���������̺��� �����ϰ� ���� ��ǰ���� ��ȯ�ϴ� ���ν����� �ۼ� �Ͻÿ�. 
 
  CREATE OR REPLACE PROCEDURE PROC_BUYPROD01(
        P_SDATE IN DATE, 
        P_EDATE IN DATE, 
        P_CNT OUT NUMBER )
    IS 
         L_CNT NUMBER := 0; -- ó���Ǽ�
         CURSOR CUR_BUYPROD IS
            SELECT BUY_PROD, SUM(BUY_QTY) AS SBMT
               FROM BUYPROD
              WHERE BUY_DATE BETWEEN P_SDATE AND P_EDATE
              GROUP BY BUY_PROD;   
    
    BEGIN
        FOR REC IN CUR_BUYPROD LOOP
            UPDATE REMAIN A
                SET A.REMAIN_I = A.REMAIN_I + REC.SBMT,
                    A.REMAIN_J_99 = A.REMAIN_J_99 + REC.SBMT,
                    A.REMAIN_DATE = LAST_DAY(P_EDATE)
                WHERE A.PROD_ID= REC.BUY_PROD;
                L_CNT := L_CNT +1;
                COMMIT;
        END LOOP;
        P_CNT := L_CNT;
    
    END PROC_BUYPROD01;
 
(����)
     DECLARE
         RES NUMBER:=0;
     BEGIN
         PROC_BUYPROD01(TO_DATE('20200101'),TO_DATE('20200730'),RES);
         DBMS_OUTPUT.PUT_LINE('ó���Ǽ� : ' ||RES);
     END;
    
    SELECT * FROM REMAIN;
    
 ��뿹) ���Ի�������� �Է¹޾� HR������ EMPLOYEES ���̺� �ڷḦ �����ϰ� �Է� ������� ��ȯ �޴� ���ν����� �ۼ��Ͻÿ�.
        [���Ի���ڷ�] 
        ------------------------------------------------
            �����      �����ڵ�     �μ��ڵ�      �޿�
        ------------------------------------------------
            ȫ�浿      MK_MAN        70        11000
            �̼���      AC_MGR       100        10000
            ������      PU_MAN        50         8500        
            
        - �����ȣ�� ���� �����ȣ�� ���� ��ȣ�� �Ҵ��ϰ� �Ի����ڴ� ���÷� ���� -- ����� �� �Ǽ� 
        
        CREATE OR REPLACE PROCEDURE PROC_EMP_INSERT(
            P_ENAME IN HR.EMPLOYEES.LAST_NAME%TYPE,
            P_JID IN HR.EMPLOYEES.JOB_ID%TYPE,
            P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE,
            P_SALARY NUMBER,
            P_NAME OUT VARCHAR2)
        IS
            L_EID NUMBER:=0;-- �����ȣ
        BEGIN
            SELECT MAX(EMPLOYEE_ID) +1 INTO L_EID
                FROM HR.EMPLOYEES;
            INSERT INTO HR.EMPLOYEES(EMPLOYEE_ID,LAST_NAME,HIRE_DATE,JOB_ID,SALARY,DEPARTMENT_ID)
                VALUES(L_EID, P_ENAME, SYSDATE,P_JID, P_SALARY,P_DID);
                COMMIT;
                P_NAME := P_ENAME; -- �ƿ� �Ű������̱� ������ ������ ������. ����̶�� �ǰ�?               
        END;
        
        DECLARE 
            L_ENAME VARCHAR2(80);
        BEGIN
           PROC_EMP_INSERT('ȫ�浿','MK_MAN',70,11000,L_ENAME);
           DBMS_OUTPUT.PUT_LINE(L_ENAME);
        END;
            
        SELECT * FROM  EMPLOYEES;
            
    
     
    
    
    
    
    
    
    
    