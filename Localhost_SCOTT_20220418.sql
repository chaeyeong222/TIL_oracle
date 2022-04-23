
1.  truncate / delete / drop ���ؼ� �����ϼ���

truncate �� ���̺� ���� ������ ���� , Ŀ���۾� ������ ��. �ѹ��� �Ұ���
delete �� ���̺� �� �ڷ���� �����Ҷ�
drop �� ���̺��� ������ �� ���


2.  insert �� ���� �� ������ ���� ������ �߻��ߴٸ� ������ ���� �����ϼ���
  ��. 00947. 00000 -  "not enough values" ���� ��������ʴ�, ������ ���� ���� ��
     -> INSERT ����  �÷��� ������ �÷��� ���� �ٸ���
  ��. ORA-00001: unique constraint (SCOTT.SYS_C007770) violated   ����Ű�� �ߺ�����Ǿ��� ��
  ��. ORA-02291: integrity constraint (SCOTT.FK_DEPTNO) violated - parent key not found
      ���Ἲ �������� ����
      �θ����̺� 10,20,30,40 �ۿ� ���µ�
      ISNERT INTO emp VALUES( 50,~~) 50�� �μ��� �ְڴٰ� �Ҷ� ����
    
3. ���������� ����ؼ� ���̺� ����
  ��. deptno, dname, empno, ename, sal+nvl(comm,0) pay, grade �÷��� ���� ���ο� ���̺� ����
  ��. ���̺�� : tbl_empdeptgrade   

CREATE TABLE tbl_empdeptgrade
AS (
SELECT deptno, dname, empno, ename, sal+nvl(comm,0) pay, grade
FROM emp e JOIN dept d ON e.deptno=d.deptno
           JOIN salgrade s ON e.sal BETWEEN S.LOSAL AND S.HISAL
) ;


4-1. insa ���̺��� num, name �����ͼ� tbl_score ���̺� ����

CREATE TABLE tbl_score
AS ( 
     SELECT num, name
     FROM insa
     );
4-2. kor, eng, mat, tot          , avg , grade, rank �÷� �߰�

ALTER TABLE tbl_score
   ADD(   kor number(3) DEFAULT 0
       ,eng number(3) DEFAULT 0
       ,mat number(3) DEFAULT 0
       ,tot NUMBER(3)
       ,avg NUMBER(5,2)
       ,grade char(1 char) 
       ,rank NUMBER
       );
  4-3. �� �л����� kor,eng,mat ���� 0~100 �����ϰ� ä���ֱ�.

UPDATE TABLE tbl_score
SET kor = TRUNC (dmbs_random.value( 0,101))
   ,eng = TRUNC (dmbs_random.value( 0,101))
  , mat = TRUNC (dmbs_random.value( 0,101))
   

4-4. ����, ���, ���, ��� ����
    ����)
     ����� ��� ������ 40���̻��̰�, ��� 60 �̻��̸� "�հ�"
           ��� 60 �̻��̶� �� �����̶� 40�� �̸��̶��  "����"
           �׿ܴ� "���հ�" �̶�� ����.
 UPDATE tbl_score
 SET avg = (kor+eng+mat)/3
             ,grade = CASE  
              WHEN kor>=40 AND eng>=40 AND mat >=40 AND avg >=60  THEN '�հ�'
              WHEN (kor<40 OR engm<40 OR mat <40 )AND avg >=40  THEN '����'
              ELSE '���հ�';
             
5.  emp ���̺��� ������ Ȯ���ϰ�, ���������� Ȯ���ϰ�, ������ ��� ������ �߰��ϴ� INSERT ���� �ۼ��ϼ���.
   ��. ����Ȯ�� ���� 
   
   desc emp;
   
   ��. �������� Ȯ�� ����
   
   SELECT *
   FROM user_constraints;
   
   ��. INSERT ���� 
   
   INSERT TABLE emp () VALUES () 
   

6-1. emp ���̺��� ������ �����ؼ� ���ο� tbl_emp10, tbl_emp20, tbl_emp30, tbl_emp40 ���̺��� �����ϼ���. 

CREATE TABLE tbl_emp10
AS SELECT * 
FROM emp
WHERE 1=0;

CREATE TABLE tbl_emp20
AS SELECT * 
FROM emp
WHERE 1=0;

CREATE TABLE tbl_emp30
AS SELECT * 
FROM emp
WHERE 1=0;

CREATE TABLE tbl_emp40
AS SELECT * 
FROM emp
WHERE 1=0;

6-2. emp ���̺��� �� �μ��� �ش��ϴ� ���������  ������ ������ ���̺� INSERT �ϴ� ������ �ۼ��ϼ���.   

