2023-0103-01) NULL ó���Լ�
 - ����Ŭ�� ��� Ÿ���� �⺻ �ʱⰪ�� NULL��
 - NULL���� ������ ����� ��� NULL��
 - NULL ���� ó���ϱ� ���� �Լ� : NVL, NVL2, NULLIF ���� ����
 
 1. NVL(co1,val)
    . 'col' ���� NULL�̸� 'val'�� ��ȯ�ϰ� NULL�� �ƴϸ� 'col' ���� ��ȯ
    . 'col'�� 'val'�� �ڷ� Ÿ���� �ݵ�� ��ġ�ؾ���. -- �ٸ��� ���� �߻�
    
��뿹) ������̺��� ������� ���ʽ��� ����ϰ� ���޾��� ����Ͻÿ�. 
       ���ʽ� = ���� * ���������� 50%
       ���޾� = ���� + ���ʽ�
       Alias�� �����ȣ, �����, ��������, ���ʽ�, ���޾� 
       
       SELECT EMPLOYEE_ID AS �����ȣ,
              LAST_NAME AS �����,
              NVL(TO_CHAR(COMMISSION_PCT,'0.99'),'�������� ����') AS ��������,
              SALARY AS ����,
              ROUND(NVL((SALARY * COMMISSION_PCT *0.5),0))AS ���ʽ�,
              SALARY + ROUND(NVL((SALARY * COMMISSION_PCT *0.5),0)) AS ���޾�
          FROM HR.EMPLOYEES;
          
��뿹) 2020�� 7�� ��� ��ǰ�� �Ǹż����հ�, �Ǹűݾ��հ踦 ��ȸ�Ͻÿ�. --��� OUTER JOIN
        SELECT B.PROD_ID AS ��ǰ�ڵ�, 
               B.PROD_NAME AS ��ǰ��, 
               NVL(SUM(A.CART_QTY),0) AS �����հ�, 
               NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS �ݾ��հ� 
          FROM CART A
          RIGHT OUTER JOIN PROD B ON(A.CART_PROD=B.PROD_ID AND A.CART_NO LIKE '202007%')
          GROUP BY B.PROD_ID,B.PROD_NAME
          ORDER BY 1;
          
2. NVL2(col,val1,val2)
    . 'col' ���� NULL�̸� val2�� ��ȯ�ϰ�, NULL�� �ƴϸ� val1�� ��ȯ��.
    . val1�� val2�� �ݵ�� ���� Ÿ���̾�� ��. 

��뿹) ������̺��� �� ����� ������(���) ������� ����Ͻÿ�. ��, ������(���) �����ȣ�� NULL�� ����� 'CEO  ���' �̶�� ����Ͻÿ�. 
        Alias�� �����ȣ, �����, ������ �����ȣ, ������ �����
        
        SELECT EMPLOYEE_ID AS �����ȣ, 
               LAST_NAME AS �����,
               MANAGER_ID AS �����ڻ����ȣ,
               NVL2(MANAGER_ID, TO_CHAR(MANAGER_ID), 'CEO���')  AS �����ڻ����
            FROM HR.EMPLOYEES;
            
��뿹) ��ǰ���̺��� ��ǰ�� ���������� ��ȸ�Ͽ� ���������� ������ 'A â��ǰ', ������ 'C â��ǰ'�� ������ ����Ͻÿ�.
    SELECT PROD_ID, 
        PROD_NAME, 
        PROD_COLOR, 
        NVL2(PROD_COLOR,'A â��ǰ' ,'C â��ǰ') 
      FROM PROD;
      
***PROD���̺��� �з��ڵ尡 'P301'�� ���� ��ǰ�� ����ܰ��� ���Դܰ��� ������ �����Ͻÿ�. --�ŷ��Ǹ��ߴ�
        UPDATE PROD 
          SET PROD_PRICE = PROD_COST
          WHERE UPPER(PROD_LGU) = 'P301'
          SELECT * FROM PROD;
          
 3. NULLIF(col1,col2)
  . 'col1'�� 'col2'�� ���� ���̸� NULL�� ����ϰ� �ٸ� ���̸� coll�� �����.
  
(��뿹) ��ǰ���̺��� ���Դܰ��� ����ܰ��� �����ϸ� ������ '���� ���� ��ǰ'�� ����ϰ� ���� ������ '���� ��ǰ'�� ����Ͻÿ�.
        Alias�� ��ǰ�ڵ�, ��ǰ��, ���
        SELECT PROD_ID AS ��ǰ�ڵ�,
               PROD_NAME AS ��ǰ��,
               NVL(TO_CHAR(NULLIF(PROD_PRICE,PROD_COST),'9,999,999'),'����������ǰ') AS  ���
            FROM PROD;
        
        SELECT PROD_ID AS ��ǰ�ڵ�,
               PROD_NAME AS ��ǰ��,
               NVL2(TO_CHAR(NULLIF(PROD_PRICE,PROD_COST),'9,999,999'),'�����ǰ', '����������ǰ') AS  ���
            FROM PROD;
            
                
            
4. IS NULL�� IS NOT NULL
 - NULL���� �񱳴� '=' �����ڷ� �Ǵ��� �� ����.
 - �ݵ�� IS NULL, IN NOT NULL �����ڷ� �Ǵ��ؾ���.
 - �� ������ �ƴ��� ���� ����
 
 ��뿹) ������̺��� COMMISSION_PCT�� NULL�� �ƴ� ������� ��ȸ�Ͻÿ�.
    SELECT COUNT(*)
        FROM HR.EMPLOYEES
        WHERE COMMISSION_PCT IS NOT NULL;
       -- WHERE COMMISSION_PCT != NULL;
            


