1. ����Ŭ �� DataType �� ���� ���� �����ϼ���
--����
��������
char  1����Ʈ
nchar  �ѹ��ڴ� 2����Ʈ  (�����ڵ�)
��������
varchar2
nvarchar2

LONG 2GB
--����
number(p,s) -> s �Ҽ��� �ڸ���, p ��ü �ڸ���
--��¥ Ÿ��
DATE 
TIMESTAMP

2.  emp ���̺��� [�⵵��] [����] �Ի����� ���.( PIVOT() �Լ� ��� )

    [������]
    1982	1	0	0	0	0	0	0	0	0	0	0	0
    1980	0	0	0	0	0	0	0	0	0	0	0	1
    1981	0	2	0	1	1	1	0	0	2	0	1	2
        
    
SELECT EXTRACT(MONTH FROM hiredate) hiredate_month FROM emp

SELECT *
FROM (SELECT EXTRACT(YEAR FROM hiredate) hiredate_year, EXTRACT(MONTH FROM hiredate) hiredate_month FROM emp)
PIVOT( COUNT(*)FOR hiredate_month IN(1,2,3,4,5,6,7,8,9,10,11,12));
  
    
    SELECT TO_CHAR( hiredate,'yyyy')�⵵��, TO_CHAR( hiredate,'MM') hire_month FROM emp ;
    
  
        SELECT *
    FROM ( SELECT TO_CHAR( hiredate,'yyyy')�⵵��, TO_CHAR( hiredate,'MM') hire_month FROM emp )
    PIVOT(  COUNT(hire_month) FOR hire_month IN (01,02,03,04,05,06,07,08,09,10,11,12) );
2-2.   emp ���̺��� �� JOB�� �Ի�⵵�� 1��~ 12�� �Ի��ο��� ���.  ( PIVOT() �Լ� ��� ) 
    [������]
    ANALYST		1981	0	0	0	0	0	0	0	0	0	0	0	1
    CLERK		1980	0	0	0	0	0	0	0	0	0	0	0	1
    CLERK		1981	0	0	0	0	0	0	0	0	0	0	0	1
    CLERK		1982	1	0	0	0	0	0	0	0	0	0	0	0
    MANAGER		1981	0	0	0	1	1	1	0	0	0	0	0	0
    PRESIDENT	1981	0	0	0	0	0	0	0	0	0	0	1	0
    SALESMAN	1981	0	2	0	0	0	0	0	0       
    
 SELECT *
FROM (SELECT job, EXTRACT(YEAR FROM hiredate) hiredate_year, EXTRACT(MONTH FROM hiredate) hiredate_month FROM emp)
PIVOT( COUNT(*)FOR hiredate_month IN(1,2,3,4,5,6,7,8,9,10,11,12));   
    
    
    SELECT *
    FROM ( SELECT JOB, TO_CHAR( hiredate,'yyyy')�⵵��, TO_CHAR( hiredate,'MM') hire_month FROM emp )
    PIVOT(  COUNT(hire_month) FOR hire_month IN (01,02,03,04,05,06,07,08,09,10,11,12) )
    ORDER BY job;
    
3. emp���̺��� �Ի����ڰ� ������ ������ 3�� ��� ( TOP 3 )
    [������]
    1	7369	SMITH	CLERK	    7902	80/12/17	800		    20
    2	7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
    3	7521	WARD	SALESMAN	7698	81/02/22	1250	500	30   
    

  [a.TOP-N : RoWNUM];
    SELECT *
    FROM (
    SELECT RoWNUM seq, emp.*
    FROM emp
    ORDER BY hiredate ASC
    ) WHERE seq<=3;
    
    [b.RANK()];
    SELECT *
    FROM (SELECT emp.*
           ,RANK() OVER (ORDER BY hiredate ASC) seq
    FROM emp
    )
    WHERE  seq<=3;
    
4. SMS ������ȣ  ������  6�ڸ� ���� ��� ( dbms_random  ��Ű�� ��� )

--LTRIM(), RTRIM() , TRIM()
SELECT SUBSTR ( LTRIM (LTRIM( dbms_random.value ,'0.') ,'0'),0,6) A
    ,TRUNC( dbms_random.value(100000,1000000)) B -- 100000<=  <999999
FROM dual;

4-2. ������ ��ҹ��� 5���� ���( dbms_random  ��Ű�� ��� )

SELECT dbms_random.string('A',5)
FROM dual;

