
--���� ) emp ���̺��� comm �� null �� ��� ��� ������ ����ϴ� ���� �ϼ���
SELECT *
FROM emp
WHERE comm IS NULL;
-------------------------------------------------
--1. �������
--  ��. Data        ����
--  ��. DataBase  ������ ����
--  ��. DBMS      �����ͺ��̽� ���� �ý���, ����Ʈ����   ����Ŭ
             DBMS �߿� �ϳ� ����Ŭ, MySQL, MS SQL
--  ��. DBA         �����ͺ��̽� ������    (SYS),  SYSTEM,
                                      ��������,,
                                      SCOTT -> scott.sql �˻�-> emp, dept, salgrade, bonus ���̺� ����
                                    GRANT ���� to user
--  ��. ��(ROLE)   ?
        ���� �ο�, ����..
          [������ ��]
            REVOKE ���̸�
	        FROM ����ڸ� �Ǵ� ���̸� �Ǵ� PUBLIC;
            
            �ټ� ����� <= �ο�, ����.... => �پ��� ����privilege  ȿ���� ����(���� �ο�, ����)
            ���Ի������(role)�� ���� 50�� �ο�
            CREATE USER  ������ 
            ALTER USER ������ IDENTIFIED BY NEW��й�ȣ 
                                         ACCOUNT UNLOCK;
             DROP USER CASCADE;
            
            
            CREATE TABLE ���̺��
            DROP TABLE
            
            CREATE ROLE  �Ѹ�
            DROP ROLE
            a���� ���Ի�������� �ο��ϸ� ���� 50�� �ο���.
            GRANT 
            
           1. �� ���� �� 2. �ѿ� ���� �ο� �� 3. ����ڿ��� �� �ο�

   select * 
   from role_sys_privs
   where role='RESOURCE';
 
-- �� �ȿ� �ִ� ���ѵ��� Ȯ���� ��,
CREATE SEQUENCE
CREATE TRIGGER
CREATE CLUSTER
CREATE PROCEDURE
CREATE TYPE
CREATE OPERATOR
CREATE TABLE
CREATE INDEXTYPE

   ���� 1) SCOTT ������ �����ϰ� �ִ� ���� Ȯ���ϰ�
       2) CREATE �� ����
       3) CREATE �� �ο�

   
   1)
   SELECT * 
   FROM user_role_privs;   -- ����ڿ��� �ο��� �ý��� ����?
   
SCOTT	CONNECT	NO	YES	NO
SCOTT	RESOURCE	NO	YES	NO

   FROM role _sys_privs;   --�ѿ� �ο��� �ý��� ����?
   2)
   REVOKE CONNECT FROM scott;
   3)
   GRANT CONNECT TO scott;
 -- 2,3�� sys ���� �����ؾ��Ѵ�.  
 -- + admin �ɼ��� ����, ������ �� �ִ� ����
            
--  ��. SID( ���� �����ͺ��̽� �̸� ) XE => ��Ʈ��ũ�� ���� ����ڰ� ����Ŭ �������� ������ ����ϴ� �������α׷�
--       ��ġ�� ����Ŭ DB�� ������ �̸�
--       ����Ŭ ���� ������ ��ġ�ϸ� �ڵ����� SID => XE
                    
--  ��. ������ ��  
--         ��ǻ�Ϳ� �����͸� �����ϴ� ����� �����س��� ���� ��
--         ������ ������ ��
--  ��. ��Ű��(Schema)     -> ��������� �� ������ ����� �� �ִ� ��ü���� ��������� ��, �װ��� ��Ű���� �Ѵ�.
         ��. DB���� � ������ ���Ͽ� �ʿ��� ���� ���� ������ ���̺���� ������
         ��. DATABASE SCHEMA (db ��Ű��)
             - scott ���� ���� -> ��� object �������� -> ��Ű��
             - Ư�� user�� ���õ� object�� ���
               - emp ���̺� ����
                 FROM ��Ű��.���̺�
                 FROM scott.emp;
                 
        ��. �������
           �ν��Ͻ�instance : ����Ŭ ���� -> ���� startup -> ���� shutdown
           ���� session  : ����� �α��� -> �α׾ƿ�
           ��Ű�� schema : Ư�� user�� ���õ� object�� ���
