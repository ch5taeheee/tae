2023-0109-02) VIEW ��ü --��ü ������ CREATE
 - ���̺��� ���� ��ü(������ ���̺�)
 - ������ ���̺��̳� �� ��ü�� ���Ͽ� ���ο� SELECT���� ����� �̸��� �ο��Ͽ� ���� -- SELECT���� ����� VIEW. / ��� ������ Ŀ����� �Ѵ�. 
 - VIEW �̿�
    . �ʿ��� ������ ���� ���̺� �л� ����� ��� -- 
    . ���̺��� �ڷ� �Ϻκи� �ʿ��� ���
    . Ư���ڷῡ ���� ���� ����(����) -- 
    -- �̸��� �� ���̸� ������ �ȵȴ�. �ٿ��� �Ѵ�.  -- �ý����� �����ϴ� �� ���..
    -- �������̺� ����Ǹ� ��� VIEW�� ���� / VIEW�� ����Ǹ� �������̺� ���� O
 (�������) 
    CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW ���̸�[(�÷�list)] -- ���̸��� ����ڰ� ����
    AS 
     SELECT ��; 
     [WITH READ ONLY]
     [WITH CHECK OPTION]
     
     . 'OR REPLACE' : �̹� �����ϴ� ���̸� ��ġ�ϰ� ���ο� �� ����
     . 'FORCE | NOFORCE' : FORCE�� ���� ���̺��� ��� �������� default�� NOFORCE
     . '(�÷�list)' : �信 ����� �÷��� 
        - '(�÷�lixt)'�� ����Ǹ� ���� �÷����� '(�÷�lixt)' �� ��.
        - '(�÷�lixt)'�� �����Ǹ� SELECT ���� ���� �÷���Ī�� ���� �÷����� ��.
        - '(�÷�lixt)'�� �����ǰ�, SELECT ���� ���� �÷���Ī�� ������ �ʾ����� SELECT���� �÷����� ���� �÷����� ��.
     . 'WITH READ ONLY' : �б����� �� ���� -- �並 DML����� �̿��Ͽ� ������ �� ����. INSERT, UPDATE, DELETE X. �並 ������� �� �� ������ �������̺��� ���� ����O
     . 'WITH CHECK OPTION' : SELECT ���� WHERE ������ �����ϴ� DML����� �信 ���������� ���� �߻�(��, �������̺��� WHERE ������ �����ϴ� DML ��� ���Ѿ��� ���)
      -- WITH READ ONLY �� WITH CHECK OPTION ���� ��� X  
      
(��뿹) ȸ�����̺��� ���ϸ����� 3000�̻��� ȸ������ ȸ����ȣ, ȸ����, ����, ���ϸ����� �並 �����Ͻÿ�.

        CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MILE)
        AS
          SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����,MEM_JOB AS ����,MEM_MILEAGE AS ���ϸ���
             FROM MEMBER
            WHERE MEM_MILEAGE >= 3000;
            
        CREATE OR REPLACE VIEW V_MEM01
        AS
        SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����,MEM_JOB AS ����,MEM_MILEAGE AS ���ϸ���
            FROM MEMBER
           WHERE MEM_MILEAGE >= 3000; -- �ռ� ���� �並 ������. �÷���� �ٸ���
           
        CREATE OR REPLACE VIEW V_MEM01
        AS
        SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
            FROM MEMBER
           WHERE MEM_MILEAGE >= 3000; -- SELECT���� �÷����� ���� �÷����� ��. 
           
��뿹)�� V_MEM01 'h001' ����ȣ ȸ���� ���ϸ����� 2500���� �����Ͻÿ�.
    UPDATE V_MEM01
        SET MEM_MILEAGE = 2500 WHERE MEM_ID = 'h001';
        
    select * from V_MEM01;
    
    SELECT MEM_ID, MEM_NAME, MEM_MILEAGE 
      FROM MEMBER
      WHERE MEM_ID = 'h001'; -- �� �����ϸ� �������̺� �����. 
      
��뿹) ȸ�����̺��� 'n001' ȸ���� 'h001' ȸ���� ���ϸ����� 4500���� �����Ͻÿ�.
    UPDATE MEMBER
        SET MEM_MILEAGE = 4500 
            WHERE MEM_ID IN('h001','n001'); -- ���̺� �����ϸ� �ٷ� �信�� ����.
            
        CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MILE)
        AS
          SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����,MEM_JOB AS ����,MEM_MILEAGE AS ���ϸ���
             FROM MEMBER
            WHERE MEM_MILEAGE >= 3000
            WITH READ ONLY;
            
��뿹) v_MEM01 �信�� 'h001' ȸ���� ���ϸ����� 3150���� �����Ͻÿ�.
    UPDATE V_MEM01
        SET MILE = 3150 WHERE MEM_ID = 'h001'; -- READ ONLY ��� ���� �Ұ���.
        
��뿹) V_MEM01 �信�� 'n001' ȸ���� ������ �����Ͻÿ�.
    DELETE FROM V_MEM01 WHERE MID = 'n001'; -- READ ONLY ��� ���� �Ұ���.
    
** ȸ�����̺��� ������ T_MEMBER�� �����ϼ���. --������ �� CREATE ��� �������� �̿��ؼ� AS�� �����ϸ� ���������� ����� �״�� ���̺� �����ȴ�.
    CREATE TABLE T_MEMBER
    AS
        SELECT*FROM MEMBER; 
        
��뿹) T_MEMBER ���̺��� ���� ȸ���̸� ���ϸ����� 3000�̻��� ȸ������ ȸ����ȣ, ȸ����, ���ϸ����� ������ �並 �����Ͻÿ�.

    CREATE OR REPLACE VIEW V_FMEMBER
    AS
    SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_MILEAGE AS ���ϸ���
        FROM T_MEMBER
        WHERE MEM_MILEAGE >= 3000 AND SUBSTR(MEM_REGNO2,1,1) IN('2','4')
        --WITH READ ONLY;
        WITH CHECK OPTION; -- 2���� ���ÿ� ���� �ȵ�. / WHERE ���� �߿� ��� �� �� �����̶� �����Ϸ��ص� �信�� ������ ���� ����. 
        
��뿹) T_MEMBER ���̺��� 'd001' ȸ�������� �����Ͻÿ�. 
    DELETE FROM T_MEMBER 
        WHERE MEM_ID= 'd001'; -- �䰡 READ ONLY ���� ���̺��� ����� �信 ��� �ݿ�(������).
    
��뿹) �� V_MEMBER���� 'b001' ȸ���� ���ϸ����� 2500���� ���� -- CHECK OPTION �� ��ü�� ������ �Ǹ� �ȵǳ���.. 

    UPDATE V_FMEMBER
        SET ���ϸ��� = 2500 
        WHERE ȸ����ȣ = 'b001' 

��뿹) T_MEMBER���� 'b001' ȸ���� ���ϸ����� 2500���� ���� -- ���̺��� ����

    UPDATE T_MEMBER
        SET MEM_MILEAGE= 2500 
        WHERE MEM_ID = 'b001';
        
��뿹) �� V_MEMBER���� 'j001' ȸ���� ���ϸ����� 3412 �� 5400���� ���� -- READ ONLY �ƴ϶�

    UPDATE V_FMEMBER
        SET ���ϸ��� = 5400 
        WHERE ȸ����ȣ = 'j001'
        
** ���� ����
DROP VIEW ���̸�

DROP VIEW V_FMEMBER;







        
        

        

    

            

            
            

     
     
      

    
    



      
      
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 