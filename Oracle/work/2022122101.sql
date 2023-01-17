2022-1221-01) ������ Ÿ��

 - ����Ŭ���� ����ϴ� �ڷ����� ũ�� ���ڿ�, ����, ��¥, ��Ÿ(����) �ڷ�Ÿ������ ����
 
1. ���ڿ� �ڷ��� -- string
 - ����Ŭ�� ���ڿ� �ڷḦ ' ' �ȿ� ����ϰ� ' ' �� ����� ���ڴ� ��ҹ��ڸ� ������.
 - ����Ŭ�� ���� �ڷ����� ���� --char
 - ���ڿ����� ��������(CHAR)�� ��������(VARCHAR,VARCHAR2,LONG,CLOB,NVARCHAR2,NCLOB ��) �ڷ����� ������.
 
 1) CHAR(n [BYTE|CHAR]) -- �������� �����ϸ� byte. ���� CHAR
  . �������� �ڷḦ ����
  . �ִ� 2000BYTE ���� ó�� ����
  . �ѱ� 1���ڴ� 3BYTE�� ó���� 
  . 'n [BYTE|CHAR]' : n�� ���� ������ ����Ʈ ������ ����. �����ϸ� BYTE�� ����.
  . �ѱ��� �ִ� 666���ڸ� ���� ����.
 
 ��� ��) CREATE TABLE TEMP01(
            COL1 CHAR(20 BYTE),
            COL2 CHAR(20 CHAR),
            COL3 CHAR(20));
            
        INSERT INTO TEMP01(COL1,COL2,COL3) VALUES('APPLE PERSIMMON', '������ �߱�', 'oracle SQL�� PL/SQL'); -- �ڷ� ����, ���鵵 1����, "������ �߱�" 16����Ʈ + 14����Ʈ
    
        SELECT * FROM TEMP01; -- �˻� ���) SELECT * FROM * WHERE ����� ���� ���. * = ALL, FROM ���� TABLE, VIEW. WHERE ���� : ����� ��, WHERE ���� = ALL
    
        SELECT LENGTHB(COL1) AS �÷�1, LENGTHB(COL2) AS �÷�2, LENGTHB(COL3) AS �÷�3 FROM TEMP01; --���̸� BYTE�� ����Ͻÿ�.
    
 2) VARCHAR2(n [BYTE|CHAR])
  . �������� �����͸� ����.
  . �ִ� 4000BYTE�� ó����.
  . VARCHAR�� ���� ����̸�, NVARCHAR2�� UTF-8������� ������. 
  . VARCHAR2�� ����Ŭ������ �����Ǵ� ������ Ÿ��.
  
 ��� ��) CREATE TABLE TEMP02(
            COL1 VARCHAR2(4000),
            COL2 VARCHAR2(4000 BYTE),
            COL3 VARCHAR2(4000 CHAR)); --�� ����X
            
         INSERT INTO TEMP02 VALUES('����ȭ ���� �Ǿ����ϴ�','����ȭ ����','IL POSTINO');
         
         SELECT * FROM TEMP02;
         
         SELECT LENGTHB(COL1) AS �÷�1, LENGTHB(COL2) AS �÷�2, LENGTHB(COL3) AS �÷�3 FROM TEMP02; --AS : ��Ī (�� ���� �ȿ�����) �������� ����. 
         SELECT LENGTHB(COL1), LENGTHB(COL2) AS �÷�2, LENGTHB(COL3) AS �÷�3 FROM TEMP02; --��Ī�� ���� : �����Ǿ��� �� �ְ�! 
         SELECT LENGTHB(COL1) �÷�1, LENGTHB(COL2) AS �÷�2, LENGTHB(COL3) AS �÷�3 FROM TEMP02; -- AS ���� ����.
         
 3) LONG
 . �ʱ� ��뷮 ���� �ڷ� ���忡 ���
 . �ִ� 2GB���� ó�� ����
 . �� ���̺� �ϳ��� �÷������� LONG Ÿ������ ������ �� ����.
 . ���� ��ɰ��� ���񽺰� ����� => CLOB�� ������ Ÿ���� ����.
 . �Ϻ� �Լ��� LONGŸ�Կ� ����� �� ���� : �������� ũ�� ����
 . SELECT���� SELECT��, UPDATE���� SET��, INSERT���� VALUES�������� ��� ����
 
  ��� ��) 
            CREATE TABLE TEMP03(COL1 VARCHAR2(4000),COL2 LONG, COL3 LONG); --���� LONG 2��
            CREATE TABLE TEMP03(COL1 VARCHAR2(4000),COL2 LONG); -- LONG ��������!!
            
            INSERT INTO TEMP03 VALUES('����ȭ ���� �Ǿ����ϴ�','����ȭ ����');
            SELECT * FROM TEMP03;
            SELECT LENGTHB(COL1), LENGTHB(COL2)�÷�2 FROM TEMP03; --LONG�� �ʹ� ũ�� ������ LENGTHB, LENGTH ��� X
 22.12.22           
 4) CLOB(Character Large OBject)
    . ���� ���ڿ� ������ ����
    . �ִ� 4GB���� ���� ����
    . �ϳ��� ���̺� ���� ���� CLOBŸ�� �÷��� ������ �� ����.
    . �Ϻ� ����� DBMS_LOB API(Application Programming Interface)�� ������ �޾ƾ� ��.
    
 ��� ��) CREATE TABLE TEMP04 (
            COL1 CLOB,
            COL2 LONG, --�ϳ��� ���̺� 1��
            COL3 CLOB,
            COL4 VARCHAR2(4000));
            
         INSERT INTO TEMP04(COL1,COL2,COL4) VALUES('����ȭ ���� �Ǿ����ϴ�-������','�¹���','���� �� ���� �̾Ƹ�...-�ڿϼ�');
            
         SELECT * FROM TEMP04;
         
         Substr(���ڿ�,����,����) 
         
         SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL4)FROM TEMP04; --���� ? LENGHTB ���� X(CLOB, LONG)
         SELECT SUBSTR(COL1,7,4),SUBSTR(COL2,7,4),DBMS_LOB.SUBSTR(COL1,7,4),DBMS_LOB.GETLENGTH(COL1,7,4) FROM TEMP04; --����? �÷�2 LONG Ÿ���� SUBSTR X CLOB SUBSTR O
         SELECT SUBSTR(COL1,7,4),DBMS_LOB.SUBSTR(COL1,7,4),DBMS_LOB.GETLENGTH(COL1,7,4) FROM TEMP04;
         -- DBMS_LOB ��뷮 �ڷ� �����ϱ� ���� ���Ǿ����� �Լ����� ���� / SUBSTR(A,7,4) 4��° ���ڿ��� 7����! 
         SELECT SUBSTR(COL1,7,4),LENGTHB(COL1),DBMS_LOB.SUBSTR(COL1,7,4),DBMS_LOB.GETLENGTH(COL1,7,4) FROM TEMP04; --LENGTHB ��� X
         SELECT SUBSTR(COL1,7,4),LENGTH(COL1),DBMS_LOB.SUBSTR(COL1,7,4),DBMS_LOB.GETLENGTH(COL1,7,4) FROM TEMP04; -- LENGTHB ��� O ���� ��
    
    
    
    
    
    
    
    

            
 