--  ��. R+DBMS          ������ �����ͺ��̽�

--2. ��ġ�� [����Ŭ�� ����]�ϴ� ������ [�˻�]�ؼ� ���� ��������.  ***
  ��. �۾������� - ���� �ǿ��� Oracle �پ����ִ� ���� �� �� �������ΰ��� ��� ��Ŭ�� - ����    
  ��. uninstall.exe  / ���α׷� �߰� �� ���� -> ����
  ��. Ž���� - ����Ŭ ���� (oraclxe) ����
  ��. ������Ʈ�������� regedit.exe -> ����Ŭ ���� ������Ʈ�� ����

--3. SYS �������� �����Ͽ� ��� ����� ������ ��ȸ�ϴ� ����(SQL)�� �ۼ��ϼ���.
SELECT *
FROM dba_tables; --SCOTT�� ��� �Ұ�, SYS ������ ����
FROM all_tables ; -- SCOTT ������ �����ϰ� �ִ� ���̺� + ������ �ο��޾Ƽ� ����� �� �ִ� ���̺� ����

FROM user_tables; -- SCOTT ������ �����ϰ� �ִ� ���̺� ���� VIEW
FROM all_users; 
FROM dba_users;  
FROM user_users;


--4. SCOTT ���� + ���� ��ü(���̺�)  �� �����ϴ�  ����(SQL)�� �ۼ��ϼ���.  
    ��. ���� ����             CREATE USER scott IDENTIFIED ��й�ȣ;
    ��. ���� ����              ALTER USER scott IDENTIFIED BY ��й�ȣ;
    ��. ���� ����            DROP USER scott CASCADE;

--5. ���� 4���� ���ؼ�
--    SCOTT ������ �����Ǿ����� SCOTT ������ tiger ��й�ȣ�� �����ϴ� ����(SQL)�� �ۼ��ϼ���. 
         CREATE USER scott IDENTIFIED tiger; 

--6. ����Ŭ�� �����ϴ� �⺻���� ��(role)�� ������ �����ð�,
     
--6-2.   SCOTT �������� ������ �ο��ϴ� ����(SQL)�� �ۼ��ϼ���. 
  GRANT CONNECT, RESOURCE, UNILMITED TABLESPACE TO scott ;

--7-1. SCOTT ��������  scott.sql ������ ã�Ƽ� emp, dept, bonus, salgrade ���̺��� ���� �� ������ �߰��� ������ �ۼ��ϼ���.
CREATE TABLE DEPT
       (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	DNAME VARCHAR2(14) ,
	LOC VARCHAR2(13) ) ;
DROP TABLE EMP;
CREATE TABLE EMP
       (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);
INSERT INTO DEPT VALUES
	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES
	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES
	(40,'OPERATIONS','BOSTON');
INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87')-85,3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-JUL-87')-51,1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
DROP TABLE BONUS;
CREATE TABLE BONUS
	(
	ENAME VARCHAR2(10)	,
	JOB VARCHAR2(9)  ,
	SAL NUMBER,
	COMM NUMBER
	) ;
DROP TABLE SALGRADE;
CREATE TABLE SALGRADE
      ( GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER );
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;

--7-2. �� ���̺� � ������ �����ϴ��� �÷��� ���� ����( �÷���, �ڷ��� )�� �����ϼ���.
--  ��. emp      EMPNO, ���ڿ�/ JOB,���ڿ� / MGR,������/HIREDATE ,��¥/SAL,������/COMM,������/DEPTNO, ������
--  ��. dept      �μ���ȣ,2�ڸ������ڷ��� / �μ���,14����Ʈũ�� ���ڿ� �ڷ���/ ������, 13����Ʈ ���ڿ��ڷ���
--  ��. bonus     ENAME, 10����Ʈ ���ڿ� �ڷ���/ JOB, 9����Ʈ���ڿ��ڷ���/SAL ������/COMM ������ 
--  ��. salgrade   ���,������/ LOSAL, ������/ HISAL, ������

DESC emp;

--8. SCOTT ������ �����ϰ� �մ� ��� ���̺��� ��ȸ�ϴ� ����(SQL)�� �ۼ��ϼ���.
SELECT *
FROM user_users;



