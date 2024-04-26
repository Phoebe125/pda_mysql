-- 2. group by, order by
use testdb;

select * from Emp 
	order by id limit 20, 10; # 20: offset
    
select sub.*  
	from (select * from Emp order by id desc limit 10, 11) sub
    order by sub.id; # 뒤에서 접근하는 경우, order by를 desc  -- 뒤에서 부터 접근하는 경우 >> desc으로 잘라와서 다시 asc으로 순서 원래대로

select dept, max(ename) maxname, min(ename), count(*), max(salary), min(salary) minsal
	from Emp
    group by dept
    having count(*) >= 40 -- having은 group by를 filtering, order by 앞에 
    order by max(ename); -- maxename 도 가능함

-- 부서명과 함께 최고 연봉자 수
select e.dept, d.dname, max(salary) maxsal, count(*) cnt
	from Emp e inner join Dept d on e.dept = d.id
				inner join (select dept, max(salary) maxsal from Emp group by dept) maxdept
                on e.dept = maxdept.dept and e.salary = maxdept.maxsal
	group by e.dept, e.salary;
    
-- self join
select d1.dname '상위부서', d2.dname '하위부서'
	from Dept d1 inner join Dept d2 on d1.id = d2.pid;
    
-- 과목-담당쌤
use schooldb;
select sub.*, p.name
	from Subject sub inner join Prof p on sub.prof = p.id;
    
--
update Subject set prof = (select id from Prof where name="교수3")
	where id=4;
    
select * from Subject;

-- 교수명이 '교수3'인 과목의 이름 '음악'으로 변경하시오.
update Subject s inner join Prof p on s.prof = p.id
    set s.name = "음악"
    where p.name = '교수3';
    
select * from Subject;
update Subject set prof=null
where id = 3;

select * from Subject where prof is null;