INSERT ALL
 WHEN deptno =10 THEN
    INTO tbl_emp10 VALUES (�÷���)..
  WHEN deptno =20 THEN
    INTO tbl_emp20 VALUES (�÷���)..
    
    SELECT FROM emp;


7. ������ �ִ� ���� INSERT ������  INSERT ALL �� INSERT FIRST ���� ���� �������� �����ϼ���.
 
 
 INSERT ALL ��� when then ���� �����Ѵ�
 INSERT FIRST ���� ó�� ���ǿ� �´� ���� �����ϸ� �� ���� ���� �������� �ʴ´�.
 
 
 ���л��鸸 �������� 5�� ����
 
 UPDATE tbl_score 
SET eng = eng+5
WHERE num = (
            SELECT ts.num
            FROM tbl_score ts,( 
                          SELECT num, DECODE (MOD( SUBSTR(ssn, -7,1),2),0,'����') gender  
                          FROM insa)i
            WHERE ts.num = i.num AND gender IS NOT NULL) ;
            
 ANY ������ ���
 
 UPDATE tbl_score
 SET eng = eng+5
 WHERE num = ANY (
   SELECT num
   FROM insa
   WHERE MOD( SUBSTR(ssn, -7,1),2)=0 AND num <=1005
   );
   
   �������� in���δ� �ȵ�, any �� ��� ����
   ------------------------------
   ����޷�
   
   SELECT dates
        , TO_CHAR(dates, 'D') D  --1��2��3ȭ..
        , TO_CHAR(dates, 'DY') DY
        , TO_CHAR(dates, 'DAY') DAY
        
        --IW: �Ͽ����� �� �ַ� ó��
        , TO_CHAR(dates, 'IW') IW
        , CASE
             WHEN TO_CHAR(dates, 'D') =1 THEN TO_CHAR(dates, 'IW')+1
             ELSE TO_NUMBER (TO_CHAR(dates, 'IW'))
             END "IW2"
        , TO_CHAR(dates, 'WW') WW
        , TO_CHAR(dates, 'W') W  --�ش���� 1-7 �� ��
   FROM (   
   SELECT TO_DATE ( :yyyymm,'YYYYMM') +LEVEL -1 dates
   FROM dual
   CONNECT BY LEVEL <= EXTRACT(DAY FROM LAST_DAY( TO_DATE ( :yyyymm,'YYYYMM')) )
   )t;
   
   
   ----------------------------
SELECT 
      NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 1, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 2, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 3, TO_CHAR( dates, 'DD')) ), ' ')  ȭ
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 4, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 5, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 6, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 7, TO_CHAR( dates, 'DD')) ), ' ')  ��
FROM (
        SELECT TO_DATE(:yyyymm , 'YYYYMM') + LEVEL - 1  dates
        FROM dual
        CONNECT BY LEVEL <= EXTRACT ( DAY FROM LAST_DAY(TO_DATE(:yyyymm , 'YYYYMM') ) )
)  t 
GROUP BY CASE 
               -- IW �� 50�� �����鼭 "�Ͽ���"
             WHEN TO_CHAR(dates, 'MM') = 1 AND  TO_CHAR(dates, 'D') = '1' AND TO_CHAR( dates, 'IW') > '50' THEN 1
             WHEN TO_CHAR(dates, 'MM') = 1 AND TO_CHAR(dates, 'D') != '1' AND TO_CHAR( dates, 'IW') > '50' THEN 0  
             WHEN TO_CHAR( dates , 'D') = 1 THEN TO_CHAR( dates , 'IW') + 1
             ELSE TO_NUMBER( TO_CHAR( dates , 'IW') )
          END   
ORDER BY  CASE 
             WHEN TO_CHAR(dates, 'MM') = 1 AND  TO_CHAR(dates, 'D') = '1' AND TO_CHAR( dates, 'IW') > '50' THEN 1
             WHEN TO_CHAR(dates, 'MM') = 1 AND TO_CHAR(dates, 'D') != '1' AND TO_CHAR( dates, 'IW') > '50' THEN 0  
             WHEN TO_CHAR( dates , 'D') = 1 THEN TO_CHAR( dates , 'IW') + 1
             ELSE TO_NUMBER( TO_CHAR( dates , 'IW') )
            END      ;  
--------------------------
SELECT 
      NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 1, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 2, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 3, TO_CHAR( dates, 'DD')) ), ' ')  ȭ
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 4, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 5, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 6, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 7, TO_CHAR( dates, 'DD')) ), ' ')  ��
FROM (
        SELECT TO_DATE(:yyyymm , 'YYYYMM') + LEVEL - 1  dates
        FROM dual
        CONNECT BY LEVEL <= EXTRACT ( DAY FROM LAST_DAY(TO_DATE(:yyyymm , 'YYYYMM') ) )
)  t 
 GROUP BY CASE
            WHEN TO_CHAR( dates, 'D' ) < TO_CHAR( TO_DATE( :yyyymm,'YYYYMM' ), 'D' ) THEN TO_CHAR( dates, 'W' ) + 1
            ELSE TO_NUMBER( TO_CHAR( dates, 'W' ) )
        END
