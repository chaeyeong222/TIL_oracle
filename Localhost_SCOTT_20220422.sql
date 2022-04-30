--------------------------------------------------------
--  ������ ������ - �ݿ���-4��-22-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table T_SAMPLE
--------------------------------------------------------

  CREATE TABLE "SCOTT"."T_SAMPLE" 
   (   "S_ID" NUMBER, 
   "S_NAME" VARCHAR2(20 BYTE), 
   "S_ODATE" DATE DEFAULT SYSDATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "SCOTT"."T_SAMPLE"."S_ID" IS '����ID';
   COMMENT ON COLUMN "SCOTT"."T_SAMPLE"."S_NAME" IS '���ø�';
   COMMENT ON COLUMN "SCOTT"."T_SAMPLE"."S_ODATE" IS '������';
   COMMENT ON TABLE "SCOTT"."T_SAMPLE"  IS '����';
REM INSERTING into SCOTT.T_SAMPLE
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index PK_T_SAMPLE
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCOTT"."PK_T_SAMPLE" ON "SCOTT"."T_SAMPLE" ("S_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table T_SAMPLE
--------------------------------------------------------

  ALTER TABLE "SCOTT"."T_SAMPLE" ADD CONSTRAINT "PK_T_SAMPLE" PRIMARY KEY ("S_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "SCOTT"."T_SAMPLE" MODIFY ("S_ID" NOT NULL ENABLE);
  
  SELECT * FROM t_sample;
  ---------------------------------------------------------
  T_MEMBER ȸ��
  T_POLL ����
  T_POLLSUB �����׸�
  T_VOTER ��ǥ
  -----------------------------------
  ȸ��
  1. ȸ�� ����/Ż��/����
CREATE SEQUENCE seq_member
INCREMENT BY 1
START WITH 1
MAXVALUE 9999
NOCACHE;
  
  
 INSERT INTO T_MEMBER ( MemberSeq, MemberID, MemberPasswd, MemberName,MemberPhone, MemberAddress  )
VALUES  (seq_member.nextval, 'admin','1234','������','010-1111-1111','���� ������');
   INSERT INTO T_MEMBER ( MemberSeq, MemberID, MemberPasswd, MemberName,MemberPhone, MemberAddress  )
VALUES  (seq_member.nextval, 'hong','1234','ȫ�浿','010-2222-2222','��⵵ ������');
 INSERT INTO T_MEMBER ( MemberSeq, MemberID, MemberPasswd, MemberName,MemberPhone, MemberAddress  )
VALUES  (seq_member.nextval, 'kim','1234','����','010-3333-3333','���� ��õ��');
  
  SELECT *
  FROM t_member;
  
  2. �������(�ۼ�)/ ����/ ����
CREATE SEQUENCE seq_poll;
--Sequence SEQ_POLL��(��) �����Ǿ����ϴ�.
INSERT INTO T_POLL (PollSeq,Question,SDate, EDAte , ItemCount,PollTotal, RegDate, MemberSEQ )  
  VALUES (seq_poll.nextval, '�����ϴ� �����?'
           ,TO_DATE('2022-03-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
           ,TO_DATE('2022-03-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
           ,5
           ,0
           ,TO_DATE('2022-02-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
           ,1
           );
INSERT INTO T_POLL (PollSeq,Question,SDate, EDAte , ItemCount,PollTotal, RegDate, MemberSEQ )  
  VALUES (seq_poll.nextval, '�����ϴ� ����?'
           ,TO_DATE('2022-04-20 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
           ,TO_DATE('2022-05-01 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
           ,4
           ,0
           ,TO_DATE('2022-04-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
           ,1
           );
 INSERT INTO T_POLL (PollSeq,Question,SDate, EDAte , ItemCount,PollTotal, RegDate, MemberSEQ )  
  VALUES (seq_poll.nextval, '5��5�� �ް� ����?'
           ,TO_DATE('2022-05-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
           ,TO_DATE('2022-05-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
           ,2
           ,0
           ,SYSDATE
           ,1
           );          
 COMMIT; 
 
 SELECT * FROM t_poll;
 
 --�����׸� �߰� ���� �ۼ�
 CREATE SEQUENCE seq_pollsub;
INSERT INTO T_PollSub (PollSubSeq , Answer , ACount , PollSeq  )  
VALUES  (seq_pollsub.nextval,'�载��',0,1 );
INSERT INTO T_PollSub (PollSubSeq , Answer , ACount , PollSeq  )  
VALUES  (seq_pollsub.nextval,'�����',0,1 );
INSERT INTO T_PollSub (PollSubSeq , Answer , ACount , PollSeq  )  
VALUES  (seq_pollsub.nextval,'������',0,1 );
INSERT INTO T_PollSub (PollSubSeq , Answer , ACount , PollSeq  )  
VALUES  (seq_pollsub.nextval,'�輱��',0,1 );

INSERT INTO T_PollSub (PollSubSeq , Answer , ACount , PollSeq  )  
VALUES  (seq_pollsub.nextval,'����',0,2 );
INSERT INTO T_PollSub (PollSubSeq , Answer , ACount , PollSeq  )  
VALUES  (seq_pollsub.nextval,'����',0,2 );
INSERT INTO T_PollSub (PollSubSeq , Answer , ACount , PollSeq  )  
VALUES  (seq_pollsub.nextval,'����',0,2 );
INSERT INTO T_PollSub (PollSubSeq , Answer , ACount , PollSeq  )  
VALUES  (seq_pollsub.nextval,'��ȸ',0,2 );
INSERT INTO T_PollSub (PollSubSeq , Answer , ACount , PollSeq  )  
VALUES  (seq_pollsub.nextval,'����',0,2 );

INSERT INTO T_PollSub (PollSubSeq , Answer , ACount , PollSeq  )  
VALUES  (seq_pollsub.nextval,'����',0,3 );
INSERT INTO T_PollSub (PollSubSeq , Answer , ACount , PollSeq  )  
VALUES  (seq_pollsub.nextval,'�ݴ�',0,3 );

COMMIT;

SELECT * FROM t_pollsub;
  3. ���� ��� ������ = ����
--��ȣ/ ����/ �ۼ���/ ������/������/�׸��/�����ڼ�/����

SELECT pollseq, question, membername, sDate, edate
  , itemcount, polltotal
  , CASE
      WHEN SYSDATE > edate  THEN '����'
      WHEN SYSDATE BETWEEN sdate AND edate  THEN '������'
      ELSE '������'
    END   state
FROM t_poll p JOIN t_member m ON p.memberseq = m.memberseq;

  4. ���� ��ǥ/ ����. ���
CREATE SEQUENCE seq_vector;
--1
INSERT INTO t_voter (VectorSeq , UserName,RegDate, PollSeq,PollSubSeq, MemberSeq)   
  VALUES (seq_vector.nextval, 'ȫ�浿', SYSDATE,1,3 ,2);
--2
UPDATE t_poll
SET polltotal = polltotal+1
WHERE pollseq = 1;
--3
UPDATE t_pollsub
SET acount = acount +1
WHERE pollsubseq =3;

--1
INSERT INTO t_voter (VectorSeq , UserName,RegDate, PollSeq,PollSubSeq, MemberSeq)   
  VALUES (seq_vector.nextval, '����', SYSDATE,1,3 ,2);
--2
UPDATE t_poll
SET polltotal = polltotal+1
WHERE pollseq = 1;
--3
UPDATE t_pollsub
SET acount = acount +1
WHERE pollsubseq =3;

--1
INSERT INTO t_voter (VectorSeq , UserName,RegDate, PollSeq,PollSubSeq, MemberSeq)   
  VALUES (seq_vector.nextval, '������', SYSDATE,1,2 ,2);
--2
UPDATE t_poll
SET polltotal = polltotal+1
WHERE pollseq = 1;
--3
UPDATE t_pollsub
SET acount = acount +1
WHERE pollsubseq =2;


SELECT * FROM t_voter;
SELECT * FROM t_poll;
SELECT * FROM t_pollsub;
COMMIT;
  5. ������ǥ �������
 --1
 SELECT COUNT(*)
 FROM t_voter
 WHERE pollseq =1;
  --1-2.�����ڼ�
SELECT polltotal
FROM t_poll
WHERE pollseq =1;

----
SELECT question, answer
    ,RPAD(' ',v+1,'#') ||acount || '(' || v||')'
FROM (
SELECT question, answer, acount, polltotal
       , ROUND( acount/polltotal *100)v
FROM t_pollsub s JOIN t_poll p ON s.pollseq = p.pollseq
WHERE p.pollseq=1
)t;
  
  ---����, ����, ���� ��
DECLARE
  vname varchar2(20);
  vage number(3) :=20;
BEGIN
  vname := 'ȫ�浿';
  vage :=20;
  
  DBMS_OUTPUT.PUT_LINE(vname || ','||vage);
--EXCEPTION
  --����ó��
END;
------------------
����) 10�� �μ��� �߿� �޿��� ���� ���� �޴� ����� ������ ����ϴ� �͸����ν��� �����
 empno, deptno, ename, job, mgr, hiredate, pay(sal+comm)
 
 SELECT empno,deptno, ename,job, mgr, hiredate,pay
 FROM (
         SELECT empno, e.deptno, ename, job, mgr, hiredate, sal+NVL(comm,0)pay
            ,rank() over (order by sal+NVL(comm,0)DESC) r
 FROM emp e JOIN dept d ON e.deptno= d.deptno
 WHERE d.deptno=10
 )t
 WHERE t.r=1;
 -----------------
 SELECT empno, deptno, ename, job, mgr, hiredate, sal+NVL(comm,0)pay
 FROM emp
 WHERE deptno=10 AND sal+NVL(comm,0) = (
 SELECT MAX(sal+NVL(comm,0) )maxpay
 FROM emp
  WHERE deptno=10
 );
 -----------------
 
DECLARE
  vname varchar2(20);
  vage number(3) :=20;
BEGIN
  vname := 'ȫ�浿';
  vage :=20;
  
  DBMS_OUTPUT.PUT_LINE(vname || ','||vage);
--EXCEPTION
  --����ó��
END;
 
 
 -----
 DECLARE
   vempno NUMBER(4);
   vdeptno NUMBER(2);
   vename emp.ename%TYPE; --Ÿ���� ����
   vjob emp.job%TYPE;
   vmgr emp.mgr%TYPE;
   vhiredate emp.hiredate%TYPE;
   vpay NUMBER;
 BEGIN
    SELECT empno, deptno, ename, job, mgr, hiredate, sal+NVL(comm,0)pay
       INTO vempno, vdeptno, vename, vjob, vmgr, vhiredate, vpay
 FROM emp
 WHERE deptno=10 AND sal+NVL(comm,0) = (
                                     SELECT MAX(sal+NVL(comm,0) )maxpay
                                     FROM emp
                                      WHERE deptno=10);
 DBMS_OUTPUT.PUT_LINE( vempno  || ', ' || vename  || ', ' ||  vjob  || ', ' || vmgr  || ', ' ||  vhiredate  );        
 --EXCEPTION
 END;
 
 -------------------
  DECLARE
   vempno NUMBER(4);
   vdeptno NUMBER(2);
   vename emp.ename%TYPE; --Ÿ���� ����
   vjob emp.job%TYPE;
   vmgr emp.mgr%TYPE;
   vhiredate emp.hiredate%TYPE;
   vpay NUMBER;
   
   vmax_pay NUMBER;
 BEGIN
 --1
 SELECT MAX(sal+NVL(comm,0) )INTO vmax_pay
 FROM emp
 WHERE deptno=10;
 --2
    SELECT empno, deptno, ename, job, mgr, hiredate, sal+NVL(comm,0)pay
       INTO vempno, vdeptno, vename, vjob, vmgr, vhiredate, vpay
 FROM emp
 WHERE deptno=10 AND sal+NVL(comm,0) = vmax_pay;
 DBMS_OUTPUT.PUT_LINE( vempno  || ', ' || vename  || ', ' ||  vjob  || ', ' || vmgr  || ', ' ||  vhiredate  );        
 --EXCEPTION
 END;
 -----------------------
-- emp���̺� �� ��(���ڵ�) ��ü ������ ���� ����
   DECLARE
   vemprow emp%ROWTYPE;
   vpay NUMBER;
   vmax_pay NUMBER;
 BEGIN
 --1
 SELECT MAX(sal+NVL(comm,0) )INTO vmax_pay
 FROM emp
 WHERE deptno=10;
 --2
    SELECT empno, deptno, ename, job, mgr, hiredate, sal+NVL(comm,0)pay
       INTO vemprow.empno, vemprow.deptno, vemprow.ename, vemprow.job, vemprow.mgr, vemprow.hiredate, vpay
 FROM emp
 WHERE deptno=10 AND sal+NVL(comm,0) = vmax_pay;
 DBMS_OUTPUT.PUT_LINE( vemprow.empno  || ', ' || vemprow.ename  || ', ' ||  vemprow.job  || ', ' || vemprow.mgr  || ', ' ||  vemprow.hiredate  );        
 --EXCEPTION
 END;
 
 ------------------------
 --���� ����: exact fetch returns more than requested number of rows
 -- ��û�� �ຸ�� �� ���� ���� ��ȯ�ȴ�.
 --ó������� �������� ���� ��ȯ�� ��쿡�� �ݵ�� Ŀ��cursor�� ����ؾ� �Ѵ�.
 
 DECLARE
  vename emp.ename%TYPE;
  vjob emp.job%TYPE;
 BEGIN
     SELECT ename, job --12���� ==12row(��)
       INTO vename, vjob
     FROM emp;
     --WHERE empno=7369;
     DBMS_OUTPUT.PUT_LINE(vename ||','||vjob);
 --EXCEPTION
 END;
 ----------------------
 --PL/SQL���~
-- JAVA
  if(���ǽ�) {
  }
  
--  PLSQL
      IF(���ǽ�) THEN
      IF ���ǽ� THEN  
      END IF;
  
--  JAVA
  if��
 -- PLSQL 
      IF(���ǽ�) THEN
      --
      ELSE
      --
      END IF;
 -- �ڹ�
 if() else if()~

 --PLSQL
     IF (���ǽ�) THEN
     ELSIF(���ǽ�)THEN
     ELSE
     END IF;
  -------------����) ������ �ϳ� �����ؼ� ������ �Է¹޾Ƽ� ¦��/Ȧ�� ���
  
  DECLARE
    vnum NUMBER := 0;
    vresult VARCHAR2(20);
  BEGIN
    vnum  :=         :bindNumber; --���ε�����
    IF MOD((vnum),2)=0 THEN 
       vresult := '¦��';
    ELSE
       vresult := 'Ȧ��';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(vresult);
  --EXCEPTION
  END;
  
  ---------------
  --�������� �Է¹޾� ����̾簡 ����ϴ� �͸����ν��� �ۼ��ϱ�
  
  DECLARE
    vkor NUMBER(3) := 0; 
    vgrade VARCHAR2(3);
  BEGIN
     vkor :=  :bindKor;
     
     IF vkor >=90 THEN
        vgrade := '��';
     ELSIF vkor >=80 THEN
         vgrade := '��';
     ELSIF vkor >=70 THEN
        vgrade := '��';
     ELSIF vkor >=60 THEN
        vgrade := '��';
     ELSE 
         vgrade := '��';
     END IF;
     
     DBMS_OUTPUT.PUT_LINE(vgrade);
  --EXCEPTION
  END;
  --------------------
    DECLARE
    vkor NUMBER(3) := 0; 
    vgrade VARCHAR2(3);
  BEGIN
     vkor :=  :bindKor;
     
     vkor := TRUNC(vkor/10);
     
    CASE vkor
      WHEN 10 THEN vgrade :='��';
      WHEN 9 THEN vgrade :='��';
      WHEN 8 THEN vgrade :='��';
      WHEN 7 THEN vgrade :='��';
      WHEN 6 THEN vgrade :='��';
      ELSE vgrade :='��';
      END CASE;
     
     DBMS_OUTPUT.PUT_LINE(vgrade);
  --EXCEPTION
  END;
  
  ----PL/SQL FOR��
  
FOR counter���� IN [REVERSE] ���۰�,, ����
LOOP
  //�ݺ�ó���� �ڵ�
END LOOP;

FOR   IN ����.. ��
LOOP
END LOOP;

--------����. 1-10 ������ ��
DECLARE
   vi NUMBER;
   vsum NUMBER := 0;
BEGIN
  FOR  vi IN 1..10
  LOOP
    vsum := vsum + vi;
    IF vi=10 THEN dbms_output.put(vi);
    ELSE dbms_output.put(vi || '+');
    END IF;
    
  END LOOP;
   dbms_output.put_line('=' || vsum);
--EXCEPTION
END;
--------------------
--���Ǹ����� ������ �ƴϸ� ���ѷ���
LOOP

   EXIT WHEN ���� --break
END LOOP;
--------------------
--������ ���ϵ��� ���� �ݺ�
WHILE (����)
LOOP

END LOOP;
------------------
--1~10 ���� ���� ���
1) LOOP END LOOP;��

DECLARE
  vi NUMBER :=1;
  vsum NUMBER :=0;
BEGIN

   LOOP 
        EXIT WHEN (vi =11);
        dbms_output.put(vi || '+');
        vsum := vsum+vi;
        vi := vi+1;
   END LOOP;
         dbms_output.put_line('=' || vsum);
--EXCEPTION
END;


2) WHIL ELOOP END LOOP; ��

DECLARE
  vi NUMBER :=1;
  vsum NUMBER :=0;
BEGIN
   WHILE(vi <=10)
   LOOP 
        dbms_output.put(vi || '+');
        vsum := vsum+vi;
        vi := vi+1;
   END LOOP;
         dbms_output.put_line('=' || vsum);
--EXCEPTION
END;
-------------
���� : ������ ���
--1) for 2 ��
DECLARE
  --vi NUMBER(1) :=1;  --FOR���� ���Ǵ� �ݺ������� �������� �ʾƵ� ��
  --vdan NUMBER(1) :=1;
BEGIN
   
   FOR vdan IN 2..9
   LOOP
       FOR  vi  IN 1..9
       LOOP
       dbms_output.put( vdan || '*' || vi ||'='|| RPAD(vdan*vi, 4,' ') );   
       END LOOP;
       DBMS_OUTPUT.PUT_LINE('');
    END LOOP;

--EXCEPTION
END;

2) while 2��

DECLARE
  vdan NUMBER(2):=2 ;
  vi NUMBER(2) := 1 ;
BEGIN
   WHILE (vdan <= 9)
   LOOP
      vi  := 1;  -- *****
      WHILE( vi <= 9)
      LOOP
          DBMS_OUTPUT.PUT( vdan || '*' || vi || '=' || RPAD( vdan*vi, 4, ' ' ) );
          vi := vi + 1;
      END LOOP;
      DBMS_OUTPUT.PUT_LINE('');
      
      vdan := vdan + 1;
   END LOOP; 
--EXCEPTION
END;
---------------------
record �� ���� ����

emp/ dept ����
 deptno, dname, empno,ename
 
 SELECT d.deptno, dname, empno, ename,sal+NVL(comm,0) pay
 FROM emp e JOIN dept d ON e.deptno = d.deptno
 WHERE empno = 7369;
-------------------------------------
  1)
 DECLARE
    vdeptno dept.deptno%TYPE;
    vdname  dept.dname%TYPE;
    vempno  emp.empno%TYPE;
    vename emp.ename%TYPE;
    vpay NUMBER;
 BEGIN
         SELECT d.deptno, dname, empno, ename,sal+NVL(comm,0) pay
           INTO vdeptno, vdname, vempno, vename,vpay
         FROM emp e JOIN dept d ON e.deptno = d.deptno
         WHERE empno = 7369;  
         
         DBMS_OUTPUT.PUT_LINE(vdeptno ||','||vdname ||','||vempno||','||vename||','||vpay);
 --EXCEPTION
 END;
----------------------------------
 2) %ROWTYPW�� ���� ����
 
 DECLARE
 
   vdrow dept%ROWTYPE;
   verow emp%ROWTYPE;
    
    vpay NUMBER;
 BEGIN
         SELECT d.deptno, dname, empno, ename,sal+NVL(comm,0) pay
           INTO vdrow.deptno, vdrow.dname, verow.empno, verow.ename,vpay
         FROM emp e JOIN dept d ON e.deptno = d.deptno
         WHERE empno = 7369;  
         
         DBMS_OUTPUT.PUT_LINE(vdrow.deptno ||','||vdrow.dname ||','||verow.empno||','||verow.ename||','||vpay);
 --EXCEPTION
 END;
-------------------------------------------------
--3. ���ڵ��� ����
DECLARE
     --����� ���� �ڷ���
     TYPE EmpDeptType IS RECORD
     (
     vdeptno dept.deptno%TYPE,
     vdname  dept.dname%TYPE,
     vempno  emp.empno%TYPE,
     vename emp.ename%TYPE,
     vpay NUMBER
     );
     vrow EmpDeptType; --RECORD�� ���� ����
 BEGIN
         SELECT d.deptno, dname, empno, ename,sal+NVL(comm,0) pay
           INTO vrow.vdeptno, vrow.vdname, vrow.vempno, vrow.vename, vrow.vpay
         FROM emp e JOIN dept d ON e.deptno = d.deptno
         WHERE empno = 7369;  
         
         DBMS_OUTPUT.PUT_LINE(vrow.vdeptno ||','||vrow.vdname ||','||vrow.vempno||','||vrow.vename||','||vrow.vpay);
 --EXCEPTION
 END;
-- Encountered the symbol "JOIN" when expecting one of the following:
------------
--Ŀ��?
1. PL/SQL �� ������ ����Ǵ� SELECT ���� �ǹ�
2.�������� ���ڵ带 ó���ϱ� ���ؼ� Ŀ�� CURSOR ����ؾ��Ѵ�
3. Ŀ���� 2���� ����
   ��. implicit cursor ������(�Ͻ���, �ڵ�) Ŀ��
   
DECLARE 
   --vrow
BEGIN
   FOR vrow IN (SELECT empno, ename, job FROM emp)
   LOOP
     DBMS_OUTPUT.PUT_LINE( vrow.empno ||','|| vrow.ename ||','|| vrow.job);
   END LOOP;
--EXCEPTION
END;

��. explicit cursor ����� Ŀ��
  1) Ŀ������
  2) Ŀ�� open
  3) LOOP
     --ó�� FETCH ��������
     EXIT WHEN Ŀ�� ���� ���� ���� �� ���� 
     END LOOP;
  4) Ŀ�� CLOSE
