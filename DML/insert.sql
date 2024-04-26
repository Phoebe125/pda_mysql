-- 4/26 강의 시작

-- 0. data 넣기 [insert에서 이어서 배움]
insert into Prof (name) select '교수' from testdb.Emp where id <= 6;
select * from Prof;
update Prof set name = concat(name, id);
update Prof set likecnt = floor(rand() * 100);

-- 1. insert
insert into Subject(name, prof) values('국어', 1);
insert into Subject(name, prof) values('수학', 2), ('과학', 2), ('미술', 2);
select * from Subject;

