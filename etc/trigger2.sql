use testdb;

select * from Subject;
select * from Prof; -- 지난번에 해당 교수가 담당하는 과목 수 까지 진행했음

-- Subject에 insert 문이 실행되면, 해당 교수의 subjectcnt를 하나 증가되도록
-- Trigger 만들어 보기
create trigger tr_Subject_after_insert
		after insert on Subject for each row
		update Prof set subjectcnt = subjectcnt + 1
        where id = New.prof;
    
insert into Subject(name, prof) values('사회', 4);

-- Subject에 delete 문이 실행될때의 Trigger 생성
create trigger tr_Subject_after_delete
		after delete on Subject for each row
		update Prof set subjectcnt = subjectcnt - 1
        where id = OLD.prof;
        
delete from Subject where id = 7;

-- Subject에 update문이 실행될 때의 Trigger 생성
select prof, count(*)
	from Subject
    group by prof;

-- 한개의 Table에 update가 일어나면, 이에 다른 Table도 동일한 값으로 update가 일어나도록
update Prof p
	inner join (select prof, count(*) cnt from Subject group by prof) sub
		on p.id = sub.prof
	set p.subjectcnt = sub.cnt
    where p.id > 0;
    
Select s.*, p.subjectcnt
	from Subject s inner join Prof p on p.id = s.prof;

create trigger tr_subject_after_update
	after update on Subject for each row
	update Prof set subjectcnt = if(id = NEW.prof, subjectcnt + 1, subjectcnt - 1)
	where id in (OLD.prof, NEW.prof) and OLD.prof <> NEW.prof; -- prof에 변경이 있을 때
-- trigger는 가벼워야한다.
    
select * from Subject;
select * from Prof;
update Subject set prof = 8 where id = 4;
update Subject set name = '사회과부도' where id = 8;