ORDER BY CASE
            WHEN TO_CHAR( dates, 'D' ) < TO_CHAR( TO_DATE( :yyyymm,'YYYYMM' ), 'D' ) THEN TO_CHAR( dates, 'W' ) + 1
            ELSE TO_NUMBER( TO_CHAR( dates, 'W' ) )
        END;
 
 

 
   --------------------
   LEVEL �ǻ�Į��
   ---------
   LEVEL �÷��� ����Ŭ ������ �����ϴ� �÷��̸�, 
   �ڽ��ڵ�� �θ��ڵ��� �Ӽ��� ���� ���̺��� �ش� �÷��� ���° ������ ���ϴ��� ������ �ش�.

�����������̺��� ��(row)�� LEVEL�� ����Ű�� �Ϸù�ȣ ����    
   [LEVEL �Լ�]
   
��. CONNECT_BY_ISLEAF  �� �̻� LEAF �����Ͱ� ������ 1, ������ 0�� ��ȯ 
��. CONNECT_BY_ISCYCLE  root �������̸� 1, �ƴϸ� 0�� ��ȯ 
��. CONNECT_BY_ROOT  �� �������� root���� LEVEL ���� ��ȯ 

������ ����(hierarchical query)
��. ������ ���ǹ��� ���ι��̳� �信���� ����� �� ������
��. CONNECT BY �������� �������� ���� ������ �� ����.
��. �����ġ� 
	SELECT 	[LEVEL] {*,�÷��� [alias],...}
	FROM	���̺��
	WHERE	����
	START WITH ����
	CONNECT BY [PRIOR �÷�1��  �񱳿�����  �÷�2��]
		�Ǵ� 
		   [�÷�1�� �񱳿����� PRIOR �÷�2��]
��. PRIOR�� ��ġ�� ���� TOP-DOWN ��� BOTTOM UP ������� ����

��. �׽�Ʈ
SELECT empno,ename,mgr,deptno 
FROM emp;
-----

SELECT empno, ename, mgr, LEVEL
FROM emp
--START WITH empno=7839
START WITH MGR IS NULL
CONNECT BY PRIOR empno = mgr;

TOP DOWN ��� PRIOR �ڽ�Ű= �θ�Ű
BOTTOM UP ��� PRIOR �θ�Ű =  �ڽ�Ű
   
SELECT  LPAD(' ',4*LEVEL-4) || ename
      , empno, mgr, LEVEL
      ,SYS_CONNECT_BY_PATH(ename, '/') path
      ,CONNECT_BY_ROOT ename ROOT_NODE
      ,CONNECT_BY_ISLEAF
FROM emp
--START WITH empno=7839
START WITH MGR IS NULL
CONNECT BY PRIOR empno = mgr;
   
   
--����ϴ� ��? �亯�� �Խ����� ������ �� ������ ���� ����ϸ� �ȴ�.
�Խñ� �۹�ȣ EMPNO    �θ�Խñ� ��ȣ MGR
--> �����δ� ������
--> ��? ������ ���Ǵ� DBMS ����Ŭ������ ����� �� �ֱ⶧����
--> ��� DBMS ���� ��� �Ұ�.

--��)
���̺��� dname �÷� ũ�� 20->30���� ����
create table tbl_level(
 deptno number(3) not null primary key,
 dname varchar2(20) not null,
 college number(3),
 loc varchar2(10)
 );
Table TBL_LEVEL��(��) �����Ǿ����ϴ�.

alter table tbl_level
  modify dname varchar2(30);



insert into tbl_level ( deptno, dname, college, loc ) values ( 10,'��������', null , null);

insert into tbl_level ( deptno, dname, college, loc ) values ( 100,'�����̵���к�',10, null );
insert into tbl_level ( deptno, dname, college, loc ) values ( 101,'��ǻ�Ͱ��а�',100,'1ȣ��');
insert into tbl_level ( deptno, dname, college, loc ) values ( 102,'��Ƽ�̵���а�',100,'2ȣ��');

insert into tbl_level ( deptno, dname, college, loc ) values ( 200,'��īƮ�δн��к�', 10,null);
insert into tbl_level ( deptno, dname, college, loc ) values ( 201,'���ڰ��а�',200,'3ȣ��');
insert into tbl_level ( deptno, dname, college, loc ) values ( 202,'�����а�',200,'4ȣ��');