--9. SQL*Plus �� ����Ͽ� SYS�� �����Ͽ� ������ ����� Ȯ���ϰ�, ��� ����� ������ ��ȸ�ϰ�
--   �����ϴ� ��ɹ��� �ۼ��ϼ���.  
-- ��� �α��� �ϴ��� ��
 --   sqlplus /?


--10. ������ ������ ���� �ٽ� ���� ���
   ��.  ��ü (���̺�)
   ��.  �Ӽ� (�÷�)
   ��.  ���� 

--11. Oracle SQL Developer ���� ����(SQL)�� �����ϴ� ����� ��� ��������.
 /*
   ��.  Ŀ���� �ΰ� ctrl + enter
   ��.  �����ϰ��� �ϴ� �ڵ� �巡�� �� �� ctrl + enter
   ��. ����� f5
*/
--12. ����Ŭ �ּ�ó�� ���  3������ ��������.
  /*
    ��. --
    ��. rem
*/
--13. �ڷ� ����( Data [Dictionary] ) �̶�? 
  ��Ÿ������(META DATA) == DATA Dictionary �� ����
   ��. Data Dictionary = ���̺� + ��view �� ����
   ��. �����ͺ��̽��� ������ �����ϴ� ���� 
      ex. scott �����ϰ� �ִ� ���̺� ����
       FROM user_users; //Data Dictionary ��
    ��. DB ������ sys ���� ���� -> SYS ��Ű�� ���� ���ο� �ڷ� ���� ����
    
    
    FROM user_tables; // �ڷ���� = �� ����
      dba_
      all_
      user_
      v$   DB�� ���ɺм�/ ��� ���� �����ϴ� ��
--14. SQL �̶� ?

     ���� <-> Ŭ���̾�Ʈ   
        ��� ��� -> ����ȭ �� ���� ���

--15. SQL�� ������ ���� ���� ��������.
    ��.  ������ �˻� DQL  ->   SELECT
    ��.  ������ ���� DDL -> CREATE, ALTER, DROP
    ��.  ������ ���� DML -> INSERT, UPDATE, DELETE  + �ݵ�� commit, rollback
    ��.  ���Ѻο�, ���� DCL -> GRANT, REVOKE
    ��.  Ʈ������ ó�� TCL -> COMMIT, ROLLBACK, SAVEPOINT

--16. select ���� 7 ���� ���� ó�� ������ ���ؼ� ��������.

WITH         1
SELECT    6   
FROM  2
WHERE   3
GROUP BY  4
HAVING    5
ORDER BY  7

--17. emp ���̺��� ���̺� ����(�÷�����)�� Ȯ���ϴ�  ������ �ۼ��ϼ���.

DESC emp;
   
--18. employees ���̺���  �Ʒ��� ���� ��µǵ��� ���� �ۼ��ϼ���. 

SELECT FIRST_NAME, LAST_NAME, concat(FIRST_NAME, LAST_NAME) AS NAME
FROM employees;
   
FIRST_NAME          LAST_NAME                   NAME                                           
-------------------- ------------------------- ---------------------------------------------- 
Samuel               McCain                    Samuel McCain                                  
Allan                McEwen                    Allan McEwen                                   
Irene                Mikkilineni               Irene Mikkilineni                              
Kevin                Mourgos                   Kevin Mourgos                                  
Julia                Nayer                     Julia Nayer     

--19. �Ʒ� ��(View)�� ���� ������ ��������.
--  ��. dba_tables                
--  ��. all_tables                
--  ��. user_tables  == tabs     

--20. HR ������ ���� �ñ�� [��ݻ���]�� Ȯ���ϴ� ������ �ۼ��ϼ���.

SELECT username, account_status 
FROM dba_users    -- SYS ���� ���
WHERE username = 'HR' ;   -> �˻��� �� ��ҹ��� ������
FROM all_users;  -- HR 43   14/05/29
 
--21. emp ���̺��� ��,  �����ȣ, �̸�, �Ի����ڸ� ��ȸ�ϴ� ������ �ۼ��ϼ���.

SELECT job, empno, ename, hiredate
FROM emp;

