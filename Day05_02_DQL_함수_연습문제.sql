-- 1. EMPLOYEES 테이블에서 JOB_ID를 조회하시오. 동일한 JOB_ID는 한 번만 출력하고 알파벳 순으로 정렬하여 조회하시오.
SELECT DISTINCT JOB_ID
  FROM EMPLOYEES
 ORDER BY JOB_ID ASC;
-- 알파벳순 오름차순 연봉 높은순 내림차순 
-- 2. EMPLOYEES 테이블에서 DEPARTMENT_ID가 50인 사원 중에서 SALARY가 5000 이상인 사원을 조회하시오.
SELECT DEPARTMENT_ID, SALARY
   FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 50 AND SALARY >= 5000;

-- 3. EMPLOYEES 테이블에서 FIRST_NAME이 'Steven', LAST_NAME이 'King'인 사원을 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME   
  FROM EMPLOYEES
 WHERE FIRST_NAME = 'Steven' AND LAST_NAME = 'King';

-- 4. EMPLOYEES 테이블에서 EMPLOYEE_ID가 151 ~ 200인 사원을 조회하시오.
SELECT EMPLOYEE_ID, FIRST_NAME || '' || LAST_NNAME
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID BETWEEN 151 AND 200; -- 비트윈을 사용할때는 = 등호를 사용안하고 컬럼명 뒤에 비트윈 쓰고 앤드 

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID BETWEEN  151 AND 200;
 
-- 5. EMPLOYEES 테이블에서 JOB_ID가 'IT_PROG', 'ST_MAN'인 사원을 조회하시오.
SELECT JOB_ID
  FROM EMPLOYEES
 WHERE JOB_ID IN ('IT_PROG','ST_MAN');

SELECT EMPLOYEE_ID, JOB_ID
  FROM EMPLOYEES
 WHERE JOB_ID IN ('IT_PROG','ST_MAN');
 
-- 6. EMPLOYEES 테이블에서 HIRE_DATE가 2005년도인 사원을 조회하시오.
SELECT HIRE_DATE
  FROM EMPLOYEES
 WHERE HIRE_DATE LIKE '05%'; 

SELECT EMPLOYEE_ID,  HIRE_DATE
  FROM EMPLOYEES
 WHERE TO_CHAR(HIRE_DATE, 'YY') = 05; 
 
-- 7. EMPLOYEES 테이블에서 MANAGER_ID가 없는 사원을 조회하시오.
SELECT MANAGER_ID,FIRST_NAME || ' '|| LAST_NAME
  FROM EMPLOYEES
 WHERE MANAGER_ID IS NULL ;
 
-- 8. EMPLOYEES 테이블에서 COMMISSION_PCT를 받는 사원들의 실제 커미션을 조회하시오. 커미션은 COMMISSION_PCT * SALARY로 계산하시오.
SELECT COMMISSION_PCT*SALARY, FIRST_NAME || ' '|| LAST_NAME
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NOT NULL; 

SELECT FIRST_NAME, LAST_NAME, COMMISSION_PCT *SALARY AS 돈
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NOT NULL;

-- 9. EMPLOYEES 테이블에서 FIRST_NAME이 'J'로 시작하는 사원을 조회하시오.
SELECT FIRST_NAME
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE 'J%'; -- 뭐로 시작하거나 하는건 무조건 LIKE 함수 사용해주기

SELECT EMPLOYEE_ID, FIRST_NAME
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE 'J%';
 
-- 10. EMPLOYEES 테이블에서 JOB_ID가 'MAN'으로 끝나는 사원들의 MANAGER_ID를 중복을 제거하여 조회하시오.
SELECT DISTINCT MANAGER_ID -- DISTINCT값은 무조건 SELECT절에 넣어줘야한다
  FROM EMPLOYEES
 WHERE JOB_ID LIKE '%MAN';

-- 11. EMPLOYEES 테이블에서 전체 사원을 DEPARTMENT_ID의 오름차순으로 조회하되, 동일한 DEPARTMENT_ID 내에서는 HIRE_DATE의 오름차순으로 조회하시오.
SELECT DEPARTMENT_ID, HIRE_DATE
  FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID ASC, TO_DATE(HIRE_DATE, 'YY/MM/DD') ASC;
 
SELECT DEPARTMENT_ID, HIRE_DATE
  FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID ASC, HIRE_DATE ASC;

