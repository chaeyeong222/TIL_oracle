�����𵨸�
         
         5) ����ȭ(Normal Form)����
           ��. ��1����ȭ(1NF) : 
                    �����̼ǿ� ���� ��� �Ӽ��� ������(�÷���)�� 
                    ���� ��(atomic value=�ߺ�X)���θ� �����Ǿ� ������ ��1�������� ���Ѵ�.
                    �ݺ��Ǵ� �Ӽ��� ������ �� �⺻ ���̺��� �⺻Ű�� �߰��� ���ο� ���̺��� �����Ѵ�.
           ��. ��2����ȭ(2NF) : 
              - �κ��Լ��� ���Ӽ� �����ؼ� ���� �Լ� ����
              - ��� �÷�(�Ӽ�)�� ����Ű ��ü�� �������̾�� �Ѵ�.
              
              -�Լ��� ���Ӽ�
                dept     X(deptno) Y(dname)
                          ������      ������
               Y�� X�� �Լ��� �����̴�
               X->Y
              -���� �Լ��� ���Ӽ�
              -�κ� �Լ��� ���Ӽ�
                ����) ����Ű(X+Y)�� ��ü������ �������� �ʴ� �Ӽ�
                
               ��) �а���� ���̺�
                 PK -> [�й� + �����ڵ� ]����Ű
                  
                 �й�  �����ڵ�  ���ڵ�  ������  �����Ⱓ
                 100   A001        A    JAVA    1����
                 100   A002        F    ASP     3����
                 101   A001        A    JAVA    1����
                 101   A003        C      C#    1����
                 102   A001        A    JAVA    1����
                  =>������� �����Ⱓ�� ����Ű�� ���������� �ʰ�, �����ڵ� �Ӽ��� �κ��Լ��� ���Ӽ��� �ִ�.
                  =>������, �����Ⱓ �Ӽ� ����( �κ��Լ��� ���Ӽ� ����) -> ��2����ȭ -> ���ο� ���̺� ����
                  
                 ���)
                  PK -> [�й� + �����ڵ� ]����Ű
                 �й�  �����ڵ�  ���ڵ�  
                 100   A001        A   
                 100   A002        F  
                 101   A001        A    
                 101   A003        C   
                 102   A001        A   
                  
                  PK
                 �����ڵ�   ������  �����Ⱓ
                  A001     JAVA      1����
                  A002     ASP       3����
                  A001     JAVA      1����
                  A003      C#       1����
                  A001     JAVA      1����
                  
              -���� �Լ��� ���Ӽ�
              
           ��. ��3����ȭ(3NF) : 
              ���� �Լ��� ���Ӽ� ����
               X    ->  Y
               ������  ������
               Y   -> Z (Z�� �Ϲ�Į����Y�� �������ϰ�� ����)
               
               ��.
               ������̺�
               PK
               empno(x) ename(y)  deptno(z)  dname(k)
               7369      ȫ�浿       10       ������
               
               X -> Y
               X -> Z
               z -> k (������ �Լ� ����)
               
               xyz�� ������̺� �ΰ� zk�� �μ����̺��� ���� �����ؼ� �д�
               
               
           ��. BCNF :(���̽�/�ڵ� ������[ Boyce/Codd Normal Form ])
             - �����̼� R�� ��3����ȭ�� �����ϰ�, ��� �����ڰ� �ĺ�Ű �����Ѵٴ� ��.
             -��3����ȭ�� �����ϴ� ��κ��� �����̼�(���̺�)�� BCNF�� �����Ѵ�.
             
             [X+Y] ����Ű
             
             Z->Y ����Ű ���� �� �Ӽ��� �Ϲ�Ű�� ����..
             
           ��. ��4����ȭ(4NF) : 
           ��. ��5����ȭ(5NF) :       
     
 ������ȭ : ���� �� ���� ��ĺ�ȭ ����� ���� -> fk�ʹ� ���Ƽ�        
 ��1����ȭ : �ߺ��� ������ ����
 ��2����ȭ : �κ��Լ��� ���Ӽ� ����
 ��3����ȭ : �������Լ����Ӽ� ����
 --------------------------------------------------------------
 [������ �𵨸�]
  - ���� �𵨸� : ���� ��Ű�� + ����ȭ
  - �� �� ȿ�������� �����ϱ� ���� �۾��� �Բ� �����Ϸ��� DBMS�� Ư���� �°� 
    ���� �����ͺ��̽� ���� ��ü���� �����ϴ� �ܰ�
  - ������ ��뷮 �м�, ���� ���μ��� �м��� ���ؼ� ���� ȿ������ �����ͺ��̽��� �ǵ���
    �ε��� ���, ������ȭ�� ����
  --------------------------------------------------------------
  --�� VIEW
