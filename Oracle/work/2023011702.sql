2023-0117-02) ��Ű��(PACKAGE)
  - ���������� ���ü� �ִ� ���� ����Ŭ PL/SQL ��ü���� ��� ����ϱ� ���� ����
  - ���� ������Ʈ�� ���
  - ĸ��ȭ ��� ����
  - �����(����, ���, Ŀ��, �Լ�, ���ν��� ���� ����) �� ������(����ο��� ����� �������α׷��� ���� ���) �� �����Ǹ�
    ������ ������ �Ǿ�� ��.
    
1) �����
 - ��Ű������ ���� ����, ���, ����, �������α׷��� ���(PROTOTYPE) ����
 
 (�������)
    CREATE OR REPLACE PACKAGE ��Ű���� IS
        ����, ���, Ŀ��, ���� ����;
        
        FUNCTION �Լ���[(�Ű����� [IN|OUT|INOUT] Ÿ��,...)]
            RETURN Ÿ�Ը�;
                :
        PROCEDURE ���ν�����[(�Ű����� [IN|OUT|INOUT] Ÿ��,...)];
                :
    END [��Ű����];
    
2) ������
 - ����ο��� ���ǵ� �������α׷��� BODY �κ��� ���
 (�������)
     CREATE OR REPLACE PACKAGE BODY ��Ű���� IS
        ����, ���, Ŀ��, ���� ����;
        
        FUNCTION �Լ���[(�Ű����� [IN|OUT|INOUT] Ÿ��,...)]
            RETURN Ÿ�Ը�;
         IS|AS
         
         BEGIN
         
         END[�Լ���];
                    :
         
        PROCEDURE ���ν�����[(�Ű����� [IN|OUT|INOUT] Ÿ��,...)];
         IS|AS
        
         BEGIN
        
         END[���ν�����];
                   :
     END [��Ű����];
     
     
** ������ ���̺� ����
  1) ���̺�� : RETIRE
  ------------------------------------------------------------
    �÷�           ������ Ÿ��      N.N      PK&FK      DEFAULT
  ------------------------------------------------------------
  EMPLOYEE_ID      NUMBER(6)               PK&FK     
  RETIRE_DATE      DATE
  
     
     
     
    ��뿹) �����ȣ�� �Է¹޾� ������� ��ȯ�ϴ� �Լ�, 
            �űԻ���� ����ϴ� ���ν���,
            ����� ����� ó���ϴ� ���ν����� �����Ǵ� ��Ű���� �ۼ��Ͻÿ�. (RETIRE PLAG�� Y�� �ٲٰ� ������ RETIRE�� �Űܶ�)
            -- �ǵ��� ���� ������ �Լ�, ��ȯ�� ������ ������ ���ν����� ����ض�. 
   (�����)         
    CREATE OR REPLACE PACKAGE hr_pkg IS 
    
        --�����ȣ�� �Է¹޾� ������� ��ȯ�ϴ� �Լ�
     FUNCTION fn_get_emp_name(P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE)
        RETURN VARCHAR2;
        
    -- �űԻ���� ����ϴ� ���ν���
        PROCEDURE proc_new_emp(
            P_EMP_NAME IN VARCHAR2,
            P_HDATE IN DATE);
            
    -- ����� ����� ó��
        PROCEDURE proc_retire_emp(
            P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE,
            P_DATE IN DATE);
        END hr_pkg;
        
        
 (������)       
    CREATE OR REPLACE PACKAGE BODY hr_pkg IS 
    
        --�����ȣ�� �Է¹޾� ������� ��ȯ�ϴ� �Լ�
     FUNCTION fn_get_emp_name(P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE)
        RETURN VARCHAR2
     IS 
        L_ENAME VARCHAR2(100);
     BEGIN
        SELECT LAST_NAME INTO L_ENAME
            FROM EMPLOYEES
            WHERE EMPLOYEE_ID = P_EID;
            
          RETURN L_ENAME;
     END fn_get_emp_name;
        
    -- �űԻ���� ����ϴ� ���ν���
        PROCEDURE proc_new_emp(
            P_EMP_NAME IN VARCHAR2,
            P_HDATE IN DATE)
        IS
            L_EID EMPLOYEES.EMPLOYEE_ID%TYPE;
        BEGIN
        SELECT MAX(EMPLOYEE_ID) + 1 INTO L_EID
            FROM EMPLOYEES;
            
            INSERT INTO EMPLOYEES( EMPLOYEE_ID,LAST_NAME,HIRE_DATE) --�ʼ��Է»���
                VALUES(L_EID, P_EMP_NAME, P_HDATE);
            COMMIT;
        END proc_new_emp;
            
    -- ����� ����� ó��
        PROCEDURE proc_retire_emp(
            P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE,
            P_DATE IN DATE)
        IS
        BEGIN
            INSERT INTO RETIRE VALUES (P_EID, P_DATE);
            
            UPDATE EMPLOYEES
                SET RETIRE_FLAG = 'Y'
                WHERE EMPLOYEE_ID = P_EID;
        END proc_retire_emp;
        END hr_pkg;        
        
    (����)
   SELECT HR_PKG.FN_GET_EMP_NAME(123) FROM DUAL;
   
   EXEC HR_PKG.PROC_NEW_EMP('�̼���',SYSDATE);
        
   EXEC HR_PKG.PROC_RETIRE_EMP(184,SYSDATE);
        
        
        
        
        
        
        
        
 
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        
        