5. �Խñ��� �����ϴ� ���̺� ����
   ��.   ���̺�� : tbl_test
   ��.   �÷�               �ڷ���  ũ��    ����뿩��    ����Ű
         �۹�ȣ    seq   NUMBER(3)     NOT NULL PRIMARY KEY     
         �ۼ���    writer   VARCHAR2     NOT NULL
         ��й�ȣ passwd      VARCHAR2    NOT NULL
         ������    title       VARCHAR2    NOT NULL
         �۳���    content  VARCHAR2
         �ۼ���    regdate   ����Ʈ - SYSDATE
    ��.  �۹�ȣ, �ۼ���, ��й�ȣ, �� ������ �ʼ� �Է� �������� ����
    ��.  �۹�ȣ��  �⺻Ű( PK )�� ����
    ��.  �ۼ����� ���� �ý����� ��¥�� �ڵ� ����
    
    
    CREATE TABLE tbl_test (
                    seq       NUMBER      NOT NULL   CONSTRAINTS  PK_tbltest_seq  PRIMARY KEY  
                   ,writer  VARCHAR2(20)  NOT NULL
                   ,passwd  VARCHAR2(20)  NOT NULL
                   ,title VARCHAR2(100)   NOT NULL
                   ,content  LONG  
                   ,regdate   DATE   DEFAULT SYSDATE
    );
    --Table TBL_TEST��(��) �����Ǿ����ϴ�.
  
5-2. ��ȸ��    read   �÷��� �߰� ( �⺻�� 0 ����  ���� ) 

ALTER TABLE tbl_test
    ADD read number DEFAULT 0;
    --Table TBL_TEST��(��) ����Ǿ����ϴ�.
  --�÷� �� ���� �߰��� ���� () ���� ����  
  
  DESC tbl_test;
5-3. �۳���    content �÷��� �ڷ����� clob �� ���� (LONG -> CLOB)

ALTER TABLE tbl_test
  MODIFY (content clob);
--Table TBL_TEST��(��) ����Ǿ����ϴ�.
5-4. ���̺� ���� Ȯ��

DESC tbl_test;

5-5. ������     title ��   subject�� ���� 

SELECT title subject FROM tbl_test; --��Ī���� ��밡��

ALTER TABLE tbl_test
   RENAME COLUMN title TO subject; 
   
--Table TBL_TEST��(��) ����Ǿ����ϴ�.
5-6.  tbl_test  -> tbl_board ���̺�� ���� 

RENAME tbl_test TO tbl_board;

DESC tbl_board;
--���̺� �̸��� ����Ǿ����ϴ�.

�̸�      ��?       ����            
------- -------- ------------- 
SEQ     NOT NULL NUMBER        
WRITER  NOT NULL VARCHAR2(20)  
PASSWD  NOT NULL VARCHAR2(20)  
SUBJECT NOT NULL VARCHAR2(100) 
CONTENT          CLOB          
REGDATE          DATE          
READ             NUMBER    


5-7. CRUD  ( insert, select, update, delete ) 
   ��. ������ �Խñ� 5���� �߰� insert 
   INSERT INTO tbl_board ( seq,writer, passwd, subject, content, regdate, read)
        VALUES ( 1,'admin','1234','test1', 'test -1',SYSDATE,0);
   --1 �� ��(��) ���ԵǾ����ϴ�.
    INSERT INTO tbl_board ( seq,writer, passwd, subject, content)
        VALUES ( 2,'hong','1234','hong1', 'hong -1');
   --����Ʈ�ɼ� �����ϱ� regdate, read ��������
   
   --�۳��� content �ʼ��Է� x
    INSERT INTO tbl_board ( seq,writer, passwd, subject)
        VALUES ( 3,'kenik','1234','kenik 1');
   
   COMMIT;
   ��. �Խñ� ��ȸ select
   SELECT *
   FROM tbl_board; 
   
   ��. 3�� �Խñ��� �� ����, ���� ���� update
     (�Խñ� ����, ���� �Ҷ��� �˻��� ��!)
   SELECT seq, subject, content
   FROM tbl_board
   WHERE seq=3;
   
   UPDATE tbl_board
   SET subject = '[e]' || subject, content='[e]'||NVL(content,'���� ��')
   WHERE seq=3;
   
   COMMIT;
   
   ��. 4�� �Խñ� ���� delete
   
   DELETE FROM tbl_board
   WHERE seq=4;
   --0�� �� ��(��) �����Ǿ����ϴ�. 4������ �����ϱ�..
   
5-8. tbl_board ���̺� ����  
                         
DROP TABLE tbl_board PURGE;  --���� ����( ������ ��ġ�� �ʰ�)
--Table TBL_BOARD��(��) �����Ǿ����ϴ�.

