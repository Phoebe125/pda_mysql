select
    row_number() over(order by dept, salary desc) '순번',
    e.*,
    rank() over w '부서내 순위',
    dense_rank() over w '부서내 순위',
    percent_rank() over w '부서내 %순위',
    cume_dist() over w '부서내 %경계',
    ntile(3) over w '급여등급'
  from Emp e
 where ename like '박%'
 WINDOW w as (partition by dept order by dept, salary desc); # Window 함수를 사용하기 위해서 Window를 반드시 명시해줘야 한다.
 
 select row_number() over(order by dept, salary desc) '순번',
    e.*,
    sum(salary) over w '급여 누적치',
    first_value(salary) over w '부서내 1등 급여',
    last_value(salary) over w '부서내 현재까지의 꼴등 급여',
    nth_value(salary, 2) over w '부서내 2등 급여',
    lag(salary, 1) over w '이전 급여', -- 생각보다 이전 값을 cursor로 알기가 어렵 >> window 에 lag와 lead를 사용해서 이전, 다음 행 값을 알 수 있음!
    lead(salary, 1) over w '다음 급여'
  from Emp e
 where ename like '박%'
 WINDOW w as (partition by dept order by dept, salary desc);
 
 -- ROLLUP
 select p.id, d.id, (case when p.id is not null
            then max(p.dname)
            else 'Total' end
        ) as '상위부서', 
       (case when d.id is not null
            then max(d.dname)
            else '- 소계 -' end
        ) as '부서',
       format(sum(e.salary), 0) as '급여합'
  from Dept p
        inner join Dept d on p.id = d.pid
        inner join Emp e on d.id = e.dept
 group by p.id, d.id
 with rollup;

-- 기타 테이블 요약
select '평균급여' as '구분',
   format(avg(case when dept = 3 then salary end) * 10000, 0) '영업1팀',
   format(avg(case when dept = 4 then salary end) * 10000, 0) '영업2팀',
   format(avg(case when dept = 5 then salary end) * 10000, 0) '영업3팀',
   format(avg(case when dept = 6 then salary end) * 10000, 0) '서버팀',
   format(avg(case when dept = 7 then salary end) * 10000, 0) '클라팀'
 from Emp
UNION
select '급역합계',
   format(sum(salary * (dept = 3)) * 10000, 0),
   format(sum(salary * (dept = 4)) * 10000, 0),
   format(sum(salary * (dept = 5)) * 10000, 0),
   format(sum(salary * (dept = 6)) * 10000, 0),
   format(sum(salary * (dept = 7)) * 10000, 0)
 from Emp
UNION
select '최소급여',   
   format(min(IF(dept = 3, salary, ~0)) * 10000, 0),
   format(min(IF(dept = 4, salary, ~0)) * 10000, 0),
   format(min(IF(dept = 5, salary, ~0)) * 10000, 0),
   format(min(IF(dept = 6, salary, ~0)) * 10000, 0),
   format(min(IF(dept = 7, salary, ~0)) * 10000, 0)
 from Emp
UNION
select '최대급여',   
   format(max(IF(dept = 3, salary, 0)) * 10000, 0),
   format(max(IF(dept = 4, salary, 0)) * 10000, 0),
   format(max(IF(dept = 5, salary, 0)) * 10000, 0),
   format(max(IF(dept = 6, salary, 0)) * 10000, 0),
   format(max(IF(dept = 7, salary, 0)) * 10000, 0)
 from Emp
 ;



