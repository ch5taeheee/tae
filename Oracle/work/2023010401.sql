2023-0104-01) �ܺ�����
 - ���ο� �����ϴ� ���̺� �� �������� ������ �� ���� ���� �������� �����ϴ� ����
 - �������� ����� ������ ���̺��� �÷��� �ܺ����� ������ '(+)'�� �߰���.
 - �ܺ����� ������ �ϳ� �̻� �����ϴ� ��� ��� �ܺ����� ���ǿ� '(+)'�� �ٿ��� ��. 
 - �ѹ��� �� ���̺��� �ܺ������� �� �� �ִ�. ��, A, B, C ���̺��� �ܺ������ϴ� ���
   A = B (+) AND C = B (+)�� ������ ����(��, A=B{+) AND B=C(+)�� ����)
 - �ܺ����� ������ OR �����ڿ� IN �����ڸ� ����� �� ����.
 
   (�Ϲ� �ܺ����� �������)
   SELECT �÷�list
      FROM ���̺��1 [��Ī1], ���̺��2 [��Ī2][, ���̺��3 [��Ī3],...]
    WHERE [��Ī1].�÷��� = [��Ī2]�÷���2(+)
      [AND [��Ī3].�÷���(+) = [��Ī2]�÷���2]
                    :
                    
   . �ܺ����� ���ǰ� �Ϲ������� ���� ���Ǹ� �������ΰ���� ��� => �ذ�å���� 
     1) ANSI �ܺ����� ���
     2) ���������� ����� �ܺ����� ��� --�Ϲ������� ���������� �̸� �����ϰ� �ܺ������� ��� 
     3) 
     
   (ANSI OUTER JOIN) 
   SELECT �÷�list
      FROM ���̺��1 [��Ī1]
    LEFT|RIGHT|FRLL OUTER JOIN ���̺��2 [��Ī2] ON(�������� [AND �Ϲ�����])
                        :
    [WHERE �Ϲ�����]
    
     . WHERE �Ϲ������� ����ϸ� �������ΰ���� ����� �� ����.
     . LEFT : ���̺��1�� ������ ���̺��2�� �������� ���� ��� 
     . RIGHT : ���̺��1�� ������ ���̺��2�� �������� ���� ��� 
     . FULL : ���̺��� ���̺��2 ���� ��� ������ ���
     
 (��뿹) ��ǰ���̺�� �з����̺��� �̿��Ͽ� ��� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�.
        Alias�� �з��ڵ�, �з���, ��ǰ�� ��
        
 1.       SELECT --A.PROD_LGU AS �з��ڵ�, 
               B.LPROD_GU AS �з��ڵ�,
               B.LPROD_NM AS �з���,
               COUNT(PROD_ID) AS "��ǰ�� ��"
          FROM PROD A, LPROD B
          WHERE A.PROD_LGU(+) = B.LPROD_GU
          GROUP BY B.LPROD_GU,B.LPROD_NM
          ORDER BY 1;
          
 2.      SELECT B.LPROD_GU AS �з��ڵ�,
                B.LPROD_NM AS �з���,
                COUNT(PROD_ID) AS "��ǰ�� ��"
          FROM PROD A 
          RIGHT OUTER JOIN LPROD B ON A.PROD_LGU = B.LPROD_GU
           GROUP BY B.LPROD_GU,B.LPROD_NM
          ORDER BY 1;
          
 (��뿹) ��ٱ��Ͽ� ȸ�����̺��� �̿��Ͽ� ��ü ȸ���鿡 ���Ͽ� ������Ȳ�� ��ȸ�Ͻÿ�. 
         Alias�� ȸ����ȣ, ȸ����, ���űݾ� 
         
1.      SELECT A.MEM_ID AS ȸ����ȣ,
               A.MEM_NAME AS ȸ����,
              NVL( SUM(C.PROD_PRICE * B.CART_QTY),0) AS ���űݾ�
          FROM MEMBER A, CART B, PROD C
         WHERE A.MEM_ID = B.CART_MEMBER(+)
         AND B.CART_PROD = C.PROD_ID(+)
          GROUP BY A.MEM_ID, A.MEM_NAME;
          
2.     SELECT A.MEM_ID AS ȸ����ȣ,
               A.MEM_NAME AS ȸ����,
              NVL(SUM(C.PROD_PRICE * B.CART_QTY),0) AS ���űݾ�
          FROM MEMBER A
          LEFT OUTER JOIN CART B ON A.MEM_ID = B.CART_MEMBER
          LEFT OUTER JOIN PROD C ON B.CART_PROD = C.PROD_ID
          GROUP BY A.MEM_ID, A.MEM_NAME;
          
 (��뿹) 2020�� 3�� ��� �ŷ�ó�� �������踦 ��ȸ�Ͻÿ�. // 
         Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ�
         
1.        SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
                A.BUYER_NAME AS �ŷ�ó��,
                SUM(B.BUY_QTY * C.PROD_COST) AS ���Աݾ�
          FROM BUYER A, BUYPROD B, PROD C
          WHERE A.BUYER_ID = C.PROD_BUYER(+)
             AND C.PROD_ID = B.BUY_PROD (+)
            AND B.BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
          GROUP BY A.BUYER_ID, A.BUYER_NAME
          