6-1. ������ ��¥�� ���� ��� 
 [������]
���ó�¥  ���ڿ���  ���ڸ�����       ����
-------- ---        ------   ------------
22/04/15  6             ��      �ݿ���      

SELECT SYSDATE
      ,TO_CHAR(SYSDATE,'D') ���ڿ���
      ,TO_CHAR(SYSDATE,'DY') ���ڸ�����
      ,TO_CHAR(SYSDATE,'DAY') ����
FROM dual;

6-2. �̹� ���� ������ ���� ��¥�� ��� 
 [������]
���ó�¥  �̹��޸�������¥                  ��������¥(��)
-------- -------- -- ---------------------------------
22/04/15 22/04/30 30                                30

SELECT SYSDATE ���ó�¥
      ,LAST_DAY(SYSDATE)  �̹��޸�������¥  
      ,TO_CHAR(LAST_DAY(SYSDATE) , 'DD')  
FROM dual;

6-3.
 [������]
���ó�¥    �������� �������� ���� ����
--------    -       --      --
22/04/15    3       15      15


SELECT SYSDATE ���ó�¥
      ,TO_CHAR(SYSDATE,'W') 
      ,TO_CHAR(SYSDATE,'IW') --�������� ���� �������� ����
      ,TO_CHAR(SYSDATE,'WW') --�ų� 1���� ���� �������� ����
FROM dual;
[�� ����]
IW: ������-�Ͽ��� ( ������ ����) 
WW: 1�� -7��( ���� ����)  2022.1.1~ 2022.1.7
    1/2/3/      4
IW     13      14
WW     13   (2~)  14

SELECT TO_CHAR( TO_DATE('2022.4.4'),'IW')
      ,TO_CHAR( TO_DATE('2022.4.4'),'WW')
FROM dual;
-------------------------------------------
[���̺� �����ϴ� ���]
? ���̺��� ����� ���� �ܼ��ϸ鼭�� �Ϲ����� ��� �������� ����� ���
? Extend table ����

�����ġ�
CREATE TABLE table
( �÷�1  	������Ÿ��,
  �÷�2  	������Ÿ��,...)
STORAGE    (INITIAL  	ũ��
	    NEXT	ũ��
	    MINEXTENTS	ũ��
	    MAXEXTENTS	ũ��
	    PCTINCREASE	n);
   ĳ�� ���̺��� ����ϰ� ���Ǵ� ���̺� �����͸� �����͹��� ĳ�ÿ����� ���ֽ��� 
   �˻��� ������ ����Ŵ.

? Subquery�� �̿��� table ����

? External table ����
 -DB �ܺο� ����� data source�� �����ϱ� ���� ���� ����� �ϳ��� �б� ���� ���̺�
 
? NESTED TABLE ����
 - ���̺� ���� ��� �÷��� �� �ٸ� ���̺� ������ ������.
? Partitioned Tables & Indexes ����
-------------------------------------------
--[ Subquery�� �̿��� table ����]
1. �̹� �����ϴ� ���̺� �ְ� 
2. select - subquery�� �̿��Ͽ� 
3. ���ο� ���̺��� ���� + ������ �Է�insert
4. �����ġ�
	CREATE TABLE ���̺�� [�÷��� (,�÷���),...]
	AS subquery;
? �ٸ� ���̺� �����ϴ� Ư�� �÷��� ���� �̿��� ���̺��� �����ϰ� ���� �� ���
? Subquery�� ��������� table�� ������
? �÷����� ����� ��� subquery�� �÷����� ���̺��� �÷����� ���� �ؾ� �Ѵ�.
? �÷��� ������� ���� ���, �÷����� subquery�� �÷���� ���� �ȴ�.
? subquery�� �̿��� ���̺��� ������ �� 
  CREATE TABLE ���̺�� �ڿ� �÷����� ����� �ִ� ���� ����.
5. ����.
  ��. emp ���̺��� 10�� �μ��� �˻� ->> empno, ename, hiredate, sal+NVL(comm,0) pay ���ο� ���̺� ����

CREATE TABLE tbl_emp10 -- (no, name, ibsadate, pay) --[�÷���, �÷��� , �÷���, �÷���]
AS (
   SELECT empno, ename, hiredate, sal+NVL(comm,0) pay
   FROM emp
   WHERE deptno=10
);
--Table TBL_EMP10��(��) �����Ǿ����ϴ�.

6. ���̺��� ���� Ȯ��
DESC tbl_emp10;

