--select *from lprod;

INSERT INTO lprod (
    lprod_id,
    lprod_gu,
    lprod_nm
) VALUES (
    100,
    'M101',
    '커피류'
);

SELECT *FROM LPROD;

insert into mymember(mem_Id, mem_name, mem_tel, mem_addr)
values ('a001','홍길동','111-1111','대전');

select * from mymember;

delete from mymember where mem_id = 'km';

select * from mymember;

delete from mymember where mem_id = 'aaa';

select * from mymember;

delete from mymember where mem_id = 'a003';

select * from mymember;

select count(*)as cnt from mymember where mem_id = 'a001'; 

select * from mymember;

delete from mymember where mem_id = 'a003';

select * from mymember;
commit;

update mymember set mem_name ='노태현',mem_tel = '888',mem_addr = '광주시' where mem_id = 'a001';

select * from mymember;

delete from mymember where mem_id = 'km';


