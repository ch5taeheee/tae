--select *from lprod;

INSERT INTO lprod (
    lprod_id,
    lprod_gu,
    lprod_nm
) VALUES (
    100,
    'M101',
    'Ŀ�Ƿ�'
);

SELECT *FROM LPROD;

insert into mymember(mem_Id, mem_name, mem_tel, mem_addr)
values ('a001','ȫ�浿','111-1111','����');

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

update mymember set mem_name ='������',mem_tel = '888',mem_addr = '���ֽ�' where mem_id = 'a001';

select * from mymember;

delete from mymember where mem_id = 'km';


