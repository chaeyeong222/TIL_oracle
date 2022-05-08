��. Ʈ�����(Transaction)�̶�?
    ���� ó���� �Ϸ���� ���� �߰� ������ ����Ͽ� ���� ���� �� �ܰ�� �ǵ����� ���
    ����� ����Ǳ������ �߰� �ܰ迡�� ������ �߻��Ͽ��� ��� 
    ��� �߰� ������ ��ȿȭ�Ͽ� �۾��� ó�� ���� �� �ܰ�� �ǵ����� ��
��. ��� ���� �ϷḦ �˸��� commit�� ���� ��Ҹ� �˸��� rollback�� ���δ�.
��. DML���� �����ϸ� �ش� Ʈ�����ǿ� ���� �߻��� �����Ͱ� 
    �ٸ� ����ڿ� ���� ������ �߻����� �ʵ��� LOCK(�������)�� �߻��Ѵ�. 
    �� lock�� commit �Ǵ� rollback ���� ����Ǹ� �����ȴ�.
��. Ʈ������ ó���� �ʿ��� ��. ex. ������ü�۾�
    ���ȯ -> ������ 100���� ��ü
    
    1. ���ȯ ���忡�� update 100���� �����ϴ� dml
    2. ������ ���忡�� update 100���� �����ϴ� dml
    
    1+2 -> ��� �Ϸ� commit, �ϳ��� �����ϸ� rollback;

   ex. Ʈ������ ó�� �ʿ� + Ʈ���� ����(�԰� �߰��Ǹ� �ڵ� ��� �߰�)
    �԰����̺�        insert 15
    
    ������̺�        update 15

��. Ʈ������ �׽�Ʈ 
--A user �������� scott ������ ����

SELECT *
FROM emp;

7369	SMITH	CLERK	7902	80/12/17	800		20
1) SMITH	CLERK -> MANAGER ����
UPDATE emp
SET job = 'MANAGER'
WHERE ename = 'SMITH';
--1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
--DML�� �����ϸ� ��� lock
--commit, rollback ���̴ϱ� �������x
commit;

2) SMITH	 MANAGER -> CLERK ����
UPDATE emp
SET job = 'CLERK'
WHERE ename = 'SMITH';
--1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
--commit, rollback ���̴ϱ� �������x
commit;

INSERT/UPDATE/DELETE DML�� ���� Ŀ/�� �������X

--DEAD LOCK(�����)
--���ȯ - å����� �� ����̹�X

--A ��ġO+ ��X UPDATE ������
DML ����ϸ� �ڵ����� Ʈ������ �ɸ���LOCK -> Ŀ��, �ѹ� �������
DDL/DCL �����ϸ� Ʈ������ ����
-----------------------
--SELECT DQL���� ����� �� �ִ� �� : FOR UPDATE OF ��
SELECT *
FROM EMP
FOR UPDATE OR JOB NOWAIT;
DQL + Ʈ������(LOCK)
--COMMIT; ROLLBACK;
---------------------------------
TCL�� - COMMIT, ROLLBACK,SAVEPOINT

COMMIT;

SELECT *
FROM DEPT;

1.����
SAVEPOINT sp_dept_delete;
DELETE FROM DEPT WHERE DEPTNO =50; --��� 


2.�߰�
SAVEPOINT sp_dept_insert;
INSERT INTO DEPT VALUES(60,'AA','YY'); --���


3. ����
SAVEPOINT sp_dept_update;
UPDATE DEPT
SET LOC = 'SEOUL' 
WHERE DEPTNO = 40;  --���


ROLLBACK; --����۾� ���, �������

--������ ���ܵΰ� 2���� �ѹ��Ϸ���?
rollback to savepoint sp_dept_insert;
----------------------------------------------
--*****���� sql *****
1. ����sql? ������ �ÿ� sql������ Ȯ������ �ʴ� ���

SELECT *
FROM �Խ������̺�
if ����˻� then
WHERE ���� like '�浿';
elsif ���� + ���� then
where ���� like '�浿' or ���� like '�浿';
end if;
--where ������ ��û ������
2. where ������, select �÷�.. �׸��� �������� ���ϴ� ��� ���
select ??
from 
where ? and ? or ??..

3. pl/sql ���� DDL ���� �����ϴ� ���
CREATE/ ALTER/ DROP + TRUNCATE

4. PL/SQL���� ALTER SESSION /SYSTEM ��ɾ �����ϴ� ��� DBA X

5. ��������������ϴ� ���
  1) ���õ������� (native dynamic sql : nds)******
  2) DBMS_SQL��Ű�� ��� (�����ؼ� ���X)
  
  exec(ute) �������ν�����(�Ķ����..);
