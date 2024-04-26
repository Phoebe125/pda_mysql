use testdb;

-- trigger 설정을 위해 view 및 필요한 column 추가
select prof, max(profname) profname, count(*)
	from v_subject
    group by prof;
    
alter table Prof add column subjectcnt tinyint unsigned not null default 0 comment '담당 과목수';
select * from Prof;

create trigger tr_prof_subjectcnt after insert 
	on Subject for each row
	update Prof set subjectcnt = subjectcnt + 1
    where id = NEW.prof; -- 새로 들어오는 값은 모르니까 NEW 로 받아온다.
    
create trigger tr_prof_subjectcnt_up after update -- after를 써줌
	on Subject for each row
    update Prof set subjectcnt = if(id = NEW.prof, subjectcnt + 1, subjectcnt - 1)
    where id in (OLD.prof, NEW.prof) and OLD.prof <> NEW.prof; -- 이미 삭제된 row에 대해서는 OLD로 받아온다.
-- update 의 경우, OLD, NEW 둘다 필요하다
-- 기존 row는 OLD로 바뀐거로는 NEW로 

create trigger tr_prof_subjectcnt_del after delete 
	on Subject for each row
    update Prof set subjectcnt = subjectcnt - 1
    where id = OLD.prof and subjectcnt > 0;

