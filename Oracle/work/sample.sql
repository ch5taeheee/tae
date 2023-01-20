-- 사원
CREATE TABLE "emp" (
	"emp_Id" char(4) NOT NULL,
	"emp_name" varchar2(30) NOT NULL,
	"dept_name" varchar2(50) NULL
);

-- 사원
ALTER TABLE "emp"
	ADD CONSTRAINT "PK_emp" -- 사원 기본키
	PRIMARY KEY (
	"emp_Id" -- 사원번호
	);

-- 사업장
CREATE TABLE "site" (
	"site_no" number(3) NOT NULL,
	"site_name" varchar2(50) NULL,
	"site_addr" varchar2(100) NULL
);

-- 사업장
ALTER TABLE "site"
	ADD CONSTRAINT "PK_site" -- 사업장 기본키
	PRIMARY KEY (
	"site_no" -- 사업장번호
	);

-- 근무
CREATE TABLE "tbl_work" (
	"emp_Id" char(4) NOT NULL,
	"site_no" number(3) NOT NULL,
	"winput_date" date NULL
);

-- 근무
ALTER TABLE "tbl_work"
	ADD CONSTRAINT "PK_tbl_work" -- 근무 기본키
	PRIMARY KEY (
	"emp_Id",  -- 사원번호
	"site_no"  -- 사업장번호
	);

-- 근무
ALTER TABLE "tbl_work"
	ADD CONSTRAINT "FK_emp_TO_tbl_work" -- 사원 -> 근무
	FOREIGN KEY (
	"emp_Id" -- 사원번호
	)
	REFERENCES "emp" ( -- 사원
	"emp_Id" -- 사원번호
	);

-- 근무
ALTER TABLE "tbl_work"
	ADD CONSTRAINT "FK_site_TO_tbl_work" -- 사업장 -> 근무
	FOREIGN KEY (
	"site_no" -- 사업장번호
	)
	REFERENCES "site" ( -- 사업장
	"site_no" -- 사업장번호
	);