2.        SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
                A.BUYER_NAME AS �ŷ�ó��,
                NVL(SUM(B.BUY_QTY * C.PROD_COST),0) AS ���Աݾ�
          FROM BUYER A
          LEFT OUTER JOIN PROD C ON A.BUYER_ID = C.PROD_BUYER
          LEFT OUTER JOIN BUYPROD B ON (C.PROD_ID = B.BUY_PROD 
                                        AND B.BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331'))
          GROUP BY A.BUYER_ID, A.BUYER_NAME
          
 (��뿹) 2020�� 3�� ��ǰ�� �������踦 ��ȸ�Ͻÿ�.
 
           SELECT BUY_PROD, 
                  SUM(BUY_QTY * BUY_COST) AS CSUM
              FROM BUYPROD 
             WHERE BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
             GROUP BY BUY_PROD
             
 (��뿹) 2020�� 3�� �ŷ�ó�� �������踦 ��ȸ�Ͻÿ�.
        Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ�
            SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
                   A.BUYER_NAME AS �ŷ�ó��,
                   NVL(SUM(C.CSUM),0) AS ���Աݾ�
             FROM BUYER A, PROD B, 
                    (SELECT BUY_PROD,
                            SUM(BUY_QTY * BUY_COST) AS CSUM
                        FROM BUYPROD 
                        WHERE BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
                         GROUP BY BUY_PROD) C
                WHERE B.PROD_ID = C.BUY_PROD(+)
                AND A.BUYER_ID = B.PROD_BUYER(+)
                GROUP BY A.BUYER_ID,A.BUYER_NAME
                ORDER BY 1;
                
2-1) 2020�� 3�� �ŷ�ó�� �������踦 ��ȸ(��������)

           SELECT C.PROD_BUYER AS CID, -- . �ϸ� �ݵ�� ��Ī �����. 
                  SUM(A.BUY_QTY * C.PROD_COST) AS CSUM
              FROM BUYPROD A, BUYER B, PROD C
             WHERE A. BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
                AND A. BUY_PROD = C.PROD_ID
                AND C.PROD_BUYER = B.BUYER_ID
             GROUP BY C.PROD_BUYER
             
2-2) 2020�� 3�� ��� �ŷ�ó�� �������踦 ��ȸ

       SELECT D.BUYER_ID AS �ŷ�ó�ڵ�,
                D.BUYER_NAME AS �ŷ�ó��,
                NVL(E.CSUM ,0) AS ���Աݾ�
          FROM BUYER D,
                    (SELECT C.PROD_BUYER AS CID, -- . �ϸ� �ݵ�� ��Ī �����. 
                             SUM(A.BUY_QTY * C.PROD_COST) AS CSUM
                        FROM BUYPROD A, BUYER B, PROD C
                        WHERE A. BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
                            AND A. BUY_PROD = C.PROD_ID
                            AND C.PROD_BUYER = B.BUYER_ID
                        GROUP BY C.PROD_BUYER) E
        WHERE D.BUYER_ID =E.CID(+)
        ORDER BY 1;
               
(��뿹) 2020�� 6�� ��� ��ǰ�� �������踦 ��ȸ�Ͻÿ�.
        Alias �� ��ǰ�ڵ�, ��ǰ��, �������, ����ݾ��̴�.
        
1.        SELECT B.PROD_ID AS ��ǰ�ڵ�,
               B.PROD_NAME AS ��ǰ��,
               NVL(SUM(A.CART_QTY),0) AS �������,
               NVL(SUM(B.PROD_PRICE*A.CART_QTY),0) AS ����ݾ�
         FROM CART A
         RIGHT OUTER JOIN PROD B ON (A.CART_PROD = B.PROD_ID AND SUBSTR(CART_NO,1,6) ='202006')
           GROUP BY B.PROD_ID,B.PROD_NAME
          ORDER BY 1;
          
2.         SELECT B.PROD_ID AS ��ǰ�ڵ�,
               B.PROD_NAME AS ��ǰ��,
               NVL(SUM(C.ASDD),0) AS �������,
               NVL(SUM(B.PROD_PRICE*C.ASDD),0) AS ����ݾ�
         FROM PROD B, 
                    (SELECT A.CART_QTY AS ASDD, B.PROD_ID AS ASD
                    FROM CART A, PROD B
                    WHERE A.CART_PROD = B.PROD_ID AND SUBSTR(A.CART_NO,1,6) ='202006') C
            WHERE C.ASD(+) = B.PROD_ID
            GROUP BY B.PROD_ID,B.PROD_NAME
            ORDER BY 1;
------------------------------------------------------------------------------------------------------------            
 (SUBQUERY) 
 1.2020�� 6�� ��ǰ��  �������, ����ݾ� ����
 SELECT B.PROD_ID AS BID,
 B.PROD_NAME AS BNAME,
 NVL(SUM(A.CART_QTY),0) AS BMT,
 NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS BSUM
 FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
 AND A.CART_NO LIKE '202006%'
 GROUP BY B.PROD_ID, B.PROD_NAME
 
 (PROD�� �ܺ�����)
 SELECT P.PROD_ID AS ��ǰ�ڵ�, 
        P.PROD_NAME AS ��ǰ��, 
        NVL(C.BMT,0) AS �������,
        NVL(C.BSUM,0) AS ����ݾ�
 FROM PROD P,
     (SELECT B.PROD_ID AS BID,
                B.PROD_NAME AS BNAME,
                NVL(SUM(A.CART_QTY),0) AS BMT,
                NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS BSUM
                 FROM CART A, PROD B
                WHERE A.CART_PROD = B.PROD_ID
                AND A.CART_NO LIKE '202006%'
                GROUP BY B.PROD_ID, B.PROD_NAME) C
WHERE P.PROD_ID = C.BID(+)
ORDER BY 1;
-------------------------------------------------------------------------------------------------------------
 
            
            
    
       
         
         
         
    

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
