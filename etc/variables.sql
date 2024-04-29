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
