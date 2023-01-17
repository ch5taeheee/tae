2023-0112-02) �ݺ���
1) Ŀ��(CURSOR) -- SELECT INTO FROM SELECT������ ������ ���� ���Ǿ����� ������ �Ѽ����� �ϳ����� �����͸� ����, 
                -- �÷����� �������� �ڷḦ ���� �� �ִ�. SELECT���� ������ ���� �ڷḦ Ŀ���� ����� ���� FETCT �� ���྿�о�
 - Ŀ���� ���Ƿ� ����Ŭ DML ������� ���� �޴� ����� �����̰�, ���Ƿδ� SELECT���� ��� ������
 - Ŀ���� ��� ���� ���� �ڷḦ �����ڰ� �����ϱ� ���� ���� --������� ������ ���� ����� �����ϴ� ���� Ŀ����.

 
 - �͸�Ŀ��
   . �̸��� ���� Ŀ���� �Ϲ����� SELECT�� ���� �並 �ǹ���.
   . �͸�Ŀ���� ������ ���ÿ� CLOSE �Ǿ� �����ڰ� ������ ���� ���� -- �����Ŀ��(4�ܰ� (19)): ���� �ο�, --������Ŀ��
   . �͸�Ŀ�� �Ӽ�
   ----------------------------------------------------------------------
     Ŀ���Ӽ�            �ǹ� ---(�͸�Ŀ���� �׻� SQL, Ŀ���� Ŀ����%)
     --------------------------------------------------------------------
     SQL%ISOPEN        Ŀ���� OPEN �����̸� TRUE ���� �����̸� FALSE
                       �͸�Ŀ���� �׻� FALSE
     SQL%NOTFOUND      Ŀ�� ���ο� FETCH �� �ڷᰡ ������ FALSE, ������ TRUE -- ����Ǿ������� FETCH�� ����Ǿ�� ��.
     SQL%FOUND         Ŀ�� ���ο� FETCH �� �ڷᰡ ������ TRUE, ������ FALSE -- ����Ǿ������� FETCH�� ����Ǿ�� ��.
     SQL%ROWCOUNT      Ŀ�� ������ ���� ��
     --------------------------------------------------------------------
    
  - Ŀ���� ���� ����
  . Ŀ�� ����(�����) => OPEN => FETCH => CLOSE -- ���(OPEN) ������� �о��(FETCH) 
  
  (1) Ŀ�� ����
  . ����ο��� ����
  
    (��������)
     CURSOR Ŀ����[(������ Ÿ�� [,������ Ÿ��,...])] IS -- Ÿ�Ը� ���� ũ�⸦ �Ἥ�� �� �ȴ�. ������ Ÿ�� ��� ����, ������ OPEN������ ���� ����, 
       SELECT ��;
       
  (2) OPEN��
  . Ŀ���� ����ϱ� �� �ݵ�� OPEN �ؾ���
  . ���࿵������ ����
  .
  
    (��� ����)
    OPEN Ŀ���� [(�Ű�����,...)];
     . '�Ű�����' : Ŀ�����𹮿� ������ ��
     
 (��뿹) Ű����� �μ���ȣ�� �Է¹޾� �ش�μ��� ���� ����� �����ȣ, �����, �Ի���, �޿��� ����ϴ� Ŀ���� �ۼ��Ͻÿ�.
        
        ACCEPT P_DID PROMPT '�μ���ȣ(10-110) : ' -- OPEN CURSOR ������� ������� ������ �ִ�. �̰� �ٷ� Ŀ����. ��
        DECLARE --L_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE:='&P_DID' 
                L_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; -- �̷��� ����������
                L_ENAME VARCHAR2(45);
                L_HDATE DATE;
                L_SALARY HR.EMPLOYEES.SALARY%TYPE;
                
                CURSOR CUR_EMP02(HR.DEPARTMENTS.DEPARTMENT_ID%TYPE L_DID
                    IS SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY     --BEGIN ��Ͽ��� SELECT INTO FROM �� ���(�������������� ��������X) , CURSOR�� ���X
                            FROM HR.EMPLOYEES
                                WHERE DEPARTMENT_ID = L_DID;
        BEGIN 
            OPEN CUR_EMP02('&P_DID')
        END;
        
  (3) FETCH��     
  . Ŀ����� ���տ��� ������� �����͸� �о���� ���
  
  (�������) 
   FETCH Ŀ���� INTO ������ [,������,...];
   
  - Ŀ������ SELECT ���� �÷��� ������ FETCH �� INTO ���� ������ ������ ��ġ�ؾ� �Ѵ�. 
  - ��� ���տ��� �� ù��° ����� ���ʴ�� ������� �����͸� ������ INTO ������ ������ �Ҵ�
  - ���� FETCT ���� �ݺ��� ���ο� �����ؾ� ��.

  (4) CLOSE��
  . ����� ���� Ŀ���� �ݵ�� �ݾƾ� �� OPEN �� �� ����.
  
  (�������)
  CLOSE Ŀ����;
  

2) �ݺ���
 - ����Ŭ PL/SQL�� ���Ǵ� �ݺ����� LOOP, WHILE, FOR���� �����ǰ� ����. --������ ���ѷ��� ����
 - �ݺ����� ��κ� Ŀ���� ����� �������� �̿��.
 
 (1) LOOP�� 
  . ���ѷ����� �����ϴ� �ݺ����� �⺻ ������ ����
  (�������)
   LOOP 
     �ݺ���ɹ�(��); 
     [EXIT WHEN ����;]--Ŀ��%NOTFOUND
     [�ݺ���ɹ�(��);]
    END LOOP;
    
    . 'EXIT WHEN ����' : ������ �����ϸ� �ݺ��� ���
    
    
        ACCEPT P_DID PROMPT '�μ���ȣ(10-110) : ' -- OPEN CURSOR ������� ������� ������ �ִ�. �̰� �ٷ� Ŀ����. ��
        DECLARE --L_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE:='&P_DID' 
                L_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; -- �̷��� ����������
                L_ENAME VARCHAR2(45);
                L_HDATE DATE;
                L_SALARY HR.EMPLOYEES.SALARY%TYPE;
                --
                L_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME%TYPE;
                
                CURSOR CUR_EMP02(L_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) 
                    IS 
                    SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY     --BEGIN ��Ͽ��� SELECT INTO FROM �� ���(�������������� ��������X) , CURSOR�� ���X
                            FROM HR.EMPLOYEES
                                WHERE DEPARTMENT_ID = L_DID;
        BEGIN 
            OPEN CUR_EMP02('&P_DID'); --�μ���ȣ ���
            --
            SELECT DEPARTMENT_NAME INTO L_DNAME FROM HR.DEPARTMENTS WHERE DEPARTMENT_ID = '&P_DID';
            DBMS_OUTPUT.PUT_LINE('�μ���ȣ : &P_DID' || '�μ��� : '||L_DNAME);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            LOOP -- ������
                FETCH CUR_EMP02 INTO L_EID,L_ENAME,L_HDATE,L_SALARY;
                EXIT WHEN CUR_EMP02%NOTFOUND; -- �� �̻� ���� �ڷᰡ �������� ������ �� -> LOOP ��
        
            DBMS_OUTPUT.PUT_LINE('�����ȣ : '||L_EID);
            DBMS_OUTPUT.PUT_LINE('����� : '||L_ENAME);
            DBMS_OUTPUT.PUT_LINE('�Ի��� : '||L_HDATE);
            DBMS_OUTPUT.PUT_LINE('�޿� : '||L_SALARY);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            
             END LOOP;
            DBMS_OUTPUT.PUT_LINE('��ü �ο� : '|| CUR_EMP02%ROWCOUNT);
            CLOSE CUR_EMP02;
        END;
        
 (2)WHILE ��
  . ������ �ο��Ͽ� ������ �� ����� ���� �ݺ� ���࿩�θ� �����ϴ� �ݺ���
  (�������)
  WHILE ���� LOOP
    �ݺ�ó����(��);
  END LOOP;
   . '����'�� ��(true)�̸� �ݺ� ����
   
 ��뿹) �������� 7���� ����Ͻÿ�. 
 
     DECLARE
        L_CNT NUMBER:=1;
     BEGIN
        WHILE L_CNT <= 9 LOOP 
         DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT || ' = ' || 7 * L_CNT);
         L_CNT := L_CNT +1;
        END LOOP;
     END;
     
     
        ACCEPT P_DID PROMPT '�μ���ȣ(10-110) : ' -- OPEN CURSOR ������� ������� ������ �ִ�. �̰� �ٷ� Ŀ����. ��
        DECLARE --L_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE:='&P_DID' 
                L_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; -- �̷��� ����������
                L_ENAME VARCHAR2(45);
                L_HDATE DATE;
                L_SALARY HR.EMPLOYEES.SALARY%TYPE;
                --
                L_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME%TYPE;
                
                CURSOR CUR_EMP02(L_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) 
                    IS 
                    SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY     --BEGIN ��Ͽ��� SELECT INTO FROM �� ���(�������������� ��������X) , CURSOR�� ���X
                            FROM HR.EMPLOYEES
                                WHERE DEPARTMENT_ID = L_DID;
        BEGIN 
            OPEN CUR_EMP02('&P_DID'); --�μ���ȣ ���
            --
            SELECT DEPARTMENT_NAME INTO L_DNAME FROM HR.DEPARTMENTS WHERE DEPARTMENT_ID = '&P_DID';
            DBMS_OUTPUT.PUT_LINE('�μ���ȣ : &P_DID' || '�μ��� : '||L_DNAME);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            FETCH CUR_EMP02 INTO L_EID,L_ENAME,L_HDATE,L_SALARY;
 --(WHILE ���)
            WHILE (CUR_EMP02%FOUND) LOOP 
           
            DBMS_OUTPUT.PUT_LINE('�����ȣ : '||L_EID);
            DBMS_OUTPUT.PUT_LINE('����� : '||L_ENAME);
            DBMS_OUTPUT.PUT_LINE('�Ի��� : '||L_HDATE);
            DBMS_OUTPUT.PUT_LINE('�޿� : '||L_SALARY);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            
            FETCH CUR_EMP02 INTO L_EID,L_ENAME,L_HDATE,L_SALARY;
            
             END LOOP;
            DBMS_OUTPUT.PUT_LINE('��ü �ο� : '|| CUR_EMP02%ROWCOUNT);
            CLOSE CUR_EMP02;
        END;
 
  (3)FOR ��
   . �ݺ�Ƚ���� ��Ȯ�� �˰� �ְų� �ݺ�Ƚ���� �߿��� ��� ����ϴ� �ݺ���
 (�Ϲ� FOR��)
   (�������)
    FOR �ε��� IN [REVERSE] �ʱⰪ...������ LOOP
        �ݺ�ó����ɹ�(��);
    END LOOP;
    
     . '�ε���'�� �ʱⰪ�� ������ �� �������� �� �� 1�� ���� �Ǵ� ����([REVERSE]) ��Ű�鼭 �ݺ�ó����ɹ�(��)�� ������.
     . '�ε���'�� �ý��ۿ��� �ڵ����� �������ִ� �����̴�.
     