��. -> �������� �� �������� ������ Ŀ�� ��� ��������.
DECLARE
     vename emp.ename%TYPE;
     vsal emp.sal%TYPE;
     vhiredate emp.hiredate%TYPE;
BEGIN
  SELECT ename, sal, hiredate
     IN vename, vsal, vhiredate
  FROM emp
  WHERE deptno =30;

  DBMS_OUTPUT.PUT_LINE(vename||','||vsal||','||vhiredate);

--EXCEPTION
END;
---------------
Ŀ�� ����ϱ�
--1. Ŀ�� ����
DECLARE
     vename emp.ename%TYPE;
     vsal emp.sal%TYPE;
     vhiredate emp.hiredate%TYPE;
 CURSOR emp30_cursor IS  (
                    SELECT ename, sal, hiredate
                    FROM emp
                    WHERE deptno =30
                    );
BEGIN
  --2.OPEN
  --OPEN Ŀ����
  OPEN emp30_cursor;
  --3.LOOP ~ FETCH (�ݺ������� �������� �۾�)
  LOOP
    FETCH emp30_cursor INTO vename, vsal, vhiredate;
    DBMS_OUTPUT.PUT_LINE(vename||','||vsal||','||vhiredate);
   --EXIT WHEN emp30_cursor%NOTFOUND;
   EXIT WHEN emp30_cursor%NOTFOUND OR emp30_cursor%ROWCOUNT >=3;
  END LOOP;
   --4. CLOSE
   --CLOSE Ŀ����
   CLOSE emp30_cursor;
