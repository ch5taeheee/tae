2023-0106-01) DML ��ɰ� ��������
1. INSERT���� ����ϴ� �������� 
 - VALUES�� ����
 - ���������� '( )'�ȿ� ������� ����.
 
 (��뿹) ���������̺� �����ڷḦ �Է��Ͻÿ�.
         �⵵ : '2020', PROD_ID�� PROD���̺��� ��ǰ�ڵ�, 
         ������� : ��ǰ���̺��� �������(PROD_PROPERSTOCK)
         
 INSERT INTO REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_J_99,REMAIN_DATE)  
    SELECT '2020',PROD_ID,PROD_PROPERSTOCK,PROD_PROPERSTOCK,TO_DATE('20200101')
      FROM PROD;
      
      SELECT * FROM REMAIN;
      
      COMMIT;
      
2. UPDATE���� ����ϴ� ��������                                                 --WHERE �� � ��ǰ ���� SET �����ų �� ����
 - SET ������ ������ ���� ����
 - WHERE ������ ������ �׸�(��)�� ����
 
 (��뿹) �������̺��� 2020�� 1�� ��ǰ�� ���Լ����� ���ϰ� ��� �������̺��� ���Լ����� �����Ͻÿ�.
 
 UPDATE REMAIN A 
    SET REMAIN_I = (��������)
 
 (1) 2020�� 1�� ��ǰ�� ���Լ�������
 
  SELECT BUY_PROD, 
         SUM(BUY_QTY) 
      FROM BUYPROD 
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')   -- ��¥���� BETWEEN ���
     GROUP BY  BUY_PROD
     
 (2) 2020�� 1�� ���Ի�ǰ�ڵ� ��ȸ => UPDATE�� WHERE �� -- ���Ե� ��ǰ�� ������Ʈ ���Ѿ���.  WHERE ������ 
   SELECT DISTINCT BUY_PROD
       FROM BUYPROD 
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')  

-- �� �÷��� �� ������Ʈ     
 UPDATE REMAIN A 
    SET A.REMAIN_I, = (SELECT A.REMAIN_I + B.SQTY                         -- A. ����  B.�߰� ���� ���ϸ� ���� �����Ϳ� ���������.
                         FROM(SELECT BUY_PROD, 
                                     SUM(BUY_QTY) AS SQTY 
                                 FROM BUYPROD 
                                WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')  
                                 GROUP BY  BUY_PROD) B
                         WHERE A.PROD_ID = B.BUY_PROD),
        A.REMAIN_J_99 = (SELECT A.REMAIN_J_99 + B.SQTY                        -- ����� �ٲ�.
                         FROM(SELECT BUY_PROD, 
                                     SUM(BUY_QTY) AS SQTY 
                                 FROM BUYPROD 
                                WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')  
                                 GROUP BY  BUY_PROD) B
                         WHERE A.PROD_ID = B.BUY_PROD),
                         
-- �ϼ���(3���� �÷��� �� ����)                         
  UPDATE REMAIN A 
    SET(A.REMAIN_I, A.REMAIN_J_99, A.REMAIN_DATE) =  -- ���� ������ �� ���� ����
        (SELECT A.REMAIN_I + B.SQTY, A.REMAIN_J_99 + B.SQTY, TO_DATE('20200131')                     
            FROM(SELECT BUY_PROD, 
                      SUM(BUY_QTY) AS SQTY 
                  FROM BUYPROD 
                  WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')  
                  GROUP BY  BUY_PROD) B
            WHERE A.PROD_ID = B.BUY_PROD)  -- ��������� �ϸ� ��� �����Ͱ� ������Ʈ ��. NULL
   WHERE A. PROD_ID IN(SELECT DISTINCT BUY_PROD --2020�� 1�� ���Թ߻��� �ڵ常 ������ ������Ʈ �� �׸� ����
                        FROM BUYPROD 
                        WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
                        
SELECT * FROM REMAIN;
        
** ��ǰ���̺��� ��ǰ�� ���ϸ����� �Ǹ������� 0.1%�� �����Ͻÿ�. �ǸŰ� - ���԰� *0.0001

    UPDATE PROD
    SET PROD_MILEAGE=ROUND((PROD_PRICE - PROD_COST) * 0.001);
    
    SELECT PROD_ID, PROD_MILEAGE FROM PROD;
    
** MEMBER ���̺��� ��� ȸ���� ���ϸ����� 0���� ���� 
    UPDATE MEMBER
    SET MEM_MILEAGE = 0;
    
    COMMIT;
    
(��뿹) ȸ������ ���Ž����� ���� ���ϸ����� ����Ͽ� ȸ�����̺��� �����Ͻÿ�. -- (����)

SELECT A.CART_MEMBER,
       SUM(A.CART_QTY * B.PROD_MILEAGE)
    FROM  CART A, PROD B
    WHERE B.PROD_ID = A.CART_PROD
    GROUP BY A.CART_MEMBER 

    
    UPDATE MEMBER
    SET MEM_MILEAGE = (SELECT AR
                        FROM(SELECT A.CART_MEMBER AS AE,
                                    SUM(A.CART_QTY * B.PROD_MILEAGE) AS AR
                                FROM  CART A, PROD B
                                 WHERE B.PROD_ID = A.CART_PROD
                                 GROUP BY A.CART_MEMBER) C -- ȸ����ȣ�� ���ϸ��� �հ�
                         WHERE MEM_ID = C.AE)
    WHERE MEM_ID IN(SELECT CART_MEMBER FROM CART)
    
 --2020�⵵   
    UPDATE MEMBER
    SET MEM_MILEAGE = (SELECT AR
                        FROM(SELECT A.CART_MEMBER AS AE,
                                    SUM(A.CART_QTY * B.PROD_MILEAGE) AS AR
                                FROM  CART A, PROD B
                                 WHERE B.PROD_ID = A.CART_PROD
                                 AND A.CART_NO LIKE '2020%'
                                 GROUP BY A.CART_MEMBER) C -- ȸ����ȣ�� ���ϸ��� �հ�
                         WHERE MEM_ID = C.AE)
    WHERE MEM_ID IN(SELECT DISTINCT CART_MEMBER FROM CART WHERE CART_NO LIKE '2020%')
    
    
    
    SELECT *FROM MEMBER
     
     select mem_id, mem_milEagE
     from meMBER
     order by 1;
     
     SELECT CART_MEMBER ,SUM(CART_QTY*PROD_MILEAGE)
FROM CART , PROD
WHERE CART_PROD = PROD_ID AND CART_MEMBER = 'b001'
group by CART_MEMBER
     
     
  
                            

    
      
 
 
    
    
    
    
    
    
    
    
    
    
    
    
    

         

   
 
 

 
 
 
 
 
 
 