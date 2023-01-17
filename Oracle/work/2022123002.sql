2022-1230-02) �� ��ȯ �Լ�
 - �Լ��� ���� ��ġ���� ����� ������Ÿ���� ������̰� �Ͻ������� ���� ��ȯ  -- ALTER �ƿ� ���� ��ȯ��Ű����,
 - TO_CHAR, TO_DATE, TO_NUMBER, CAST�� ����   --CAST�� ��¥, ���� ����, ��     -- �Ͻ����� ��ȯ
 
1. CAST(expr AS type��)
 - 'expr'�� ���� type������ ��ȯ
 
 (��뿹)
    SELECT PROD_ID AS ��ǰ�ڵ�,
        CAST(PROD_NAME AS CHAR(40)) AS ��ǰ��,
        CAST(PROD_COST AS VARCHAR2(10)) AS ���Դܰ�, 
        PROD_PRICE AS ����ܰ�
     FROM PROD;
     
2. TO_CHAR(c), TO_CHAR(d [,fmt]), TO_CHAR(n [,fmt])
 - 'c'�� �������� ���ڿ�Ÿ��(CHAR)�̳� CLOB Ÿ���� VARCHAR2Ÿ������ ��ȯ
 - ��¥(d)�� Ư������(fmt)�� ���ڿ� �ڷ�� ��ȯ
 - ����(n)�� Ư������(fmt)�� ���ڿ� �ڷ�� ��ȯ
 
 ** ��¥ ��������
 -----------------------------------------------------------------------------------------------------------------------
         ���� ���ڿ�                ����                                ��
 -----------------------------------------------------------------------------------------------------------------------
            CC                     ����               SELECT TO_CHAR(SYSDATE,'CC') FROM DUAL;
          AD, BC                   ����               SELECT TO_CHAR(SYSDATE, 'CC BC') FROM DUAL;            
      YYYY,YYY,YY,Y                �⵵               SELECT TO_CHAR(SYSDATE, 'YYY') FROM DUAL; --YYY:022 �����ʿ��� �߸�
           YEAR              ���ڷ� ǥ���� �⵵         SELECT TO_CHAR(SYSDATE, 'YYYY YEAR') FROM DUAL;    
            Q                      �б�               SELECT TO_CHAR(SYSDATE, 'Q') FROM DUAL;  
          MM,RM                    D��                SELECT TO_CHAR(SYSDATE, 'MM RM') FROM DUAL;  
        MONTH, MON              '��' ���             SELECT TO_CHAR(SYSDATE, 'MONTH MON') FROM DUAL;   
          W, WW                    ����               SELECT TO_CHAR(SYSDATE, 'W WW') FROM DUAL;  
            DD                   ���� ��¥             SELECT TO_CHAR(SYSDATE, 'DD') FROM DUAL;
          D, DDD                ��, ���� ��¥          SELECT TO_CHAR(SYSDATE, 'D DDD') FROM DUAL;
         DY, DAY                   ����               SELECT TO_CHAR(SYSDATE, 'DY DAY') FROM DUAL;
      AM,PM,A.M,P.M              ����/����            SELECT TO_CHAR(SYSDATE, 'A.M') FROM DUAL;
       HH,HH12,HH24                �ð�               SELECT TO_CHAR(SYSDATE, 'HH24 : HH12 :HH24') FROM DUAL;
            MI                      ��                SELECT TO_CHAR(SYSDATE, 'MI') FROM DUAL;
         SS,SSSSS                   ��                SELECT TO_CHAR(SYSDATE, 'SS SSSSS') FROM DUAL;
            J                     �ٸ���(����� 4713�� 12�� 31�� ���� ������ ��)
            
         "���ڿ�"              ����� ���� ���� ����     SELECT TO_CHAR(SYSDATE,'YYYY "��" MM "��" DD "��"') FROM DUAL;
-----------------------------------------------------------------------------------------------------------------------

** ������������ --������ �ȵȴ�. (,), ��ȭ��ȣ, <>, - : ���ڷ� �ٲ� �� ���� ��ȣ���̶� ���� X/ ���ڷ� �ٲ� �� �ִ� ���� . �ۿ� ����. ���ڷ� �� �ٲٰ� �ʹ� �ϸ� TO_NUMBER�� ��� �Ѵ�. 
-----------------------------------------------------------------------------------------------------------------------
        ���Ĺ��ڿ�             ����                                                     ��
-----------------------------------------------------------------------------------------------------------------------
            9           �ش���ġ�� �����Ǵ� ��ȿ���ڴ� ���,                
                        ��ȿ�� 0�� ����ó��
            0           �ش���ġ�� �����Ǵ� ��ȿ���ڴ� ���, 
                        ��ȿ�� 0�� '0' ���
           $,L          ������ ���ʿ� ȭ���ȣ ���
           PR           ������ ��� '< >' �ȿ� ���
           MI           ������ ��� '-' ��ȣ�� ���� ������ ���� ���
        ,(COMMA)        3�ڸ� �ڸ���
         .(DOT)         �Ҽ���

(��뿹) SELECT TO_CHAR(23450,'9999999'),  
               TO_CHAR(23450,'9,999,999'),
               TO_CHAR(23450,'L99,999'),
               TO_CHAR(23450.459,'99,999.99'), --�ڵ����� �ݿø� ��.
               TO_CHAR(23450.4,'99,999.99'),
               TO_CHAR(-23450,'99,999MI'),
               TO_CHAR(23450,'99,999MI'),
               TO_CHAR(-23450,'99,999PR') --������ ��� <>, ����� ��� �״��
            FROM DUAL;
            
        SELECT TO_CHAR(23450,'0000000'),
               TO_CHAR(23450,'0,000,000'),
               TO_CHAR(23450,'L00,000'),
               TO_CHAR(23450.459,'00,000.00'), --�ڵ����� �ݿø� ��.
               TO_CHAR(23450.4,'00,000.00'),
               TO_CHAR(-23450,'00,000MI'),
               TO_CHAR(23450,'00,000MI'),
               TO_CHAR(-23450,'00,000PR') 
            FROM DUAL;
            
3. TO_NUMBER(c [,fmt])
 - ���ڿ� �ڷ� c�� ���������� ��ȯ
 - 'fmt'�� TO_CHAR �Լ��� �������� ���� ���ڿ��� ����
 
 (��뿹) 
    SELECT TO_NUMBER('234'), -- 0 234
           TO_NUMBER('23,450','00,000'), --X  ,������ ���� ���� X ->  X�� �����ʿ� �������� ������ �ǰ� �ϴ� ��. -> 23,450
           TO_NUMBER('$234,567.90','$999,999.99'),
           TO_NUMBER('<12,450>','99,999PR')
        FROM DUAL;
        
4. TO_DATE(c|n [,fmt])
 - ���ڿ� �ڷ� c�� �����ڷ� n�� ��¥������ ��ȯ
 - 'fmt'�� TO_CHAR �Լ��� ��¥���� ���Ĺ��ڿ��� ����
 
 (��뿹) --�⺻ Ÿ������ �ٲ� (0000/00/00) (����, /, -, �ƹ��͵� ���� ��)
    SELECT TO_DATE('20201217'),
           TO_DATE(20201217),
           TO_DATE('2020/12/17'),��
           TO_DATE('2020-12-17'),
           TO_DATE('2020 12 17')
      FROM DUAL;
      
    SELECT TO_DATE('20201217 17:25:50','YYYYMMDD HH24:MI:SS') FROM DUAL; --�ð��� �� ����. �ð� ������ �Ϸ��� TO_CHAR ���.
           
            
            
            
            
              
               

            
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
 