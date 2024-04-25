-- update
select * from Dept;

update Dept set captin = id * 10
	where id > 0;

-- inner join 
select d.*, e.ename as '부서장'
	from Dept d inner join Emp e on d.captin = e.id;
    
-- outer join (left 기준으로)
select d.*, e.ename as '부서장'
	from Dept d left outer join Emp e on d.captin = e.id; 
    
select d.*, ifnull(e.ename, '공석') as '부서장'
	from Dept d left outer join Emp e on d.captin = e.id;