SELECT *
FROM tbl_level;

desc tbl_level;
   
rollback;
   
SELECT LPAD ( ' ', (LEVEL-1)*3) ||dname ������
       ,deptno, college, level
FROM tbl_level
START WITH deptno =10
CONNECT BY PRIOR deptno =college; --top-down ���
   
 --�����̵���к� ���� ����
 
 SELECT LPAD ( ' ', (LEVEL-1)*3) ||dname ������
       ,deptno, college, level
FROM tbl_level
WHERE dname != '�����̵���к�'
START WITH deptno =10
CONNECT BY PRIOR deptno =college; --top-down ���

-- --�����̵���к� +���� (�ڽ�) ���� ���� connext by �� ���
 SELECT LPAD ( ' ', (LEVEL-1)*3) ||dname ������
       ,deptno, college, level
FROM tbl_level 
START WITH deptno =10
CONNECT BY PRIOR deptno =college AND dname != '�����̵���к�'; --top-down ���

--MERGE(����, ����)
��. [������ ����] �� ���� ���̺��� ���Ͽ� 
   -> �ϳ��� ���̺�� ��ġ�� ���� ������ ����
��. UNION, UNION ALL ������?  �ΰ��� ������ ��ġ�� ��
                     merge -> �ϳ��� ���̺�� ������
��. ����ϴ� ��?
  ���� ���, �Ϸ翡 �����Ǿ� �߻��ϴ� �����͸� �ϳ��� ���̺� ������ ��� 
   �뷮�� �����ͷ� ���� ���ǹ��� ������ ���ϵȴ�.
    �̷� ���, �������� ������ ���̺��� �����ϴٰ� �⸻�� ���� �м��� ���� 
    �ϳ��� ���̺�� ��ĥ �� merge ���� ����ϸ� ���ϴ�.

��. merge�ϰ��� �ϴ� �ҽ� ���̺��� ���� �о� ŸŶ ���̺� ��ġ�Ǵ� ���� �����ϸ� 
                   ���ο� ������ UPDATE�� �����ϰ�, 
    ���� ��ġ�Ǵ� ���� ���� ��� 
                  ���ο� ���� ŸŶ ���̺��� INSERT�� �����Ѵ�. 

��. 
�����ġ�
    MERGE [hint] INTO [schema.] {table ? view} [t_alias]
      USING {{[schema.] {table ? view}} ?
            subquery} [t_alias]
      ON (condition) [merge_update_clause] [merge_insert_clause] [error_logging_clause];

��merge_update_clause ���ġ�
   WHEN MATCHED THEN UPDATE SET {column = {expr ? DEFAULT},...}
     [where_clause] [DELETE where_clause]

��merge_insert_clause ���ġ�
   WHEN NOT MATCHED THEN INSERT [(column,...)]
    VALUES ({expr,... ? DEFAULT}) [where_clause]
   
��where_clause ���ġ�
   WHERE condition

��error_logging_clause ���ġ�
   LOG ERROR [INTO [schema.] table] [(simple_expression)]
     [REJECT LIMIT {integer ? UNLIMITED}]
��. �׽�Ʈ

create table tbl_emp(
  id number primary key,  --��� id pk
  name varchar2(10) not null, --�����
  salary  number,               --�⺻��
  bonus number default 100) ;   --���ʽ�(�⺻��100)
--Table TBL_EMP��(��) �����Ǿ����ϴ�.

insert into tbl_emp(id,name,salary) values(1001,'jijoe',150);
insert into tbl_emp(id,name,salary) values(1002,'cho',130);
insert into tbl_emp(id,name,salary) values(1003,'kim',140);

COMMIT;

SELECT *
FROM tbl_emp;

create table tbl_bonus(
      id number
      , bonus number default 100
      );
--Table TBL_BONUS��(��) �����Ǿ����ϴ�.

INSERT INTO tbl_bonus ( id) (SELECT id FROM tbl_emp);
  
commit;


INSERT INTO tbl_bonus VALUES ( 1004,50);

SELECT *
FROM tbl_bonus;

--id       bonus
1001	100
1002	100
1003	100
1004	50

SELECT *
FROM tbl_emp;

1001	jijoe	150	100
1002	cho	130	100
1003	kim	140	100

--���� tbl_emp ->tbl_bonus

--INSERT INTO tbl_bonus
  MERGE INTO tbl_bonus b 
  USING (SELECT id, salary FROM tbl_emp ) e
  ON (b.id = e.id)
  WHEN MATCHED THEN   --UPDATE
       UPDATE SET b.bonus = b.bonus +e.salary*0.01 
  WHEN NOT MATCHED THEN --INSERT
        INSERT (b.id, b.bonus) VALUES ( e.id, e.salary *0.01);

