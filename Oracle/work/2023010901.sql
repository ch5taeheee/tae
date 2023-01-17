2023-0109-01)
**���������� �̿��� ���̺� ����
 - ������ ���̺��� �����Ͽ� ������ �����͸� ���� --�÷��� �����͸� �����.
 - ���������� ������� ����.(NULL �Ӽ��� ����)
 - �ܼ� ��� �Ǵ� ���̺� ���� ���� �뵵�� ���
 
(�������)
    CREATE TABLE ���̺�� [(�÷� list)] --(�÷�����Ʈ ���� ����) �÷� LIST : ���Ӱ� ���Ǿ��� �÷��� = ���������� SELECT ���� �Ȱ��ƾ� ��. �÷��� ������ ��ġ�ؾ� ��. ���������� ���� �� ���δ�.(INSERT����)
    AS 
      ��������;
    
    . ���������� ����� '���̺�'�� ������.
    --�ĺ��� ����� ����, ��ĺ� ����� ����, �ڽ��� ���� ���
    
 (��뿹) ���������̺��� 2020�� �ڷḦ �˻��Ͽ� T_REMAIN ���̺�� �����Ͻÿ�. 
    CREATE TABLE T_REMAIN
    AS
      SELECT REMAIN_YEAR,PROD_ID, REMAIN_J_00,REMAIN_I,REMAIN_O,REMAIN_J_99
      FROM REMAIN
      WHERE REMAIN_YEAR = '2020'
      ORDER BY PROD_ID;
      
**���տ����� 
 - ��ȸ(SELECT��)�� ����� ������� �����ϴ� ������ --SELECT�� ����� VIEW, Ŀ�� ��� ��. 
 - UNION, UNION ALL(������),INTERSECT(������), MINUS(������) ���� --(������ : A-B / B-A) / ������ ���� �� �ִ�~ / (UNION : �ߺ��� ������ ������, �ߺ��� �κ��� �ѹ��� )
 - ���� ���Ǵ� SELECT���� �÷��� ������ Ÿ���� ��ġ�ؾ���.
 - ORDER BY���� �� ������ SELECT������ ��밡��
 - BLOB, CLOB, BFILE, LONG Ÿ���� ���տ��꿡 ����� �� ����.
 
 -- �÷��� ������ ��ü�� ����?
 
 1) UNION
 - �ߺ��� ������ �������� ����� ��ȯ 
 
 (��뿹) ȸ�����̺��� ������ '�ڿ���'�� ȸ���� ����ȸ���� ȸ����ȣ, ȸ����, ���ϸ����� ��ȸ�Ͻÿ�. 
 
 (������ �ڿ����� ȸ��)
 SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_MILEAGE AS ���ϸ���
   FROM MEMBER
  WHERE MEM_JOB = '�ڿ���' 
  UNION
 -- (����ȸ��)
 SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_MILEAGE AS ���ϸ���
   FROM MEMBER
  WHERE SUBSTR(MEM_REGNO2,1,1) IN ('2','4')
  
 --  SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_MILEAGE AS ���ϸ���
 --  FROM MEMBER
 --  WHERE SUBSTR(MEM_REGNO2,1,1)='2' AND SUBSTR(MEM_REGNO2,1,1)='4'
 
  SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_MILEAGE AS ���ϸ���
   FROM MEMBER
  WHERE MEM_JOB = '�ڿ���' 
  UNION ALL
 SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_MILEAGE AS ���ϸ���
   FROM MEMBER
  WHERE SUBSTR(MEM_REGNO2,1,1) IN ('2','4')
  ORDER BY 1;
  
 (��뿹) 2020�� 4�� ��ǰ�� ���Լ�������� ����������踦 ���غ���. 
        ��� : ��ǰ��ȣ, ��ǰ��, ���Լ�������, �����������
 (2020�� 4�� ��ǰ�� ���Լ�������)
 
    SELECT A.BUY_PROD AS ��ǰ��ȣ,
           B.PROD_NAME AS ��ǰ��,
           SUM(A.BUY_QTY) AS ��������
        FROM BUYPROD A, PROD B
       WHERE A.BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200430')
            AND A.BUY_PROD = B.PROD_ID
       GROUP BY A.BUY_PROD, B.PROD_NAME
       
       SELECT TA.A1 AS ��ǰ�ڵ�,
              TA.A2 AS ��ǰ��,
              TA.A3 AS ���Լ���,
              0 AS ������� --������� �����ϱ� 0���� ��.
           FROM ( SELECT A.BUY_PROD AS A1,
                         B.PROD_NAME AS A2,
                         SUM(A.BUY_QTY) AS A3
                    FROM BUYPROD A, PROD B
                    WHERE A.BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200430')
                    AND A.BUY_PROD = B.PROD_ID
                    GROUP BY A.BUY_PROD, B.PROD_NAME
       
  
 (2020�� 4�� ��ǰ�� �����������)
    SELECT A.CART_PROD AS ��ǰ��ȣ,
           B.PROD_NAME AS ��ǰ��,
           SUM(A.CART_QTY) AS ��������
        FROM CART A, PROD B
       WHERE A.CART_NO LIKE '202004%'
            AND A.CART_PROD = B.PROD_ID
       GROUP BY A.CART_PROD, B.PROD_NAME


       SELECT TA.A1 AS ��ǰ�ڵ�,
              TA.A2 AS ��ǰ��,
              TA.A3 AS ���Լ���,
              0 AS ������� --������� �����ϱ� 0���� ��.
           FROM ( SELECT A.BUY_PROD AS A1,
                         B.PROD_NAME AS A2,
                         SUM(A.BUY_QTY) AS A3
                    FROM BUYPROD A, PROD B
                    WHERE A.BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200430')
                    AND A.BUY_PROD = B.PROD_ID
                    GROUP BY A.BUY_PROD, B.PROD_NAME )TA
    UNION 
        SELECT TB.B1 AS ��ǰ�ڵ�,
               TB.B2 AS ��ǰ��,
               0 AS ���Լ���,
               TB.B3 AS �������
           FROM (SELECT A.CART_PROD AS B1,
                        B.PROD_NAME AS B2,
                        SUM(A.CART_QTY) AS B3
                        FROM CART A, PROD B
                         WHERE A.CART_NO LIKE '202004%'
                        AND A.CART_PROD = B.PROD_ID
                        GROUP BY A.CART_PROD, B.PROD_NAME )TB
 
 3) INTERSECT(������)
  - �������� SELECT���� ��� �� �����κ�(�ߺ�)�� ��ȯ�ϴ� ������
  
 (��뿹) ��ٱ������̺��� 2020�� 4��, 2020�� 5��, 2020�� 6�� ��� �Ǹŵ� ��ǰ�� ��ǰ��ȣ, ��ǰ��, �з����� ����Ͻÿ�. -- �Ǹż����� �� �ȴ�. 
   --��Ī�� �ʿ�X ù��° ���
 SELECT DISTINCT A.CART_PROD AS ��ǰ��ȣ, 
        B.PROD_NAME AS ��ǰ��, 
        C.LPROD_NM AS �з���
   FROM CART A, PROD B, LPROD C
  WHERE A.CART_PROD = B.PROD_ID AND B.PROD_LGU = C.LPROD_GU
        AND A.CART_NO LIKE '202004%'
