// ȸ������ ���α׷� ���̺� ���� ��ũ��Ʈ 
create table mymember(
    mem_id varchar2(8) not null,  -- ȸ��ID
    mem_name varchar2(100) not null, -- �̸�
    mem_tel varchar2(50) not null, -- ��ȭ��ȣ
    mem_addr varchar2(128),    -- �ּ�
    reg_dt DATE DEFAULT sysdate, -- �����
    CONSTRAINT MYMEMBER_PK PRIMARY KEY (mem_id)
);
--����̹��� ���� ���� �ʿ��ϴ