�̸�       ��? ����           
-------- -- ------------ 
EMPNO       NUMBER(4)      emp ���̺� �ڷ���
ENAME       VARCHAR2(10)   emp ���̺� �ڷ���
HIREDATE    DATE           emp ���̺� �ڷ���
PAY         NUMBER         �ý����� �ڷ��� ����(�˾Ƽ�)

7. �������̺��� �״�� �ΰ�, �����ؼ� ���̺� ����ϰ� ���� �� ���
CREATE TABLE tbl_empcopy
AS (
        SELECT * FROM emp 
    );
--Table TBL_EMPCOPY��(��) �����Ǿ����ϴ�.
-- emp ���̺��� ����+ 12���� ��������� �״�� ���� -> ���ο� ���̺� ����
DESC tbl_empcopy;

8. ���������� ������� �ʴ´� (NOT NULL ���������� ����)
  ��. EMP ��������
  SELECT *
  FROM user_constraints
  WHERE table_name = UPPER( 'emp');
  
��������
������    �������� �̸�      �������� Ÿ��
OWNER   CONSTRINT_NAME
SCOTT	PK_EMP	             P     PK
SCOTT	FK_DEPTNO	         R     FK
  
  FROM tabs;
  FROM user_tables;
    
    ��. tbl_empcopy ��������
    
  SELECT *
  FROM user_constraints
  WHERE table_name =  'tbl_empcopy';
  
9. ���̺� ����
DROP TABLE tbl_emp10 PURGE;
DROP TABLE tbl_empcopy PURGE;

10. ���̺��� ���� ���̺�κ��� ���������� ����ؼ� ���� + �����ʹ� �ʿ�x
-----------------���1)-----------------
CREATE TABLE tbl_emp_copy
AS (
  SELECT *
  FROM emp
);
 1) �����ϰ� ����
 DELETE FROM tbl_emp_copy;
 COMMIT;
 2) DELETE ���� WHERE ���� �� ���� ����� ��� ������ ������.
SELECT *
FROM tbl_emp_copy;
--����Ŭ 11G XE �� PURGE �Ⱥٿ��� �ڵ����� ���� ������.
-----------------���2)-----------------
--�׻� ������ ���� �־��ָ� ������ �����ϰ� ���̺� ������ - ������ ����.
CREATE TABLE tbl_emp_copy
AS (
  SELECT *
  FROM emp
  WHERE 1=0 
);

DROP TABLE tbl_emp_copy;
-------------------------------------------
1. tbl_member ���̺� �ִ��� Ȯ��

SELECT *
FROM user_tables
WHERE REGEXP_LIKE( table_name,'member','i');

2. tbl_member ���̺� ����
DROP TABLE tbl_member;

3. ���̺� ����

rrn �ֹε�Ϲ�ȣ�� �÷����� �߰�      => ����Ӽ�
     -> ����, ����, ���� ���� ���� -> ���� ���� ��� �ֹι�ȣ ���

CREATE TABLE tbl_member
 (
    id varchar2(10) NOT NULL CONSTRAINTS PK_TABLEMEMBER_ID PRIMARY KEY         --����ŰPK =�ߺ�x = (���ϼ�unique+ NN(not null))
    ,name varchar2(20) NOT NULL
      ,age  NUMBER(3)
      ,birth DATE
    ,regdate DATE DEFAULT SYSDATE --������ 
    ,point NUMBER DEFAULT 100  --����Ʈ
 );
-- Table TBL_MEMBER��(��) �����Ǿ����ϴ�.

SELECT *
FROM user_constraints
WHERE table_name = 'TBL_MEMBER';

PK   P
NN   C
FK   R

--�������� �� �������� ������ �ڵ����� SYS~~
����߰�
���� ���� -
ORA-01830: date format picture ends before converting entire input string
 -- '1991/03/04' �������� �ִ��� fmt���� �˷������
INSERT INTO TBL_MEMBER (id, name, age, birth, regdate, point)
     VALUES ('admin','������',32,TO_DATE( '03/04/1991','MM/DD/YYYY'),SYSDATE, 100);

���� ���� -
ORA-00001: unique constraint (SCOTT.PK_TABLEMEMBER_ID) violated
 PK ����Ű�� �ߺ� �ȵȴ� 
INSERT INTO TBL_MEMBER VALUES ('hong','ȫ�浿',22,'2001.01.01',SYSDATE, 100);
--���̺� ������ �Ȱ����Ƿ� ����
 
���� ���� -
SQL ����: ORA-00947: not enough values :
����Ʈ �� ������ �����ߴµ� �� ����-> �����尪 �����Ϸ��� Į���� �־������.
 INSERT INTO TBL_MEMBER (id, name, age, birth) VALUES ('park','������',25,'1998.5.9');

