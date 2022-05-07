[PL/SQL�� ��Ű��]
1. ����Ǵ� Ÿ��, ���α׷� ��ü, �������α׷�(procedure, function)�� �������� ���� ���� ���� �ǹ�
2.��Ű���� ��. specification  ��. body �κ����� ����
3.����Ŭ���� �⺻������ �����ϴ� ��Ű���� ������, ������ �̸� �̿��ϸ� ���ϴ�
4.specification �κ��� type, constant, variable, exception, cursor, subprogram(�������ν���, �����Լ�) �� ����ȴ�. 
5. body �κ��� cursor, sub program ������ �����Ѵ�.
6. ȣ���� �� '��Ű��_�̸�.���ν���_�̸�' ������ ������ �̿��ؾ� �Ѵ�.
----------------------------------------------------------------
1)specification �κ�  
CREATE OR REPLACE PACKAGE logon_pkg 
AS 
    PROCEDURE up_idCheck 
    (
        pempno IN emp.empno%TYPE --ID
        , pempnoCheck OUT NUMBER --0(��밡��)   1(���Ұ���)
    );
    procedure up_logon
    (
        pempno in emp.empno%type --id
        , pename in emp.ename%type --��й�ȣ ��ſ� ��� 
        , plogonCheck out number --�α��ΰ����ϸ� 0 1(id ����x) -1 (id���������� ��� Ʋ��) 
    );
    FUNCTION uf_age
    (
      prrn VARCHAR2
    )
    RETURN NUMBER ;
END logon_pkg;

--Package LOGON_PKG��(��) �����ϵǾ����ϴ�.
2)body �κ�
CREATE OR REPLACE PACKAGE BODY logon_pkg
AS
    PROCEDURE up_idCheck
    (
        pempno IN emp.empno%TYPE --ID
        , pempnoCheck OUT NUMBER --0(��밡��)   1(���Ұ���)
    )
    IS
    BEGIN
        SELECT COUNT(*) INTO pempnoCheck
        FROM emp
        WHERE empno=pempno;
    --EXCEPTION
    END up_idCheck;
    procedure up_logon
    (
        pempno in emp.empno%type --id
        , pename in emp.ename%type --��й�ȣ ��ſ� ��� 
        , plogonCheck out number --�α��ΰ����ϸ� 0 1(id ����x) -1 (id���������� ��� Ʋ��) 
    ) 
    is 
    vename emp.ename%type;
    begin
        select count(*) into  plogonCheck --id �������� ������ 0
        from emp 
        where empno=empno;
        --id�� �����ϸ�, ��й�ȣ�� �´��� üũ  
        if plogonCheck = 1 then 
            select ename into vename
            from emp
            where empno=pempno;
    
            --id����, �����ȣ ��ġ 
            if vename=pename then
           plogonCheck := 0; --�α��μ��� 
            else  --id ����, ��й�ȣx 
            plogonCheck:= -1; --�α��� ���� 
            end if;
    else 
        plogonCheck := 1;
        end if; 
    end up_logon;
    FUNCTION uf_age
    (
      prrn VARCHAR2
    )
    RETURN NUMBER 
    IS
       vischeck number(1);
       vt_year  number(4);
       vb_year  number(4);
       vage     number(3);
    BEGIN
       vischeck :=  SIGN(  TRUNC( SYSDATE ) -  TO_DATE(  SUBSTR( prrn, 3,4), 'MMDD') );
       vt_year  := TO_CHAR( SYSDATE  , 'YYYY');
       vb_year  := CASE  
                     WHEN SUBSTR( prrn, 8, 1 ) IN (1,2,5,6) THEN '1900' + SUBSTR( prrn, 1,2)
                     WHEN SUBSTR( prrn, 8, 1 ) IN (3,4,7,8) THEN '2000' + SUBSTR( prrn, 1,2)
                     ELSE                                       '1800'  + SUBSTR( prrn, 1,2)
                 END;
       vage     :=  CASE  VISCHECK
                    WHEN -1 THEN  --  �� ��  ����  ��� 
                     vt_year - vb_year-1
                    ELSE   -- 0, 1
                     vt_year - vb_year
                END  ;        
       RETURN vage;         
    --EXCEPTION
    END;