--EXCEPTION
END;
-----------------------------------
--�Ͻ��� Ŀ�� ��� ���� �м�
   
DECLARE 
   --vrow
   CURSOR emp_cursor is (SELECT empno, ename, job FROM emp);
BEGIN
   FOR vrow IN emp_cursor
   LOOP
     DBMS_OUTPUT.PUT_LINE( vrow.empno ||','|| vrow.ename ||','|| vrow.job);
   END LOOP;
--EXCEPTION
END;

------------------------------------
--WHERE CURRENT OF ��
--stored procedure ���� ���ν��� PL/SQL/6���� ���� �� 2��°
1. PL/SQL/ 6���� ���� �߿� ���� ��ǥ���� ����
2. �����ڰ� ���� �����ؾ��ϴ� ������ �� ������ ���� �̸� �ۼ��ϰ�
   ������ ���̽� ���� �����صξ��ٰ� �ʿ��Ҷ����� ȣ���ؼ� ����� �� �ִ�
3. ���� ���ν��� ���� ����
CREATE OR REPLACE PROCEDURE ���ν�����
(             �Է¿�/��¿�/
  p�Ķ���� MODE(IN/OUT/INOUT) �ڷ���(ũ�⼳��x),
  p�Ķ���� MODE(IN/OUT/INOUT) �ڷ���,
  p�Ķ���� MODE(IN/OUT/INOUT) �ڷ���
)
IS
  --����
BEGIN
  --����
EXCEPTION
  --����ó��
END;
4. ���� ���ν��� ����ϴ� ���
  ��. execute �� ����
  ��. �� �ٸ� ���� ���ν����ȿ��� ȣ���ؼ� ����
  ��. �͸� ���ν��� ȣ��
5. ��  user procedure ==up
CREATE OR REPLACE PROCEDURE up_delDept
( --�Է¿� �Ķ����
  pdeptno IN NUMBER
)
 IS
 
 BEGIN
   DELETE FROM dept
   WHERE deptno= pdeptno;
   
 -- COMMIT; ó���ؾ� ����� ó����.
-- EXCEPTION
 END up_delDept;

SELECT * FROM dept;

1. �͸����ν���
--DECLARE
BEGIN
  up_delDept(40);
--EXCEPTION
END;
2.EXECUTE�� ����
EXECUTE up_delDept(40);


------------------
�� �������ν��� �����Լ�
ȭ Ʈ���� ��Ű��
�� ��������
�� ��ȣȭ
�� Ʈ������