--null����ϴ� Į���� null�� ä���� ��.
 INSERT INTO TBL_MEMBER( name, birth, id, age) VALUES ('������', null, 'kenik',25);

COMMIT;                
SELECT *
FROM tbl_member;
                
 -------�������� ����ؼ� insert�� �� �ִ�
���� )
INSERT INTO ���̺��(��������);

----------------
1. tbl_emp10 ���̺� ���� Ȯ��  -> ����
2. emp ���̺��� ��������o, ������x -> tbl_emp10 ���̺� ����
CREATE TABLE tbl_emp1  --Į����
AS (
   SELECT *
   FROM emp
   WHERE 1=10
   );
   
SELECT *
FROM tbl_emp;

3.emp ���̺��� 10�� �μ������� select �ؼ� tbl_emp10 ���̺� �߰�

INSERT INTO tbl_emp10
   (
   SELECT *
   FROM emp
   WHERE deptno=10   
   );
    
    commit;
    DROP TABLE tbl_emp10;
    
--[MULTITABLE INSERT��] �������̺� INSERT��
--4���� ����
--    ��������             ����
--��. unconditional insert all 
--��. conditional insert all 
--��. conditional first insert 
--��. pivoting insert 

--�ϳ��� INSERT ���� 

--��. unconditional insert all 
--  ���ǿ� ������� ����Ǿ��� �������� ���̺� �����͸� �Է��Ѵ�
? ���������κ��� �ѹ��� �ϳ��� ���� ��ȯ�޾� ���� insert ���� �����Ѵ�.
? into ���� values ���� ����� �÷��� ������ ������ Ÿ���� �����ؾ� �Ѵ�
 ���� 
 INSERT ALL
      INTO ���̺�1 VALUES (�÷���..)
      INTO ���̺�2 VALUES (�÷���..)
      INTO ���̺�3 VALUES (�÷���..)
      :
      �������� ;  SELECT(10��)

CREATE TABLE dept_10 AS SELECT * FROM dept WHERE 1=0;
CREATE TABLE dept_20 AS SELECT * FROM dept WHERE 1=0;
CREATE TABLE dept_30 AS SELECT * FROM dept WHERE 1=0;
CREATE TABLE dept_40 AS SELECT * FROM dept WHERE 1=0;

SELECT * FROM dept_10; DELETE FROM dept_10;
SELECT * FROM dept_20; DELETE FROM dept_20;
SELECT * FROM dept_30; DELETE FROM dept_30;
SELECT * FROM dept_40; DELETE FROM dept_40;

INSERT ALL
    INTO dept_10 VALUES (deptno, dname, loc)
    INTO dept_20 VALUES (deptno, dname, loc)
    INTO dept_30 VALUES (deptno, dname, loc)
    INTO dept_40 VALUES (deptno, dname, loc)
SELECT deptno, dname, loc
FROM dept;
--16�� �� ��(��) ���ԵǾ����ϴ�.
COMMIT;
DROP TABLE dept_10;
DROP TABLE dept_20;
DROP TABLE dept_30;
DROP TABLE dept_40;

-��. conditional insert all 

����) emp ���̺� �ѹ��� ����ֱ�

-- emp���̺��� ������ �����ؼ� ���̺� ����
CREATE TABLE emp_10 AS SELECT * FROM emp WHERE 1=0;
CREATE TABLE emp_20 AS SELECT * FROM emp WHERE 1=0;
CREATE TABLE emp_30 AS SELECT * FROM emp WHERE 1=0;
CREATE TABLE emp_40 AS SELECT * FROM emp WHERE 1=0;

�����ġ�
	INSERT ALL
	WHEN ������1 THEN
	  INTO [���̺�1] VALUES (�÷�1,�÷�2,...)
	WHEN ������2 THEN
	  INTO [���̺�2] VALUES (�÷�1,�÷�2,...)
	........
	ELSE
	  INTO [���̺�3] VALUES (�÷�1,�÷�2,...)
	Subquery;

? subquery�κ��� �ѹ��� �ϳ��� ���� ���Ϲ޾� WHEN...THEN������ üũ�� ��,
   ���ǿ� �´� ���� ����� ���̺� insert ���� �����Ѵ�.
