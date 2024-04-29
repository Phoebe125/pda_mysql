-- 프로시저 정의
DELIMITER $$

CREATE PROCEDURE `sp_test` (_dept_name VARCHAR(31))
BEGIN
    DECLARE v_deptId TINYINT UNSIGNED;
    DECLARE empCnt INT;
    DECLARE avgSalary DECIMAL(10, 2);

    -- 부서명에 해당하는 부서 ID 조회
    SELECT id INTO v_deptId FROM Dept WHERE dname = _dept_name;

    -- 해당 부서의 직원 수와 평균 급여 조회
    SELECT COUNT(*), AVG(salary) INTO empCnt, avgSalary
    FROM Emp
    WHERE dept = v_deptId;

    -- 결과 출력
    SELECT empCnt, avgSalary;
END$$

DELIMITER ;

-- 프로시저 호출
call sp_test("영업부");