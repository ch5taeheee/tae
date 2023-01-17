2022-1230-01)��¥�Լ�-

1. ADD MONTHS(d,n) -(**)
 - �־��� ��¥�ڷ� d�� n������ ���� ��¥ ��ȯ
 (��뿹) HR������ �Ի���(HIRE_DATE)�� 10��(120����)�� ���� ��¥�� �����Ͻÿ�.
    UPDATE HR.EMPLOYEES
        SET HIRE_DATE = ADD_MONTHS(HIRE_DATE,120);
        
        SELECT * FROM HR.EMPLOYEES;
        
        COMMIT;
        
2. NEXT_DAY(d,c), LAST_DAY(d) - (***)
 - NEXT_DAY : �־��� ��¥ d�κ��� �ٰ��� 'c'������ ��¥ ��ȯ
    'c'�� '������', '��', 'ȭ����', 'ȭ'...'�Ͽ���','��'�� ���� ���
 - LAST_DAY : �־��� ��¥ d�� ���Ե� ���� ������ ������ ��¥�� ��ȯ
    �ַ� �Է� �޴� ������ ���� ������ ���ڳ� 3���� ������ ���ڸ� ���� �� ���
 (��뿹) 2020�� 2�� ��ǰ�� �������踦 ��ȸ�Ͻÿ�. 
    Alias�� ��ǰ�ڵ�, ���Լ����հ�, ���Աݾ��հ�
    SELECT BUY_PROD AS ��ǰ�ڵ�, 
           SUM(BUY_QTY) AS ���Լ����հ�, 
           SUM(BUY_QTY * BUY_COST) AS ���Աݾ��հ� 
        FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201')) 
     GROUP BY BUY_PROD
     ORDER BY 1;
     
     SELECT NEXT_DAY(SYSDATE,'ȭ����'),
            NEXT_DAY(SYSDATE,'ȭ'),
            NEXT_DAY(TO_DATE('19990813'),'ȭ����')
        FROM DUAL;
            
3. MONTHS_BETWEEN(d1,d2)
 - �� ��¥ d1�� d2 ������ ������ ��ȯ
 
 (��뿹) ������̺��� ������ ���Ե� �ټӳ���� ����Ͻÿ�.
        Alias�� �����ȣ, �����, �Ի���, �ټӳ�� 
     SELECT EMPLOYEE_ID AS �����ȣ, 
            LAST_NAME AS �����,  
            HIRE_DATE AS �Ի���, 
            ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) AS ������,
           TRUNC(ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))/12) ||'��'||
           MOD(ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)),12)||'��' AS �ټӳ��
     FROM HR.EMPLOYEES;
     
4. MONTHS(FMT FROM d1) -(****)
 - ��¥�ڷ� d1�� ���Ե� fmt��Ҹ� ��ȯ
 - fmt�� 'YEAR','MONTH','DAY','HOUR','MINUTE','SECOND' �� �ϳ��̸� ��ȯ�Ǵ� �����ʹ� ��������
 
 (��뿹) ������̺��� �⵵�� �Ի��ο������� ��ȸ�Ͻÿ�.
        Alias�� �⵵, �Ի�����
        SELECT EXTRACT(YEAR FROM HIRE_DATE) AS �⵵,    --ī��Ʈ�� �Ϲ��Լ� �׷� ����Ѵ�.
               COUNT(*) AS �Ի����� 
         FROM HR.EMPLOYEES
         GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
         ORDER BY 1;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
 
        