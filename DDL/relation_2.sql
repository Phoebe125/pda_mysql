-- 먼저 fk pk 설정 혼자 해보기 (강의자님 풀이: relation_3)
use testdb;

alter table Dept drop column captin;
alter table Dept add column captin int unsigned null comment '부서장';

select * from Dept;

analyze table Dept;

alter table Dept add constraint fk_captin_Emp 
foreign key (captin)
references Emp(id)
on delete set null
on update cascade;

-- 일시적으로 FK 조건 삭제
ALTER TABLE Dept
DROP FOREIGN KEY fk_captin_Emp;

select * from Dept;