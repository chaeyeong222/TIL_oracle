-- 오라클 주석 처리
-- 모든 사용자 계정 조회(확인) 라는 쿼리(SQL) 이다.
SELECT *
FROM all_users;
-- 쿼리 실행하는 방법
-- 1) 실행하고자하는 쿼리 SQL 를 선택SELECT하고 F5키를 누른다.
-- 2) 실행하고자하는 쿼리 SQL 를 선택SELECT하고 Ctrl + ENTER
-- 3) 커서 두고, Ctrl + ENTER

-- SCOTT 계정 생성 SQL문
CREATE USER scott IDENTIFIED BY tiger;

GRANT RESOURCE, CONNECT TO scott;