--22.  emp ���̺���  �Ʒ��� ���� ��ȸ ����� �������� ������ �ۼ��ϼ���.
    (  sal + comm = pay  )
SELECT EMPNO, ENAME, SAL,
            -- NVL( COMM,0), sal+nvl(comm,0) pay
            NVL(COMM,COMM,0) COMM, SAL+NVL2(COMM , COMM, 0)PAY
            --CONCAT(SAL, COMM) AS PAY
FROM emp
WHERE ENAME = 'MILLER';
    
     EMPNO ENAME             SAL       COMM        PAY
---------- ---------- ---------- ---------- ----------
      7369 SMITH             800          0        800
      7499 ALLEN            1600        300       1900
      7521 WARD             1250        500       1750
      7566 JONES            2975          0       2975
      7654 MARTIN           1250       1400       2650
      7698 BLAKE            2850          0       2850
      7782 CLARK            2450          0       2450
      7839 KING             5000          0       5000
      7844 TURNER           1500          0       1500
      7900 JAMES             950          0        950
      7902 FORD             3000          0       3000

     EMPNO ENAME             SAL       COMM        PAY
---------- ---------- ---------- ---------- ----------
      7934 MILLER           1300          0       1300

	12�� ���� ���õǾ����ϴ�.  

--23.  emp���̺���
--    �� �μ����� �������� 1�� �����ϰ� �޿�(PAY)���� 2�� �������� �����ؼ� ��ȸ�ϴ� ������ �ۼ��ϼ���.   
SELECT deptno, ename, sal+ NVL(comm, 0) pay
FROM emp 
ORDER BY deptno ASC, pay DESC;
--ORDER BY deptno ASC, NVL(comm, 0)DESC;

--24. ������ �����ϴ� ���� ���Ŀ� ���� ��������.
     
--25. ������ ������ ��й�ȣ , ����� �����ϴ� ���� ���Ŀ� ���ؼ� ��������.
 
ALTER USER ������ INDICATED BY ��й�ȣ
                                ACCOUNT UNLOCK;
  
--26. DB�� �α����� �� �ִ� ������ �ο��ϴ� ���� ���Ŀ� ���ؼ� ��������.
    
--27. Ư����Ʈ( 1521 Port )�� ��ȭ�� �����ϴ� ����� ���ؼ� ���� ������ ��������.

--28. SQL*PLUS ���� ����ؼ� 
--   ��. SYS�� �α����ϴ� ���(����)�� ��������   
--   ��. SCOTT�� �α����ϴ� ���(����)�� ��������   

--29. SQL�� �ۼ���� 
   
--30. �Ʒ� ���� �޽����� �ǹ̸� ��������.
  ��. ORA-00942: table or view does not exist   --  >FROM ���̺� �� -- ��Ÿ, ���ٱ���X 
                                        
  ��. ORA-00904: "SCOTT": invalid identifier  -- �ĺ���  - ���� �̸�, ��Ÿ
  ��. ORA-00936: missing expression           --ǥ����(����) �߸��� ���
  ��. ORA-00933: SQL command not properly ended  --���� ���� ���� 
  
  SQL? ����ȭ �� ���� ���
  PL/SQL = SQL + ( ������ ���� Ȯ��)
    ������ ��� ����
    if
    for
    ���
    ����

   [sql �ۼ� ���]
   1. ��ҹ��ڸ� ����X
    select *
   from emp;
   
   Select *
   From emp;
   
   SELECT *
   FROM EMP;
   
   WHERE username = 'hr';
   WHERE username = 'HR';
   
   2) sqlplus
   SQL> select
      2  *
      3  from
      4  emp
      5  ;
  
   3)  
   SELECT     empno,    ename  ,    deptno 
   FROM emp;
   
   4) �� ���� ���� ����
   5) Ű���� �빮��, �׿� ����( ���̺��, �÷��� ��� ) �ҹ��� - ����.
   6) ��, ���� ��� -  ����
   

-- 31. emp ���̺��� �μ���ȣ�� 10���̰�, ���� CLERK  �� ����� ������ ��ȸ�ϴ� ���� �ۼ�.

SELECT *
FROM emp
WHERE dep = 10 AND job='CLERK';