? VALUES ���� ������ DEFAULT ���� ����� �� �ִ�. 
  ���� default���� �����Ǿ� ���� �ʴٸ�, NULL ���� ���Եȴ�.
  
  INSERT ALL
    WHEN deptno=10 THEN
     INTO emp_10 VALUES (empno, ename, job, mgr, hiredate, sal, comm, deptno)
      WHEN deptno=20 THEN  
     INTO emp_20 VALUES (empno, ename, job, mgr, hiredate, sal, comm, deptno)
      WHEN deptno=30 THEN
     INTO emp_30 VALUES (empno, ename, job, mgr, hiredate, sal, comm, deptno)
      WHEN deptno=40 THEN
     INTO emp_40 VALUES (empno, ename, job, mgr, hiredate, sal, comm, deptno)
  SELECT * FROM emp;
  
SELECT * FROM dept_10;
SELECT * FROM dept_20; 
SELECT * FROM dept_30;
SELECT * FROM dept_40;

emp10 ���ڵ� ��� ����
DROP TABLE emp_10 ; --���̺� ���� ����

DELETE FROM emp_10; --��� ���ڵ�(������) ����
COMMIT;

TRUNCATE TABLE emp_10; -- ��� ���ڵ�(������) ���� + �ڵ� Ŀ��/�ѹ�X
-- WHERE ������ ���� DELETE �ϴ� �Ͱ� ���� ��, �ڵ�Ŀ��
--Table EMP_10��(��) �߷Ƚ��ϴ�.
TRUNCATE TABLE emp_20; 
TRUNCATE TABLE emp_30; 
TRUNCATE TABLE emp_40; 

--��. conditional first insert  

�����ġ�
INSERT FIRST
WHEN ������1 THEN
  INTO [���̺�1] VALUES (�÷�1,�÷�2,...)
WHEN ������2 THEN
  INTO [���̺�2] VALUES (�÷�1,�÷�2,...)
........
ELSE
  INTO [���̺�3] VALUES (�÷�1,�÷�2,...)
Sub-Query;

? conditional INSERT FIRST�� �������� ����Ͽ� ���ǿ� �´� ������ ���ϴ� ���̺� ������ �� �ִ�.
? ���� ���� WHEN...THEN���� ����Ͽ� ���� ���� ����� �����ϴ�. ��, ù ��° WHEN ������ ������ �����Ѵٸ�, INTO ���� ������ �� ������ WHEN ������ �� �̻� �������� �ʴ´�.
? subquery�κ��� �� ���� �ϳ��� ���� ���� �޾� when...then������ ������ üũ�� �� ���ǿ� �´� ���� ����� ���̺� insert�� �����Ѵ�.
? ������ ����� when ������ �����ϴ� ���� ���� ��� else���� ����Ͽ� into ���� ������ �� �ִ�. else���� ���� ��� ���� �� ���࿡ ���ؼ��� �ƹ��� �۾��� �߻����� �ʴ´�.

---
SELECT *
FROM emp
WHERE deptno =10;

--7782	CLARK	MANAGER	7839	81/06/09	2450		10
--7839	KING	PRESIDENT		81/11/17	5000		10
--7934	MILLER	CLERK	7782	82/01/23	1300		10

SELECT *
FROM emp
WHERE job ='CLERK';

--7369	SMITH	CLERK	7902	80/12/17	800		20
--7900	JAMES	CLERK	7698	81/12/03	950		30
--7934	MILLER	CLERK	7782	82/01/23	1300		10

MILLER �� �μ�10, ���� CLERK

