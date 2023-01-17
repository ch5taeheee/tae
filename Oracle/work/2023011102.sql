2023-0111-02)PL/SQL(Procedure Language SQL) -- ������ ��� 
 - ǥ�� SQL�� ��ɿ� �б���, �ݺ����, ���� ���� ���⶧���� ����� ���ѵǾ� ����.
 - ǥ�� SQL�� ����� Ȯ���Ͽ� ����� �����ϰ� �ش� ����� �������Ͽ� ���� ������ ��ü�� �����Ͽ� ������ ����
 - ���ȭ, ĸ��ȭ ����
 - �͸� ���(Anoymous Block), ����� ���� �Լ�(User Defined Function), ���� ���ν���(Stored Procedure), Ʈ����(Trigger), ��Ű��(Package)���� ������.
 -- ��ü ���� ���� ���, ������, ĸ��ȭ �ʿ�
 1. �͸� ���(Anoymous Block)
    . �ܼ� ��ũ��Ʈ���� ����Ǹ� ������ ������� ����.
    . PL/SQL�� �⺻ ����
    
(�������)
    DECLARE
        ����� - ����/���/Ŀ�� ����
    BEGIN
        �����Ͻ� ����ó��
        
     [EXCEPTION ó����
     ]
     END; -- �ݵ�� ; �ʿ�
     
     -- SELECT �÷�list into ������ FROM ���̺�� (��������������)
     -- ���� : ������ ������ �� �ִ� ������ �̸�. / ���: ������ �ʴ� �� / Ŀ�� : SELECT �� ��� ���� (= ��, Ŀ��)
     -- ������ �ϳ��� ���� ������ �� �ִµ� ���� �� �����ϰ� �����ִ� ���� Ŀ��
     
��뿹) ���ϸ����� ���� 3���� ȸ���� 2020�� 5�� ����� ���踦 ��ȸ
       Alias�� ȸ����ȣ, ȸ����, ����� �հ��̴�. �̸� �͸������� �ۼ��Ͻÿ�.
       
 1) ���ϸ����� ���� 3���� ȸ���� ȸ����ȣ �˻�
    SELECT A.MEM_ID
      FROM (SELECT MEM_ID
              FROM MEMBER
                ORDER BY MEM_MILEAGE DESC)A 
      WHERE ROWNUM<=3; --Ŀ���� �Ǿ�� ��. 
      
 2) �͸��� �ۼ�
    DECLARE
      L_MID MEMBER.MEM_ID%TYPE; --ȸ����ȣ
      L_MNAME MEMBER.MEM_NAME%TYPE; --ȸ����
      L_AMT NUMBER :=0;--����� �հ� (:=���Կ����� ) , 0 ���� ������ NULL���� ���� �߻�
      CURSOR CUR_CART01 IS
            SELECT A.MEM_ID,A.MEM_NAME 
                FROM (SELECT MEM_ID, MEM_NAME
                        FROM MEMBER
                         ORDER BY MEM_MILEAGE DESC)A 
                WHERE ROWNUM<=3; -- FETCH�� Ŀ���� �ִ� ���� �о� ���� ��
    BEGIN
      OPEN CUR_CART01;
      DBMS_OUTPUT.PUT_LINE('ȸ����ȣ    ȸ����    ���űݾ��հ�');
      DBMS_OUTPUT.PUT_LINE('------------------------------------'); 
      LOOP 
         FETCH CUR_CART01 INTO L_MID, L_MNAME; --FETCH �� �� �о�ͼ� INTO�� �־���.
         EXIT WHEN CUR_CART01%NOTFOUND; -- �ڹ��� BREAK;
           SELECT SUM(A.CART_QTY * B.PROD_PRICE) INTO L_AMT
             FROM CART A, PROD B 
           WHERE B.PROD_ID = A.CART_PROD
             AND A.CART_NO LIKE '202005%'
             AND A.CART_MEMBER = L_MID;
         
        DBMS_OUTPUT.PUT('  '||L_MID); -- PUT_LINE  �� �ٲ㼭 PUT �� �ٲ��� �ʰ� ������ ����� �ȵ�. PUT_LINE������ �� ���
        DBMS_OUTPUT.PUT('    '||L_MNAME);
        DBMS_OUTPUT.PUT('    '||TO_CHAR(L_AMT,'999,999,990'));
        DBMS_OUTPUT.PUT_LINE('   ');
        DBMS_OUTPUT.PUT_LINE('------------------------------------'); -- DBMS���â 
      END LOOP;
      CLOSE CUR_CART01;
    END;
 
 
 1.���� �� ��� ���� -- �ݵ�� �����ϰ� ����ؾ� ��. 
  - ���࿵������ ����� ���� ����
  - ������ ������ SCLAR����, REFERENCE ����, BIND ����, COMPOSITE ������ ����
(�������)
    ������[�����] [CONSTANT] ������Ÿ�� [:=��] -- CONSTANT �� ���Ǹ� ������ ����� �Ǿ���. ����� �� ���� :=���� �����ϸ� �ȵȴ�.
    
 2. SCLAR ������ ���Ǵ� ������ Ÿ��
  - ǥ�� ����Ŭ���� ���Ǵ� ������ Ÿ��,
  - PLS_INTEGER, BINARY_INTEGER : 4BYTE ������ ����(2147483647 ~ -2147483648)
  - BOOLEAN : true / false / null
  
 3. ������ ����
    ������ : ���̺��.�÷���%TYPE
    ������ : ���̺��%ROWTYPE
    ABC MEMBER%ROWTYPE;
    ABC.MEM_JOB
    
 4. BIND Ÿ��
  - �Լ��� ���ν������� �������� ����¿� ���Ǵ� ����
  - ������ ���� IN(�Է¿�), OUT(��¿�), INOUT(����� ����)���� ����
 
 5. COMPOSITE����
  - PL/SQL���� ����ϴ� �迭 ����
  - RECORD TYPE, TABLE TYPE

��뿹) Ű����� �μ���ȣ�� �Է¹޾� �ش�μ����� �� ó�� �Ի��� �Ѹ��� ��������� ����Ͻÿ�. 
       ��»����� �����ȣ, �����, �Ի���, �����ڵ��̴�. -- �������� ��� ��.
       
       ACCEPT P_DID PROMPT '�μ���ȣ(10-110) �Է� : ' --ACCEPT �ڹ��� ��ĳ�� PROMPT �޼��� ���, ;���� �ʴ´�. ����.
       DECLARE
          L_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE := '&P_DID'; -- �μ��ڵ�
          L_EID EMP.EMPLOYEE_ID%TYPE; -- �����ȣ
          L_ENAME VARCHAR2(100); -- �����
          L_HDATE DATE;--EMP.HIRE_DATE%TYPE; --L_HDATE DATE; �̷��� �ᵵ ��. -- �Ի���
          L_JID EMP.JOB_ID%TYPE; -- �����ڵ�
        
       BEGIN
         SELECT A.EMPLOYEE_ID,A.LAST_NAME,A.HIRE_DATE,A.JOB_ID
            INTO L_EID,L_ENAME,L_HDATE,L_JID --������������ INTO �ʿ�
            FROM (SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, JOB_ID
                    FROM HR.EMPLOYEES
                     WHERE DEPARTMENT_ID = L_DID
                     ORDER BY 3)A
             WHERE ROWNUM =1;
             
          DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : '||L_DID);   
          DBMS_OUTPUT.PUT_LINE('�����ȣ : '||L_EID);   
          DBMS_OUTPUT.PUT_LINE('����� : '||L_ENAME);   
          DBMS_OUTPUT.PUT_LINE('�Ի��� : '||L_HDATE);   
          DBMS_OUTPUT.PUT_LINE('�����ڵ� : '||L_JID);   
       
       END;
       
       
       
       


       
       
       