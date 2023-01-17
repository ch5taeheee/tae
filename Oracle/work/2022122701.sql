2022-1227-01) ��Ÿ������
1. IN ������ --'='�� �����Ǿ� ���� / �˻��Ҷ� ȿ���� / >,< �� �� ����.
    - �־��� �������� �� �� ��� �ϳ��� ��ġ�ϸ� ��ü ����� ��(TRUE)�� ��ȯ
    - OR �����ڿ� ȣȯ
    - =ANY, =SOME�� ���� ��� ���� -- '='�� �����Ǿ� ���� ���� / >,< �� �� �ִ�.
 (�������)
    expr IN(��1[,��2,...])
     . 'expr' ���� '��1',...'��n' �� ��� �ϳ��� ��ġ�ϸ� ���ǽ� ��ü�� ���̵�.
     . '��1[,��2,...]' �� �ҿ������� ���� ��� ȿ����
     
 (��뿹) ������̺��� 10, 90, 110�� �μ��� ���� ������� �����ȣ, �����, �Ի���, �����ڵ带 ��ȸ�Ͻÿ�.
    (OR ������ ���)
    select EMPLOYEE_ID AS �����ȣ, 
           LAST_NAME AS �����, 
           HIRE_DATE AS �Ի���, 
           DEPARTMENT_ID AS �μ��ڵ�,
           JOB_ID AS �����ڵ�
        from HR.EMPLOYEES
            WHERE DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 90 OR DEPARTMENT_ID = 110;
            
     (IN ������ ���)
    select EMPLOYEE_ID AS �����ȣ, 
           LAST_NAME AS �����, 
           HIRE_DATE AS �Ի���, 
           DEPARTMENT_ID AS �μ��ڵ�,
           JOB_ID AS �����ڵ�
        from HR.EMPLOYEES
            WHERE DEPARTMENT_ID IN(10,90,110);
            
     (=SOME, =ANY ������ ���)
    select EMPLOYEE_ID AS �����ȣ, 
           LAST_NAME AS �����, 
           HIRE_DATE AS �Ի���, 
           DEPARTMENT_ID AS �μ��ڵ�,
           JOB_ID AS �����ڵ�
        from HR.EMPLOYEES
            WHERE DEPARTMENT_ID =SOME(10,90,110);           
                  
 (��뿹) 2020�� 5�� ���ž��� ���� 5���� ȸ����ȣ, ȸ����, �ּ�, ���ϸ���, ������ ��ȸ�Ͻÿ�.
  SELECT MEM_ID AS ȸ����ȣ, 
         MEM_NAME AS ȸ����, 
         MEM_ADD1||' ' ||MEM_ADD2 AS �ּ�, 
         MEM_MILEAGE AS ���ϸ���, 
         MEM_JOB AS ����
    FROM MEMBER
   WHERE MEM_ID IN(SELECT C.MID AS CMID
                     FROM(SELECT A.CART_MEMBER AS MID,
                                 SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
                             FROM CART A, PROD B
                            WHERE SUBSTR(A.CART_NO,1,6)='202005'
                            GROUP BY A.CART_MEMBER
                            ORDER BY 2 DESC) C
                      WHERE ROWNUM <=5);
                      
2. ANY(SOME) ������ -- ����ϳ��� �����ϸ� 
 - IN �����ڿ� �����ϳ� ANY(SOME)���� '=' ����� ����.
 (�������)
    expr ���迬����ANY(��1 [,��2, ...]) --<,>,...
    . 'expr' �� �� ��� �ϳ��� ANY�տ� ����� '���迬����'�� �����ϸ� ��ü ����� ��(TRUE)�� ��ȯ
    
 (��뿹) ȸ�� �� ������ '�л�'�� ȸ���麸�� ���� ���� ���ϸ����� ������ ȸ������ ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�Ͻÿ�.
    SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_JOB AS ����, 
           MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
        WHERE MEM_MILEAGE > ANY(700,2200,2700) -- ALL�� ����ϸ� 2700���� ū ���鸸..
        
3. ALL ������
 - ANY(SOME) �� ������ �����
 - �־��� ���� ��� ���ÿ� ������ �� ��ü�� ���̵Ǵ� ������
 - ALL�����ڿ� '='�����ڴ� ���� ���� �� ����
  (�������)
    expr ALL(��1[, ��2,...])
     . 'expr' ���� ��� '��'�� ALL �տ� ����� ���迬���ڸ� �����ϸ� ��(TRUE)�� ��ȯ
     
  (��뿹) ȸ�� �� ������ '�л�'�� ȸ���麸�� ���� ���� ���ϸ����� ������ ȸ������ ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�Ͻÿ�.
    SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_JOB AS ����, 
           MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
        WHERE MEM_MILEAGE > ALL(700,2200,2700)
        ORDER BY 4 ;
        
4. EXISTS ������
 - EXISTS �����ڴ� �ݵ�� ���������� ���� ����ؾ� ��.
 