3�� �� ��(��) ���յǾ����ϴ�.

SELECT *
FROM tbl_bonus;

1001	101.5
1002	101.3
1003	101.4
1004	50

--���� ����

CREATE TABLE tbl_merge1
(
   id number primary key
   , name varchar2(20)
   , pay number
   , sudang number
);

CREATE TABLE tbl_merge2
(
   id number primary key 
   , sudang number
);

INSERT INTO tbl_merge1 (id, name, pay, sudang) VALUES (1, 'a', 100, 10);
INSERT INTO tbl_merge1 (id, name, pay, sudang) VALUES (2, 'b', 150, 20);
INSERT INTO tbl_merge1 (id, name, pay, sudang) VALUES (3, 'c', 130, 0);
    
INSERT INTO tbl_merge2 (id, sudang) VALUES (2,5);
INSERT INTO tbl_merge2 (id, sudang) VALUES (3,10);
INSERT INTO tbl_merge2 (id, sudang) VALUES (4,20);

COMMIT;

SELECT *
FROM tbl_merge1;

SELECT *
FROM tbl_merge2;

MERGE INTO tbl_merge2 t2
USING (SELECT id, sudang FROM tbl_merge1) t1 ON ( t1.id= t2.id ) 
WHEN MATCHED THEN
   UPDATE SET t2.sudang = t2.sudang + t1.sudang
WHEN NOT MATCHED THEN
   INSERT (t2.id, t2.sudang) VALUES (t1.id, t1.sudang);
------------��������
1. ���̺��� �������� Ȯ�� :user_constraints ��view
SELECT *
FROM user_constraints
WHERE table_name = 'EMP';

2. ��������?
  ��. �������� ���Ἲ�� ���ؼ� ���̺� ���ڵ�(��)�� �߰�, ����, ������ �� ����Ǵ� ��Ģ
  ��. ���̺��� ���������� ���ؼ��� ���������� ����Ѵ�
  
DELETE FROM dept
WHERE deptno =30;
--���� ���� - integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
DEPT (deptno PK) -- emp( deptno FK) ���� �ϰ� ������ �����Ұ���..

   ��. ������ ���Ἲ?
   
   �����Ͱ� �㰡���� �ʴ� ������  �߰�, ����, ���� �����ϴ� ��
    ? 1) ��ü ���Ἲ(Entity Integrity)
    INSERT INTO dept VALUES( 10,'QC','SEOUL');
        �����̼ǿ� ����Ǵ� Ʃ��(tuple=��=row=record)�� ���ϼ��� �����ϱ� ���� �������� ==pk ����Ű
    ? 2) ���� ���Ἲ(Relational Integrity)
    UPDATE emp
    SET deptno=90 --dept���̺��� 90���μ��� �����Ƿ� ������ �� ����.
    WHERE empno=7369;
    
    -�����̼�(���̺�) ���� �������� �ϰ����� �����ϱ� ���� ���������̴�
    - dept ���̺� 10,20,30,40
    - emp ���̺�,:90�� �μ� ����x
    ? 3) ������ ���Ἲ(domain integrity)
    �÷�/�Ӽ� ���� ����, ������ Ÿ��, ����, �⺻ Ű, ���ϼ�, null ���
           , ��� ���� ������ ���� �پ��� ���������� ������ 
    ��. ��������
    kor NUMBER(3) not null default 0  3�ڸ� ���� + �ʼ��Է»��� + �Է¾��ϸ� �⺻�� 0 
     -999~999 ������ ������ �� �ִµ�, 0<=���� <=100(���� ���� ����)
----
EX. �ֹε�Ϲ�ȣ   -> ������ ���Ἲ ����
       rrn char(14)      INSERT INTO ���̺��( rrn) values ('123')
---
3. �������ǻ���ϴ� ����? dml �Ҷ� �߸� ���۵Ǵ� ���� �����ϱ� ���ؼ�
DML -UPDATE INSERT DELETE

4. ���������� ����(����)�ϴ� ��� 
  ��. CREATE TABLE ���̺� ����
  ��. ALTER TABLE ���̺� ����
  
  CREATE TABLE XXX
  {
    ID  �ڷ���  NOT NULL PRIMARY KEY
  )
5. �������� ���� 5����
  ��. PRIMARY KEY ��������(����Ű PK)
  ��. FOREIGN KEY �������� ( �ܷ�Ű, ����Ű FK)
  ��. NOT NULL �������� (NN)
  ��. UNIQUE KEY �������� (���ϼ� UK)
  ��. CHECK ��������(CK)
  
