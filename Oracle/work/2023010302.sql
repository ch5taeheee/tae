2023-0103-02)���̺� ����(JOIN)
 - ������ �����ͺ��̽��� ���̺��� �ּ����� �����͸� ����
 - ���� ������ �ʿ��� ��� �������� ���̺�κ��� ������ �����ؾ��ϰ� �̸� �����ϱ� ���Ͽ� ���̺� ���̿� ���谡 �����Ǿ�� ��. 
 - �̷��� ������ ���踦 Ȱ���Ͽ� �ʿ��� ������ �������� ���̺��� �����ϴ� ������ JOIN��.
 - ������ ����
    . ���Ǵ� �����ڿ� ���� : ��������(=)�� �񵿵� ����
    . �������ǿ� ���� : ��������(���������� �����ϴ� ���Ǹ� ���, ���� �������� ���� ���� ����.), 
                      �ܺ�����(OUTER ����: ���������� �������� �ʴ� ������ ����), 
                      īŸ�þ� ����(CROSS����, ���������� ������ �����Ǿ��� ���, �߸� ����� ���)
    . ���� ��� ���� : �������� (��Ī�ο��ؼ� ����,�� ���̺� ��Ī�� �ٸ��� ���� �ٸ� ���̺�� ����)
    . ��Ÿ : ANSI ����
    
1. Cartesian Product(Cross Join)
  - ���������� ���ų� ���������� �߸��� ���
  - �ݵ�� �ʿ��� ��찡 �ƴϸ� �����ؼ��� �� ��.
  - �־��� ��� ���ο� �����ϴ� ���̺� ����� �������� ������ �������� ��ŭ�� ����� ���´�.(�ִ��� ����)
  
(�Ϲ� �������)
    SELECT �÷�list -- �÷�����Ʈ�� ,�� 
      FROM ���̺��1 [��Ī1],���̺��2 [��Ī2][,���̺��3 [��Ī3],...] --���� ���� ����, �ܾ ����ض�. ��κ� ���ĺ�
      --(.) ���������ڴ� SELECT�� WHERE���� ���, FROM�� ���̺��� �����ϴ� �Ŵ� . ����ϴ� �� �ƴ�.
      
 (ANSI CROSS JOIN) -- ANSI �� FROM ������ ���̺��� �� �ϳ� ����.
     SELECT �÷�list
      FROM ���̺��1 [��Ī1]
       CROSS JOIN ���̺��2 [��Ī2]
       
 
 SELECT COUNT(*)
  FROM BUYPROD, CART, PROD;
  
 SELECT COUNT(*)
  FROM BUYPROD
    CROSS JOIN CART
    CROSS JOIN PROD;
    
2. ��������
  - ���������� �����ϴ� �ڷḸ ���꿡 �����ϰ� �������� �ʴ� �ڷ�� ������.
  
 (�Ϲ���������)
    SELECT �÷�list
      FROM ���̺��1 [��Ī1], ���̺��2 [��Ī2] [,���̺��3 [��Ī3],...]
     WHERE ��������1
       [AND ��������2]
            :
       [AND �Ϲ�����] 
 . ���� ���̺��� n���� �� ���������� �ּ� n-1�� �̻��̾�� ��. -- ������ ���x, ������ �ּ� n -1 
       
 (ANSI��������)
    SELECT �÷�list
      FROM ���̺��1 [��Ī1]
       INNER JOIN ���̺��2 [��Ī2] ON(��������1 [AND �Ϲ�����])
       INNER JOIN ���̺��3 [��Ī3] ON(��������2 [AND �Ϲ�����]) --3�� 1,2�� ����� ���εǾ���.
            :
       [WHERE �Ϲ�����n]
        . '���̺��1'�� '���̺��2'�� �ݵ�� ���� ���� �����ؾ���
        . '�Ϲ�����1'�� ���̺��2�� ���õ� ����
        . WHERE ���� �Ϲ������� ��� ���̺� ������ ��ġ�� �����̾�� ��.
        . �� ��° INNER JOIN�� ���ʹ� ���� ���� ����� ������ �����.
        
��뿹) 2020�� 6�� ��ǰ�� �������踦 ��ȸ�Ͻÿ�.
        Alias�� ��ǰ��ȣ, ��ǰ��, ���Լ���, ���Աݾ��̸� ���Դܰ��� PROD ���̺��� �ܰ��� Ȱ���Ѵ�.
        