(��뿹) �������� 7���� ���
    DECLARE 
    BEGIN
      FOR I IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE('7 * '||I||' = '||7*I);
      END LOOP;
    END;
    
    --------------------------------------------------------------------------------------------------------
    DECLARE 
    BEGIN
      FOR I IN REVERSE 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE('7 * '||I||' = '||7*I);
      END LOOP;
    END;
    
 (Ŀ���� FOR��)
   (�������)
    FOR ���ڵ�� IN Ŀ����|IN-LINE Ŀ���� LOOP
        �ݺ�ó����ɹ�(��);
    END LOOP;
    
    . Ŀ���� FOR���� ����ϸ� OPEN, FETCH, CLOSE�� ���ʿ���.
    . Ŀ�� ���� ��� IN ���� IN_LINE ���������� �������
    . Ŀ���� �÷��� ������ '���ڵ��.Ŀ��SELECT���� �÷���' �������� ����
    
    
        ACCEPT P_DID PROMPT '�μ���ȣ(10-110) : ' 
        DECLARE 
                L_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME%TYPE;
                CURSOR CUR_EMP02
                    IS 
                     SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY    
                            FROM HR.EMPLOYEES
                            WHERE DEPARTMENT_ID = '&P_DID';
        BEGIN -- Ŀ�� FOR���� OPEN�� �ʿ� X
            SELECT DEPARTMENT_NAME INTO L_DNAME FROM HR.DEPARTMENTS WHERE DEPARTMENT_ID = '&P_DID';
            DBMS_OUTPUT.PUT_LINE('�μ���ȣ : &P_DID' || '�μ��� : '||L_DNAME);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            --Ŀ�� FOR��
           FOR REC IN CUR_EMP02 LOOP 
           
            DBMS_OUTPUT.PUT_LINE('�����ȣ : '||REC.EMPLOYEE_ID);
            DBMS_OUTPUT.PUT_LINE('����� : '||REC.LAST_NAME);
            DBMS_OUTPUT.PUT_LINE('�Ի��� : '||REC.HIRE_DATE);
            DBMS_OUTPUT.PUT_LINE('�޿� : '||REC.SALARY);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            
             END LOOP;
            
        END;    
    ------------------------------------------------------------------------------------------------- Ŀ���� �� �Ἥ �� ���� ����.
       ACCEPT P_DID PROMPT '�μ���ȣ(10-110) : ' 
        DECLARE 
                L_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME%TYPE;
                
        BEGIN -- Ŀ�� FOR���� OPEN�� �ʿ� X
            SELECT DEPARTMENT_NAME INTO L_DNAME 
                FROM HR.DEPARTMENTS 
              WHERE DEPARTMENT_ID = '&P_DID';
              
            DBMS_OUTPUT.PUT_LINE('�μ���ȣ : &P_DID' || '�μ��� : '||L_DNAME);
            
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
--Ŀ�� FOR��
           FOR REC IN (SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY     --IN ������ Ŀ���� ��ſ� SELECT�� /  OPEN, FETCH, CLOSE ����
                            FROM HR.EMPLOYEES
                            WHERE DEPARTMENT_ID = '&P_DID') LOOP 
           
            DBMS_OUTPUT.PUT_LINE('�����ȣ : '||REC.EMPLOYEE_ID);
            DBMS_OUTPUT.PUT_LINE('����� : '||REC.LAST_NAME);
            DBMS_OUTPUT.PUT_LINE('�Ի��� : '||REC.HIRE_DATE);
            DBMS_OUTPUT.PUT_LINE('�޿� : '||REC.SALARY);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            
             END LOOP;
            
        END;   
     
    
   
   
   
   
   
   
   

   
   
   
   
   
   
   
   
   
   
   
   
 
        

    
        
     

    
    
  
  
  
  
  
  
  
                                
                                
        
        
   
 
        