-- 31-2. emp ���̺��� ���� CLERK �̰�, �μ���ȣ�� 10���� �ƴ� ����� ������ ��ȸ�ϴ� ���� �ۼ�.

SELECT *
FROM emp
WHERE DEPTNO != 10 AND JOB='CLERK';


-- 32. ����Ŭ�� null�� �ǹ� �� null ó�� �Լ��� ���ؼ� �����ϼ��� .
      ��. null �ǹ�?    ���� ���ǵ��� ���� ��
       ��. null ó�� �Լ� 2���� ������ ������ ���� �����ϼ��� .
NVL2 (A,B,C) -> A �� NULL�̸� C��, NULL�� �ƴϸ� B�� ��ü�ȴ�.
NVL(  A, B) -> A�� NULL �̸� B�� ��ü�ȴ�


-- 33.  emp ���̺��� �μ���ȣ�� 30���̰�, Ŀ�̼��� null�� ����� ������ ��ȸ�ϴ� ���� �ۼ�.
  ( ��.  deptno, ename, sal, comm,  pay �÷� ���,  pay= sal+comm )
  ( ��. comm�� null �� ���� 0���� ��ü�ؼ� ó�� )
  ( ��. pay �� ���� ������ ���� )

SELECT deptno, ename, sal, comm,  sal + NVL(comm,0) pay
FROM emp
WHERE deptno = 30 AND comm is NULL ; 
ORDER BY pay DESC;

   [NOT] IN (list)
   [NOT] BETWEEN a AND b
   IS [NOT] NULL

 null
 1. ��Ȯ�ε� ��
 2. ''  0 �ٸ� ��
 3. null ���� Ȯ���Ҷ��� = �񱳿����� ������� �ʰ�
                    sql ������ �� is null, is not null ������ Ȯ���Ѵ�.

-- 34. insa ���̺��� ������ ����� ��� ������ ��� ��ȸ�ϴ� ���� �ۼ� ( �������� ���� )
  ��. OR ������ ����ؼ� Ǯ�� 
  
SELECT *
FROM insa
WHERE city = '����' OR city ='���' OR city ='��õ'
ORDER BY city ASC;

  ��. IN ( LIST ) SQL ������ ����ؼ� Ǯ�� 