--���� ���� �����ϴ� ���� �����ϰ� �������� �������.
INSERT FIRST
    WHEN  deptno =10 THEN
    INTO emp_10 VALUES (empno, ename, job, mgr, hiredate, sal, comm, deptno)
    WHEN job='CLERK'  THEN
    INTO emp_20 VALUES (empno, ename, job, mgr, hiredate, sal, comm, deptno)
    ELSE
    INTO emp_40 VALUES (empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT * FROM emp;
-> �з��� �μ��� 10�̶� 10������ ���� ���������� ���õǹǷ� 20������ �ȵ�

DROP TABLE emp_10;
DROP TABLE emp_20;
DROP TABLE emp_30;
DROP TABLE emp_40;

--��. Pivoting insert ��

�����ġ�
INSERT ALL
WHEN ������1 THEN
  INTO [���̺�1] VALUES (�÷�1,�÷�2,...)
  INTO [���̺�1] VALUES (�÷�1,�÷�2,...)
  ..........
Sub-Query;

? ���� ���� INTO ���� ����� �� ������, INTO �� �ڿ� ���� ���̺��� ��� �����Ͽ��� �Ѵ�.
? �ַ� ���� ���� �ý������κ��� �����͸� �޾� �۾��ϴ� dataware house�� �����ϴ�. ����ȭ ���� ���� data source���̳� �ٸ� format���� ����� data source���� Oracle�� ������ DB���� ����ϱ⿡ ������ ���·� ��ȯ�Ѵ�.
? ����ȭ ���� ���� �����͸� oracle�� �����ϴ� relational�� ���·� ���̺��� �����ϴ� �۾��� pivoting�̶�� �Ѵ�.

CREATE TABLE tbl_sales(
   employee_id       number(6),
   week_id            number(2),
   sales_mon          number(8,2),
   sales_tue          number(8,2),
   sales_wed          number(8,2),
   sales_thu          number(8,2),
   sales_fri          number(8,2)
   );

--Table TBL_SALES��(��) �����Ǿ����ϴ�.

insert into tbl_sales values(1101,4,100,150,80,60,120);
insert into tbl_sales values(1102,5,300,300,230,120,150);

COMMIT;

SELECT *
FROM tbl_sales;

create table tbl_sales_data(
  employee_id        number(6),
  week_id            number(2),
  sales              number(8,2)
  );
--Table TBL_SALES_DATA��(��) �����Ǿ����ϴ�.

insert all
   into tbl_sales_data values(employee_id, week_id, sales_mon)
   into tbl_sales_data values(employee_id, week_id, sales_tue)
   into tbl_sales_data values(employee_id, week_id, sales_wed)
   into tbl_sales_data values(employee_id, week_id, sales_thu)
   into tbl_sales_data values(employee_id, week_id, sales_fri)
   
   select employee_id, week_id, sales_mon, sales_tue, sales_wed,
          sales_thu, sales_fri
   from tbl_sales;

SELECT *
FROM tbl_sales_data;

--------------------
         �̹� �����ϴ� ���̺��� ����ؼ� ���ο� ���̺� ����
���� ) insa ���̺��� num, name �÷��� �����ؼ� tbl_score ���̺� ����
     ����1) num <= 1005 �ڷ�(���ڵ�)�� ����.
     
CREATE TABLE tbl_score  
  AS 
   SELECT num, name
   FROM insa
   WHERE num <=1005;
--Table TBL_SCORE��(��) �����Ǿ����ϴ�.

--alter table + �߰��� add ������ modify
����2) tbl_score ���̺� kor, eng, mat, tot, avg, grade , rank Į�� �߰�
 (k, e, m �⺻�� 0 ,         grade �� �ѹ���(����, �ѱ�)
ALTER TABLE tbl_score 
   ADD( kor number(3) DEFAULT 0
       ,eng number(3) DEFAULT 0
       ,mat number(3) DEFAULT 0
       ,tot NUMBER(3)
       ,avg NUMBER(5,2)
       ,grade char(1 char) 
       ,rank NUMBER
       );
--Table TBL_SCORE��(��) ����Ǿ����ϴ�.

DESC tbl_score;

�̸�    ��?       ����           
----- -------- ------------ 
NUM   NOT NULL NUMBER(5)    
NAME  NOT NULL VARCHAR2(20) 
KOR            NUMBER(3)    
ENG            NUMBER(3)    
MAT            NUMBER(3)    
TOT            NUMBER(3)    
AVG            NUMBER(5,2)  
GRADE          CHAR(1 CHAR) 
RANK           NUMBER       

���� ) 1001~1005 num, name
     kor, eng, mat ������ ������ �߻����Ѽ� ����
  
 UPDATE tbl_score
 SET  kor =  TRUNC( dbms_random.value(0,101))
     ,eng =   TRUNC( dbms_random.value(0,101))
     ,mat  =  TRUNC( dbms_random.value(0,101));
  COMMIT;
����) tbl_score ���̺� TOT, AVG ����ؼ� ���� UPDATE

UPDATE tbl_score
SET  tot = kor+eng+mat
    , avg = (kor+eng+mat)/3;

��� 90�̻� A
    80    B
    70    C
    60    D
          F
 --���1
UPDATE tbl_score
SET grade = CASE
              WHEN avg >=90  THEN grade ='A'
              WHEN avg BETWEEN 80 AND 89  THEN 'B'
              WHEN avg BETWEEN 70 AND 79  THEN 'C'
              WHEN avg BETWEEN 60 AND 69  THEN 'D'
              ELSE 'F'
  --���2 
UPDATE tbl_score
SET grade 
   = DECODE(TRUNC(avg/10),10,'A',9,'A',8,'B',7,'C',6,'D','F');
COMMIT;

-����) ��� ó���ϴ� UPDATE ��

