2022-1222-02)
4. ��Ÿ �ڷ���(2���ڷ���)
  - 2�� �ڷḦ �����ϱ� ���� �ڷ���
  - BLOB, BFILE, RAWŸ���� ����
  - ����� 2�� �ڷḦ ��ȸ�� �� ����Ŭ�� �ؼ��ϰų� ��ȯ�Ͽ� ������� ����. -- ���̺� �ȿ� ����, �ӵ��� �������� ������ �Է��ϴ� �� ��ƴ� BLOB / �ٸ� ���� ������ ��θ� ���̺� ����, �ٲ� ���ɼ� ���� �� - BFILE
  
  1) RAW Ÿ��
  . ���� �Ը��� 2���ڷḦ ó���ϴ� �ڷ���
  . �ִ� 2000BYTE ���� ���� ����
  . �ε���ó�� ����
  . 16������ 2���� ����
  . �ַ� �̵���ڷ� ���忡 ��� 
  
  (��� ����)
    �÷��� RAW(ũ��)
                                                                                             2022-12-23 
  (��� ��) CREATE TABLE TEMP08(
            COL1 RAW(100),
            COL2 RAW(2000));
            
            INSERT INTO TEMP08 VALUES('DC1A','1101110000011010'); 
            INSERT INTO TEMP08 VALUES(HEXTORAW('DC1A'),'DC1A'); 
            
            SELECT * FROM TEMP08; -- ����Ǿ��� �ڷ����¸� 
            
  2) BFILE Ÿ��                  
  . 2�� �ڷ� ����
  . ������ ��� �ڷḦ �����ͺ��̽� �ۿ� �����ϰ� �����ͺ��̽����� ���(PATH)�� ���ϸ� ����
  . ���� �̸��� �ڷ᳻���� ���� ����Ǵ� ��� ȿ����
  . �ִ� 4GB ���� ó�� ����
  
  (�������)
  �÷��� BFILE 
   . ��θ� �����ִ� ���丮 ���� 30BYTE, ���ϸ��� 256BYTE ���� �����ͷ� ǥ��
   
   (��� ��) BFILE Ÿ������ �׸��� ����
    1) ������ �׸� �غ�(JPEGŸ��)
    2) ���丮 ��ü ���� 
        CREATE DIRECTORY ���丮�� AS '��θ�';
        
        CREATE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\Oracle\work';
        
     
    3) ���̺� �غ�
        CREATE TABLE TEMP09(
            COL1 BFILE);
            
            DROP TABLE TEMP09;
    
    4) �׸� ����
        INSERT INTO TEMP09 VALUES(BFILENAME('TEST_DIR','sample.jpg'));
        
        SELECT * FROM TEMP09;
        
  3) BLOB(Binary Large OBject) Ÿ��
  . 2�� �ڷ� ����
  . ������ ��� �ڷḦ �����ͺ��̽� ���ο� ���� -- �ӵ� ����
  . �ڷ᳻���� ������ �Ͼ�� �ʴ� ��� ȿ����
  . �ִ� 4GB ���� ó�� ����
  
  (��� ��) D:\A_TeachingMaterial\Oracle\work�� ����� sample.jpg������ BLOB ������� �����Ͻÿ�.
  
  1) ���̺� ����
     CREATE TABLE TEMP10(
        COL1 BLOB);
  2) �͸��� �ڼ�
     DECLARE
        L_DIR VARCHAR(30) := 'TEST_DIR'; -- := �Ҵ翬����
        L_FILE VARCHAR(255) := 'sample.JPG';
        L_BFILE BFILE;
        L_BLOB BLOB;
     BEGIN
       INSERT INTO TEMP10(COL1) VALUES(EMPTY_BLOB())
        RETURN COL1 INTO L_BLOB;
       
       L_BFILE := BFILENAME(L_DIR, L_FILE);
       DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
       DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
       DBMS_LOB.FILECLOSE(L_BFILE);
     END;
        
     SELECT * FROM TEMP10;
        
        
            
            
            
                                                                                                  
            
            
            
            
            
            
            
            
            
            
            
            