select ename into vename ��������
6. �������� ������
  1) execute immediate ����������
                       INTO ������, ������ ��
                       using mode(in,out,inout)�Ķ����, �Ķ����..��
7. �������� ����(�ۼ�) -> ����

DECLARE
  vdsql varchar2(1000);
  vdeptno emp.deptno%type;
  vempno emp.empno%type;
  vename emp.ename%type;
  vjob emp.job%type;
  
BEGIN
  --��. �������� �ۼ�
 vdsql :=  'SELECT deptno, empno, ename, job ';
  vdsql :=   vdsql || 'FROM emp ';
  vdsql :=  vdsql ||  'WHERE empno = 7369 ' ;

   --��. �������� ����
execute immediate vdsql
               into vdeptno, vempno, vename, vjob;
  dbms_output.put_line(vdeptno ||','|| vempno ||','|| vename ||','|| vjob);
--EXCEPTION
END;
----------------
�������ν��������
CREATE OR REPLACE PROCEDURE up_DSELEMP
(
 pempno emp.empno%type
)
is
  vdsql varchar2(1000);
  vdeptno emp.deptno%type;
  vempno emp.empno%type;
  vename emp.ename%type;
  vjob emp.job%type;
  
BEGIN
  --��. �������� �ۼ�
  vdsql := 'SELECT deptno, empno, ename, job';
  vdsql := vdsql || 'FROM emp';
  vdsql := vdsql || 'WHERE empno=7369';
   --��. �������� ����
EXECUTE IMMEDIATE vdsql
               INTO vdeptno, vempno, vename, vjob
               USING pempno;
  dbms_output.put_line(vdeptno ||','|| vempno ||','|| vename ||','|| vjob);
--EXCEPTION
END;
--
--�������ν��� ����ؼ� �������� �ۼ� �� ����..(insert)
CREATE OR REPLACE PROCEDURE up_DSELEMP
(
 pdname dept.dname%type
  , ploc dept.loc%type
)
is
  vdsql varchar2(1000);
  vdeptno dept.deptno%type; --50

BEGIN
  --��. �������� �ۼ�
  vdsql := 'INSERT INTO dept';
  vdsql := vdsql || 'VALUES (:deptno, :dname, :loc)';
   --��. �������� ����
EXECUTE IMMEDIATE vdsql 
               USING vdeptno, pdname, ploc;

  --COMMIT;
--EXCEPTION
END;
--Procedure UP_DSELEMP��(��) �����ϵǾ����ϴ�.

SELECT * FROM DEPT;
EXEC up_DSELEMP('QC','SEOUL');

4.�͸����ν����� ����ؼ� �������� + DDL(CREATE��)
DECLARE
  vsql varchar2(1000);
  vtableName varchar2(20);
BEGIN
  vtableName := 'tbl_nds';
   vsql := 'CREATE TABLE ' || vtableName ;
   -- vsql := 'CREATE TABLE  :tableName ' ;
   vsql := vsql || ' ( ' ;
   vsql := vsql || '         id number primary key  ' ;
   vsql := vsql || '         , name varchar2(20)  ' ;
   vsql := vsql || ' ) ' ;

 
 DBMS_OUTPUT.PUT_LINE(vsql);
 
 EXECUTE IMMEDIATE vsql;
END;
------------
��5. [OPEN FOR��] ����? 
[���� SQL]�� �������� �������� ���ڵ�(��) ��ȯ�ϴ� [SELECT��+Ŀ��]
CREATE OR REPLACE PROCEDURE up_nds02
(
  pdeptno dept.deptno%type
)
IS
  vsql varchar2(1000);
  vrow emp%ROWTYPE;
  vcursor SYS_REFCURSOR; -- 9i  REF CURSOR
BEGIN
   vsql := 'SELECT * ';
   vsql := vsql || 'FROM emp ';
   vsql := vsql || 'WHERE deptno = :deptno ';
   
   -- X EXECUTE IMMEDIATE ��������   
   -- OPEN FOR �� ����Ѵ�. 
   OPEN  vcursor FOR vsql USING pdeptno;
   
   LOOP
      FETCH vcursor INTO vrow;
      EXIT WHEN vcursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE( vrow.empno || ', ' || vrow.ename );
   END LOOP;
   
   CLOSE vcursor;
END;

-- Procedure UP_NDS02��(��) �����ϵǾ����ϴ�.
EXEC UP_NDS02( 30 );
EXEC UP_NDS02( 10 );