5. BETWEEN ������
 - ������ ������ �� ���
 - 'AND' �����ڷ� ����� �� ����
 (�������)
    co1 BETWEEN ��1 AND ��2
    . 'co1'�� ���� '��1'���� '��2' ������ ���̸� ���� ��ȯ
    . '��1'�� '��2'�� ���� Ÿ���� �ڷ��̾�� ��.
    . ����ϴ� �ڷ�� ����Ŭ���� ����ϴ� ��� �ڷ�Ÿ��
    
 (��뿹) ������̺��� 40~70�� �μ��� ���� ������� ��ȸ
         Alias�� �����ȣ, �����, �μ���ȣ, �޿�
(BETWEEN ������ ���)         
         select EMPLOYEE_ID AS �����ȣ,
                LAST_NAME AS �����,
                DEPARTMENT_ID AS �μ���ȣ,
                SALARY AS �޿�
            FROM HR.EMPLOYEES
                WHERE DEPARTMENT_ID BETWEEN 40 AND 70
                ORDER BY 3;
                
(AND ������ ���)         
         select EMPLOYEE_ID AS �����ȣ,
                LAST_NAME AS �����,
                DEPARTMENT_ID AS �μ���ȣ,
                SALARY AS �޿�
            FROM HR.EMPLOYEES
                WHERE DEPARTMENT_ID >=40 AND DEPARTMENT_ID <=70
                ORDER BY 3;                
             
 (��뿹) ȸ�����̺��� 20�� ~ 40�� ȸ������ ��ȸ
         Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���
         ���̼����� ����ϸ� ���̴� ������� �÷����� ���
         
    SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           EXTRACT (YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR)AS ����, 
           MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
        WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1) BETWEEN 20 AND 40    
        ORDER BY 3 ;
         
 (��뿹) �������̺��� 2020�� 2�� ������Ȳ�� ��ȸ�Ͻÿ�.
         Alias�� ����, ��ǰ�ڵ�, ���Լ���, �ܰ�, �ݾ�
         SELECT *FROM BUYPROD;
         
    SELECT  BUY_DATE AS ����, 
            BUY_PROD AS ��ǰ�ڵ�, 
            BUY_QTY AS ���Լ���, 
            BUY_COST AS �ܰ�, 
            BUY_QTY * BUY_COST AS �ݾ�
         FROM BUYPROD
        -- WHERE BUY_DATE BETWEEN '2020/02/01' AND '2020/02/29'
        WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201'));
        
6. LIKE ������
 - ���Ϻ� ����
 - ���Ϲ��ڿ�(���ϵ�ī��)�� '%','_'�� ���
 (�������)
    expr LIKE '���Ϲ��ڿ�' -- expr�� �ݵ�� ���ڿ��̾�� �Ѵ�.
     . ���ڿ� �� ������
     . '%' : '%'�� ���� ��ġ�� ���ڿ� ������ ��� ���ڿ��� ����
      ex) '��%' : '��'���� �����ϴ� ��� ���ڿ��� ���� ����� ��ȯ
          '%��' : '��'���� ������ ��� ���ڿ��� ����
          '%��%' : ���ڿ� ���ο� '��'�� ������ ���� ��ȯ
          
     . '_' : '_'�� ���� ��ġ���� �� ���ڿ� ����
      ex) '��_' : '��'���� �����ϰ� 2������ ���ڿ��� ��(true)�� ��ȯ
          '_��' : '��'���� ������ 2������ ���ڿ��� ����
          '_��_' : ���ڿ��� 3���ڷ� �����ǰ� ���ڿ� ���ο� '��'�� ������ ���� ��ȯ
          
 (��뿹) ȸ�� �� '�泲'�� �����ϴ� ȸ������ ������ ��ȸ�Ͻÿ�.
         Alias�� ȸ����ȣ, ȸ����, �ּ�, ���ϸ���
        select MEM_ID AS ȸ����ȣ, 
               MEM_NAME AS ȸ����, 
               MEM_ADD1 AS �ּ�, 
               MEM_MILEAGE AS ���ϸ��� 
            FROM MEMBER
             WHERE MEM_ADD1 LIKE '�泲%';
         
         
 (��뿹) 2020�� 4�� ������Ȳ�� ��ȸ�Ͻÿ�.
         Alias�� ��¥, ��ǰ�ڵ�, �������
         
        SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS ��¥, 
               CART_PROD AS ��ǰ�ڵ�, 
               CART_QTY AS �������
            FROM CART
             WHERE CART_NO LIKE '202004%'
            

 (��뿹) 2020�� 4�� ������Ȳ�� ��ȸ�Ͻÿ�.
         Alias�� ��¥, ��ǰ�ڵ�, ���Լ���, ���Աݾ�
                 
        SELECT BUY_DATE AS ��¥, 
               BUY_PROD AS ��ǰ�ڵ�, 
               BUY_QTY AS ���Լ���, 
               BUY_QTY * BUY_COST AS ���Աݾ�
            FROM BUYPROD
            WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200430'); -- DATE�� LIKE ��� X
    -- WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND LAST_DAY(TO_DATE('20200401')); -- DATE�� LIKE ��� X
            

        

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            