FROM ���̺� �� �Ǵ� ���
FROM             user_tables;

1. ���̺�(��)�� ���� ���� â�� :�� VIEW
2. ���� �ǹ̴� �ϳ��� select ���� ����
   select deptno, ename
   from emp
   where deptno=10;
3. �並 ���� insert, update, delete �� ���������� ��κ��� select �� ���� ���
4. ��� �������̺��̴�
5. ��� �Ѱ� �̻��� ���̺� -> �� ����
         �� �ٸ� ��      -> �����
6. ���� : �Ϻθ� ������ �� �ֵ��� �����ϱ� ���� ���, ���ȼ�+����
7. �� �����Ѵٴ� �ǹ� : ������ ��ųʸ�(�ڷ����) ���̺� �信 ���� ���Ǹ� ����ǰ�
                     ��ũ�� ��������� �Ҵ���� �ʴ´�
    ��. user_Tables ��-> ���� -> �ڷ����
8. �並 ����ؼ� DML + �������� ������ �����ϴ�
9. ���� ����
   ��. ���ú� simple view   - 1�� ���̺� ����
   ��. ���պ� complex view  - ������ ���̺� ����
10. �� ����
�����ġ�
	CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���̸�
		[(alias[,alias]...]
	AS subquery
	[WITH CHECK OPTION]
	[WITH READ ONLY];

���⼭ ������ �ɼ��� �ǹ̴� ������ ����.
�ɼ� �� �� 
OR REPLACE ���� �̸��� �䰡 ���� ��� �����ϰ� �ٽ� ���� 
FORCE �⺻ ���̺��� ������ ������� �並 ���� 
NOFORCE �⺻ ���̺��� ���� ���� �並 ���� 
ALIAS �⺻ ���̺��� �÷��̸��� �ٸ��� ������ ���� �÷��� �ο� 
WITH CHECK OPTION �信 ���� access�� �� �ִ� ��(row)���� ����, ���� ���� 
WITH READ ONLY -- DML �۾��� ����(���� �д� �͸� ����) 

   ����) �츮�� ����� �Ǹŷ��� Ȯ���ϴ� ���� ����
   SELECT b.b_id, title, price, g.g_id, g_name, p_date, p_su
   FROM book b JOIN danga d ON b.b_id =d.b_id
               JOIN panmai p ON p.b_id =b.b_id
               JOIN gogaek g ON g.g_id =p.g_id;
   
--�� ����
--panView �� ������ �����ϰ� ������ �����Ѵ�.
--���� ���� -
--ORA-01031: insufficient privileges ������ ��� �� ���� �Ұ�. scott ������ view ��������x
--scott�������� -> �α���x -> ���� �ο�
CREATE OR REPLACE VIEW panView 
         (bookid, booktitle, bookdanga, gogaekid, gogaekname, pdate, p_su) 
AS 
   SELECT b.b_id, title, price, g.g_id, g_name, p_date , p_su
   FROM book b JOIN danga d ON b.b_id =d.b_id
               JOIN panmai p ON p.b_id =b.b_id
               JOIN gogaek g ON g.g_id =p.g_id;
   
 -- View PANVIEW��(��) �����Ǿ����ϴ�.
 --������ �� ���
 SELECT *
 FROM PANVIEW;
 --View PANVIEW��(��) �����Ǿ����ϴ�.
 
 --���� Ȯ��
 SELECT *
 FROM user_sys_privs;
 
 DESC PANVIEW;
 �̸�         ��?       ����            
---------- -------- ------------- 
BOOKID     NOT NULL VARCHAR2(10)  
BOOKTITLE  NOT NULL VARCHAR2(100) 
BOOKDANGA  NOT NULL NUMBER(7)     
GOGAEKID   NOT NULL NUMBER(5)     
GOGAEKNAME NOT NULL VARCHAR2(20)  
PDATE               DATE    
 --�� �ҽ� Ȯ�� 
 SELECT *
 FROM user_views
 WHERE view_name = 'PANVIEW';
 
 --�並����ؼ� ��ü�Ǹűݾ� ��������
 SELECT sum(p_su * bookdanga) ��ü�Ǹűݾ�
 FROM panview;
