2022-1222-01) ���ڵ����� Ÿ��
 - ���� �� �Ǽ� NUMBER�� �����ڷ�����
 - NUMBER�� ����
 (�������)
  �÷��� NUMBER[(*|���е�[,������])]
  . '*|���е�' : ���е��� ��ü ������ ũ�⸦ ��Ÿ���� (1-38) ������ ���� ����ϸ�, '*' ����ϸ� �ý����� ����ڰ� ������ ���� ������ ���� ������ ũ�⸦ ��������.
  . ǥ������ : 1.0E-130 ~ 9.9999..99E125
  . '������': �Ҽ��� ������ �ڸ��� �ǹ� 
  . �������� �����ϸ� 0���� ���ֵ�.
  . NUMBER(5,2)�� ��ü 5�ڸ��� Ȯ���ǰ� �־��� ���� �Ҽ��� ���� 3��° �ڸ����� �ݿø��Ͽ� �Ҽ� 2��° �ڸ����� ����Ǹ�, �����κ��� 3�ڸ����� ���. --
  . '������'�� �����̸� �����κ��� �ش� ��ġ���� �ݿø� ��. 
  . '(*|���е�[,������])'�� �����Ǹ� ����ڰ� ������ ���� �״�� ����
  
���뿹) 
---------------------------------------------------------
        �Է°�          ����              ����� ��
---------------------------------------------------------
    12345.6789        NUMBER            12345.6789 
    12345.6789        NUMBER(6,2)       ����.68
    12345.6789        NUMBER(7,2)       12345.68
    12345.6789        NUMBER(7)         12346
    12345.6789        NUMBER(8,1)       12345.7
    12345.6789        NUMBER(*,3)       12345.679 -- *=8
    12365.6789        NUMBER(6,-2)      12400 --������ ��� �ش���ġ���� �ݿø� 6���� �ݿø�
    
 CREATE TABLE TEMP05(
    COL1         NUMBER,   
    COL2         NUMBER(6,2),       
    COL3         NUMBER(7,2),      
    COL4         NUMBER(7),         
    COL5         NUMBER(8,1),      
    COL6         NUMBER(*,3),       
    COL7         NUMBER(6,-2));      
    
 INSERT INTO TEMP05 VALUES(12345.6789,12345.6789,12345.6789,12345.6789,12345.6789,12345.6789,12365.6789); -- 2������ ����
 INSERT INTO TEMP05 VALUES(12345.6789,2345.6789,12345.6789,12345.6789,12345.6789,12345.6789,12365.6789);
 
 SELECT *FROM TEMP05;
 
3.��¥ ������ Ÿ��
 - ��¥(��,��,��)�� �ð�(��,��,��) ������ �����ϱ� ���� �ڷ�Ÿ��
 - DATE�� TIMESTAMP Ÿ�� ����
 
 1) DATE Ÿ��
 . �⺻ ��¥��(��,��,��,��,��,��) �ڷ� ����
 . '+'�� '-' ������ �����ϴ�.
(�������)
 �÷��� DATE
    
 ** SYSDATE : �ý��ۿ��� �����ϴ� ��¥ �� �ð� ����
 ��� ��) CREATE TABLE TEMP06(
            COL1 DATE,
            COL2 DATE,
            COL3 DATE);
            
         INSERT INTO TEMP06 VALUES(SYSDATE, SYSDATE-10, SYSDATE+10);
         INSERT INTO TEMP06 VALUES('20221010', '2022-10-10',TO_DATE(20221010));
         INSERT INTO TEMP06(COL1) VALUES(TO_DATE('20221010 13:20:35', 'YYYYMMDD HH24:MI:SS'));
         
         SELECT *FROM TEMP06;
         
         SELECT TO_CHAR(COL1,'YYYY-MM-DD HH24:MI:SS') AS "COL1",
                TO_CHAR(COL2,'YYYY-MM-DD HH24:MI:SS') AS "COL2",
                TO_CHAR(COL3,'YYYY-MM-DD HH24:MI:SS') AS "COL3" FROM TEMP06;

  2) TIMESTAMP Ÿ��
  . �ð��뿪 ������ ������ �ð�����(10����� 1��)�� �����ϴ� �ڷ���
  . TIMESTAMP -- �ð��뿪 ���� ���� ������ �ð�����
    TIMESTAMP WITH TIME ZONE -- ������ ��ġ�� ������ �ð��뿪 ���� ���/����
    TIMESTAMP WITH LOCAL TIME ZONE -- ���ü����� �ð��뿪����(TIMESTAMP�� ����)�� �����ϹǷ� ������ �ð��뿪 �������� ����
    
  
    CREATE TABLE TEMP07(
        COL1 TIMESTAMP,
        COL2 TIMESTAMP WITH TIME ZONE,
        COL3 TIMESTAMP WITH LOCAL TIME ZONE );
        
    INSERT INTO TEMP07 VALUES(SYSDATE, SYSDATE, SYSDATE);
    SELECT * FROM TEMP07;
    
  
  DROP TABLE TEMP07;
  
  
  
  
  
  
  
  