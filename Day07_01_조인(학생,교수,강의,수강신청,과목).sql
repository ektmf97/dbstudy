-- 학생 이름, 담당 교수 이름 조회하기 
-- 1) 표준 문법 내부조인
SELECT S.S_NAME, P.P_NAME
  FROM PROFESSOR_TBL P INNER JOIN STUDENT_TBL S -- 별명
    ON P.P_NO = S.P_NO; -- PK, FK 

-- 2) 오라클 문법
SELECT S.S_NAME, P.P_NAME
  FROM PROFESSOR_TBL P, STUDENT_TBL S
 WHERE P.P_NO = S.P_NO;
 
 
-- 교수번호, 교수이름, 교수전공, 강좌이름, 강의실을 조회하시오.
SELECT P.P_NO, P.P_NAME, P.P_MAJOR, L.L_NAME, l.L_LOCATION
  FROM PROFESSOR_TBL P INNER JOIN LECTURE_TBL L
    ON P.P_NO = L.P_NO;
    

-- 학번, 학생이름, 수강 신청한 과목 이름
-- 1) 표준 문법
SELECT  S.S_NO,S.S_NAME, C.C_NAME
  FROM STUDENT_TBL S INNER JOIN ENROLL_TBL E
    ON S.S_NO = E.S_NO INNER JOIN COURSE_TBL C
    ON E.C_NO = C.C_NO; 
  
-- 2) 오라클 문법  
SELECT  S.S_NO,S.S_NAME, C.C_NAME
  FROM STUDENT_TBL S , ENROLL_TBL E ,COURSE_TBL C
 WHERE S.S_NO = E.S_NO 
   AND E.C_NO = C.C_NO; 
   
-- 모든 교수들의 교수이름, 교수전공, 강의이름을 조회하시오.
-- 1) 표준 문법
SELECT P.P_NAME, P.P_MAJOR, L.L_NAME
  FROM PROFESSOR_TBL P LEFT OUTER JOIN LECTURE_TBL L
    ON P.P_NO = L.P_NO;
    
-- 2) 오라클 문법 
SELECT P.P_NAME, P.P_MAJOR, L.L_NAME
  FROM PROFESSOR_TBL P , LECTURE_TBL L
 WHERE P.P_NO = L.P_NO(+);
    
/*
    교수는 1,2,3가 있는데 강좌는 1번 교수가 다 맡아서 이너조인을 하면 1번 교수가 맡은 강좌만 출력 나머지 교수님들은 조회 안함 
    모든교수를 입력 하려면 교수가 왼쪽에 있으니까 래프트 조인 씀 
*/