--����) �� ���� gogaekView
--�⵵, ��, ���ڵ�, ����, �Ǹűݾ���(�⵵, �� ��) ����ϱ�
 panmai - p_date
 gogaek - g_id, g_name, 
 danga - price,
 
    
  CREATE OR REPLACE VIEW gogaekView
     AS 
        SELECT TO_CHAR(p_date, 'YYYY')year,TO_CHAR(p_date, 'MM')month
                ,g.g_id, g_name, SUM(p_su * price)amt
        FROM panmai p JOIN danga d ON p.b_id=d.b_id
                      JOIN gogaek g ON p.g_id=g.g_id
        GROUP BY TO_CHAR(p_date, 'YYYY'),TO_CHAR(p_date, 'MM'),g_name,g.g_id
        ORDER BY TO_CHAR(p_date, 'YYYY'),TO_CHAR(p_date, 'MM');
 � �� �ִ� �� Ȯ��
 SELECT *
 FROM user_views;
 
 -- [�並 ����ؼ� DML �۾�]
 
 
 CREATE TABLE testa(
  aid        number primary key
  , name    varchar2(20) not null
  , tel    varchar2(20) not null
  , memo   varchar2(100)
);       
 
CREATE TABLE testb(
   bid  number primary key
   , aid  number constraint fk_testb_aid references testa(aid) on delete cascade
   , score number(3)
); 

INSERT INTO testa (aid, NAME, tel) VALUES (1, 'a', '1');
INSERT INTO testa (aid, name, tel) VALUES (2, 'b', '2');
INSERT INTO testa (aid, name, tel) VALUES (3, 'c', '3');
INSERT INTO testa (aid, name, tel) VALUES (4, 'd', '4');

INSERT INTO testb (bid, aid, score) VALUES (1, 1, 80);
INSERT INTO testb (bid, aid, score) VALUES (2, 2, 70);
INSERT INTO testb (bid, aid, score) VALUES (3, 3, 90);
INSERT INTO testb (bid, aid, score) VALUES (4, 4, 100);

SELECT * FROM testa;
1	a	1	
2	b	2	
3	c	3	
4	d	4	

SELECT * FROM testb;
1	1	80
2	2	70
3	3	90
4	4	100
----- ���ú�
CREATE OR REPLACE VIEW aView
AS
 SELECT aid, name, memo --tel �÷�x
 FROM testa;
 --View AVIEW��(��) �����Ǿ����ϴ�.
 
 SELECT * 
 FROM aView;
 --aView (����)�並 ����ؼ� insert �۾�
 INSERT INTO aView(aid, name, memo) VALUES (5,'f',null);
 --���� ���� -
--ORA-01400: cannot insert NULL into ("SCOTT"."TESTA"."TEL")
--tel�� �ڵ����� null �����Ƿ� ��������

CREATE OR REPLACE VIEW aView
AS
 SELECT aid, name, tel
 FROM testa;
 --View AVIEW��(��) �����Ǿ����ϴ�.
  INSERT INTO aView(aid, name, tel) VALUES (5,'f','5');
  --1 �� ��(��) ���ԵǾ����ϴ�.
commit;

select *
from testa;

1	a	1	
2	b	2	
3	c	3	
4	d	4	
5	f	5	 --insert��..

--���պ� abView
CREATE OR REPLACE VIEW abView
AS
  SELECT a.aid, name, tel, bid, score
  FROM testa a JOIN testb b ON a.aid=b.aid;
  WITH READ ONLY; --SELECT�� �ϰڴ�,INSERT, UPDATE, DELETE�Ұ���
-----
SELECT *
FROM abView;

INSERT INTO abView( aid, name, tel, bid, score) VALUES ( 10,'X','5',20,70);
--������, �ϳ��� INSERT ������ ���ÿ� �� ���̺� INSERT�� �� ����.

--���� 1���̺� ����
UPDATE abView
SET score = 99
where bid=1;
rollback;
--�� ���̺� ������ ����
DELETE FROM abView
WHERE aid=1;
rollback;

--�����
DROP VIEW abview;
DROP VIEW panview;
-----------��� �� ������------
WITH CHECK OPTION �信 ���� access�� �� �ִ� ��(row)���� ����, ���� ���� 
-----------
CREATE OR REPLACE VIEW bView
AS
 SELECT bid, aid, score
 FROM testb
 WHERE score >=90;
bid aid score
3	3	90
4	4	100
 
 
 SELECT *
 FROM bView;

--���� bid=3, score =70
UPDATE bView
SET SCORE=70
WHERE bid=3;
rollback;