END logon_pkg;

--Package LOGON_PKG��(��) �����ϵǾ����ϴ�.
--------------------------------


SELECT NAME, ssn
   , LOGON_PKG.uf_age(ssn) age
FROM insa;

DECLARE 
 vempnoCheck NUMBER;
BEGIN
  LOGON_PKG.up_idcheck(7369,  vempnoCheck );
  DBMS_OUTPUT.PUT_LINE(vempnoCheck);
END;
------------------------------------
Ŀ��cursor + �Ķ���͸� �̿��ϴ� ���
---------------------
CREATE OR REPLACE PROCEDURE up_selDeptEmp
(
pdeptno dept.deptno%type
)
IS 
   vename emp.ename%type;
   vsal emp.sal%type;
   
    CURSOR cemplist(    cdeptno dept.deptno%type )IS 
    ( 
                    SELECT ename, sal
                    FROM emp
                    WHERE deptno = cdeptno );
BEGIN
 OPEN cemplist(pdeptno);
 LOOP 
    FETCH cemplist INTO vename, vsal;
    EXIT WHEN cemplist%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(vename|| ','||vsal);
 END LOOP;
 CLOSE cemplist;
END;

--Procedure UP_SELDEPTEMP��(��) �����ϵǾ����ϴ�.

EXEC UP_SELDEPTEMP(30);
---------------------------------------------
*****SYS_REFCURSOR Ÿ��(����Ŭ 9i ���� : REF CURSORS )
      SYS ���� Ŀ��
---------------------------------------
--Ŀ���� �Ű������� �޾Ƽ� ����ϴ� �������ν���
CREATE OR REPLACE PROCEDURE up_selInsa
( pcursor SYS_REFCURSOR)
is
  vname insa.name%type;
  vcity insa.city%type;
  vbasicpay insa.basicpay%type;
begin
   LOOP
    FETCH pcursor INTO vname, vcity, vbasicpay;
    EXIT WHEN pcursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(vname ||','||vcity ||','||vbasicpay);
   END LOOP;
end;

--Procedure UP_SELINSA��(��) �����ϵǾ����ϴ�.
--���� ���ν����� �׽�Ʈ
CREATE OR REPLACE PROCEDURE up_test_selInsa
is
  vcursor SYS_REFCURSOR; --Ŀ�� ���� ����
begin

  OPEN vcursor FOR SELECT name, city, basicpay FROM insa;
  UP_SELINSA(vcursor); --�ݺ��� ���鼭 fetch �ϴ� �۾�
  close vcursor;
end;

--Procedure UP_TEST_SELINSA��(��) �����ϵǾ����ϴ�.

exec up_test_selInsa;
---------------------------
CREATE OR REPLACE PROCEDURE up_selInsa
(
 pcursor OUT SYS_REFCURSOR --��¿� �Ű����� Ŀ�� �������?
)
IS
BEGIN
  OPEN pcursor FOR SELECT name, city, basicpay FROM insa;
END;
--Procedure UP_SELINSA��(��) �����ϵǾ����ϴ�.
 --JDBC = JAVA + ORACLE
---------------------------------
pl/sql ����ó�� exception
1. pl/sql �� ������ ������ ó���ϴ� ��: exception ��(��)
��)
CREATE OR REPLACE PROCEDURE up_exception01
(psal emp.sal%type)
IS
 vename emp.ename%type;
BEGIN
  SELECT ename INTO vename
  FROM emp
  WHERE sal = psal;
  
  DBMS_OUTPUT.PUT_LINE(psal || '=>'|| vename);