INTERSECT     
 SELECT DISTINCT A.CART_PROD ,
        B.PROD_NAME, 
        C.LPROD_NM 
   FROM CART A, PROD B, LPROD C
  WHERE A.CART_PROD = B.PROD_ID AND B.PROD_LGU = C.LPROD_GU
        AND A.CART_NO LIKE '202005%'
 INTERSECT       
 SELECT DISTINCT A.CART_PROD, 
        B.PROD_NAME , 
        C.LPROD_NM
   FROM CART A, PROD B, LPROD C
  WHERE A.CART_PROD = B.PROD_ID AND B.PROD_LGU = C.LPROD_GU
        AND A.CART_NO LIKE '202006%'
  ORDER BY 1;
  
  => EXISTS ������ -- ������ ��������
  
SELECT DISTINCT A.CART_PROD AS ��ǰ��ȣ, 
        B.PROD_NAME AS ��ǰ��, 
        C.LPROD_NM AS �з���
   FROM CART A, PROD B, LPROD C
  WHERE A.CART_PROD = B.PROD_ID AND B.PROD_LGU = C.LPROD_GU
        AND A.CART_NO LIKE '202004%'
AND EXISTS( SELECT 1 -- WHERE �����ϸ� �� (1), ���� (0) 1�� ��µǸ� ���� ��µ�
                   FROM CART D
                   WHERE D.CART_PROD = A.CART_PROD --4������ �ǸŵǾ��� ��ǰ�ڵ� A, 5���� D
                        AND D.CART_NO LIKE '202005%' 
AND EXISTS( SELECT 1 -- ���� �������� ������ �ƹ��͵� ��� X , �� �������� �ʾ� ? FALSE
                   FROM CART E
                   WHERE E.CART_PROD = D.CART_PROD --4���� A, 6���� E
                        AND E.CART_NO LIKE '202006%' ))
                        
4) MINUS(������) -- = NOT EXISTS
 - �� ��� ������ ���� ����� ��ȯ
 - ���Ǵ� ��ġ�� ���� ����� ����

 (��뿹) ��ٱ������̺��� 2020�� 6���� 7�� ���� �� 7������ �Ǹŵ� ��ǰ������ ��ȸ�Ͻÿ�.
         Alias �� ��ǰ��ȣ, ��ǰ��
    
 (7�� �Ǹŵ� ��ǰ)        
    SELECT DISTINCT A.CART_PROD AS ��ǰ��ȣ, B.PROD_NAME AS ��ǰ��
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '202007%'
        AND A.CART_PROD = B.PROD_ID
 (6�� �Ǹŵ� ��ǰ)
    SELECT DISTINCT A.CART_PROD AS ��ǰ��ȣ, B.PROD_NAME AS ��ǰ��
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '202006%'
        AND A.CART_PROD = B.PROD_ID
 
 (����)
    SELECT DISTINCT A.CART_PROD AS ��ǰ��ȣ, B.PROD_NAME AS ��ǰ��
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '202007%'
        AND A.CART_PROD = B.PROD_ID
        AND NOT EXISTS (SELECT 1 
                        FROM CART C
                        WHERE C.CART_NO LIKE '202006%' 
                        AND A.CART_PROD = C.CART_PROD)
     ORDER BY 1;
(���� : MINUS�� �̿�)        
    SELECT DISTINCT A.CART_PROD AS ��ǰ��ȣ, B.PROD_NAME AS ��ǰ��
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '202007%'
        AND A.CART_PROD = B.PROD_ID
  MINUS       
    SELECT DISTINCT A.CART_PROD AS ��ǰ��ȣ, B.PROD_NAME AS ��ǰ��
       FROM CART A, PROD B
      WHERE A.CART_NO LIKE '202006%'
        AND A.CART_PROD = B.PROD_ID
     ORDER BY 1;
 