6. ���������� �����ϴ� 2���� ���
  ��. �÷����� COLUMN LEVEL  = IN-LINE constraint ���
  ��. ���̺� ���� table level =  OUT-LINE constraint ���
  
  --�������� x
   CREATE TABLE tbl_consraint
  (
     empno number(4)   NOT NULL
     ,ename varchar2(20) NOT NULL
     ,deptno number(2) NOT NULL
     ,kor number(3)
     ,email varchar2(50)
     ,city varchar(20)
  );
  --Table TBL_CONSRAINT��(��) �����Ǿ����ϴ�.
INSERT INTO tbl_consraint ( empno, ename, deptno, kor, email, city)
                     values (null, null, null, null, null, null);

INSERT INTO tbl_consraint ( empno, ename, deptno, kor, email, city)
                     values (1111, 'ADMIN', 10, null, null, null);
INSERT INTO tbl_consraint ( empno, ename, deptno, kor, email, city)
                     values (1111, 'HONG', 20, null, null, null);
 --�ʼ� �Է� �÷� ���� : NOT NULL ��������
 
 SELECT *
 FROM tbl_consraint; 
 
 ROLLBACK;
 DROP TABLE tbl_consraint;

  --�÷����� ������� �������� ����
  -- NOT NULL ���� ���⸸ ����

CREATE TABLE tbl_column_level
(
    empno number(4)          NOT NULL  CONSTRAINT  PK_TBLCOLUMNLEVEL_EMPNO PRIMARY KEY
    , ename varchar2(20)     NOT NULL
     -- dept ���̺��� PK(deptno) �÷��� �����ϴ� �ܷ�Ű.����Ű FK
    , deptno number(2)       NOT NULL  CONSTRAINT FK_TBLCOLUMNLEVEL_DEPTNO REFERENCES DEPT( deptno )
    , kor number(3)        CONSTRAINT CK_TBLCOLUMNLEVEL_KOR CHECK( KOR BETWEEN 0 AND 100 ) --    -999~999   0~100  CK
    , email varchar2(50)   CONSTRAINT UK_TBLCOLUMNLEVEL_EMAIL UNIQUE  -- ���ϼ�  UK  UNIQUE CONSTRAINT
    , city varchar2(20)   CONSTRAINT CK_TBLCOLUMNLEVEL_CITY CHECK( CITY IN ('����','�λ�','�뱸','����' ) )-- ���� �λ� �뱸 ����
);
-- ���̺� ���� ������� �������� ����
-- NOT NULL X

DROP TABLE tbl_table_level PURGE;
CREATE TABLE tbl_table_level
(
    empno number(4) NOT NULL
    , ename varchar2(20) NOT NULL
    , deptno number(2) NOT NULL
    , kor number(3)
    , email varchar2(50)
    , city varchar2(20)
    
    -- PK ���� ���� ����
    , CONSTRAINT PK_TBLTABLELEVEL_EMPNO PRIMARY KEY( empno )  -- ����Ű
    , CONSTRAINT FK_TBLTABLELEVEL_DEPTNO FOREIGN KEY(deptno)  REFERENCES DEPT( deptno )
    , CONSTRAINT UK_TBLTABLELEVEL_EMAIL UNIQUE( email )
    , CONSTRAINT CK_TBLTABLELEVEL_KOR CHECK( KOR BETWEEN 0 AND 100 )
    , CONSTRAINT CK_TBLTABLELEVEL_CITY CHECK( CITY IN ('����','�λ�','�뱸','����' ) )
);
-- ORA-00907: missing right parenthesis  ������ ��ȣ ������.
-- ORA-02264: name already used by an existing constraint


-- ORA-01438: value larger than specified precision allowed for this column
INSERT INTO tbl_table_level ( empno, ename, deptno, kor, email, city ) 
                     VALUES ( '1111','ADMIN', 20,  90,  'admin@naver.com', '����');
-- ��ü ���Ἲ
-- ORA-00001: unique constraint (SCOTT.PK_TBLTABLELEVEL_EMPNO) violated
-- PK = NN + UK

-- ���� ���Ἲ
-- ORA-02291: integrity constraint (SCOTT.FK_TBLTABLELEVEL_DEPTNO) violated - parent key not found

-- ������ ���Ἲ 0<=  <=100
-- ORA-02290: check constraint (SCOTT.CK_TBLTABLELEVEL_KOR) violated
-- ������ ���Ἲ
-- ORA-02290: check constraint (SCOTT.CK_TBLTABLELEVEL_CITY) violated
INSERT INTO tbl_table_level ( empno, ename, deptno, kor, email, city ) 
                     VALUES ( '2222','HONG', 30,  89,  'hong@naver.com', '�뱸');

--    DML   ������ ���� X     -> ���� ����

