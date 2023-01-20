-- ���
CREATE TABLE "emp" (
	"emp_Id" char(4) NOT NULL,
	"emp_name" varchar2(30) NOT NULL,
	"dept_name" varchar2(50) NULL
);

-- ���
ALTER TABLE "emp"
	ADD CONSTRAINT "PK_emp" -- ��� �⺻Ű
	PRIMARY KEY (
	"emp_Id" -- �����ȣ
	);

-- �����
CREATE TABLE "site" (
	"site_no" number(3) NOT NULL,
	"site_name" varchar2(50) NULL,
	"site_addr" varchar2(100) NULL
);

-- �����
ALTER TABLE "site"
	ADD CONSTRAINT "PK_site" -- ����� �⺻Ű
	PRIMARY KEY (
	"site_no" -- ������ȣ
	);

-- �ٹ�
CREATE TABLE "tbl_work" (
	"emp_Id" char(4) NOT NULL,
	"site_no" number(3) NOT NULL,
	"winput_date" date NULL
);

-- �ٹ�
ALTER TABLE "tbl_work"
	ADD CONSTRAINT "PK_tbl_work" -- �ٹ� �⺻Ű
	PRIMARY KEY (
	"emp_Id",  -- �����ȣ
	"site_no"  -- ������ȣ
	);

-- �ٹ�
ALTER TABLE "tbl_work"
	ADD CONSTRAINT "FK_emp_TO_tbl_work" -- ��� -> �ٹ�
	FOREIGN KEY (
	"emp_Id" -- �����ȣ
	)
	REFERENCES "emp" ( -- ���
	"emp_Id" -- �����ȣ
	);

-- �ٹ�
ALTER TABLE "tbl_work"
	ADD CONSTRAINT "FK_site_TO_tbl_work" -- ����� -> �ٹ�
	FOREIGN KEY (
	"site_no" -- ������ȣ
	)
	REFERENCES "site" ( -- �����
	"site_no" -- ������ȣ
	);