--bView + with check option
CREATE OR REPLACE VIEW bView
AS
 SELECT bid, aid, score
 FROM testb
 WHERE score >=90
WITH CHECK OPTION CONSTRAINT ck_bview;
--View BVIEW��(��) �����Ǿ����ϴ�.

update�Ϸ��ϱ� ������
���� ���� -
ORA-01402: view WITH CHECK OPTION where-clause violation
--view�� 90�� �̻��� �ָ� ���������� �����س��� ������
--70������ ������ ���� ����=> view�� ������ �� ���⶧��

INSERT INTO bView(bid,aid, score) VALUES (5,4,100);
--1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO bView(bid,aid, score) VALUES (6,4,87);
--���� ���� -
--ORA-01402: view WITH CHECK OPTION where-clause violation
--90������ ���� �ִ� ���ԺҰ�
ROLLBACK;
--��? �������̺�, �������̺� ���ȼ�, ���� -> SELECT, ���ú�, ���պ�

--��������(MATERIALIZED VIEW)
--���� ���������� �����͸� �����ϰ� �ִ� ��

--[������ SEQUENCE]
������ ���̺� ���� �⺻ŰPK�� ����ũ ŰUK�� ����Ͽ� 
�ΰ��ϴ� ������ ���ο� �÷�ó�� ����� �� �ִ� 
[�Ϸù�ȣ�� �ű�]�ϱ� ���� �ϳ��� �÷����� ������ ���̺�

INCREMENT BY ���� ������ ��ȣ�� ������ŭ�� ����(����Ʈ=1) 
START WITH ���� ���۰��� ����(����Ʈ=1) cycle �ɼ��� ����� ��� �ٽ� ���� ������ �� minvalue�� ������ ������ ���� 
MAXVALUE ���� ������ �� �ִ� �ִ밪 
NOMAXVALUE(default) �������� �ִ밪�� ������ ����, ���������� 10^27���� Ŀ�� �� �ְ�, ������������ 1���� �۾��� �� ���� 
MINVALUE ���� ������ �� �ִ� �ּҰ� 
NOMINVALUE(default) �������� �ּҰ��� ������ ����, ���������� �ּ� 1����, ������������ -(10^26)���� ����. 
CYCLE �ִ� �Ǵ� �ּҰ��� ������ �� ���� �ٽ� ���� 
NOCYCLE(default) �ִ� �Ǵ� �ּҰ��� ������ �� ���� �ٽ� ������� �� ���� 
CACHE ���� access�� ���� �������� ���� �޸𸮿� ����(�⺻ 20) 
NOCACHE � ���������� ĳ�̵��� ���� 

---***** �ǻ��÷��� �̿��� �������� ���
CURRVAL�� �����Ǳ� ���� NEXTVAL�� ���� ���Ǿ�� �Ѵ�. 
�̴� pseudo �÷��� CURRVAL�� ���� NEXTVAL �÷� ���� �����ϱ� �����̴�.
�׷��Ƿ� NEXTVAL �÷��� ������ ���� ���¿��� CURRVAL�� ����ϸ� 
�ƹ��� ���� ���� ������ error�� ����Ѵ�.

CREATE SEQUENCE seq01
  INCREMENT BY 1 --1������
  START WITH 100 --100����
  MAXVALUE 10000
  MINVALUE 1 
  CYCLE --10000���� ���ٰ� �ٽ� 1��(ȸ��) , NOCYCLE: �ִ񰪰��� ��
  CACHE 20; --�̸� ��ȣǥ�̾Ƽ� �ڸ��������� ����(����)
--Sequence SEQ01��(��) �����Ǿ����ϴ�.

CREATE SEQUENCE seq02;
--Sequence SEQ02��(��) �����Ǿ����ϴ�.
--������ Ȯ��
SELECT *
FROM user_sequences;
FROM user_views;
FROM user_constraints;
FROM user_tables;
--������ ����

DROP SEQUENCE seq01;
DROP SEQUENCE seq02;
-------
--������ �ٸ� ���̺� ���--
SELECT *
FROM dept;
--�μ����̺� ���ο� �μ��� �߰�
SELECT MAX(deptno)+10 FROM dept;

INSERT INTO dept (deptno, dname, loc) VALUES ((SELECT MAX(deptno)+10 FROM dept), 'QC','SEOUL');
rollback;

--������ seq_dept
CREATE SEQUENCE seq_dept
    INCREMENT BY 10
    START WITH 50
    MAXVALUE 90
    MINVALUE 10
    NOCYCLE
    NOCACHE;