-- 12. EMPLOYEES 테이블에서 DEPARTMENT_ID가 80인 사원들을 높은 SALARY순으로 조회하시오. SALARY는 9,000처럼 천 단위 구분기호를 표기해서 조회하시오.
SELECT DEPARTMENT_ID, TO_CHAR(SALARY, '99,999')
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 80 
 ORDER BY SALARY DESC; -- 높은순으로 조회 순서 바꾸면 정렬 오더바이 사용

SELECT EMPLOYEE_ID, DEPARTMENT_ID ,TO_CHAR(SALARY, '99,999')
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 80 
 ORDER BY SALARY DESC;
-- 13. EMPLOYEES 테이블에서 전체 사원의 근무 개월 수를 정수로 조회하시오. 1개월 1일을 근무했다면 2개월을 근무한 것으로 처리해서 조회하시오.
SELECT
       EMPLOYEE_ID, FIRST_NAME || ''|| LAST_NAME
     , CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' AS 근무개월수 --개월 수로 계산하려면 MONTHS_BETWEEN
  FROM EMPLOYEES;  -- 조건이 없어서 WHERE 사용안함
  
-- 14. EMPLOYEES 테이블에서 PHONE_NUMBER에 따른 지역(REGION)을 조회하시오.
-- PHONE_NUMBER가 011로 시작하면 'MOBILE', 515로 시작하면 'EAST', 590으로 시작하면 'WEST', 603으로 시작하면 'SOUTH', 650으로 시작하면 'NORTH'로 조회하시오.
SELECT PHONE_NUMBER
    ,CASE  -- SUBSTR(PHONE_NUMBER , 1, 3) 이렇게 하고 WHEN 에 '011' 이렇게만 사용
    WHEN PHONE_NUMBER LIKE '011%' THEN 'MOBILE'
    WHEN PHONE_NUMBER LIKE '515%' THEN 'EAST'
    WHEN PHONE_NUMBER LIKE '590%' THEN 'WEST'
    WHEN PHONE_NUMBER LIKE '603%' THEN 'SOUTH'
    WHEN PHONE_NUMBER LIKE '650%' THEN 'NORTH'
    END AS REGION
  FROM EMPLOYEES;
  
SELECT EMPLOYEE_ID
     , PHONE_NUMBER
     , CASE
            WHEN PHONE_NUMBER LIKE '011%' THEN 'MOBILE'
            WHEN PHONE_NUMBER LIKE '515%' THEN 'EAST'
            WHEN PHONE_NUMBER LIKE '590%' THEN 'WEST'
            WHEN PHONE_NUMBER LIKE '603%' THEN 'SOUTH'
            WHEN PHONE_NUMBER LIKE '650%' THEN 'NORTH'
        END AS REGION 
  FROM 
       EMPLOYEES;

-- 15. EMPLOYEES 테이블에서 근무 개월 수가 240개월 이상이면 '퇴직금정산대상', 아니면 빈 문자열('')을 조회하시오.
SELECT
      FIRST_NAME
    , LAST_NAME
    , CASE 
        WHEN MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240 THEN '퇴직금정산대상'
        WHEN MONTHS_BETWEEN(SYSDATE, HIRE_DATE) < 240 THEN ''
    END AS 근무개월수
  FROM 
    EMPLOYEES;
        
-- 16. EMPLOYEES 테이블에서 SALARY 평균이 10000 이상인 부서의 DEPARTMENT_ID와 SALARY 평균을 조회하시오. 평균은 정수로 내림처리하시오.
SELECT DEPARTMENT_ID, FLOOR(AVG(SALARY)) 
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID  -- 집계함수를 사용하면 그룹바이 사용한다.
HAVING AVG(SALARY) >= 10000;

-- 17. EMPLOYEES 테이블에서 DEPARTMENT_ID와 JOB_ID가 모두 같은 사원들을 그룹화하여 각 그룹의 사원수를 조회하시오. DEPARTMENT_ID가 NULL인 사원은 제외하시오.

-- 18. EMPLOYEES 테이블에서 전체 사원들의 부서내 연봉 순위를 조회하시오. 
SELECT
       EMPLOYEE_ID,DEPARTMENT_ID
     , FIRST_NAME || ' ' || LAST_NAME AS NAME
     , SALARY
     , RANK() OVER (ORDER BY SALARY DESC) AS 연봉순위 
   FROM 
        EMPLOYEES;
-- 19. DEPARTMENTS 테이블에서 LOCATION_ID로 그룹화하여 각 그룹의 사원수를 조회하시오. MANAGER_ID가 없는 지역은 제외하시오.

-- 20. DEPARTMENTS 테이블에서 DEPARTMENT_NAME의 첫 2글자로 그룹화하여 각 그룹의 사원수를 조회하시오. 'IT'와 'Co'인 부서만 조회하시오.