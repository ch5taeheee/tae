2022-1229-01)�����Լ�
1. ABS(n), SIGN(n), SQRT(n), POWER(n,b)
 - ������ �������� ��ȯ
 - ABS : ���밪, SIGN : �������� ��ȣ�� ����(-1,0,1) ��ȯ,
 - SQRT : ����, POWER: n�� b�� ��, �� �ۿ��� �ﰢ�Լ��� �����Լ� �� ���������� ������.
 
 (��뿹) SELECT ABS(-200),ABS(200), 
                SIGN(-19000), SIGN(0), SIGN(0.00001),
                SQRT(3.3), POWER(2,20)
                FROM DUAL;
                
2. GREATEST(n1,n2[,n3,...]), LEAST(n1,n2[,n3,...]) -- ���߿���  -- �ƽ��� �̴ϸ��� �� �߿��� 
 - �־��� �� �� ���� ū ��(GREATEST), ���� ���� ��(LEAST) ��ȯ
 - GREATEST�� LEAST�� ������(���η�) ������ �� �� ���� ���� ���̰� MAX�� MIN�� �ϳ��� ��(��)���� ���� ū �� �Ǵ� ���� ���� ��ȯ
 
 (��뿹)
    SELECT PROD_COST,
           PROD_PRICE,
           PROD_SALE,
           GREATEST(PROD_COST,PROD_PRICE, PROD_SALE),
           LEAST(PROD_COST,PROD_PRICE, PROD_SALE)
        FROM PROD;
        
    SELECT MAX(PROD_COST)
        FROM PROD;

    SELECT GREATEST('ȫ', 1200, '*' )FROM DUAL;
    
    SELECT ASCII('ȫ'),
           ASCII(1200),
           ASCII('*')
     FROM DUAL;
     
����] ȸ�����̺��� ���ϸ����� 1000�̸��� ȸ������ ���ϸ����� 1000���� �����Ͻÿ�.
      Alias�� ȸ����ȣ, ȸ����, �������ϸ���, ���渶�ϸ����̴�. 
      
      SELECT MEM_ID AS ȸ����ȣ, 
             MEM_NAME AS ȸ����, 
             MEM_MILEAGE AS �������ϸ���, 
             GREATEST(MEM_MILEAGE,1000) AS ���渶�ϸ���
        FROM MEMBER
        
2. ROUND(n,[,1]), TRUNC(n [,1]) - (****)
 - �ݿø�(ROUND)�� �ڸ�����(TRUNC)�� ����
 - �־��� �� n�� �Ҽ��� ���� loc + 1��° �ڸ����� �ݿø�(�ڸ�����)�Ͽ� loc��° �ڸ����� ǥ��
 - 1�� �����Ǹ� 0���� ������
 - 1�� �����̸� �����κ� �ش���ġ(loc wk�ڸ�)���� �ݿø�(�ڸ�����) ����
 
 (��뿹) ������̺��� �� �μ��� ����ӱ��� ��ȸ�Ͻÿ�.
         Alias �μ���ȣ, �μ���, ����ӱ��̰� �μ��ڵ� ������ ����ϰ� ����ӱ��� �Ҽ� 2�ڸ����� ��Ÿ���ÿ�.
         
     SELECT A.DEPARTMENT_ID AS �μ���ȣ,
            B.DEPARTMENT_NAME AS �μ���,
            ROUND(AVG(SALARY),2) AS ����ӱ�
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B              -- FROM ������ ���̺��� ��Ī / (���̺�� ��Ī ) .�� SELECT�� WHERE������ 
          WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID               -- ��������
          GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
          ORDER BY 1;
 
 (��뿹) ȸ�����̺��� ȸ������ ���ɺ� ��ո��ϸ����� ��ȸ�Ͻÿ�. -- GROUP ������. 
         Alias�� ���ɴ�, ȸ����, ��ո��ϸ����̸� ��ո��ϸ����� �Ҽ������� �����Ͽ� ����Ͻÿ�. 
         
         SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE) -EXTRACT(YEAR FROM MEM_BIR),-1)AS ���ɴ�, 
                COUNT(*)AS ȸ����, 
                TRUNC(AVG(MEM_MILEAGE)) AS ��ո��ϸ���
            FROM MEMBER
                GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE) -EXTRACT(YEAR FROM MEM_BIR),-1)
                ORDER BY 1;
                
