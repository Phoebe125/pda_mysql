-- p.52에 있는 실습
use schooldb;

-- 1. Dept 테이블에 empcnt 컬럼 추가
alter table Dept add column empcnt smallint unsigned not null default 0 comment '부서별 직원수';

select * from Dept;
select * from Emp;

-- 2. insert trigger 생성 (Emp insert하면, empcnt 를 증가)
create trigger tr_Emp_after_insert
		after insert on Emp for each row
		update Dept set empcnt = empcnt + 1
        where id = New.dept;

-- 잘 돌아가는 지 insert 문 생성
insert into Emp(ename, dept, salary) values('이선민', 4, 300);    

-- 3. delete trigger 생성 (Emp delete하면, empcnt를 감소)
create trigger tr_Emp_after_delete
		after delete on Emp for each row
		update Dept set empcnt = empcnt - 1
        where id = Old.dept;
        
-- 잘 돌아가는 지 delete 문 생성        
delete from Emp where id = 253;
    
-- 4. 초기값 세팅
select * from Dept;

update Dept d
	inner join (select dept, count(*) cnt from Emp group by dept) e
		on d.id = e.dept
	set d.empcnt = e.cnt
    where d.id > 0;
    
-- 5. update 문 작성
create trigger tr_emp_after_update
	after update on Emp for each row
	update Dept set empcnt = if(id = NEW.dept, empcnt + 1, empcnt - 1)
	where id in (OLD.dept, NEW.dept) and OLD.dept <> NEW.dept; -- dept에 변경이 있을 때
    
-- 잘 돌아가는지 update 확인
select * from Emp;
update Emp set dept = 5 where id = 3;

-- cf: read lock때문에 update trigger와 lock 걸리는 경우
-- update trigger를 잠시 꺼두고, read 작업 후에 update할 수 있도록 한다!
update Emp set dept = (select id from Dept order by rand() limit 1);

-- Union
select * from Dept where id <4
union
select * from Dept where id >=4
order by id desc;
-- 이런경우 procedure로 작성해야!