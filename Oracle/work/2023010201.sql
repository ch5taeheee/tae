2023-0102-01) �׷��Լ�
  - �ϳ� �̻��� ���� �׷����� �и��Ͽ� �� �׷캰 ��(SUM), ���(AVG), �ڷ��� ��(COUNT), �ִ밪(MAX), �ּҰ�(MIN)�� ��ȯ
  - �׷��Լ��� �Ϲ� �÷��� SELECT���� ���� ���Ǹ� �ݵ�� GROUP BY ���� ����ؾ���. 
  - GROUP BY ������ SELECT���� �׷��Լ��� ������ ���� ��� �Ϲ� �÷��� ����ؾ� �ϸ�, �ʿ��ϴٸ� SELECT���� ���� Į���� ��� ����.
  - �׷��Լ��� SELECT ���� ���Ǹ� GROUP BY���� ����ؼ��� �ȵ�.
  - �׷��Լ��� �׷��Լ��� ������ �� ������, �Ϲ��Լ��� �׷��Լ��� ���Եǰų� ������ �� ����.
 
  -- NULL ���� ī���Ϳ��� ����. *�� ���� ��ü �� ��� COUNT : �ڷ��� ��, ���� ��
  
 (�������)
    SELECT [�Ϲ� �÷�, ]
           SUM(expr) | AVG(expr) | MAX(expr) | MIN(expr) | COUNT(*|COL)
     FROM ���̺��
    [WHERE ����]                                      -- WHERE 
    [GROUP BY �÷���1[,�÷���2,...]]
    [HAVING ����]                                     -- HAVING �׷��Լ� ��ü�� ������ �ο��Ǿ� �� �� ��� ex) ���� 50 �̻��� ��
    [ORDER BY �÷���|�÷�INDEX [ASC|DESC][,   ];
    
    - COUNT(*|COL) : '*'�� ����ϸ� ���� NULL�̾ ���
    - HAVING ���� : ���ǿ� �׷��Լ��� ���� ��� 
    
 ��뿹) ������̺��� ��ü ����� �޿��հ�, ��ձ޿�, �ο���, �ִ�޿�, �ּұ޿��� ��ȸ�Ͻÿ�. -- gruob by x (--��)
 
         SELECT SUM(SALARY) AS �޿��հ�,
                ROUND(AVG(SALARY)) AS ����հ�,
                COUNT(*)AS �ο���, --��ü NULL�� ���� ī��Ʈ ��. 
                MAX(SALARY) AS �ִ�޿�,
                MIN(SALARY) AS �ּұ޿�
            FROM HR.EMPLOYEES;
 
 ��뿹) ������̺��� �� �μ��� ��� �޿�, �ο���, �ִ�޿�, �ּұ޿��� ��ȸ�Ͻÿ�. --�μ���, �μ���ȣ�� �տ� ���. 
 
          SELECT DEPARTMENT_ID AS �μ���ȣ, 
                 ROUND(AVG(SALARY)) AS ��ձ޿�,
                 COUNT(*) AS �ο���,
                 MAX(SALARY) AS �ִ�޿�,
                 MIN(SALARY) AS �ּұ޿�
            FROM HR.EMPLOYEES
            GROUP BY DEPARTMENT_ID
            ORDER BY 1;
 
 ��뿹) ��ǰ���̺��� �� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�. (����)
 
        SELECT PROD_LGU AS �з��ڵ�,
               COUNT(PROD_ID) AS ��ǰ��
            FROM PROD
            GROUP BY PROD_LGU
            ORDER BY 1;
 
 ��뿹) ȸ�����̺��� ���� ��� ���ϸ����� ��ȸ�Ͻÿ�.
 
        SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '����ȸ��' ELSE '����ȸ��' END AS ����, 
               ROUND(AVG(MEM_MILEAGE)) AS ��ո��ϸ��� 
           FROM MEMBER
           GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '����ȸ��' ELSE '����ȸ��' END ;
           
 
 ��뿹) 2020�� ���� ������Ȳ(���Լ����հ�, ���Աݾ��հ�)�� ��ȸ�Ͻÿ�.
 
        SELECT EXTRACT(MONTH FROM BUY_DATE) AS ��, 
        SUM(BUY_QTY) AS ���Լ����հ�, 
        SUM(BUY_QTY * BUY_COST) AS ���Աݾ��հ�
        FROM BUYPROD
        WHERE EXTRACT(YEAR FROM BUY_DATE) = 2020
        GROUP BY EXTRACT(MONTH FROM BUY_DATE)
        ORDER BY 1;
        
 
 ��뿹) 2020�� ������ ������Ȳ�� ��ȸ�Ͻÿ�. (����)
        
     SELECT SUBSTR(A.CART_NO,5,2) ||'��' AS ��,
          
           SUM(B.PROD_PRICE * A.CART_QTY) AS ������Ȳ
        FROM CART A, PROD B
        WHERE SUBSTR(A.CART_NO,1,4) ='2020'
        GROUP BY  SUBSTR(A.CART_NO,5,2)
        ORDER BY 1;       
        
 ��뿹) 2020�� ����, ȸ����, ������Ȳ�� ��ȸ�Ͻÿ�.
 
        SELECT SUBSTR(CART_NO, 5,2)||'��' AS ��, 
               CART_MEMBER AS ȸ����ȣ,
               SUM(CART_QTY) AS ����������� 
         FROM CART
            WHERE CART_NO LIKE '2020%' 
            GROUP BY SUBSTR(CART_NO,5,2), CART_MEMBER -- SUBSTR(CART_NO,1,4) = '2020'
            ORDER BY 1;
 
 ��뿹) ������̺��� �� �μ��� �ο��� 5�� �̻��� �μ��� �μ���ȣ, �ο���, ������������ ��ȸ�Ͻÿ�. 
 
         SELECT DEPARTMENT_ID AS �μ���ȣ,
                COUNT(*) AS �ο���,
                TRUNC(AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE))) AS ����������
            FROM HR.EMPLOYEES
            GROUP BY DEPARTMENT_ID 
            HAVING COUNT(*) >= 5 -- �׷��� ������ �غ�����.
            ORDER BY 1;
 
 ��뿹) 2020�� 5�� ���Ծ� �հ谡 50���� �̻��� ��ǰ��ȣ, ���Լ����հ�, ���Աݾ� �հ踦 ��ȸ�Ͻÿ�. 
 
  
      --(X) 
        SELECT BUY_PROD AS ��ǰ��ȣ,
               SUM(BUY_QTY) AS ���Լ����հ�,
               SUM(BUY_QTY * BUY_COST) AS ���Աݾ�
          FROM BUYPROD
             WHERE  EXTRACT(YEAR FROM BUY_DATE)=2020 AND EXTRACT(MONTH FROM BUY_DATE)=05 AND (BUY_QTY * BUY_COST)>=500000 --X
             GROUP BY BUY_PROD
             ORDER BY 1;
            
              
        SELECT BUY_PROD AS ��ǰ��ȣ,
               SUM(BUY_QTY) AS ���Լ����հ�,
               SUM(BUY_QTY * BUY_COST) AS ���Աݾ�
          FROM BUYPROD
            WHERE  EXTRACT(YEAR FROM BUY_DATE)=2020 AND EXTRACT(MONTH FROM BUY_DATE)=05 
            GROUP BY BUY_PROD
            HAVING SUM(BUY_QTY * BUY_COST)>=500000
            ORDER BY 1;
            
        SELECT BUY_PROD AS ��ǰ��ȣ,
               SUM(BUY_QTY) AS ���Լ����հ�,
               SUM(BUY_QTY * BUY_COST) AS "���Աݾ� �հ�"
            FROM BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE('20200501') AND TO_DATE('20200531')
        GROUP BY BUY_PROD
        HAVING SUM(BUY_QTY * BUY_COST) >= 1000000
        ORDER BY 3 DESC;
        
        
--------------------------------------------------------------------------------------------------------------------------------        
        
    SELECT DEPARTMENT_ID,
           COUNT(*)
        FROM HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ORDER BY 1;
        
        
    SELECT DEPARTMENT_ID,
           COUNT(COMMISSION_PCT) -- Ư���� �÷����� ����ϸ� NULL���� ī������ ���� �ʴ´�. 
        FROM HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ORDER BY 1;        
                            
                                 -- �ΰ��� �־�. ��?�ƿ�����? 
                                 -- * �� NULL ���� ����. �ش�Ǿ����� �÷��� �ΰ��� ���͵� 1�� ���
                                 
           
              
             
              
              
             
         
         
 
 
 
 
 
    