EXCEPTION
  WHEN NO_DATA_FOUND THEN   --�̸� ���ǵ� ����
     RAISE_APPLICATION_ERROR(-20002,'>QUERY DATA NOT FOUND<');
  WHEN TOO_MANY_ROWS THEN 
     RAISE_APPLICATION_ERROR(-20003,'>QUERY TOO MANY ROWS FOUND<');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20004,'>QUERY OTHERS EXCEPTION FOUND<');
END;

--Procedure UP_EXCEPTION01��(��) �����ϵǾ����ϴ�.
------------------------
SELECT ename, sal
FROM emp;

EXEC UP_EXCEPTION01(1250);
EXEC UP_EXCEPTION01(800);

------------------------------
--�̸� ���ǵ��� ���� ���� ��� ó��?
INSERT INTO dept VALUES (40,'QC','SEOUL');
--ORA-00001: unique constraint (SCOTT.PK_DEPT) violated (40���μ��̹�����)
DUP_VAL_ON_INDEX ORA-00001 �̹� �ԷµǾ� �ִ� �÷� ���� �ٽ� �Է��Ϸ��� ��쿡 �߻�

--------------
INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (9999, 'adnin','CLERK',9000, SYSDATE, 950,NULL, 90);
--�̸����ǵ� 7���� ���ܿ� ���� ���� ó��  EX. ORA-02291
--ORA-02291: integrity constraint (SCOTT.FK_DEPTNO) violated - parent key not found
-------------------
CREATE OR REPLACE PROCEDURE up_insEmp
(
pempno emp.empno%type,
pename emp.ename%type,
pjob emp.job%type,
pmgr emp.mgr%type,
phiredate emp.hiredate%type,
psal emp.sal%type,
pcomm emp.comm%type,
pdeptno emp.deptno%type
)
IS
   ve_invalid_deptno EXCEPTION;
   --���� ��ü ����(����)�� �� PRAGMA EXCEPTION �� ���
   PRAGMA EXCEPTION_INIT(ve_invalid_deptno, -02291);
BEGIN
  INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
    VALUES (pempno, pename, pjob, pmgr, phiredate, psal, pcomm, pdeptno);
    COMMIT;
EXCEPTION
    WHEN ve_invalid_deptno THEN
       RAISE_APPLICATION_ERROR(-20999,'>QUERY DEPTNO FK NOT FOUND<');
    WHEN OTHERS THEN
       RAISE_APPLICATION_ERROR(-20004,'>QUERY OTHERS EXCEPTION FOUND<');

END;

--Procedure UP_INSEMP��(��) �����ϵǾ����ϴ�.

EXEC up_insEmp(9999, 'adnin','CLERK',9000, SYSDATE, 950,NULL, 90);

----------------------------
--����ڰ� �����ϴ� ����ó�� ���
SELECT *
FROM tbl_score;

CREATE OR REPLACE PROCEDURE up_exception02
(
   psal IN emp.sal%type
)
IS
   vempcount NUMBER;
   
   ve_no_emp_returned EXCEPTION;
BEGIN
   SELECT COUNT(*) INTO vempcount
   FROM emp
   WHERE sal BETWEEN  (psal-100) AND (psal+100) ;
   
   IF  vempcount = 0 THEN
      -- ���� ���� �߻�         throw  new MyScoreException();
      RAISE ve_no_emp_returned;
   ELSE
      DBMS_OUTPUT.PUT_LINE('>ó�� ��� : ' || vempcount );
   END IF;
EXCEPTION
   WHEN ve_no_emp_returned THEN
      RAISE_APPLICATION_ERROR(-20011, '> QUERY EMP COUNT = 0 .... <');
   WHEN OTHERS THEN
     RAISE_APPLICATION_ERROR(-20004, '> QUERY OTHERS EXCEPTION FOUND <');
END;


EXEC UP_EXCEPTION02( 500 );