(�Ϲ�����) SELECT B.PROD_ID AS ��ǰ��ȣ, 
                 B.PROD_NAME AS ��ǰ��, 
                 SUM(A.BUY_QTY) AS ���Լ���, 
                 SUM(A.BUY_QTY * B.PROD_COST) AS ���Աݾ�
            FROM BUYPROD A, PROD B
            WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630') --�Ϲ�����
                AND A.BUY_PROD = B.PROD_ID -- ��������
            GROUP BY B.PROD_ID,B.PROD_NAME
            ORDER BY 1;
            
(ANSI����)
        1.  SELECT B.PROD_ID AS ��ǰ��ȣ, 
                 B.PROD_NAME AS ��ǰ��, 
                 SUM(A.BUY_QTY) AS ���Լ���, 
                 SUM(A.BUY_QTY * B.PROD_COST) AS ���Աݾ�
            FROM BUYPROD A
            INNER JOIN PROD B ON (A.BUY_PROD=B.PROD_ID AND
                A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'))
            GROUP BY B.PROD_ID,B.PROD_NAME
            ORDER BY 1;
            
            
        2.  SELECT B.PROD_ID AS ��ǰ��ȣ, 
                 B.PROD_NAME AS ��ǰ��, 
                 SUM(A.BUY_QTY) AS ���Լ���, 
                 SUM(A.BUY_QTY * B.PROD_COST) AS ���Աݾ�
            FROM BUYPROD A
            INNER JOIN PROD B ON (A.BUY_PROD=B.PROD_ID )
                WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
            GROUP BY B.PROD_ID,B.PROD_NAME
            ORDER BY 1;
        
        
(��뿹) �з��ڵ尡 'P302'�� ��ǰ������ ��ȸ�Ͻÿ�.
        Alias�� ��ǰ��ȣ, ��ǰ��, �з��ڵ�, �з���, �ŷ�ó��
        
       1. SELECT A.PROD_ID AS ��ǰ��ȣ,
               A.PROD_NAME AS ��ǰ��,
               A.PROD_LGU AS �з��ڵ�,
               B.LPROD_NM AS �з���,
               C.BUYER_NAME AS �ŷ�ó��
            FROM PROD A,LPROD B, BUYER C
            WHERE A.PROD_LGU = 'P302' AND A.PROD_LGU =B.LPROD_GU AND A.PROD_BUYER = C.BUYER_ID
            
 --  1. SELECT A.PROD_ID AS ��ǰ��ȣ,
               A.PROD_NAME AS ��ǰ��,
               A.PROD_LGU AS �з��ڵ�,
               B.LPROD_NM AS �з���,
               C.BUYER_NAME AS �ŷ�ó��
            FROM PROD A,LPROD B, BUYER C
            WHERE A.PROD_LGU = 'P302' --�Ϲ�����
                AND A.PROD_LGU =B.LPROD_GU --���� ����
                AND A.PROD_BUYER = C.BUYER_ID            
               
       2.  SELECT A.PROD_ID AS ��ǰ��ȣ,
               A. PROD_NAME AS ��ǰ��,
               A.PROD_LGU AS �з��ڵ�,
               B.LPROD_NM AS �з���,
               C.BUYER_NAME AS �ŷ�ó��
            FROM PROD A
            INNER JOIN LPROD B ON(A.PROD_LGU=B.LPROD_GU)
            INNER JOIN BUYER C ON(A.PROD_BUYER = C.BUYER_ID)
            WHERE A.PROD_LGU = 'P302'
            
            
 (��뿹) 2020�� ��ݱ� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
        Alias�� ��ǰ�ڵ�, ��ǰ��, ��������հ�, ����ݾ��հ�
        
   1.     SELECT A.PROD_ID AS ��ǰ�ڵ�,
               A.PROD_NAME AS ��ǰ��, 
               SUM(B.CART_QTY) AS ��������հ�,
               SUM(B.CART_QTY * A.PROD_COST)AS ����ݾ��հ�
        FROM PROD A, CART B 
            WHERE A.PROD_ID = B.CART_PROD AND SUBSTR(B.CART_NO,1,8) BETWEEN '20200101' AND '20200630'
            GROUP BY A.PROD_ID, A.PROD_NAME
            ORDER BY 1;
            
   2.    SELECT A.PROD_ID AS ��ǰ�ڵ�,
               A.PROD_NAME AS ��ǰ��, 
               SUM(B.CART_QTY) AS ��������հ�,
               SUM(B.CART_QTY * A.PROD_COST)AS ����ݾ��հ�
        FROM PROD A
        INNER JOIN CART B ON(A.PROD_ID = B.CART_PROD)
         WHERE A.PROD_ID = B.CART_PROD AND SUBSTR(B.CART_NO,1,8) BETWEEN '20200101' AND '20200630'
            GROUP BY A.PROD_ID, A.PROD_NAME
            ORDER BY 1;
        
                      
 (��뿹) 2020�� ��ݱ� �ŷ�ó�� ��������踦 ��ȸ�Ͻÿ�.
         Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ����ݾ��հ�
         
 1.       SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
               A.BUYER_NAME AS �ŷ�ó��,
               SUM(C.CART_QTY * B.PROD_PRICE) AS ����ݾ��հ�
          FROM BUYER A, PROD B, CART C
            WHERE B.PROD_BUYER = A.BUYER_ID AND C.CART_PROD = B.PROD_ID
            AND SUBSTR(C.CART_NO,1,8) BETWEEN '20200101' AND '20200630'
            GROUP BY A.BUYER_NAME,A.BUYER_ID
            ORDER BY 1;
            
 2.       SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
               A.BUYER_NAME AS �ŷ�ó��,
               SUM(C.CART_QTY * B.PROD_PRICE) AS ����ݾ��հ�
           FROM BUYER A
             INNER JOIN PROD B ON (B.PROD_BUYER = A.BUYER_ID)
             INNER JOIN CART C ON (C.CART_PROD = B.PROD_ID)
                        AND SUBSTR(C.CART_NO,1,8) BETWEEN '20200101' AND '20200630'
                 GROUP BY A.BUYER_NAME,A.BUYER_ID
                 ORDER BY 1;
           
                    
��뿹) HR�������� �̱� �̿��� �μ��� �ٹ��ϴ� ����� ��ȸ�Ͻÿ�.
      Alias�� �����ȣ, �����, �μ���, �ּ�, ������
      �ּҴ� �Ÿ��� ���ø� �ָ� �����ڵ� ������ ����Ͻÿ�.
      
 1.     SELECT A.EMPLOYEE_ID AS �����ȣ,
             A.LAST_NAME AS �����,
             B.DEPARTMENT_ID AS �μ���,
             C.STREET_ADDRESS ||' '|| C.CITY ||' '|| C.STATE_PROVINCE ||' '|| C.COUNTRY_ID AS �ּ�,
             B.DEPARTMENT_NAME AS ������
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.JOBS D
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID AND  B.LOCATION_ID = C.LOCATION_ID AND A.JOB_ID = D.JOB_ID
            AND  C.COUNTRY_ID != 'US'
            ORDER BY B.DEPARTMENT_ID;
            
            
