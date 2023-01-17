2023-0105-01)SUBQUERY
 - ���� �ȿ� ���Ե� �� �ٸ� ������ ���������� �Ѵ�. 
 - ���������� �˷����� ���� ���ǿ� ���� ������ ������ �� ����.
 - �����ؾ� �� JOIN�� ���� ���� �� ����.
 - ���������� '()'�ȿ� ���. ��, INSERT INTO ���� ���Ǵ� ���������� '( )' ���� ���
 - ���������� ������ �����ʿ� ��ġ�ؾ� ��. 
 - ���������� �з�
  . �Ϲ� ��������, INLINE VIEW, ��ø�������� --FROM���� ������ ���������� 100% ���� ����Ǿ����� ��. 
  . ������������, �񿬰��� ��������
  . ������/������, ���Ͽ�/���߿� ��������
  
 (��뿹) ������� ��ձ޿�(��������)���� ���� �޿��� �޴� ����� �����ȣ, �����, �޿��� ����Ͻÿ�.(��������)
 (�������� : ����� �����ȣ, �����, �޿��� ���)
  SELECT EMPLOYEE_ID AS �����ȣ, 
         LAST_NAME AS �����, 
         SASARY AS �޿�
    FROM HHR.EMPLOYEES 
  WHERE SALARY >= (��������);
  
(�������� : ������� ��ձ޿�) 
 SELECT AVG(SALARY) FROM HR.EMPLOYEES;
 
(����) 
1.  SELECT EMPLOYEE_ID AS �����ȣ, 
         LAST_NAME AS �����, 
         SALARY AS �޿�
    FROM HR.EMPLOYEES 
  WHERE SALARY >= (SELECT AVG(SALARY) FROM HR.EMPLOYEES);
  
2.  SELECT A.EMPLOYEE_ID AS �����ȣ,               --�ζ��κ� �������� / ����Ƚ�� 1��
        A.LAST_NAME AS �����, 
        A.SALARY AS �޿�
    FROM HR.EMPLOYEES A ,(SELECT AVG(SALARY)AS ASAL FROM HR.EMPLOYEES)B
    WHERE A.SALARY > B.ASAL
    
    
 (��뿹) �� �μ��� �ִ�޿��� ������ �޿��� �޴� ������� �����ȣ, �����, �μ��ڵ�, �μ����� ��� �Ͻÿ�.
 (�������� : ������� �����ȣ, �����, �μ��ڵ�, �μ����� ���)
1.   SELECT �����ȣ, �����, �μ��ڵ�, �μ���
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
      WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        AND (A.DEPARTMENT_ID,A.SALARY) IN(��������)
        
 (�������� : �� �μ��� �ִ�޿�)
  SELECT DEPARTMENT_ID,
         MAX(SALARY)
    FROM HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID
   
 (����) 
  SELECT A.EMPLOYEE_ID AS �����ȣ, 
         A.LAST_NAME AS �����, 
         A.SALARY AS �޿�,
         B.DEPARTMENT_ID AS �μ��ڵ�, 
         B.DEPARTMENT_NAME AS �μ���
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
      WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        AND (A.DEPARTMENT_ID,A.SALARY) IN(SELECT DEPARTMENT_ID,   -- ���� �÷��� ���� ���� �� () ���´�. ��~~
                                                 MAX(SALARY)
                                             FROM HR.EMPLOYEES
                                            GROUP BY DEPARTMENT_ID)
       ORDER BY 4;
        
 SELECT EMPLOYEE_ID,
        SALARY
   FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID = 50
   ORDER BY 2 DESC;

 (��뿹)�������� ���̺�(job_history)�� �ִ� �μ��ڵ��� ���� �μ��� �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
    SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
           A.DEPARTMENT_NAME AS �μ���
     FROM HR.DEPARTMENTS A
    WHERE A.DEPARTMENTS_ID = (�������� : �����������̺� �ִ� �μ��ڵ�)
 (IN ������)
    SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
           A.DEPARTMENT_NAME AS �μ���
     FROM HR.DEPARTMENTS A
    WHERE A.DEPARTMENT_ID IN (SELECT DISTINCT DEPARTMENT_ID
                                  FROM HR.JOB_HISTORY);
 (EXISTS ������) --�������� ����� �ϳ��� ������ ��, ������ ���� ��µ� ����� ��� ����. 
     SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
           A.DEPARTMENT_NAME AS �μ���
       FROM HR.DEPARTMENTS A
      WHERE EXISTS ( SELECT  1 --1�� �ǹ��ϴ� ��? 1����϶�... ����ϸ� ��ü ������ ��. ��� �� �ϸ� ����
                        FROM HR.JOB_HISTORY B 
                       WHERE B.DEPARTMENT_ID = A.DEPARTMENT_ID) --���������� * �� �� ��.
                       
 (��뿹) 2020�� 5�� ������� ���� 5���� ȸ���� ��ȸ�ϰ� �� ȸ������ ȸ����ȣ, ȸ����, �ּ�, ���ϸ����� ����Ͻÿ�. --���� ������ �����ؼ� ������ �߶��
 
 (1) 2020�� 5�� ȸ���� ���űݾ��հ踦 ��ȸ�ϰ� ���űݾ��հ谡 ���� ȸ�� ������ ��� --FROM���� �������� 
    SELECT D.MEM_ID AS ȸ����ȣ,
           D.MEM_NAME AS ȸ����,
           D.MEM_ADD1||' '||D.MEM_ADD2 AS �ּ�,
           D.MEM_MILEAGE AS ���ϸ���,
           C.CSUM AS ���űݾ��հ�
      FROM (SELECT A.CART_MEMBER AS CID,
                  SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM
             FROM CART A, PROD B
            WHERE B.PROD_ID = A.CART_PROD AND A.CART_NO LIKE '202005%'    
            GROUP BY A.CART_MEMBER
            ORDER BY 2 DESC)C, MEMBER D
     WHERE D.MEM_ID = C.CID 
      AND ROWNUM <=5;
      
**���������̺� ����
 1) ���̺�� : REMAIN
 2) �÷�
 -------------------------------------------------------------------------------------
 �÷���             ������Ÿ��           NOT NULL ����         PK/FK          DEFAULT��     
--------------------------------------------------------------------------------------
REMAIN_YEAR         CHAR(4)                                  PK
PROD_ID             VARCHAR2(10)                             PK&FK
REMAIN_J_00         NUMNER(5)                                                   0      -- ���� ��� �ѹ� ��������
REMAIN_J_I          NUMNER(5)                                                   0      -- �԰�
REMAIN_J_O          NUMNER(5)                                                          -- ���
REMAIN_J_99         NUMNER(5)                                                          -- ����� (�԰� + ��� - ���)
REMAIN_DATE         DATE                                                               -- ������ ������ �Ǿ��� ��¥


    

 
 
 
 








