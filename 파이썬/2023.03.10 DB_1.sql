create table emp(
	e_id VARCHAR(10),
	e_name VARCHAR(20),
	sex VARCHAR(20),
	addr VARCHAR(100));
	
insert into emp(e_id,e_name,sex,addr) VALUES('1','1','1','1');

update emp set e_name = '6',sex = '6', addr='6' where e_id = '3';

delete from emp where e_id = 3;