SELECT *
FROM insa
WHERE city IN ( '����', '���', '��õ); 

  
-- 35. insa ���̺��� ������ ����� �ƴ� ��� ������ ��� ��ȸ�ϴ� ���� �ۼ� ( �������� ���� )
  ��. AND ������ ����ؼ� Ǯ��  
SELECT *
FROM insa
WHERE  city != '����' AND  city != '���'  AND city != '��õ';
  ��. NOT IN ( LIST ) SQL ������ ����ؼ� Ǯ��   
SELECT *
FROM insa
WHERE city NOT IN  ('����','��õ','���);

  ��. OR, NOT �� ������ ����ؼ� Ǯ��
SELECT *
FROM insa
WHERE NOT (city = '����' OR city ='���' OR city ='��õ');   
       
-- 36. ����Ŭ �� �����ڸ� ��������.
  ��. ����   :   =
  ��. �ٸ���  :   !=, ^=, <>
  
-- 37. emp ���̺��� pay(sal+comm)��  1000 �̻�~ 2000 ���� �޴� 30�μ����鸸 ��ȸ�ϴ� ���� �ۼ�
  ���� : ��.  pay �������� �������� ���� --ename�� �������� �������� �����ؼ� ���(��ȸ)
           ��. comm �� null�� 0���� ó�� ( nvl () )  
           
           sql ���� ����
SELECT deptno, ename, sal+nvl(comm,0) pay
FROM emp
--WHERE pay BETWEEN 1000 AND 2000 AND  deptno = 30 --pay �ν� ���ؼ� ����
WHERE sal+nvl(comm,0) BETWEEN 1000 AND 2000 AND  deptno = 30
ORDER BY pay ASC; 

ORA-00920: invalid relational operator
00920. 00000 -  "invalid relational operator"
*Cause:    
*Action:
453��, 23������ ���� �߻�

  ���2) 
SELECT deptno, ename, sal+nvl(comm,0) pay
FROM emp
WHERE deptno = 30;

30	ALLEN	1900
30	WARD	1750
30	MARTIN	2650
30	BLAKE	2850
30	TURNER	1500
30	JAMES	950

���� ������� ������ WITH �� ���
WHERE pay BETWEEN 1000 AND 2000;

-------------------------------
WITH temp AS ( --��������
SELECT deptno, ename, sal +NVL(comm,0) pay
FROM emp
WHERE deptno = 30
)
SELECT t.*
FROM temp t  --���̺��� ��Ī
WHERE t.pay BETWEEN 1000 AND 2000;
---------------
--����°���    --�ζ��κ� inline view
-- �ζ��κ� : from �� �ȿ� �ִ� ���������� �ζ��κ��� �Ѵ�.
SELECT T.*
FROM (  
    SELECT deptno, ename, sal +NVL(comm,0) pay
    FROM emp
    WHERE deptno = 30
) t 
WHERE T.pay BETWEEN 1000 AND 2000;

-- 38. emp ���̺��� 1981�⵵�� �Ի��� ����鸸 ��ȸ�ϴ� ���� �ۼ�.

SELECT hiredate, ename
FROM emp
WHERE hiredate LIKE '81%'; 

SELECT hiredate, ename
FROM emp
WHERE hiredate BETWEEN '1981-01-01' AND '1981-12-31';

--oracle :    Date   + ��¥�� ���� �տ��� ' Ȭ����ǥ ����
--java : ��¥�� date, calender, localdate, localtime, localdatetime
 
SELECT hiredate
          , substr(hiredate, 0,2) YY
          ,substr(hiredate, 1,2) YY_1
--    , substr(char, position, length)
--    , substr(char, position, [,length]) ���ڿ� ������ �ڸ��ڴ�.
FROM emp;

-- ����Ŭ ��¥���� �⵵�� ������ ���?
TO_CHAR(��¥��) �Լ��� ��¥�� ���ڰ��� ���� ���ϴ� ��(�⵵, ��, ��, ����) �� 
                                        ���ڿ��� ��ȯ�ϴ� �Լ�
  [ RR �� YY ������ ����] TO_CHAR(datetime) �Լ�

SELECT hiredate, ename
--          ,TO_CHAR(hiredate, 'RR')
--          ,TO_CHAR(hiredate, 'YY')
           --�� �Լ��� ������ -����Ÿ�� TO_CHAR '1981'  EXTRACT : ���� 1981
          ,TO_CHAR(hiredate, 'YYYY')
          ,EXTRACT(YEAR FROM hiredate ) "YEAR"
--          ,TO_CHAR(hiredate, 'RRRR')
--          ,TO_CHAR(hiredate, 'YEAR')
--          ,TO_CHAR(hiredate, 'SYYYY')
FROM emp;

����) insa ���̺��� �ֹε�Ϲ�ȣ�κ��� 
     ���ڸ� 6�ڸ� ���,
     ���ڸ� 7�ڸ� ���,
     �⵵ 2�ڸ� ���
     �� 2�ڸ� ���
     �� 2�ڸ� ���
     �ֹι�ȣ ������ ���� 1�ڸ� ���
DESC insa;
   --�ֹι�ȣ ���ڸ� *�� ǥ��

SELECT name
        , substr(ssn, 0,8) || '*******' rrn
        , concat(substr(ssn, 0,8), '*******') RRN
--       ,substr(SSN, 1,6) RRN6
--       ,substr(SSN, 8)  RRN7
--       ,substr(SSN, 0,2) YY
--       ,substr(SSN, 3,2) MM
--       ,substr(SSN, 4,2) DD
--       ,substr(SSN, 14)  RRN14
--       ,substr(SSN, -1,1) RRN14   -- -������ �ڿ������� �о��.
FROM insa;

-- 39. emp ���̺��� ���ӻ��(mgr)�� ����  ����� ������ ��ȸ
SELECT empno, ename, mgr
FROM emp
WHERE MGR is null;


-- 40. emp���̺��� �� �μ����� �������� 1�� �����ϰ� �޿�(PAY)���� 2�� �������� �����ؼ� ��ȸ�ϴ� ���� �ۼ�

SELECT *
FROM emp
ORDER BY ename ASC, PAY DESC;

