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

