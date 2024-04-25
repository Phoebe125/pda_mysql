start transaction;

select * from Emp;

update Emp set salary=230 where id=3;

update Emp set salary=240 where id=4;

update Emp set salary=250 where id=3;

-- rollback; -- 실행할 때만 주석 해제

-- commit; -- 실행할 때만 주석 해제