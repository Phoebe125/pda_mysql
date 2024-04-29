-- Common Table Expression
-- 임시 테이블 사용하는 것처럼 사용
WITH
  cte1 AS (SELECT a, b FROM table1),
  cte2 AS (SELECT c, d FROM table2)
SELECT b, d FROM cte1 INNER JOIN cte2
    ON cte1.a = cte2.c;
    
-- 재귀함수랑 동일하게 사용됨
WITH RECURSIVE cte (n) AS
(
  SELECT 1     -- initial(root) row set
  UNION ALL
  SELECT n + 1 FROM cte WHERE n < 5 -- additional row sets
)
SELECT * FROM cte;

-- CTE 예시 테이블
WITH 
  AvgSal AS (
    select d.dname, avg(e.salary) avgsal
      from Dept d inner join Emp e on d.id = e.dept
     group by d.id
  ),
  MaxAvgSal AS (
    select * from AvgSal order by avgsal desc limit 1
  ),
  MinAvgSal AS (
    select * from AvgSal order by avgsal limit 1
  ),
  SumUp AS (
    select '최고' as gb, m1.* from MaxAvgSal m1
    UNION
    select '최저' as gb, m2.* from MinAvgSal m2
  )
select gb, dname, format(avgsal * 10000,0) from SumUp
UNION
select '', '차액', format( (max(avgsal) - min(avgsal)) * 10000, 0) from SumUp;

-- 재귀함수를 사용한 피보나치 수열 계산 코드
WITH RECURSIVE fibonacci (n, fib_n, next_fib_n) AS
(
    select 1, 0, 1
    UNION ALL
    select n + 1, next_fib_n, fib_n + next_fib_n
      from fibonacci where n < 10
)
select * from fibonacci;

-- 재귀함수의 또다른 예시
WITH RECURSIVE CteDept(id, pid, pname, dname, d, h) AS 
(
    select id, pid, cast('' as char(31)), dname, 0, cast(id as char(10)) from Dept where pid = 0
    UNION ALL
    select d.id, d.pid, cte.dname, d.dname, d + 1, concat(cte.h, '-', d.id) from Dept d inner join CteDept cte on d.pid = cte.id
)
select /*+ SET_VAR(cte_max_recursion_depth = 5) */ d, dname, h from CteDept order by h;


