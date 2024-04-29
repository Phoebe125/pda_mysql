-- union
select * from Dept where id <=4
union all
select * from Dept where id >=4
order by id desc;

-- Variables
-- 해당 session 에만 존재하는 세션 변수: @를 붙여준다 (@가 declare를 포함하고 있음)
-- prepared statement 를 사용한다 == query cache에 관리가 된다. session이 끊어져도 유지됨
-- declare로 선언 -> query cache에 올라감 -> 메모리에 저장됨
-- declare: 저장 프로시저(Stored Procedure)나 트리거(Trigger) 내에서 사용됨
-- function은 return 값이 한개, procedure은 순차적으로 실행하는 것

-- select sum(sal) into @sal_sum ...

-- DECLARE <var-name> <type> [default ..];
--  (ex. declare v_i int default 0)
-- SET <var-name> = <value>;  -- a = 1 ⇒ set a = 1;
-- SELECT <col> INTO <var-name> from …;  -- select sum(sal) into @salsum …
-- ex.
-- declare v_addr varchar(255);
-- set v_i = 1;
-- select addr into v_addr from Student where id = v_i;
-- cf. session variable (unnecessary declaration, but ...)
-- set @var = 'aaa';
-- session 뭔가 os thread 개념으로 생각하면 편할 듯


select (select @rownum := @rownum + 1) No, s.* # :=은 초기값을 세팅하는 기호
	from Emp s, (select @rownum := 0) rn;

-- Functions => DELIMITER 신경쓰기 싫으면, workbench gui 로 생성
-- _ts 처럼 _를 사용하는 것은 관례이다!
-- output은 session 변수로 받기 때문에, output도 () 안에 @output 이런식으로 받아야함!
DELIMITER $$
CREATE Function f_dt(_ts timestamp) RETURNS varchar(31)
BEGIN
	RETURN date_format(_ts, '%m/%d %H:%i');
END $$
DELIMITER ;

    
select * from Dept;
select * from Emp;

-- 위에 생성한 함수가 잘 작동되는지 확인해보기
select f_dt(now());

-- 실습: 직원 id를 전달하면, 직원명과 부서를 반환하는 함수를 작성 -> GUI로 함수 작성
DELIMITER $$
CREATE DEFINER=`root`@`%` FUNCTION `f_empinfo`(_empId int unsigned) RETURNS varchar(64) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
BEGIN
	declare v_ret varchar(64) default 'Not Found';
	select concat(e.ename, '(', d.dname, ')') into v_ret
		from Emp e inner join Dept d on e.dept = d.id
        where e.id = _empId;
	return v_ret;
END $$
DELIMITER ;

select f_empinfo(e.id), e.* from Emp e;