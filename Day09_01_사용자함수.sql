/*
    사용자 함수(FUNCTION)
    1. 어떤 값을 반환할 때 사용하는 데이터베이스 객체이다.
    2. 실제로 함수를 만들어서 사용하는 개념이다. 
    3. RETURN 개념이 존재한다.
    4. 함수의 결과 값을 확인할 수 있도록 SELECT문에서 많이 사용한다. (호출시)
    5. 형식
        CREATE [OR REPLACE] FUNCTION 함수명[(매개변수)]
        RETURN 반환타입 
        IS - AS도 가능
            변수 선언
        BEGIN 
            함수 본문
        [EXCEPTION
            예외처리]
        END;
*/


-- 사용자 함수 FUNC1 정의(만들기)
-- HELLO WORLD 반환
CREATE OR REPLACE FUNCTION FUNC1
RETURN VARCHAR2 -- 반환타입에서는 크기를 명시하지 않음 / 사이즈를 안 적어도 된다.
IS 
BEGIN
    RETURN 'Hello  World';
END;

-- 사용자 함수 FUNC1 호출하기
SELECT FUNC1() FROM DUAL; -- FUNC1에 테이블은 필요없어 () 아무것도 안 채워도 된다.


-- 사용자 함수 FUNC2 정의
-- 사원번호를 전달하면 해당 사원의 FIRST_NAME을 반환하는 함수

-- 사용자 함수의 파라미터는 IN/OUT 표기가 없다.
-- 입력 파라미터 형식으로 사용된다.

CREATE OR REPLACE FUNCTION FUNC2(EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURN VARCHAR2
IS
    FNAME EMPLOYEES.FIRST_NAME%TYPE;-- SELECT에서 받아온 변수를 출력할 변수가 필요함
BEGIN
    SELECT FIRST_NAME --  FIRST_NAME 조회해서
      INTO FNAME -- FNAME에 저장하시오
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID = EMP_ID;
     
    RETURN FNAME; -- 조회결과를 반환하시오.
END;


-- 사용자 함수 FUNC2 호출하기
SELECT FUNC2(100)
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID = 100;
 
 
-- 문제 1) 사원번호를 전달하면 해당 사원의 FULL_NAME(Steven King)을 반환하는 함수 
CREATE OR REPLACE FUNCTION FUNC2(EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURN VARCHAR2
IS
    FNAME EMPLOYEES.FIRST_NAME%TYPE;
    LNAME EMPLOYEES.LAST_NAME%TYPE;
BEGIN
    SELECT FIRST_NAME, LAST_NAME
      INTO FNAME, LNAME
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID = EMP_ID;
     
    RETURN FNAME || ' '  || LNAME;
END;

SELECT FUNC2(100)
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID = 100;
 
 
 
-- 문제 2) 사원번호를 전달하면 해당 사원의 연봉이 15000 이상이면 '고액연봉', 아니면 '보통연봉'을 반환하는 함수
-- 사용자 함수 FUNC3 정의
CREATE OR REPLACE FUNCTION FUNC3(EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURN VARCHAR2
IS
    SAL EMPLOYEES.SALARY%TYPE;
    MESSAGE VARCHAR2(12 BYTE);
BEGIN
    
    SELECT SALARY
      INTO SAL
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID = EMP_ID;
    
    IF SAL >= 15000 THEN
        MESSAGE := '고액연봉';
    ELSE
        MESSAGE := '보통연봉';
    END IF;
    
    RETURN MESSAGE;
    
END;

-- 사용자 함수 FUNC3 호출      
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, FUNC3(EMPLOYEE_ID) -- 모든 사원 나오게 
  FROM EMPLOYEES;


-- 함수 MY_CEIL 정의
CREATE OR REPLACE FUNCTION MY_CEIL(N NUMBER, DIGIT NUMBER)
RETURN NUMBER
IS
BEGIN
    RETURN  CEIL(N * POWER(10, DIGIT))  / POWER(10, DIGIT); -- N *10 의 제곱 / 곱하기- 올림처리- 나누기
END;

-- 함수 MY_CEIL 호출
SELECT 
        MY_CEIL(111.111, 2)  -- 소수2자리 올림
      , MY_CEIL(111.111, 1)  -- 소수1자리 올림
      , MY_CEIL(111.111, 0)  -- 정수로 올림
      , MY_CEIL(111.111, -1) -- 일의자리 올림
      , MY_CEIL(111.111, -2) -- 십의자리 올림
  FROM DUAL;


-- 함수 MY_FLOOR
CREATE OR REPLACE FUNCTION MY_FLOOR(N NUMBER, DIGIT NUMBER)
RETURN NUMBER
IS
BEGIN
    RETURN  FLOOR(N * POWER(10, DIGIT))  / POWER(10, DIGIT); 
END;    


-- 함수 MY_FLOOR 호출
SELECT 
        MY_FLOOR(111.111, 2)  -- 소수2자리 내림
      , MY_FLOOR(111.111, 1)  -- 소수1자리 내림
      , MY_FLOOR(111.111, 0)  -- 정수로 내림
      , MY_FLOOR(111.111, -1) -- 일의자리 내림
      , MY_FLOOR(111.111, -2) -- 십의자리 내림
  FROM DUAL;