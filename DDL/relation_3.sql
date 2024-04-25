-- fk pk 연산 & join 연산 강의자님 version

select * from Emp;
select * from Dept;

show index from Dept;

alter table Dept drop column captin;
alter table Dept add column captin int unsigned null comment '부서장';

alter table Dept add constraint fk_Dept_captin_Emp_id
	foreign key (captin)
	references Emp(id)
	on delete set null
	on update cascade;

-- 일시적으로 FK 조건 삭제
ALTER TABLE Dept
DROP FOREIGN KEY fk_Dept_captin_Emp_id;

-- 완전히 삭제하려면, index에서도 삭제해야함 
alter table Dept drop index  fk_Dept_captin_Emp_id;

-- 확인 차원
select count(*) from Emp;
select count(*) from Dept;
select * from Emp where id <= 10;

-- Join 연산
-- 사투리 쓰지마라
select Emp.*, Dept.dname
	from Emp inner join Dept
    where Dept.id = Emp.dept; Emp.dept = Dept.id 보다 굳, 왜냐면 Dept.id는 클러스터 index Emp.dept는 비클러스터 index
-- where은 filtering 하는 거임

-- 아래 sql이 표준어임
select Emp.*, Dept.dname
	from Emp inner join Dept on Emp.dept = Dept.id;
    
explain select Emp.*, Dept.dname
	from Emp inner join Dept on Emp.dept = Dept.id;
    



