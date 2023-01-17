2022-1220-03) ���̺� ����, ����, ����

1. ���̺� ����
 - ����� �ڷḦ �����ϱ� ���� ������� ����
 (��� ����)
 CREATE TABLE ���̺�� (
    �÷��� ������Ÿ��[(ũ�� [BYTE|CHAR])] [NOT NULL] [DEFAULT ��],
                        :
    �÷��� ������Ÿ��[(ũ�� [BYTE|CHAR])] [DEFAULT ��],
    [CONSTRAINT �⺻Ű ������ PRIMARY KEY(�÷���[,�÷���,...]),]
    [CONSTRAINT �ܷ�Ű ������ FOREIGN KEY(�÷���) REFERENCES ���̺��(�÷���),]
                        :
    [CONSTRAINT �ܷ�Ű ������ FOREIGN KEY(�÷���) REFERENCES ���̺��(�÷���),]
    
    
��� ��) ĥ���� ERD�� ���̺�� �����Ͻÿ�.

 1) ȸ�����̺�(CUSTOMERS) ����
    - ȸ����ȣ(CUST_ID), ȸ����(CUST_NAME), ��ȭ��ȣ(CUST_TEL_NUM)
 2) ��ǰ���̺�(GOODS)
    - ��ǰ��ȣ(G_ID), ��ǰ��(G_NAME), ����(G_PRICE)
 3) �ֹ����̺�(ORDERS)
    - �ֹ���ȣ(ORDER_ID), ��¥(ORDER_DATE)
 4) �ֹ���ǰ���̺�(ORDERS_G00DS)
    - ����(ORDER_QTY)

1   
CREATE TABLE CUSTOMERS(
    CUST_ID CHAR(4),
    CUST_NAME VARCHAR2(30) NOT NULL,
    CUST_TEL_NUM VARCHAR2(20),
    CONSTRAINT pk_customers PRIMARY KEY(CUST_ID));
    
2
CREATE TABLE GOODS(
    G_ID NUMBER(4) ,
    G_NAME VARCHAR2(50) NOT NULL,
    G_PRICE NUMBER(7) DEFAULT 0,
    CONSTRAINT pk_goods PRIMARY KEY(G_ID));
3 
CREATE TABLE ORDERS(
    ORDER_ID CHAR(12), --PK
    ORDER_DATE DATE DEFAULT SYSDATE, --�����Ͱ� ��ϵǴ� ������ ��¥������
    CUST_ID CHAR(4), --FK
    CONSTRAINT pk_orders PRIMARY KEY(ORDER_ID), 
    CONSTRAINT fk_orders_cust FOREIGN KEY(CUST_ID)
        REFERENCES CUSTOMERS(CUST_ID));

 DROP TABLE ORDERS_GOODS;
4
CREATE TABLE ORDERS_GOODS (
    ORDER_QTY NUMBER(3),
    G_ID NUMBER(4), -- PK & FK
    ORDER_ID CHAR(12),  --PK & FK
    CONSTRAINT pk_ordergood PRIMARY KEY(G_ID,ORDER_ID),
    CONSTRAINT fk_org_goods FOREIGN KEY(G_ID)
        REFERENCES GOODS(G_ID),
    CONSTRAINT fk_org_orders FOREIGN KEY(ORDER_ID)
        REFERENCES ORDERS(ORDER_ID) );
 2022-12-21        
2. ���̺� ����
 - DROP TABLE ������� ����
 - ����(RELATIONSHIP)�� �ΰ��ִ� ���̺� �� �θ����̺��� �ڽ����̺��� �����ϸ� ������ �� ����.
 
(��� ����)
 DROP TABLE ���̺��;
 
3. ���̺� ���� ����(ALTER)
 - ���̺��� �÷��� �߰�, ����, ���� �� �÷����� ����
 - ���̺�� ���� 
 - ������� �߰� �� ����
    
 1) �÷� �߰�
    . ���̺� ���ο� �÷� �߰�
    
(��� ����)
    ALTER TABLE ���̺�� ADD(�÷��� ������Ÿ��[(ũ�� [BYTE|CHAR])] [NOT NULL] [DEFAULT ��]);
    
 ��� ��) HR������ EMPLOYEES ���̺� EMP_NAME �÷��� �߰��Ͻÿ�.
       �ش� �÷��� VARCHAR2(80)�� ũ�⸦ ���´�. 
        
    ALTER TABLE HR.EMPLOYEES ADD(EMP_NAME VARCHAR2(80));
    
 2) �÷� ����
    . �÷��� �������� ũ�⸦ ����
    . ũ�⺯��� ����ũ�⺸�� �۰� �� �� ����.
    
 (��� ����)
    ALTER TABLE ���̺�� MODIFY(�÷��� ������Ÿ��[(ũ�� [BYTE|CHAR])] [NOT NULL] [DEFAULT ��]);
    
 ��� ��) HR������ EMPLOYEES ���̺��� FIRST_NAME �÷�(VARCHAR2(20))�� CHAR(20)���� �����Ͻÿ�.
    ALTER TABLE HR.EMPLOYEES MODIFY(FIRST_NAME CHAR(20));
    ALTER TABLE HR.EMPLOYEES MODIFY(FIRST_NAME NUMBER(20)); (X) �÷� �ƿ� ���� 
    ALTER TABLE HR.EMPLOYEES MODIFY(FIRST_NAME VARCHAR2(15)); (X) 
    ALTER TABLE HR.EMPLOYEES MODIFY(FIRST_NAME VARCHAR2(25));
    
 3) �÷� ����
    . ���ʿ��� �÷��� ����
 (��� ����)
    ALTER TABLE ���̺�� DROP COLUMN �÷���;
    
 (��� ��)HR������ EMPLOYEES ���̺��� FIRST_NAME �÷��� �����Ͻÿ�.
    ALTER TABLE HR.EMPLOYEES DROP COLUMN FIRST_NAME;
    ROLLBACK;
    
    
    
 4) �÷��� ����
 (��� ����)
    ALTER TABLE ���̺�� RENAME COLUMN old_�÷��� TO NEW_�÷���;

 5) ���̺�� ����
 (��� ����)
    ALTER TABLE old_���̺�� RENAME TO new_���̺��;
 (��� ��) ORDERS_GOODS ���̺��� tbl_order_detail�� �����Ͻÿ�.
    ALTER TABLE ORDERS_GOODS RENAME TO tbl_order_detail;
    
 5) ������� �߰� ����, ����
 (��� ����)
    (�߰�) ALTER TABLE ���̺�� ADD CONSTRAINT ����� PRIMARY KEY|FOREIGN KEY (�÷���)[,�÷���,...])[REFERENCES ���̺��(�÷���)];
    (����) ALTER TABLE ���̺�� DROP CONSTRAINT �����; --���� ���� ��
    (����) ALTER TABLE ���̺�� MODIFY �÷�����; -- �÷� �������(NOT NULL, DEFAULT �� ���� ����)
    
 (��� ��) GOODS ���̺��� �����Ͻÿ�.
    DROP TABLE GOODS; (X)
    
    1) �������(�ڽ����̺� �����ϴ� ���� ���� ����)
    ALTER TABLE TBL_ORDER_DETAIL DROP CONSTRAINT FK_ORG_GOODS;
    DROP TABLE GOODS;
    
  (��� ��) CUSTOMERS ���̺��� �����Ͻÿ�.  
    DROP TABLE TBL_ORDER_DETAIL;
    DROP TABLE ORDERS;
    DROP TABLE CUSTOMERS;
    
    
    
    
    