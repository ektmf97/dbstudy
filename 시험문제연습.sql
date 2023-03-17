-- 사원번호를 전달하면 해당 사원의 이름을 반환하는 함수 만들기
-- 1001번 이라고 등록하면 구창민이 나와야함

-- 함수 만들기 GET_NAME(사원번호를 받을 수 있는 매개변수 선언/ 테이블에 원래 있는 칼럼이름을 쓰면 안된다 충돌)
-- 만드는거 (8점)
CREATE OR REPLACE FUNCTION GET_NAME(EMPNO EMPLOYEE_TBL.EMP_NO%TYPE) --  EMPLOYEE_TBL.EMP_NO%TYPE(참조타입)
RETURN VARCHAR2 -- RETURN타입을 사용할 때는 사이즈를 안 적어도 된다.
IS
    EMPNAME EMPLOYEE_TBL.NAME%TYPE; 
BEGIN
    SELECT NAME
      INTO EMPNAME -- NAME칼럼값을 EMPNAME에 저장하기 위해서 사용
      FROM EMPLOYEE_TBL
     WHERE EMP_NO = EMPNO; -- EMPNAME이라고 적으면 4명이 다 나오니깐 1001이=EMPNO로 전달되서 EMPNO;<- 1001
    RETURN EMPNAME;
END;
-- 사원명
-- 구창민

-- 실행 (2점)
-- 한명만 보기
SELECT GET_NAME(1001) AS 사원명 -- 전체 사원이 보고싶으면 EMP_NO로 바꾼다.
  FROM EMPLOYEE_TBL
 WHERE EMP_NO = 1001; -- WHERE절을 안하면 4개행에 구창민이 나옴 
-- 한명만 보기
SELECT DISTINCT GET_NAME(1001) AS 사원명 
  FROM EMPLOYEE_TBL;
-- 실행이 갑자기 안되면 컴파일 다시하기
-- 여러명 보기
SELECT GET_NAME(1001) AS 사원명 -- get변수 우리가 지정한 함수값 
  FROM EMPLOYEE_TBL;
  
-- 삽입/삭제/수정하면 메시지를 출력하는 트리거 만들기 (10점 , 오타나 틀리면 5점)

SET SERVEROUTPUT ON; -- 이걸 먼저 켜놓아야 실행 가능

CREATE OR REPLACE TRIGGER MY_TRIGGER -- 트리거 이름 정하기
    AFTER 
    INSERT OR DELETE OR UPDATE --삽입,수정,삭제 전부 동작하기 OR로 연결
    ON DEPARTMENT_TBL -- 어떤 테이블 대상인지
    FOR EACH ROW -- 행단위로 트리거가 실행하기 때문에
BEGIN
    DBMS_OUTPUT.PUT_LINE('하하하하');
END;

INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME, LOCATION) VALUES(5, '개발부', '서울');
    
-- 트리거의 종류는 두가지 애프터, 비포


-- 전달된 부서번호의 부서를 삭제하는 프로시저를 작성하시오.
-- 전달된 부서에 근무하는 모든 사원을 함께 삭제하시오.
CREATE OR REPLACE PROCEDURE DELETE_PROC(DEPTNO IN DEPARTMENT_TBL.DEPT_NO%TYPE) -- 프로시저 이름은 문제따라 다르다 문제보고 정하기 / 칼럼 다른거 적용X IN 입력 파라미터 사용자 함수 
IS -- 변수가 필요하면 IS 밑에 선언하고 사용하면 된다.
BEGIN
    DELETE
      FROM EMPLOYEE_TBL
     WHERE DEPART = DEPTNO;
    DELETE 
      FROM DEPARTMENT_TBL
     WHERE DEPT_NO = DEPTNO;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE); -- 예외코드
        DBMS_OUTPUT.PUT_LINE(SQLERRM); -- 예외메시지
        ROLLBACK;
END;

-- 키워드 실행
EXECUTE DELETE_PROC(1);-- 1인 부서를 지워라 
-- 외래키를 가진 사원을 먼저 지운다. 부서와 사원의 관게 부서 1 : 사원 M 여러개 있는 쪽을 먼저 지운다. 일대다는 다쪽을 먼저 지우고 생성할대는 일을 먼저 만들고 다를 만든다

