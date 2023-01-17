2023-0110-01) SEQUENCE ��ü
1. SEQUENCE 
 - �������� ��ȣ�� �ʿ��� ��� ���
 - �⺻Ű�� ������ ���� �׸��� ���� ���, �ڵ����� �������� ��ȣ�� �ʿ��� ��� ���
 -- ���̺�� ���������� ����. ���� ���̺��� �ϳ��� �������� ��밡��. B, ���ǰ� �ʿ���. 
 -- �������� �⺻Ű�� �����ؾ� �ϴµ� ���� �� ������ �ڵ��Ǿ� �����Ǵ� ���� �ߺ��� �ȵǴ� �⺻Ű�� ���ڴٴ� ��
 -- �������� ���� �ڿ� �ִ� ���� ����� ���� ����. �̹� ������ ���� ���� �� ��. ���簪�� �̷� ���� ����ؾ� ��.
 --
 (�������)
    CREATE SEQUENCE ��������
        [START WITH n] -- ������ ���۰� ���� �����ϸ� MINVALUE (: ���� ���� ������ �� ����ϴ� �ɼ�)
        [INCREMENT BY n] -- �ڵ� ������
        [MAXVALUE n|NOMAXVALUE] -- �ִ밪 ���� �⺻�� NOMAXVALUE�̸� 10^27���� ���
        [MAXVALUE n|NOMINVALUE] -- �ּҰ� ���� �⺻�� NOMINVALUE�̸� 1
        [CYCLE|NOCYCLE] -- �ִ�/�ּҰ� ���� �ٽ� �������� ���� �⺻�� NOCYCLE
        [CACHE n|NOCACHE] -- ĳ�� ��뿩�� �⺻�� CACHE 20 
        [ORDER | NOORDER] -- ������ ��� ������ ���� ���忩�� �⺻�� NOORDER
        
 - ������ �ǻ�Į��(Pseudo Column)
 --------------------------------------------------------------
 �ǻ��÷�               �ǹ�
 --------------------------------------------------------------
 ��������.NEXTVAL       '������'�� ���� �� ��ȯ
 ��������.CURRVAL       '������'�� ���� �� ��ȯ
 --------------------------------------------------------------
 �������� �����ǰ� ó�� ����Ǿ�� �ϴ� �ǻ��÷��� NEXTVAL�̾�� �Ѵ�.
 
 ��뿹)LPROD ���̺� ���� �ڷḦ �����Ͻÿ�.
 --------------------------------------------------------------
            LPROD_ID        LPROD_GU        LPROD_NM
            ------------------------------------------
              10             P501            ��깰
              11             P502            �ӻ깰
              12             P601            ��갡����ǰ

 -> LPROD_ID�� �������� ����Ͻÿ�.
 CREATE SEQUENCE SEQ_LPROD_ID
    START WITH 10;
    
    INSERT INTO LPROD VALUES (SEQ_LPROD_ID.NEXTVAL,'P501','��깰');
    INSERT INTO LPROD VALUES (SEQ_LPROD_ID.NEXTVAL,'P502','�ӻ깰');
    INSERT INTO LPROD VALUES (SEQ_LPROD_ID.NEXTVAL,'P601','��갡����ǰ'); -- ������ ���� �� ��. ���Ӱ� ����� ���.
    
    SELECT * FROM LPROD;
    
2. ���Ǿ�(SYNONYM)
 - ����Ŭ ��ü�� �ο��ϴ� ��Ī(Alias)
 - SELECT ������ ���Ǵ� �÷��̳� ���̺� ��Ī���� �������� ��� �����̴�. -- �������(�д�)�� �ٸ���. ����Ŭ �� ��� ��ü�� ��� ����. / ���̺� �̳� �÷��� �ش� SQL�ȿ����� ��밡��.
 - �ַ� �ٸ� ���� ������ ��ü�� ������ �� �� �����κ��� ª�� ��Ī�� ����� ��� 
 
 (�������)
 CREATE [OR REPLACE] SYNONYM ���Ǿ�
    FOR ��ü��
    . '��ü��' �� ���ο� �̸��� '���Ǿ�'�� �ο�
    
��뿹)HR������ EMPLOYEES ���̺�� DEPARTMENTS���̺� ���� EMP�� DEPT ��Ī�� �ο��Ͽ� ����϶�.

CREATE OR REPLACE SYNONYM EMP FOR HR.EMPLOYEES;
CREATE OR REPLACE SYNONYM DEPT FOR HR.DEPARTMENTS;

SELECT * FROM HR.EMPLOYEES;
SELECT * FROM EMP; --���̺�δ� �������� ������ ��Ī���θ� ����. 

SELECT A.LAST_NAME,
       B.DEPARTMENT_NAME,
       A.HIRE_DATE,
       A.JOB_ID
   FROM EMP A, DEPT B
  WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
  ORDER BY B.DEPARTMENT_ID ;   
  
  SELECT 23457 * 2167134265
    FROM SYS.DUAL; --DUAL : ���̺��� �ʿ������� ������ SELECT ���� �ʿ��� �ǹ̾��� ���̺�, ���� ���߱� ���� ���̺��̴�. SYS. DUAL ; ���ο��� �ó��Ѱ�.
    
CREATE OR REPLACE SYNONYM D1 FOR SYS.DUAL;



              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
 
 
 
 