--41. Alias ��Ī�� �ۼ��ϴ� 3���� ����� ��������.
   SELECT deptno, ename 
     , sal + comm   (��)  AS "��Ī"
     , sal + comm   (��)  AS ��Ī
     , sal + comm   (��)  ��Ī
    FROM emp;

--42. ����Ŭ�� �� �����ڸ� ��������.
  ��.   AND
  ��.    OR
  ��.   NOT

-- 43. ���� ��� ����Ŭ�� SQL �����ڸ� ��������.
  ��.   (NOT) IN ()
  ��.  (NOT) BETWEEN A AND B (A,B�� ����, �׻� A<B)
  ��. IS NULL, IS NOT NULL
  
  ��. ANY, SOME, ALL  SQL �����ڴ� WHERE �������� ���������� ����� �� ���̴� ������
  
  WITH temp AS
(
  ��������
 )
  
  INLINE VIEW(�ζ��κ�)
  FROM(
  ��������
  )
  WHERE      SOME , ANY, ALL(��������)
  
  ===========================
  
  --LIKE SQL������ ����
  ����) INSA ���̺��� ���� �达�� ����� ���� ��ȸ
  
--  java - name.startwith("��"),endwith()

SELECT name
     --,SUBSTR(name,1,1)
     ,ibsadate
FROM insa
WHERE name LIKE '_��%';
WHERE name LIKE '_��_';
WHERE name LIKE '%��%'; --�̸� �ӿ� �� �� ���ڸ� �����ϰ� �ֳ�?
WHERE name LIKE '��_'; --�� ������ ù ���ڰ� ��
WHERE name LIKE  '��%' ; --�ȿ͵� ���� �ƹ��ų��͵� �� 
--WHERE SUBSTR(name,1,1) = '��';

like ������ ��ȣ : ���ϵ�ī�� ( %, _)

-- REGEXP_LIKE �Լ� : ����ǥ������ ����ϴ� LIKE �Լ�

==============
���� ) �达�� ���
SELECT name, ssn
FROM insa
WHERE REGEXP_LIKE (name, '^��' );    -^ : �� ����,  $ :�� ��
where REGEXP_LIKE(name,'��$';

���� ) �达 �Ǵ� �̾� ��� ���
1) like
SELECT name, ssn
FROM insa
WHERE name LIKE '��%' OR name LIKE '��%';

2)regexp_like
SELECT name, ssn
FROM insa
--WHERE REGEXP_LIKE( name ,'^[����]');
WHERE REGEXP_LIKE( name ,'^(��|��)');

����) emp ���̺��� �̸�ename�ӿ� la ���ڿ� �����ϴ� ���
1) like
SELECT ename
FROM emp
--WHERE ename LIKE '%LA%'; --�ҹ��ڷ� �ϸ� �˻� �ȵ�
--JAVA ���ڿ��� �빮�ڷ� ��ȯ�ϴ� �޼��� TOUPPERCASE
--ORACLE                           UPPER()
WHERE ename LIKE '%' || UPPER('la') || '%';

2) regexp_like
SELECT ename
FROM emp
--WHERE REGEXP_LIKE (ename, '����ǥ����');
--WHERE REGEXP_LIKE (ename, 'LA');
--WHERE REGEXP_LIKE (ename, UPPER('la'));
WHERE REGEXP_LIKE (ename, 'la', i);   --i ������ ��ҹ��� ���о���
--WHERE REGEXP_LIKE (ename, '[a-zA-Z]*LA[a-zA-Z]*');

����) Ste�� �����ϰ� v�� ph�� en���� ������ ��� -> '^Ste(v|ph)en$'


����) �λ����̺��� ���� ��, �̾� �� ������ ��� �������
1) like
SELECT name, ssn

FROM insa
--[1]WHERE NOT( name LIKE '��%' OR name LIKE '��%');
WHERE name NOT LIKE '��%' AND name NOT LIKE '��%');
2)REGEXP_LIKE()
SELECT name, ssn
FROM insa
WHERE REGEXP_LIKE (name, '^[^����]');
--WHERE NOT REGEXP_LIKE (name, '^[����]');
--WHERE NOT REGEXP_LIKE (name, '^[��|��]');