-- ORA-01400: cannot insert NULL into ("SCOTT"."TBL_TABLE_LEVEL"."ENAME")
INSERT INTO tbl_table_level ( empno, ename, deptno, kor, email, city ) 
                     VALUES ( '3333', null , 30,  null,  null, null);


INSERT INTO tbl_table_level ( empno, ename, deptno, kor, email, city ) 
                     VALUES ( '3333', 'KENIK' , 30,  null,  null, null);
                     
SELECT *
FROM tbl_table_level;

-- tbl_table_level ���� ���� Ȯ��
SELECT *
FROM user_constraints
WHERE table_name = UPPER('tbl_table_level');

SCOTT	SYS_C008399	C	TBL_TABLE_LEVEL
SCOTT	SYS_C008400	C	TBL_TABLE_LEVEL
SCOTT	SYS_C008401	C	TBL_TABLE_LEVEL
SCOTT	CK_TBLTABLELEVEL_KOR	C	TBL_TABLE_LEVEL
SCOTT	CK_TBLTABLELEVEL_CITY	C	TBL_TABLE_LEVEL
SCOTT	PK_TBLTABLELEVEL_EMPNO	P	TBL_TABLE_LEVEL
SCOTT	UK_TBLTABLELEVEL_EMAIL	U	TBL_TABLE_LEVEL
SCOTT	FK_TBLTABLELEVEL_DEPTNO	R	TBL_TABLE_LEVEL

-- TBL_TABLE_LEVEL ���̺��� PK ���� ������ ����

ALTER TABLE ���̺�� 
DROP [CONSTRAINT constraint�� | PRIMARY KEY | UNIQUE(�÷���)]
***** [CASCADE] *****;

-- 1) PK ����
ALTER TABLE TBL_TABLE_LEVEL
DROP PRIMARY KEY;
-- Table TBL_TABLE_LEVEL��(��) ����Ǿ����ϴ�.


ALTER TABLE TBL_TABLE_LEVEL
 DROP CONSTRAINT PK_TBLTABLELEVEL_EMPNO;

-- 2) PK ���� ���̺� �߰� :  PK_TBLTABLELEVEL_EMPNO

�����ġ�
	ALTER TABLE ���̺��
	ADD [CONSTRAINT �������Ǹ�] ��������Ÿ�� (�÷���);
    
ALTER TABLE TBL_TABLE_LEVEL
  ADD CONSTRAINT PK_TBLTABLELEVEL_EMPNO PRIMARY KEY (empno);


-- ����) 1. ���� ������ Ȯ���ϰ� 
--       2. ��� CK ����(����)
--        TBL_TABLE_LEVEL ���̺���
SCOTT	CK_TBLTABLELEVEL_KOR	C	TBL_TABLE_LEVEL
SCOTT	CK_TBLTABLELEVEL_CITY	C	TBL_TABLE_LEVEL

ALTER TABLE TBL_TABLE_LEVEL
DROP CONSTRAINT CK_TBLTABLELEVEL_KOR;
ALTER TABLE TBL_TABLE_LEVEL
DROP CONSTRAINT CK_TBLTABLELEVEL_CITY;


-- ����) kor �÷��� NN ���� ���� ������ �ȵǾ� �־��..
--      KOR �÷��� NN ���� ���� �߰��ϼ���...
ALTER TABLE ���̺��
ADD CONSTRAINT �������Ǹ� CHECK( kor IS NOT NULL );
�Ǵ�
ALTER TABLE ���̺��
MODIFY kor is NOT NULL;

-- �������� Ȱ��ȭ/ ��Ȱ��ȭ                   ==  ����/�߰�
ALTER TABLE ���̺��
ENABLE CONSTRAINT �������Ǹ�

ALTER TABLE ���̺��
DISABLE CONSTRAINT �������Ǹ� [ CASCADE ];


-- **** FK ������ �� ���� �ɼ� ����
? ON DELETE CASCADE �ɼ��� �̿��ϸ� �θ� ���̺��� ���� ������ �� �̸� ������ �ڽ� ���̺��� ���� ���ÿ� ������ �� �ִ�.
? ON DELETE SET NULL �� �ڽ� ���̺��� �����ϴ� �θ� ���̺��� ���� �����Ǹ� �ڽ� ���̺��� ���� NULL ������ �����Ų��.

1)
emp -> tbl_emp ���̺� ����
dept -> tbl_dept ���̺� ����
DROP TABLE tbl_emp PURGE;
CREATE TABLE tbl_emp AS ( SELECT * FROM emp );
CREATE TABLE tbl_dept AS ( SELECT * FROM dept );

NN ������ �������� ������� �ʴ´� 

2) tbl_emp ���� ���� , tbl_dept ���� ���� Ȯ��

