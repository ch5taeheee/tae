2022-1223-01) �˻����(SELECT)
 - �ڷ� ��ȸ��� ����  
 (��� ����)
    SELECT [DISTINCT] * | �÷��� [AS ��Ī][,] 
            �÷��� [AS ��Ī][,]
             :
            �÷��� [AS ��Ī]
        FROM ���̺�� 
       [WHERE ����] -- select as��Ī�� ���� X
       [ORDER BY �÷���|�÷�INDEX [ASC|DESC],...]; -- �÷��� n���� ��� ���ڷ� ǥ�� ���� ex) order by 1 , 
       . 'DISTINCT' : �ߺ� �� ����  -- ��ǥ �÷� 1����
       . �ʼ� ���� SELECT���� FROM��
       . !����Ǵ� ���� : FROM �� -> WHERE �� ->  ORDER BY �� -> SELECT ��  -- ����� �� : WHERE
       .'�÷�INDEX' : SELECT������ �÷��� ����� ����
       .'ASC|DESC' : ���� ���( ASC : �������� : ���� �� -> ū �� ��)
                             ( DESC : �������� : ū �� -> ���� �� ��)
                     �����Ǹ� ASC�� ���ֵ�.
       . FROM ������ ���̺��̳� VIEW�� ����Ǿ�� ��. -- �ΰ� �̻� ���� JOIN : ���̺� ���ϴ� �ڷᰡ �ٸ� ���̺� ���� ��
       
  (��� ��)
    SELECT A.MEM_ID AS ȸ����ȣ, A.MEM_NAME AS ȸ����, A.MEM_MILEAGE AS ���ϸ��� --. : �Ҽ��� ��Ÿ���� �Ҽ� ������.
      FROM (SELECT MEM_ID , MEM_NAME, MEM_MILEAGE
                FROM MEMBER
              WHERE MEM_ADD1 LIKE '�泲%' -- AND ROWNUM =1 �� ����� ������ 26��
              ORDER BY 3 DESC) A 
      WHERE ROWNUM = 1; -- ���� �ȿ� ������ ������ �Ǵµ� ����� �ٸ��� ����
       
       -- SELECT A.M1 AS ȸ����ȣ, A.M2 AS ȸ����, A.M3 AS ���ϸ��� --. : �Ҽ��� ��Ÿ���� �Ҽ� ������.
       -- FROM (SELECT MEM_ID AS M1 , MEM_NAME, MEM_MILEAGE
       
������
 - ���������, ���迬����, ��������, ��Ÿ������ --������ ������ X
 1) ���������
  . 4Ģ������ �����ϴ� ������(+, -, /,*)
  . ������ ������ �Լ��� ������.
  
  (��� ��) ������̺��� ������� ��������(COMMISSION_PCT)�� ���� ���ʽ��� ����Ͽ� ���޾��� ��ȸ�Ͻÿ�.
           ���ʽ� = ���������ڵ� * �⺻��
           ���޾� = �⺻��(SALARY) + ���ʽ�
           Alias(��Ī)�� �����ȣ, �����, �μ���ȣ, �⺻��, ���ʽ�, ���޾��̸� �μ���ȣ ������ ���/�ϵ� ���� �μ��̸� ���޾��� ���� ��������� ���
           
           SELECT EMPLOYEE_ID AS �����ȣ, 
                  LAST_NAME AS �����, 
                  DEPARTMENT_ID AS �μ���ȣ, 
                  SALARY AS �⺻��, 
                  SALARY * COMMISSION_PCT AS ���ʽ�, 
                  SALARY + (SALARY * COMMISSION_PCT) AS ���޾� 
            FROM HR.EMPLOYEES ORDER BY 3; --  �� ���� ����Ǹ� ����� �� , ���������� �����θ�..
            
            SELECT EMPLOYEE_ID AS �����ȣ, 
                  LAST_NAME AS �����, 
                  DEPARTMENT_ID AS �μ���ȣ, 
                  SALARY AS �⺻��, 
                  NVL(SALARY * COMMISSION_PCT,0) AS ���ʽ�,
                  SALARY + NVL(SALARY * COMMISSION_PCT,0) AS ���޾� 
            FROM HR.EMPLOYEES ORDER BY 3,6 DESC; --SALARY + NVL(SALARY * COMMISSION_PCT)) DESC;
 
 2) ���� ������
  . �ڷ� ���� ũ�⸦ ���Ͽ� ��(true)�� ����(false)�� ������� ��ȯ
  . > , < , = , <= , >= , !=(<>) (><(X))
  . �ַ� ���ǽĿ� ����
  
  
 (��� ��) ȸ�����̺��� ���ϸ����� 2000 �̻��� ȸ�������� ��ȸ�Ͻÿ�.
          Alias �� ȸ����ȣ, ȸ����, ����, ���ϸ���
          
    SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_JOB AS ����, 
           MEM_MILEAGE AS ���ϸ��� 
        FROM MEMBER 
            WHERE MEM_MILEAGE >= 2000
                ORDER BY 4 DESC;
          
 (��� ��) ȸ�����̺��� ����ȸ�������� ��ȸ�Ͻÿ�
          Alias �� ȸ����ȣ, ȸ����, �ּ�, ���ϸ���
          
     SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_ADD1||' '||MEM_ADD2 AS �ּ�, 
           MEM_MILEAGE AS ���ϸ��� 
        FROM MEMBER 
            WHERE SUBSTR(MEM_REGNO2,1,1)= '2' OR SUBSTR(MEM_REGNO2,1,1)= '4';
           
 (��� ��) ȸ�����̺��� ������ �����ϴ� ����ȸ�������� ��ȸ�Ͻÿ�
          Alias �� ȸ����ȣ, ȸ����, �ּ�, ���ϸ���
          
        SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_ADD1||' '||MEM_ADD2 AS �ּ�, 
           MEM_MILEAGE AS ���ϸ��� 
        FROM MEMBER 
            WHERE MEM_ADD1 LIKE '����%' 
            AND (SUBSTR(MEM_REGNO2,1,1)= '2' OR SUBSTR(MEM_REGNO2,1,1)= '4');
            
          
 (��� ��) ��ǰ���̺��� �ǸŰ��� 50���� �̻��� ��ǰ���� ��ȸ�Ͻÿ�  
          Alias �� ��ǰ�ڵ�, ��ǰ��, �з��ڵ�, �ǸŰ���
          
          SELECT * FROM PROD;
          
        SELECT PROD_ID AS ��ǰ�ڵ�, 
           PROD_NAME AS ��ǰ��, 
           PROD_LGU AS �з��ڵ�, 
           PROD_PRICE AS �ǸŰ���
        FROM PROD 
            WHERE PROD_PRICE >=500000 ;
          
          
 (��� ��) HR������ ������̺��� 80�� �μ��� ���� ��� ������ ��ȸ�Ͻÿ�.
          Alias �� �����ȣ, �����, �μ��ڵ�, �����ڵ�
        
        SELECT * FROM HR.EMPLOYEES;
          
        SELECT EMPLOYEE_ID AS �����ȣ,
               LAST_NAME AS �����,
               DEPARTMENT_ID AS �μ��ڵ�,
               JOB_ID AS �����ڵ�
        FROM HR.EMPLOYEES
            WHERE DEPARTMENT_ID = 80;
            
            
 (��� ��) HR������ ������̺��� 80�� �μ��� ���� ��� �� �ټӳ���� 15�� �̻��� ��������� ��ȸ�Ͻÿ�.
          Alias �� �����ȣ, �����, �Ի���, �ټӳ��, �����ڵ�
          
          SELECT * FROM HR.EMPLOYEES;
          
           SELECT EMPLOYEE_ID AS �����ȣ,
               LAST_NAME AS �����,
               HIRE_DATE AS �Ի���,
               EXTRACT (YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS �ټӳ��,
               JOB_ID AS �μ��ڵ�,
               DEPARTMENT_ID AS �����ڵ�
        FROM HR.EMPLOYEES
            WHERE DEPARTMENT_ID = 80 
            AND (EXTRACT (YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)) >= 15;
            
 (��� ��) ȸ�����̺��� ȸ���� ������ ���ϸ����� 
          0 ~ 3000 : '�Ϲ�ȸ��'
          3001 ~ 6000 : '���ȸ��'
          6001 �̻� : 'VIPȸ��'  
          �� ����� ����Ͻÿ�.
          Alias�� ȸ����ȣ, ȸ����, ���ϸ���, ���
          
          select * from MEMBER;
          
        SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_MILEAGE AS ���ϸ���,
            CASE WHEN MEM_MILEAGE <= 3000 THEN
                      '�Ϲ�ȸ��'
                 WHEN MEM_MILEAGE <=6000 THEN
                      '���ȸ��'
                 ELSE 'VIPȸ��'
             END AS ���
            FROM MEMBER ;
            
            
            
            
            
            
**ǥ���� CASE WHEN ~ THEN ���
  . SELECT�������� ���
  . 
 (������� -1)
  CASE WHEN ���ǽ�1 THEN
            ��ɹ�1;
       WHEN ���ǽ�2 THEN
            ��ɹ�2;
              :   
       ELSE ��ɹ�n;
  END
  
  (������� -2)
  CASE ���ǽ� WHEN ��1 THEN
             ��ɹ�1;
             WHEN ��2 THEN
             ��ɹ�2;
              :   
             ELSE ��ɹ�n;
  END
  
  
 3) �� ������
  . �������� ���迬���� ������ �� ���
  . NOT, AND, OR ���
  
 (��� ��) Ű����� ������ �⵵�� �Է¹޾� ��� �ش�⵵�� ��������, ��������� �Ǵ��Ͻÿ�.
 
  ACCEPT P_YEAR PROMPT '�⵵ �Է� : ' 
  DECLARE
    L_YEAR NUMBER(4):='&P_YEAR';
    L_RES VARCHAR2(200);
  BEGIN
   IF (MOD(L_YEAR,4)=0 AND MOD(L_YEAR,100)!=0) OR MOD(L_YEAR,400)=0 THEN 
         L_RES:=L_YEAR||'�⵵�� �����Դϴ�.';
   ELSE 
         L_RES:=L_YEAR||'�⵵�� ����Դϴ�.';
   END IF;
   DBMS_OUTPUT.PUT_LINE(L_RES);
  END;
  
  (��� ��) ȸ�����̺��� 20���̸鼭 ���ϸ����� 3000�̻��� ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�Ͻÿ�.
           (���̴� �ֹε�Ϲ�ȣ�� ����� ��)
  
  SELECT * FROM MEMBER;
           
           
     SELECT MEM_ID AS ȸ����ȣ,
            MEM_NAME AS ȸ����,
            MEM_REGNO1 AS �ֹι�ȣ1,
        CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','2') THEN
              EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900)
        ELSE
              EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000)
        END AS ����,
            MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
            WHERE TRUNC(CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','2') THEN
                EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900)
            ELSE
                EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000)
              END,-1) = 20
        AND MEM_MILEAGE>=3000;
        
        
         SELECT MEM_ID AS ȸ����ȣ,
                MEM_NAME AS ȸ����,
           CASE WHEN (SUBSTR(MEM_REGNO2, 1, 1)) IN('1','2') THEN 
                   EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER (SUBSTR(MEM_REGNO1, 1, 2) + 1900))
           ELSE 
                   EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER (SUBSTR(MEM_REGNO1, 1, 2) + 2000))
           END AS ����,
                MEM_MILEAGE AS ���ϸ���
           FROM MEMBER
            WHERE trunc(CASE WHEN (SUBSTR(MEM_REGNO2, 1, 1)) IN('1','2') THEN 
                   EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER (SUBSTR(MEM_REGNO1, 1, 2) + 1900))
                 ELSE 
                   EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER (SUBSTR(MEM_REGNO1, 1, 2) + 2000))
                 END, -1) = 20
            AND MEM_MILEAGE >= 3000;
           
  
  
 
 
 
 
 
 

           



 
 
 
 
 
 
 
 