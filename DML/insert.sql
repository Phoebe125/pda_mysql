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

desc Student;

insert into Student(name, birthdt, major, mobile, email) 
	values ('홍길동', '2002-01-02', 1, '01012341234', 'hong@gmail.com');

insert into Student(name, birthdt, major, mobile, email) values
	('박길동', '2003-01-22', 1, '01012341234', 'park@gmail.com'),
    ('김길동', '2002-01-22', 1, '01012341234', 'kim@gmail.com');
    
select * from Student;

insert into Enroll(subject, student) values(1, 1);
insert into Enroll(subject, student) values(2, 2);
insert into Enroll(subject, student) values(3, 2);
-- Error Code: 1062. Duplicate entry '2-2' for key 'enroll.unique_subject_student'
insert into Enroll(subject, student) values(2, 2);

-- 해결 방법
insert ignore into Enroll(subject, student) values
	(2, 1), (2, 2); -- 중복인 경우 무시~ (id=3 없음 -> auto_increment 때문에)
    
-- : 2 row(s) affected: insert 하다가 중복이 발생한 행에 대해서는 update를 할 것임
insert into Enroll(subject, student) values (2, 2)
	on duplicate key update createdate = now();

select * from Enroll;

-- cf
show variables like '%dir';

-- 실습 1
select tmp.name as '학생명', sbj.name as '과목명'
from (select subject, student, name from Enroll e inner join Student s on e.student = s.id) tmp inner join Subject sbj
	on tmp.subject= sbj.id;
    
-- 실습 1 답안
select e.id, sbj.name as '과목명', stu.name as'학생명'
	from Enroll e inner join Subject sbj on e.subject = sbj.id
				  inner join Student stu on stu.id = e.student;

-- case when 과 if 문
select e.id, sbj.name as '과목명', stu.name as'학생명', 
	(case when mod(e.id, 2) = 1 then '홀수' else '짝수' end) as '홀짝1',
	(case mod(e.id, 2) when 1 then '홀수' else '짝수' end) as '홀짝2',
    if (mod(e.id, 2) = 1, '홀수', '짝수') '홀짝3', 
    (case when e.id = 5 then '55' when e.id = 2 then '22' else '100' end) as 'XX',
    (case e.id when 5 then '55' when 2 then '22' else '100' end) as 'YY'
	from Enroll e inner join Subject sbj on e.subject = sbj.id
				  inner join Student stu on stu.id = e.student
	where e.subject = 2;