SELECT * 
FROM user_constraints
WHERE table_name IN ( 'TBL_EMP', 'TBL_DEPT');

3) tbl_emp  , tbl_dept ���� ���� : PK �߰�
  PK_���̺��_�÷��� empno / deptno

ALTER TABLE tbl_emp
ADD CONSTRAINT PK_TBLEMP_EMPNO PRIMARY KEY( empno );

ALTER TABLE tbl_dept
ADD CONSTRAINT PK_TBLDEPT_DEPTNO PRIMARY KEY( deptno );


4) tbl_dept( deptno PK )-->  tbl_emp( deptno )����Ű FK ����

ALTER TABLE tbl_emp
ADD CONSTRAINT FK_TBLEMP_DEPTNO FOREIGN KEY( deptno ) REFERENCES tbl_dept( deptno );


SCOTT	PK_TBLDEPT_DEPTNO	P
SCOTT	PK_TBLEMP_EMPNO	    P
SCOTT	FK_TBLEMP_DEPTNO	R

 5) ��ȸ
 SELECT  *FROM tbl_emp;
 SELECT * FROM tbl_dept;
 
 6) tbl_dept ���̺��� 30�� �μ��� ����
 DELETE FROM tbl_dept
 WHERE deptno = 30; 
 -- ORA-02292: integrity constraint (SCOTT.FK_TBLEMP_DEPTNO) violated - child record found

 --  tbl_emp ���̺� 30�� �μ����� ���� ���� ��Ű�� �ʹ�.  ON DELETE CASCADE  �ɼ�
 
 7) FK_TBLEMP_DEPTNO  �������� ����
ALTER TABLE tbl_emp
DROP CONSTRAINT FK_TBLEMP_DEPTNO;

 8) FK �������� �ٽ� �߰�..

ALTER TABLE tbl_emp
ADD CONSTRAINT FK_TBLEMP_DEPTNO FOREIGN KEY( deptno ) REFERENCES tbl_dept( deptno ) ON DELETE CASCADE;

8-2) FK �������� �ٽ� �߰�..

ALTER TABLE tbl_emp
ADD CONSTRAINT FK_TBLEMP_DEPTNO FOREIGN KEY( deptno ) REFERENCES tbl_dept( deptno ) ON DELETE SET NULL;

 9) 
 DELETE FROM tbl_dept
 WHERE deptno = 30;
 
 SELECT * FROM tbl_dept;
 SELECT * FROM tbl_emp;
 
 ROLLBACK;

-- [ JOIN ( ���� ) ] --
-- ���ų� ���� �ٸ� �� �� �̻��� ���̺��� �÷��� �˻�(��ȸ)�ϱ� ���ؼ� ����Ѵ�. 
�μ���/�����/�Ի�����
dept : �μ���
emp  : �����/�Ի�����
-- RDBMS == ������ ������ ���� ����ϴ� DBMS
-- ���̺� <=> ���̺�
-- PK         FK

-- [ ����(JOIN) ���� ]
1. EQUI JOIN
2. NON-EQUI JOIN
3. INNER JOIN
4. OUTER JOIN
5. SELF JOIN

? �� ���� ���̺��� �� ���� ���̺�ó�� ����ϱ� ���� ���̺� ������ ����Ͽ� �� ���̺��� ��ü������ JOIN�Ͽ� ����Ѵ�.
? SELF JOIN�� ���̺��� �ڽ��� Ư�� �÷��� �����ϴ� �� �ٸ� �ϳ��� �÷��� ������ �ִ� ��쿡 ����Ѵ�.

�����ġ�
	SELECT alias1.�÷���, alias2.�÷���
	FROM �������̺� alais1, �������̺� alais2
	WHERE alias1.�÷�1��=alais2.�÷�2��;

�����ġ�
	SELECT alias1.�÷���, alias2.�÷���
	FROM �������̺� alais1 JOIN �������̺� alais2
		ON alias1.�÷�1��=alais2.�÷�2��;

SELECT * 
FROM emp;

  ����)  �����ȣ/�����/�μ��� ��ȸ  + ���ӻ��(�Ŵ���)  ����� + �μ���
  
  dept :dname
  
SELECT a.empno, a.ename, a.deptno, a.mgr , b.ename , dname
FROM emp a, emp b , dept d
WHERE a.mgr = b.empno AND  a.deptno = d.deptno;  
-- self join + equi join
SELECT a.empno, a.ename, a.deptno, a.mgr , b.ename , dname
FROM emp a JOIN  emp b ON a.mgr = b.empno
           JOIN  dept d ON a.deptno = d.deptno;  

6. CROSS JOIN
7. ANTI JOIN
8. SEMI JOIN









 