SELECT num, tot,name
       ,RANK() OVER(ORDER BY tot DESC) rank
FROM tbl_score;
--
���1
UPDATE tbl_score y
SET rank = (  SELECT r
              FROM (
                SELECT num, tot,name
                       ,RANK() OVER(ORDER BY tot DESC) r
                FROM tbl_score
                ) X
            WHERE X.NUM = Y.NUM
           );
           
  --5�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
  ROLLBACK;
  --���2
UPDATE tbl_score y
SET rank =
   ( SELECT COUNT(*)+1 FROM tbl_score  WHERE tot > y.tot);

SELECT *
FROM tbl_score;

COMMIT;

--���� ) ��� �л��� ���������� 5�� ����, 

UPDATE tbl_score
SET kor = CASE 
           WHEN kor>=95   THEN 100
           ELSE kor+5
           END;
/*JAVA
if( kor>=95) kor =100;
else kor+=5
*/
--���� ) 1001�� �л��� ���� ������ 1005�� �л��� ����, ���� ������ ����
--���1
UPDATE tbl_score
SET kor = (SELECT kor FROM tbl_score WHERE num =1005)
   ,eng = (SELECT eng FROM tbl_score WHERE num =1005)
WHERE num =1001;

--���2
UPDATE tbl_score
SET (kor, eng) = (SELECT kor, eng FROM tbl_score WHERE num= 1005)
WHERE num =1001;

COMMIT;

SELECT *
FROM tbl_score;
--����  )tbl_score ���̺��� ���л��鸸 �������� 5�� ����

--tbl_score ���� ������ �ش��ϴ� Į�� ����
-- insa ���̺� ����
-- ���α��� �ؾ���

SELECT *
FROM tbl_score;

UPDATE tbl_score 
SET eng = eng+5
WHERE num = (SELECT ts.num
            FROM tbl_score ts,( SELECT num, DECODE (MOD( SUBSTR(ssn, -7,1),2),0,'����') gender  
                               FROM insa)i
            WHERE ts.num = i.num AND gender IS NOT NULL) ;



SELECT ts.num
FROM tbl_score ts,( SELECT num, DECODE (MOD( SUBSTR(ssn, -7,1),2),0,'����') gender
                FROM insa)i
WHERE ts.num = i.num AND gender IS NOT NULL;

SELECT t.gender
FROM ( SELECT num, DECODE (MOD( SUBSTR(ssn, -7,1),2),0,'����') gender
FROM insa i)t

;

SELECT NUM
FROM insa i;
--------------------------------------------
-- ����޷�
SELECT   
          NVL( MIN(    DECODE( TO_CHAR(dates, 'D'), 1,TO_CHAR(dates, 'DD') )   ), ' ') ��
         , NVL( MIN(  DECODE( TO_CHAR(dates, 'D'), 2,TO_CHAR(dates, 'DD') ) ), ' ') ��
         , NVL( MIN(  DECODE( TO_CHAR(dates, 'D'), 3,TO_CHAR(dates, 'DD') ) ), ' ') ȭ
         , NVL( MIN(  DECODE( TO_CHAR(dates, 'D'), 4,TO_CHAR(dates, 'DD') ) ), ' ') ��
         , NVL( MIN(  DECODE( TO_CHAR(dates, 'D'), 5,TO_CHAR(dates, 'DD') ) ), ' ') ��
         , NVL( MIN(  DECODE( TO_CHAR(dates, 'D'), 6,TO_CHAR(dates, 'DD') ) ), ' ') ��
         , NVL( MIN(  DECODE( TO_CHAR(dates, 'D'), 7,TO_CHAR(dates, 'DD') ) ), ' ') ��         
FROM (
        SELECT TO_DATE( :yyyymm, 'YYYYMM') + (LEVEL -1) dates
        FROM dual
        CONNECT BY LEVEL <= EXTRACT( DAY FROM LAST_DAY( TO_DATE( :yyyymm , 'YYYYMM') ) )
      ) t      
GROUP BY  DECODE( TO_CHAR(dates, 'D'), 1, TO_CHAR( dates, 'IW') +1,  TO_CHAR( dates, 'IW')   )  
ORDER BY  DECODE( TO_CHAR(dates, 'D'), 1, TO_CHAR( dates, 'IW') +1,  TO_CHAR( dates, 'IW')   );

---------------------------------------------------------------
�м� ����
�Է�: 202203
��¥: 22/03/01
��¥+2 = ��¥
SELECT TO_DATE( '202203', 'YYYYMM') + (LEVEL -1) dates
FROM dual;

--LEVEL
������ ����(hierarchical query)