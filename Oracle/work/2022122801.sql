2022-1228-01)�Լ�
 - Ư�� ����� �����ϱ� ���Ͽ� �䱸�Ǵ� ����� ����(���)
 - �Լ�(Function)�� ��� ���� �Լ��� ���� ��ġ�� ��ȯ��.
 - ���ڿ��Լ�, �����Լ�, ��¥�Լ�, ����ȯ�Լ�, nulló���Լ�, �м��Լ�, �����Լ� ���� ����
 -- �����Լ��� �����Լ��� ������ �� ����. 5���� SUM, AVG, AVERAGE, MIN, MAX
 
 1. �����Լ�
   1) ���ڿ� ���տ�����(||)�� CONCAT(c1,c2)
    - �־��� ���ڿ� 'c1'�� 'c2'�� �����Ͽ� ���ο� ���ڿ� �ڷḦ ��ȯ
    
(��뿹) SELECT 'Oracle'||'SQL',
                CONCAT('Oracle','SQL')
            FROM DUAL; -- ������ ���̺�, 
            
 ����] ȸ�����̺��� ����ȸ������ ȸ����ȣ, ȸ����, �ֹι�ȣ, ����, ���ϸ����� ��ȸ�Ͻÿ�.
    ��, �ֹι�ȣ�� XXXXXX-XXXXXXX�������� ����Ͻÿ�.
    
 1) SELECT MEM_ID AS ȸ����ȣ, 
        MEM_NAME AS ȸ����, 
        CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2) AS �ֹι�ȣ, 
        MEM_JOB AS ����, 
        MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
     WHERE SUBSTR(MEM_REGNO2,1,1)=2 OR SUBSTR(MEM_REGNO2,1,1)=4;
     
     
 2)  SELECT MEM_ID AS ȸ����ȣ, 
        MEM_NAME AS ȸ����, 
        MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ, 
        MEM_JOB AS ����, 
        MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
     WHERE SUBSTR(MEM_REGNO2,1,1)=2 OR SUBSTR(MEM_REGNO2,1,1)=4;  
     
 2) LOWER(c1), UPPER(c1) -(**), INITCAP(c1) -(*)
  - LOWER : 'c1'�� ���� �� ��� �빮�ڸ� �ҹ��ڷ� ��ȯ�Ͽ� ��ȯ
  - UPPER : 'c1'�� ���� �� ��� �ҹ��ڸ� �빮�ڷ� ��ȯ�Ͽ� ��ȯ
  - INITCAP : 'c1'�� ���� �� ��� �ܾ��� ù ���ڸ� �빮�ڷ� ��ȯ�Ͽ� ��ȯ
  
 (��뿹) ��ǰ���̺��� �з��ڵ尡 'p201'�� ���� ��ǰ�� ��ǰ�ڵ�, ��ǰ��, ���Դܰ�, ����ܰ�

 
 SELECT PROD_ID AS ��ǰ�ڵ�,
        PROD_NAME AS ��ǰ��,
        PROD_COST AS ���Դܰ�,
        PROD_PRICE AS ����ܰ�
 FROM PROD
 WHERE LOWER(PROD_LGU) = 'p201'
 
  3) LPAD(c1,n[,c2]), RPAD(c1,n[,c2]) -(***)
    - LPAD : �������� ���ǵ� ���� n�� �����ʺ��� c1�� ä��� ���� ����(����)�� c2�� ä�� --���ڿ��� ����ó�� ����� ��
    - RPAD : �������� ���ǵ� ���� n�� ���ʺ��� c1�� ä��� ���� ����(������)�� c2�� ä�� --���ڸ� ���ڿ�ó�� ����� ��
    -'C2'�� �����ϸ� ������ ä��
    
 (��뿹) ��ǰ���̺� ���Դܰ��� ����ܰ��� ���� 7�ڸ��� ����ϵ� ���Դܰ��� ������ ������ ����ܰ��� ���� ������ �����ϰ� '*'�� �� ������ ä�������ÿ�.
         ����� �ڷ�� ��ǰ�ڵ�, ��ǰ��, ���Դܰ�, ����ܰ�
  SELECT * FROM PROD
  
  SELECT PROD_ID AS ��ǰ�ڵ�,
         PROD_NAME AS ��ǰ��,
         LPAD(PROD_COST,10,'*') AS  ���Դܰ�,
         RPAD(PROD_PRICE,10,'*') AS ����ܰ�
    FROM PROD
 
 ��뿹) Ű����κ��� �з��ڵ带 �Է¹޾� �ش�з��� ���Ե� ��ǰ������ ����ϴ� �͸� ����� �ۼ��Ͻÿ�.
        Alias�� ��ǰ�ڵ�, ��ǰ��, �����, �������̸� �������� (����ܰ�-���Դܰ�)�̴�. 
        
        ACCEPT B_CODE PROMPT '�з��ڵ� �Է�'
        DECLARE
            L_PROFIT NUMBER:=0;
            L_RES VARCHAR2(255);
            CURSOR CUR_SAMPLE IS
                SELECT PROD_ID, PROD_NAME, PROD_PRICE, (PROD_PRICE-PROD_COST) AS PIT
                    FROM PROD
                    WHERE PROD_LGU = UPPER('&B_CODE');
        BEGIN
            FOR REC IN CUR_SAMPLE LOOP 
                L_RES:= REC.PROD_ID||' '||RPAD(REC.PROD_NAME,26)||
                    TO_CHAR(REC.PROD_PRICE,'9,999,999')||TO_CHAR(REC.PIT,'9,999,999');
                DBMS_OUTPUT.PUT_LINE(L_RES);
        END LOOP;
        END;
 
  4) SUBSTR(c,m[n]) - (****)  -- �ڹٴ� 0���� ����Ŭ�� 1����
  - �־��� ���ڿ� c�� m��° ���ں��� n���� ���ڸ� �����Ͽ� ��ȯ
  - 'n'�� �����ǰų� ���� ���ڼ� ���� ū ���̸� m��° ���� ��� ���ڸ� ����
  - m�� �����̸� �����ʺ��� ó����.
  
  SELECT SUBSTR('OracleSQL�� PL/SQL',2,5),
         SUBSTR('OracleSQL�� PL/SQL',10,55),
         SUBSTR('OracleSQL�� PL/SQL',10),
         SUBSTR('OracleSQL�� PL/SQL',-10,5)
    FROM DUAL;
    
 (��뿹) 2020�� 6�� ��ٱ��� ���̺��� ����Ͽ� ��ǰ�� ������ �߻��� ������ ù��°�� ������ ���� ��ȸ�Ͻÿ�. 
         Alias�� ��¥, ȸ����ȣ, ȸ����, ����, ���ϸ���

         SELECT DISTINCT SUBSTR(A.CART_NO,1,8) ��¥, --DISTINCT �ߺ�����
                A.CART_MEMBER AS ȸ����ȣ,
                B.MEM_NAME AS ȸ����, 
                B.MEM_JOB AS ����,
                B.MEM_MILEAGE AS ���ϸ���
             FROM CART A, MEMBER B
                WHERE SUBSTR(CART_NO,1,6)='202006' 
                    AND SUBSTR(CART_NO,9)=1
                    AND A.CART_MEMBER=B.MEM_ID
                    ORDER BY 1; 
                
  5) LTRIM(c1 [,c2]), RTRIM(c1 [,c2]) -(**)
    - LTRIM : ���ڿ� c1���� ���� �����ϴ� ���ڿ��� c2�� ��ġ�ϸ� �����ϰ� ���� ������ ���ڿ��� c1�� �����ϸ� ��� ����
    - RTRIM : ���ڿ� c1���� ������ �����ϴ� ���ڿ��� c2�� ��ġ�ϸ� �����ϰ� ���� ������ ���ڿ��� c1�� �����ϸ� ��� ����
    - c2�� �����Ǹ� ���ڿ� ����(LTRIM) �Ǵ� ������(RTRIM)�� ���鹮�ڿ��� ����
      (��, ���ڿ� ������ ������ �������� ����)
    
 (��뿹) SELECT LTRIM('APPLE AP AP ALLL','AP'),
                LTRIM('APPLE AP AP ALLL','A'),
                LTRIM('APPLE AP AP ALLL','P'),
                LTRIM('   APPLE AP AP ALLL'),
                RTRIM('APPLE AP AP ALLL','LE')
          FROM DUAL;
          
         SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
            FROM MEMBER
         WHERE MEM_NAME = LTRIM(' ������');
         
         SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
            FROM MEMBER
         WHERE MEM_NAME = ' ������';    (X) -- VARCHAR2 ���� X    
         
         SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
            FROM MEMBER
         WHERE MEM_NAME = RTRIM('������ ');     
        
        
  6) TRIM(c1) -(***)
   - �־��� ���ڿ� C1�� �����ʰ� ������ ���� ��θ� ����
   - �ܾ� ���� �������Ŵ� �Ұ���
   
         SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
            FROM MEMBER
         WHERE MEM_NAME = TRIM('������ ');  
         
         
 (��뿹) ������ 2020�� 6�� 13���� ��� ��ٱ��� ��ȣ�� �����Ͻÿ�. --
    (1) ���ó�¥�� ���� ū ��ٱ��Ϲ�ȣ �˻�
        SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||
               TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000') -- (X) ������� ���, ����Ŭ ���� EX)20200613 00003 
            FROM CART
             WHERE CART_NO LIKE TO_CHAR(SYSDATE,'YYYYMMDD')||'%';
             
        SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||
               TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000'))  -- (O) ��������
            FROM CART
             WHERE CART_NO LIKE TO_CHAR(SYSDATE,'YYYYMMDD')||'%';

        SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||
               TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000')), MAX(CART_NO)+1 
            FROM CART
             WHERE CART_NO LIKE TO_CHAR(SYSDATE,'YYYYMMDD')||'%';
             
 7) INSTR(c1,c2[,m[,n]]) -(**)
  - ã�� ���ڿ��� ��ġ�� ��ȯ�ϴ� �Լ�
  - c1 ���ڿ����� c2���ڿ��� ó�� ������ ��ġ�� ��ȯ.
  - m�� ã�⸦ ������ ��ġ, n�� �ݺ�Ƚ�� ����
  
  (��뿹) SELECT INSTR('Hello heidi', 'he'),
                 INSTR('Hello heidi', 'e',3),
                 INSTR('HELLO heidi', 'h',1,2)
            FROM DUAL;
  
 8) LENGTH(c1), LENGTHB(c1) - (**)
  - ���ڿ��� ���̸� BYTE��(LENGTHB) �Ǵ� ������ ����(LENGTH) ��ȯ -- ������ 1BYTE �ѱ� 3BYTE(BYTE�� ������ ���� �ٸ���)
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
            