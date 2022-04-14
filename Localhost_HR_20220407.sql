 -- HR 계정 접속 -- 

23. hr 계정으로 접속
    employees 테이블에서 first_name, last_name 이름 속에 'ev' 문자열 포함하는 사원 정보 출력
    
FIRST_NAME           LAST_NAME         NAME                NAME                                                                                                                                                                                    
-------------------- ------------- ------------- ----------------------
Kevin                Feeney          Kevin Feeney        K[ev]in Feeney                                                                                                                                                                          
Steven               King            Steven King         St[ev]en King                                                                                                                                                                           
Steven               Markle          Steven Markle       St[ev]en Markle                                                                                                                                                                         
Kevin                Mourgos         Kevin Mourgos       K[ev]in Mourgos                                                                                                                                                                         

SELECT T.* ,  REPLACE( t.name, 'ev' , '<span color=red>ev</span>')
FROM (
 SELECT first_name , last_name
           ,first_name || '' ||last_name name
 FROM employees
 ) t
 WHERE  t.name LIKE '%ev%';
 
-- 00942. 00000 -  "table or view does not exist"-- EMP가 SCOTT꺼라서
SELECT * 
FROM emp;   

SELECT *    --이것도 오류남
FROM scott.emp; 

SELECT*
FROM arirang;

--SQL 오류: ORA-01031: insufficient privileges
DELETE FROM arirang
WHERE empno = 7369;  

scott 계정이 생성한 emp테이블이 있다면
emp 테이블의 소유자는 scott 이다.

emp 사용하려면 emp테이블 사용할 수 있는 권한을 scott(소유자)에게 부여받고(sys도 가능)
사용할 때도 스키마.emp 라고 적어야 한다.