--Sequence SEQ_DEPT��(��) �����Ǿ����ϴ�.

INSERT INTO dept (deptno, dname, loc) VALUES ( seq_dept.nextval, 'QC','SEOUL'||seq_dept.currval);

SELECT * FROM dept;

SELECT seq_dept.currval --���� ��ȣǥ ������� �̾Ҵ�? 60
FROM dual;

DELETE FROM dept
WHERE deptno=50; --�����ϰ��� �ٽ� 50������ ���� ����. ��ȣǥ ������ ��.

rollback;
----------------------
PL/SQL = SQLȮ�� +PL ==  Procedural Language extensions to SQL�� �ǹ�
                                �������� ����(���)
                                 ��. ��������
                                 ��. ���
                                 ��. ����ó��
-- PL/SQL�� �� ������ ����̴�
[���� ��� ��]
[���� ��� ��]
[���� ó�� ��]
 --PL/SQL ��������
 [DECLARE ��]   -- ����  ��
 BEGIN �� -- ����  ��
 [EXCEPTION] -- ���� ó��  ��
 END -- �� ��
  --*���������� CREATEST, LEAST, DECODE ��� �Ұ�
---------
DECLARE
BEGIN
EXCEPTION
END;
--PL/SQL�� 6���� ����
  1. �͸� anonymous ���ν��� procedure
  2. ���� store ���ν���
  3. ���� �Լ� stored fuction
  4. ��Ű�� package             ex. dbms_random ��Ű��
  5. Ʈ���� trigger
  6. ��üŸ�� Object Type
  
 
DBMS_OUTPUT ��Ű��
put()�Ǵ� 
put_line()  ���ǵ� ���ڰ��� ȭ�鿡 ����ϴ� ���μ��� 
NEW_LINE() GET_LINE�� ���� ���� ���� ���� ������ ���� �� ��� 
GET_LINE() �Ǵ� 
GET_LINES()  ���� ������ ���ڰ��� �д� ���μ��� 
ENABLE  ȭ�鿡 ���ڰ��� ����ϴ� ���� �����ϸ� ���ڰ��� ������ �� �ִ� ����ũ�⸦ ������ 
DISABLE  ȭ�鿡 ���ڰ��� ����ϴ� ���� ������ 

  
  ------------
-- ��.�͸����ν��� anonymous procedure ***
--�����Ҷ� �ݵ�� ����(�����Ƽ�)�� �� ����.
DECLARE 
  -- ���� declaration : ����, ��� ����
  -- ������ �ڷ���(ũ��);
  vename VARCHAR2(10);
  vsal NUMBER(7,2);
BEGIN
  -- ���๮ statements
  SELECT       ename, sal
          INTO vename, vsal
  FROM emp
  WHERE empno = 7369;
  
  --���
  DBMS_OUTPUT.PUT_LINE(vename);
  DBMS_OUTPUT.PUT_LINE(vsal);
--EXCEPTION
  -- ����ó���� try-catch
END; -- ) ��ȣ����
  
--���� ���� -
--ORA-06550: line 18, column 1:
--PLS-00103: Encountered the symbol "END" when expecting one of the following:
  --����ó���ϴ� �� �ּ�ó���ϴϱ� �ذ�
--  PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

DESC emp;

--��. �̸�/���� ������ ���� ���
DECLARE
  vname VARCHAR2(20);
  vage NUMBER(3);
BEGIN
  vname := 'ȫ�浿';
  vage := 20;
  
  DBMS_OUTPUT.PUT_LINE( vname || ',' ||vage); 
--EXCEPTION
END;
--���� ���� -
--ORA-06550: line 5, column 9:
--PLS-00103: Encountered the symbol "=" when expecting one of the following:
-- := . ( @ % ;

--30�� �μ��� ������loc �����ͼ� 10�� �μ��� loc�� ����
SELECT loc
FROM dept
WHERE deptno=30;

UPDATE dept
SET loc='CHICAGO'
WHERE deptno=10;
----------
DECLARE
   -- vloc   VARCHAR2(13)
     vloc dept.loc%TYPE; --Ÿ��������,dept���̺� loc�� �ڷ����� �����ϰ� �ְ���
     
    vdeptno
BEGIN
    SELECT loc INTO vloc
    FROM dept
    WHERE deptno=30;
    
    UPDATE dept
    SET loc='CHICAGO'
    WHERE deptno=10;
    
-- EXCEPTION
END;

SELECT * FROM dept;
DESC dept;