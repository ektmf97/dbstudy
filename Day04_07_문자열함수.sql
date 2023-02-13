-- 문자열 함수

-- 1. 대소문자 변환 함수
SELECT 
      UPPER(EMAIL)  -- 대문자
    , LOWER(EMAIL)  -- 소문자
    , INITCAP(EMAIL) -- 첫 글자는 대문자, 나머지는 소문자
  FROM 
       EMPLOYEES;
       
       
-- 2. 글자 수(바이트 수) 반환 함수
SELECT 
      LENGTH('HELLO') -- 글자 수 : 5
    , LENGTH('안녕') -- 글자 수 : 2
    , LENGTHB('HELLO') -- 바이트 수 : 5
    , LENGTHB('안녕') -- 바이트 수 : 6 
  FROM
      DUAL;
      

-- 3. 문자열 연결 함수/연산자
--    1) 함수 : CONCAT(A, B) 주의! 인수가 2개만 전달 가능하다. (CONCAT(A, B, C) 같은 형태는 불가능하다.)
--    2) 연산자 : || 주의! OR 연산 아닙니다! 오라클 전용입니다!
SELECT
      CONCAT(CONCAT(FIRST_NAME, ' ' ), LAST_NAME)
    , FIRST_NAME || ' ' || LAST_NAME -- || 이어 붙힌다. 
  FROM 
       EMPLOYEES;
       
       
-- 4. 문자열 일부 반환하기 
--    SUBSTR(칼럼, BEGIN, LENGTH)
--    주위! BEGIN은 1에서 시작한다.      
SELECT
       SUBSTR(EMAIL, 1, 3) -- 1번째 글자부터 3글자를 가져오시오.
  FROM
        EMPLOYEES;


-- 5. 특정 문자열의 위치 반환하기 
--    INSTR(칼럼, 찾을문자열)
--    주의! 반환되는 위치 정보는 인덱스가 아니므로 0부터 시작하지 않고, 1부터 시작한다.
--    만약 못 찾으면 0을 반환한다. 
SELECT
       INSTR(EMAIL, 'A')  -- 'A'의 위치를 반환
  FROM
       EMPLOYEES;
       
       
-- 6. 문자열 채우기(PADDING)
--    오른쪽 , 왼쪽 채우기 두가지 종류
--    1) LPAD(칼럼, 전체폭, 채워줄 문자지정) 왼쪽
--    2) RPAD(칼럼, 전체폭, 채워줄 문자) 오른쪽 
SELECT
       LPAD (NVL(DEPARTMENT_ID, 0), 3, '0') -- NULL이 나오면 0을 사용하겠다 NULL을 000으로 바꿈
     , RPAD(SUBSTR(EMAIL, 1, 2), 5, '*') -- 전체는 다섯글자 숫자 두글자 뒤에 22*** 표시하기
  FROM 
       EMPLOYEES;


-- 7. 불필요한 공백 제거
--    1) LTRIM(칼럼) : 왼쪽 공백 제거
--    2) RTRIM(칼럼) : 오른쪽 공백 제거 
--    3) TRIM(칼럼)  : 양쪽 다 제거
SELECT
       '[' || LTRIM('     HELLO') || ']'
     , '[' || RTRIM('HELLO     ') || ']'
     , '[' || TRIM('   HELLO   ') || ']'
  FROM
       DUAL; -- 아무 테이블 참고 안 할때 사용함 
       
