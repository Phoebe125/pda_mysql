-- view
use testdb;

select * 
	from Subject s left outer join Prof p on s.prof = p.id;

create view v_subject as
select s.*, p.name profname
	from Subject s left outer join Prof p on s.prof = p.id;

use testdb;
insert into Subject(name, prof) values ('미술', 2), ('역사', 3);

select * from v_subject;

-- View 를 사용하는 이유
-- 1. Security
-- 2. Simplicity
-- 3. Performance - prepared statement
-- 4. For Operator (Programmer)