4. FLOOR(n), CEIL(n) -(**)
 - ���� ����� ����(������)�� ��ȯ
 - FLOOR : n�� ���ų�(n�� ������ ���) ���� �� �� ���� ū ���� ��ȯ
 - CEIL : n�� ���ų�(n�� ������ ���) ū �� �� ���� ���� ���� ��ȯ
 - �޿��� ���ݰ� ���� ��ȭ�� �ַ� ���
 
(��뿹) 
    SELECT FLOOR(10),FLOOR(10.5), FLOOR(-10.5), 
           CEIL(10), CEIL(10.5), CEIL(-10.5)
        FROM DUAL;
        
5. MOD(n1, n2) -(***) , REMAINDER(n1,n2) -(*)
 - �������� ��ȯ
 - �������� ���ϴ� ���� �˰����� �ٸ�
 - MOD(n1,n2) : n1 - n3*FLOOR(n1/n2)
   REMAINDER(n1,n2) : n1 - n3*ROUND(n1/n2)
 - ex)
    MOD(22,4) = 22 - 4 * FLOOR(22/4)
                22 - 4 * FLOOR(5.5)
                22 - 4 * 5
                = 2
    REMAINDER(22,4) : 22 - 4 * ROUND(22/4)
                      22 - 4 * ROUND(5.5)
                      22 - 24
                      = -2
    MOD(21,4) :  22 - 4 * FLOOR (21/4)
                 22 - 4 * FLOOR(5.25) 
                 21 - 4 * 5
                 => 1
    REMAINDER(21,4) : 21 - 4 * ROUND(21/4) --0.5�� �Ѿ�� ������ MOD�� �Ȱ��� / ¦��, Ȧ��, ��� , ����, ���
                      21 - 4 * 5
                      => 1
 
 (��뿹) ���� 1�� 1�� 1�� ���� ���ñ��� ����� �ϼ�
     SELECT CASE WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=0 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'���� �Ͽ���'
                 WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=1 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'���� ������'
                 WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=2 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'���� ȭ����'
                 WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=3 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'���� ������'
                 WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=4 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'���� �����'
                 WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=5 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'���� �ݿ���'
                 WHEN MOD((TRUNC(SYSDATE)-TO_DATE('00010101')-1),7)=6 THEN 
                     TO_CHAR(SYSDATE, 'YYYY-MM-DD')||'���� �����'
            END AS ����
        FROM DUAL;
        
       SYSDATE
       
6. WIDTH_BUCKET(n, min, max, b) - (**) 
 - min���� max ������ b���� �������� �����ϰ� n�� �� ���� �� ��� ������ ���ϴ��� ��ȯ
 - ���� n�� �� ������ ���Ѱ��� ���� ���̸� n�� �� ���� ������ ���� ������ ����
   ��, ���� ���Ѱ� <= n < ���� ���Ѱ��� ������ ������ ��ȯ
 - n�� MIN���� ������ 0����, MAX���� ũ�ų� ������ B+1������ ��ȯ

 (��뿹) ȸ�����̺��� ���ϸ��� 1000~8000�� 3���� �������� ������ �� ȸ������ ���� ���� ��ȸ�Ͻÿ�. 
         Alias�� ȸ����ȣ, ȸ����, ���ϸ���, ������
         
         SELECT MEM_ID AS ȸ����ȣ,
                MEM_NAME AS ȸ����,
                MEM_MILEAGE AS ���ϸ���,
                WIDTH_BUCKET(MEM_MILEAGE,1000,8700,3) AS ������
            FROM MEMBER;
            
            ����) ���� ���� ���ϸ����� 1��� ���� ���ϸ����� 3���
            
                SELECT MEM_ID AS ȸ����ȣ,
                MEM_NAME AS ȸ����,
                MEM_MILEAGE AS ���ϸ���,
                5- WIDTH_BUCKET(MEM_MILEAGE,1000,8700,3) AS ������
            FROM MEMBER;
        
        
            
            
            
      

     
     
    