2.     SELECT A.EMPLOYEE_ID AS �����ȣ,
             A.LAST_NAME AS �����,
             B.DEPARTMENT_ID AS �μ���,
             C.STREET_ADDRESS ||' '|| C.CITY ||' '|| C.STATE_PROVINCE ||' '|| C.COUNTRY_ID AS �ּ�,
             B.DEPARTMENT_NAME AS ������
        FROM HR.EMPLOYEES A
         INNER JOIN HR.DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
         INNER JOIN HR.LOCATIONS C ON (B.LOCATION_ID = C.LOCATION_ID)
         INNER JOIN HR.JOBS D ON (A.JOB_ID = D.JOB_ID)
                    AND  NOT C.COUNTRY_ID = 'US' -- C.COUNTRY_ID <> 'US'
                    
3. ��������
  - ������ ���̺� ���� �ٸ� ��Ī�� �ο��Ͽ� �����ϴ� ���� -- ���� �ٸ� ��Ī, ���� �ٸ� ���̺�� ����.
  
(��뿹) �ſ�ȯ ȸ���� ���ϸ������� ���� ���ϸ����� ������ ȸ������ ȸ����ȣ, ȸ����, ���ϸ����� ��ȸ�Ͻÿ�. 
        SELECT B.MEM_ID AS ȸ����ȣ, 
               B.MEM_NAME AS ȸ����, 
               B.MEM_MILEAGE AS ���ϸ���
         FROM MEMBER A,MEMBER B
          WHERE A.MEM_NAME = '�ſ�ȯ' AND A.MEM_MILEAGE <= B.MEM_MILEAGE

 
  
                    
                    

                    


 
               
               
      
     
        
        
        
        
 