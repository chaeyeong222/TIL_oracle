1. PIVOT() �Լ��� ������ ��������.

SELECT *
FROM (�ǹ���� ��������)
PIVOT( �׷��Լ�(�����÷�) FOR �ǹ�Į�� IN (�ǹ�Į���� AS��Ī))


2. emp ���̺���   �� JOB�� ����� (�Ǻ�)

    CLERK   SALESMAN  PRESIDENT    MANAGER    ANALYST
---------- ---------- ---------- ---------- ----------
         3          4          1          3          1
         
         1) �ǹ���� ��������
           SELECT job FROM emp
         2) IN (���)
           SELECT DISTINCT job
           FROM emp;
           
SELECT *
FROM ( SELECT job FROM emp)
PIVOT ( COUNT(job) FOR job IN ('CLERK', 'SALESMAN','PRESIDENT','MANAGER','ANALYST'  ));


3. emp ���̺���  [JOB����] �� ���� �Ի��� ����� ���� ��ȸ 
  ��. COUNT(), DECODE() ���

JOB         COUNT(*)         1��         2��         3��         4��         5��         6��         7��         8��         9��        10��        11��        12��
--------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
CLERK              3          1          0          0          0          0          0          0          0          0          0          0          2
SALESMAN           4          0          2          0          0          0          0          0          0          2          0          0          0
PRESIDENT          1          0          0          0          0          0          0          0          0          0          0          1          0
MANAGER            3          0          0          0          1          1          1          0          0          0          0          0          0
ANALYST            1          0          0          0          0          0          0          0          0          0          0          0          1
;
SELECT job, COUNT(*)
        ,COUNT (DECODE( TO_CHAR( hiredate, 'MM'), '01',' ')) "1��"
        ,COUNT (DECODE( TO_CHAR( hiredate, 'MM'), '02',' '))"2��"
        ,COUNT (DECODE( TO_CHAR( hiredate, 'MM'), '03',' '))"3��"
        ,COUNT (DECODE( TO_CHAR( hiredate, 'MM'), '04',' '))"4��"
        ,COUNT (DECODE( TO_CHAR( hiredate, 'MM'), '05',' '))"5��"
        ,COUNT (DECODE( TO_CHAR( hiredate, 'MM'), '06',' '))"6��"
        ,COUNT (DECODE( TO_CHAR( hiredate, 'MM'), '07',' '))"7��"
        ,COUNT (DECODE( TO_CHAR( hiredate, 'MM'), '08',' '))"8��"
        ,COUNT (DECODE( TO_CHAR( hiredate, 'MM'), '09',' '))"9��"
        ,COUNT (DECODE( TO_CHAR( hiredate, 'MM'), '10',' '))"10��"
        ,COUNT (DECODE( TO_CHAR( hiredate, 'MM'), '11',' '))"11��"
        ,COUNT (DECODE( TO_CHAR( hiredate, 'MM'), '12',' '))"12��"
        --EXTRACT( MONTH FROM hiredate)
FROM emp
GROUP BY job;

TO_CHAR  �� �������� '01'
EXTRACT �� �������� 1


  ��. GROUP BY �� ���

         ��        �ο���
---------- ----------
         1          1
         2          2
         4          1
         5          1
         6          1
         9          2
        11          1
        12          3

8�� ���� ���õǾ����ϴ�. 

SELECT TO_CHAR( hiredate, 'MM') ��, COUNT(*)�ο���
FROM emp
GROUP BY TO_CHAR( hiredate, 'MM')
ORDER BY ��;
  
  ��. PIVOT() ���
  
JOB               1��          2          3          4          5          6          7          8          9         10         11         12
--------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
CLERK              1          0          0          0          0          0          0          0          0          0          0          2
SALESMAN           0          2          0          0          0          0          0          0          2          0          0          0
PRESIDENT          0          0          0          0          0          0          0          0          0          0          1          0
MANAGER            0          0          0          1          1          1          0          0          0          0          0          0
ANALYST            0          0          0          0          0          0          0          0          0          0          0          1


SELECT *
FROM ( SELECT job, EXTRACT( MONTH FROM hiredate) hire_month FROM emp) 
PIVOT(  COUNT(*)  FOR hire_month IN(1,2,3,4,5,6,7,8,9,10,11,12));

SELECT JOB, EXTRACT( MONTH FROM hiredate) hire_month 
FROM emp;



4. emp ���̺��� �� �μ��� �޿� ���� �޴� ��� 2�� ���
  ������)
       SEQ      EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- ---------- --------- ---------- -------- ---------- ---------- ----------
         1       7839 KING       PRESIDENT            81/11/17       5000                    10
         2       7782 CLARK      MANAGER         7839 81/06/09       2450                    10
         1       7902 FORD       ANALYST         7566 81/12/03       3000                    20
         2       7566 JONES      MANAGER         7839 81/04/02       2975                    20
         1       7698 BLAKE      MANAGER         7839 81/05/01       2850                    30
         2       7654 MARTIN     SALESMAN        7698 81/09/28       1250       1400         30
   ; 
 1. RANK ���� �Լ�
 2. TOP-N ���
SELECT *
FROM(SELECT rank() over(partition by deptno order by sal desc) seq 
      , empno, ename, job, NVL(mgr,0) hiredate, sal, NVL(comm,0), deptno
FROM emp)t
WHERE t.seq <=2;

----
����) EMP ���̺��� GRADE ��޺� ����� ��ȸ GRADE -> SALGRADE ���̺�;

SELECT *
FROM salgrade;

1	700	    1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999

--1) COUNT �� DECODE �Լ� �̿�
/*
SELECT ename, COUNT( ( sal BETWEEN LOSAL AND HISAL) grade))
FROM emp e, dept d ;
GROUP BY grade
*/
SELECT ename, sal, losal || '~' || hisal grade
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

----
SELECT COUNT(*)
   , COUNT(DECODE(grade,1,'o')) "1���"
   , COUNT(DECODE(grade,1,'o')) "2���"
   , COUNT(DECODE(grade,1,'o')) "3���"
   , COUNT(DECODE(grade,1,'o')) "4���"
   , COUNT(DECODE(grade,1,'o')) "5���"
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;


--2) GROUP BY �� ���

SELECT grade||'���' ��� , COUNT(*)
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal
GROUP BY grade
ORDER BY grade ASC;

--3) PIVOT ���

SELECT *
FROM ( 
       SELECT deptno, grade 
       FROM emp e , salgrade s 
       WHERE sal BETWEEN s.losal AND s.hisal)
PIVOT( COUNT(*) FOR grade IN(1,2,3,4,5));

--deptno �߰��ϸ� �μ��� ��� Ȯ���� �� �ִ�.

--����) emp ���̺��� �⵵�� �Ի� �����

1. COUNT, DECODE �Լ�
SELECT COUNT ( DECODE ( TO_CHAR( hiredate, 'YYYY'),1980,'O' ) ) "1980��"
        ,COUNT ( DECODE ( TO_CHAR( hiredate, 'YYYY'),1981,'O' ) )"1981��"
        ,COUNT ( DECODE ( TO_CHAR( hiredate, 'YYYY'),1982,'O' ) )"1982��"
FROM emp;

2. GROUP BY ��

SELECT TO_CHAR( hiredate, 'YYYY'), COUNT(*)
FROM emp
GROUP BY TO_CHAR( hiredate, 'YYYY')
ORDER BY TO_CHAR( hiredate, 'YYYY');

3. PIVOT 

SELECT *
FROM ( 
       SELECT EXTRACT( YEAR FROM hiredate) hire_year
       FROM emp) 
PIVOT( COUNT(*) FOR hire_year IN(1980,1981,1982) );

--������ �ǹ� ����)
-- ������Ʈ ���� �� ����
1. ���̺� ���� : TBL_PIVOT
   �÷� : no(��ȣ), name, jumsu

CREATE TABLE TBL_PIVOT(
    no NUMBER NOT NULL PRIMARY KEY --�ʼ� �Է�(������ Ű)
    , name VARCHAR2(20) NOT NULL
    , jumsu NUMBER(3)
);
--Table TBL_PIVOT��(��) �����Ǿ����ϴ�.

2. �л��� ���� ���� �߰� (INSERT)

INSERT INTO TBL_PIVOT (no, name, jumsu) VALUES( 1,'�ڿ���','90'); --KOR
INSERT INTO TBL_PIVOT (no, name, jumsu) VALUES( 2,'�ڿ���','89'); --ENG
INSERT INTO TBL_PIVOT (no, name, jumsu) VALUES( 3,'�ڿ���','99'); --MAT

3. ������: ����, ����, ���� ������ ���� ���� -> ���� ���� �����ؾ��ϴµ� �߸� ����
  
INSERT INTO TBL_PIVOT (no, name, jumsu) VALUES( 4,'�Ƚ���','56'); --KOR
INSERT INTO TBL_PIVOT (no, name, jumsu) VALUES( 5,'�Ƚ���','45'); --ENG
INSERT INTO TBL_PIVOT (no, name, jumsu) VALUES( 6,'�Ƚ���','12'); --MAT

INSERT INTO TBL_PIVOT (no, name, jumsu) VALUES( 7,'���','99'); --KOR
INSERT INTO TBL_PIVOT (no, name, jumsu) VALUES( 8,'���','85'); --ENG
INSERT INTO TBL_PIVOT (no, name, jumsu) VALUES( 9,'���','100'); --MAT

4. ��ȸ
SELECT *
FROM TBL_PIVOT;

1	�ڿ���	90
2	�ڿ���	89
3	�ڿ���	99
4	�Ƚ���	56
5	�Ƚ���	45
6	�Ƚ���	12
7	���	    99
8	���	    85
9	���	    100

4. ������� �̷��� ������ ����
�ǹ� ����ؼ�
��ȣ �̸�   ���� ���� ����
1   �ڿ���  90  89  99
2   �Ƚ���  56  45  12
3    ���   99  85  100

1. �ǹ� ��� ��������
SELECT TRUNC( (no-1)/3)+1 no, name, jumsu 
    ,DECODE ( MOD(no,3),1,'����',2,'����','����') ����
FROM TBL_PIVOT;

IN (���) '����','����','����';

SELECT *
FROM (
        SELECT TRUNC( (no-1)/3)+1 no, name, jumsu 
            ,DECODE ( MOD(no,3),1,'����',2,'����','����') subject
        FROM TBL_PIVOT
)
PIVOT( SUM(jumsu) FOR subject IN ('����','����','����'))
ORDER BY no ASC;

--NO  1/2/3  1
--NO 4/5/6   2
--NO 7/8/9   3

SELECT no
    , (no-1)
    , TRUNC( (no-1)/3)+1 no
FROM TBL_PIVOT;

/* �����Ѱ�
SELECT *
FROM ( SELECT no, name, jumsu 
    ,DECODE ( MOD(no,3),1,'����',2,'����','����') ����
FROM TBL_PIVOT   )
PIVOT( COUNT(*) FOR ���� IN ('����','����','����');

SELECT DECODE( MOD(no,3),1,'O') ����
        ,DECODE( MOD(no,3),2,'O') ����
       , DECODE( MOD(no,3),0,'O') ����
FROM TBL_PIVOT;
WHERE MOD(no,3)=1;

SELECT DECODE ( MOD(tp.no,3),1,'����',2,'����','����') ����, t.name, t.jumsu
FROM ( 
SELECT name, jumsu --COUNT(*)
FROM TBL_PIVOT
)t, TBL_PIVOT tp
GROUP BY MOD(no,3);
*/
-----------
JAVA  : ���� (������ ��)   0.0 <=Math.random() <1.0
ORACLE : dbms_random ��Ű��(package)  != �ڹ��� ��Ű�� ������� �ٸ�

PL/SQL = Ȯ��� SQL + PL(������ ���)
SELECT    dbms_random.value
    ,dbms_random.value(0, 100)   --0<= �Ǽ� <100
    ,floor(dbms_random.value(0, 45)) + 1 lotto
    ,dbms_random.string('U', 5) --UPPER �빮�� 5��
    ,dbms_random.string('L', 5) --LOWER �ҹ��� 5��
    ,dbms_random.string('A', 5) -- ���ĺ� ��ҹ��� 5��
    ,dbms_random.string('x', 5) -- �빮��+����5��
    ,dbms_random.string('P', 5) --�빮�� + Ư������
FROM dual;

-----
���� 150<= ���� <=200  

SELECT dbms_random.value(0,50)
      , TRUNC (dbms_random.value *51) +150
      , TRUNC ( dbms_random.value(0,51))+150
      , TRUNC (dbms_random.value(150,201))
FROM dual;

SELECT CEIL( dbms_random.value(0,50))+150
FROM dual;
------
����Ŭ �ڷ���
����(����,�Ǽ�) - NUMBER
��¥          - DATE(�� ��¥�ð�) ,TIMESTAMP( ���뼼����ns + Ÿ����)
���ڿ�        - VARCHAR2  

�����ڷ��� char/ nchar
         varchar2 / nvarchar2
         [var]
         [n]
1. CHAR
 ��. ���� ���� ���� �ڷ���
     char(10)
     'abc'
     10 byte = ['a']['b']['c'][][][][][][][]
 ��. 1byte ~ 2000 byte ���ĺ� 1���� = 1byte, �ѱ� 1���� = 3byte  
 SELECT VSIZE('A'), VSIZE('��')
 FROM dual;
 ��. ����
    CHAR(SIZE [BYTE|CHAR])
    
    char(3) == char(3 byte)
    char(3 char) == 3����(���ĺ�, �ѱ�)
    char == char(1) == char (1 byte)
 ��.�׽�Ʈ
 
 CREATE TABLE tbl_char(
   aa char
   ,bb char(3)
   ,cc char(3 char)
 );
 --Table TBL_CHAR��(��) �����Ǿ����ϴ�.
SELECT *
FROM tbl_char;

INSERT INTO tbl_char (aa, bb, cc ) VALUES ( 'a','kbs','kbs' );
--1 �� ��(��) ���ԵǾ����ϴ�.
COMMIT;     --Ŀ�� �Ϸ�.
INSERT INTO tbl_char VALUES ( '��','kbs','kbs' );
--ORA-12899: value too large for column "SCOTT"."TBL_CHAR"."AA" (actual: 3, maximum: 1)
-- ũ�⺸�� ū ���̶� ������

INSERT INTO tbl_char VALUES ( 'b','k','�ɺ�' );
COMMIT;

2. NCHAR == N+CHAR == U[N]ICODE + CHAR
 ��. �����ڵ�(unicode) ��� ����� 1���ڸ� 2����Ʈ�� ó��
 ��. ����
  NCHAR[(SIZE)]
 ��. [��������] 2000����Ʈ
 
  nchar == nchar(1) 1����
  nchar(5)          5����
  
 CREATE TABLE tbl_nchar(
   aa char
   ,bb char(3 char)
   ,cc nchar(3)
 );
--Table TBL_NCHAR��(��) �����Ǿ����ϴ�.

INSERT INTO tbl_nchar VALUES ('a', 'ȫ��X', 'ȫ�浿');
--1 �� ��(��) ���ԵǾ����ϴ�.
COMMIT;

SELECT *
FROM tbl_nchar;

3. VARCHAR2 = VAR + CHAR
    ��. ��������, �ִ� 4000 ����Ʈ
    ��. ����
      VARCHAR2(size [byte|char]) �� �ó�� VARCHAR 
    ��. 
      char = char(1 byte)
      varchar2 == varchar2(4000 byte)
      varchar2(10) == varchar2( 10 byte)
      varchar2(10 char)
    ��. ��������/�������� ������ ����
      char(10) == char(10 byte)
      varchar2(10) == varchar2( 10 byte)
      
      'kbs' ����
      char [k][b][s]['']['']['']['']['']['']['']
      varchar2 [k][b][s]  --�� ������ ����
      
      ��. � ��쿡 ��������/�������� ����ϴ°�?
      
      char / nchar �������� : ������ ���� ���� ���� ���
                     ex. �ֹι�ȣ 14�ڸ� ���ڿ�, �����ȣ
      varchar2 /nvarchar2 �������� : ex.�Խñ� ����

4. NVARCHAR2
 ��. N(�����ڵ�) + VAR(��������)
 ��. �ִ� 4000����Ʈ
 ��. NVARCHAR2[(size)]
 ��. nvarchar2 == nvarchar2 (4000)
 
5. LONG ���������� ���� �ڷ��� - 2GB
6. NUMBER[(P,S)]
  ��.���� ( ����, �Ǽ�)
  ��. precision ��Ȯ��  - ���� ��ü�ڸ���   1~38
     scale     �Ը�    - �Ҽ��� ���� �ڸ��� -84~127
     
     NUMBER(P) ����
     NUMBER(P,S) �Ǽ�
  ��. NUMBER == NUMBER(38,127)
  ��. �׽�Ʈ
CREATE TABLE tbl_number(
   kor NUMBER(3) --(-999)~(999)  ���ϴ� �� 0 <= <=100
   ,eng NUMBER(3)
   ,mat NUMBER(3)
   ,tot NUMBER(3)
   ,avgs NUMBER(5,2)
);
--Table TBL_NUMBER��(��) �����Ǿ����ϴ�.
--                                                91 ������ ���� ����x
INSERT INTO tbl_number ( kor, eng, mat) VALUES ( 90.89, 85, 100 );
COMMIT;

INSERT INTO tbl_number ( kor, eng, mat) VALUES ( 90, 85, 101 );
INSERT INTO tbl_number ( kor, eng, mat) VALUES ( 90, 85, -1 );

--ORA-01438: value larger than specified precision allowed for this column
INSERT INTO tbl_number ( kor, eng, mat) VALUES ( 90, 85, 1000 );

INSERT INTO tbl_number ( kor, eng, mat) VALUES ( 90, 85, -999 );

--����
INSERT INTO tbl_number ( kor, eng, mat) VALUES ( 90, 85, -1001);


SELECT *
FROM tbl_number;

��� �л��� ������ ������ 0~100 ������ ���� ����
UPDATE tbl_number
SET kor = TRUNC( dbms_random.value(0,101))
    ,eng = TRUNC( dbms_random.value(0,101))
    ,mat = TRUNC( dbms_random.value(0,101))
    ; 
    
UPDATE tbl_number
SET tot = kor+eng+mat
    ,avgs = (kor+eng+mat)/3
    ;     
 
 COMMIT;   
 
 -- avgs �÷� NUMBER(5,2)  100.00
 
 UPDATE tbl_number
 SET avgs = 999.87123; 
 SET avgs = 89.12945678;  -- scale 2, �Ҽ��� 3��° �ڸ����� �ݿø�.
 SET avgs = 89.12345678; -- �����ȳ� 
 SET avgs = 100.00;
 SET avgs = 99999;  --���� (ũ�� �ȸ���)
 SET avgs = 999;
 SET avgs = 89.23;
 
NUMBER(4,5)ó�� scale�� precision���� ũ��, �̴� ù�ڸ��� 0�� ���̰� �ȴ�.
NUMBER(p) == NUMBER(p,0)

123.89 NUMBER( 6,-2) 100
 
 7. FLOAT(P)  == ������NUMBER 
 8. DATE
    - ����, ��, ��, ��, ��, ��, �ʸ� �����ϴ� �ڷ���
    --------
�л������� �����ϴ� ���̺� : tbl_student
�÷� : 
�й� NUMBER(7) -9999999~ 9999999 
�̸� CHAR, NCHAR  �������� X
       , VARCHAR2, NVARCHAR2 ��������  
    VARCHAR2 (size BYTE|CHAR)
    VARCHAR2 ( 20)
���� NUMBER(3) -999~999
���� NUMBER(3)
���� NUMBER(3)
���� NUMBER(3)
��� NUMBER(5,2)
��� NUMBER(3)
���� DATE
�ֹι�ȣ CHAR(14)
��Ÿ VARCHAR2 -- 2GB �������� ����

9. TIMESTAMP(n) DATE�� Ȯ��� �ڷ������� �����ʱ���, n: �� ���� �ڸ���
  TIMESTAMP == TIMESTAMP(6)

10. 
INTERVAL YEAR[(n)] TO MONTH n=2  ��� ���� ����Ͽ� ��¥���� �Ⱓ�� ���� 
INTERVAL DAY[(n1)] TO SECOND[(n2)] 

11. RAW()       2000 BYTE
    LONG RAW()  2GB
    
    �̹��� ���� -> ���̺��� � �÷�
    test.gif   img RAW/LONG RAW
    010101
    2��������
12. 2GB �̻��� 2�� �����͸� �����Ҷ��� BFILE �ڷ��� ���
     BFILE -> B(binary 2��������) + FILE(�ܺ� ���� �������� ����)
     
13. LOB (Large OBject)
 ��. B + LOB = BLOB 2GB�̻��� 2�������� ����
 ��. C + LOB = CLOB 2GB�̻��� �ؽ�Ʈ ������ ����
 ��. NC + LOB = NCLOB 2GB�̻��� �����ڵ� ������ �ؽ�Ʈ ������ ����
 
 �ؽ�Ʈ (LONG) �̹���, ����������( LONG RAW) +2GB �̻�(��뷮) LOB �ڷ��� �ʿ�
 
14. ROWID �ǻ� �÷� --���� ������ �� �ִ� ������ ��
SELECT ROWID, dept.*
FROM dept;

ROWID
--------
AAAE5cAAEAAAAFMAAA	10	ACCOUNTING	NEW YORK
AAAE5cAAEAAAAFMAAB	20	RESEARCH	DALLAS
AAAE5cAAEAAAAFMAAC	30	SALES	CHICAGO
AAAE5cAAEAAAAFMAAD	40	OPERATIONS	BOSTON

------------------------------------
COUNT �Լ�
------------------------------------
������ ���� ���� ��ȯ�Ѵ�.
COUNT(�÷���) �Լ��� NULL�� �ƴ� ���� ���� ����ϰ� COUNT(*) �Լ��� NULL�� ������ ���� ���� ����Ѵ�.

�����ġ�
	COUNT([* ? DISTINCT ? ALL] �÷���) [ [OVER] (analytic ��)]
------------------------------------
--COUNT(*) OVER( ORDER BY basicpay ASC):  ������ ���� ������ ������� ��ȯ�Ѵ�.
SELECT name, basicpay
        ,COUNT(*) OVER( ORDER BY basicpay ASC)
FROM insa;

������	840000	1
ȫ�泲	875000	2
���ѱ�	880000	6
�ɽ���	880000	6
�̼���	880000	6
������	880000	6
�Ӽ���	890000	7
�̳���	892000	8
��ž�	900000	9
�踻��	920000	10
;

SELECT buseo, name, basicpay
        ,COUNT(*) OVER(PARTITION BY buseo ORDER BY basicpay ASC)
FROM insa;
------------------------------------
 SUM() �Լ� : ������ ��
------------------------------------
�����ġ�
	SUM ([DISTINCT ? ALL] expr)
               [OVER (analytic_clause)]

SELECT DISTINCT buseo
        --, name
        , SUM(basicpay) OVER (ORDER BY buseo) PS
FROM insa
ORDER BY PS ASC;

------------------------------------
 AVG() �Լ� : ������ ���
------------------------------------

�����ġ�
	AVG( [DISTINCT ? ALL] �÷���)
	   [ [OVER] (analytic ��)]

SELECT buseo, city, basicpay
        , AVG(basicpay) OVER (PARTITION BY ORDER BY city) PS
          "������� �޿���"
FROM insa;

------------------------------------
���̺� ����, ����,����...
------------------------------------
���̺� table ���� :tbl_member
�÷�    �÷���        �ڷ���                   ũ��         �� ���     ����Ű
���̵�    id      ���� /��������     varchar2  10          NOT NULL     PK
�̸�     name     ����/��������      varchar2  20          NOT NULL
����     age      ����/����           number  3           
��ȭ��ȣ  tel      ���ڿ� /��������     char    13 [ 3-4-4] NOT NULL
����     birth    ��¥/��������        date               
��Ÿ     etc      ����              varchar2  200       


�������� ���̺� ���� ���ġ�
    CREATE [GLOBAL TEMPORARY] TABLE [schema.] table
      ( 
        ���̸�  ������Ÿ�� [DEFAULT ǥ����] [��������] 
       [,���̸�  ������Ÿ�� [DEFAULT ǥ����] [��������] ] 
       [,...]  
      ); 

GLOBAL TEMPORARY : �ӽ����̺� ���� 

 CREATE TABLE scott.tbl_member
      ( 
        id  varchar2(10) NOT NULL PRIMARY KEY
        ,name  varchar2(20) NOT NULL 
        ,age number(3)
        ,tel char(13) NOT NULL 
        ,birth date
        ,etc varchar2 (200)
      );
--Table SCOTT.TBL_MEMBER��(��) �����Ǿ����ϴ�.

SELECT *
FROM tabs
WHERE table_name LIKE '%MEMBER%';

DROP TABLE tbl_member;
--Table TBL_MEMBER��(��) �����Ǿ����ϴ�.
 CREATE TABLE scott.tbl_member
      ( 
        id  varchar2(10) NOT NULL PRIMARY KEY
        ,name  varchar2(20) NOT NULL 
        ,age number(3)
        ,birth date
     );

--���̺� ����
 
 DESC tbl_member;
 
 �̸�    ��?       ����           
----- -------- ------------ 
ID    NOT NULL VARCHAR2(10) 
NAME  NOT NULL VARCHAR2(20) 
AGE            NUMBER(3)    
BIRTH          DATE    

------------------------------------
1. ���� tbl_member ���̺�    ���ο� ( ��ȭ��ȣ, ��Ÿ �÷� �߰�)

ALTER TABLE tbl_member
        ADD ( 
         tel char(13) NOT NULL 
        ,etc varchar2(200)
        );
--Table TBL_MEMBER��(��) ����Ǿ����ϴ�.

DESC tbl_member;

2. ETC   VARCHAR2(200) �÷��� �ڷ��� ���� (ũ�� 200->255)

ALTER TABLE tbl_member
      MODIFY (etc VARCHAR2(255) );
      
      --Table TBL_MEMBER��(��) ����Ǿ����ϴ�.
DESC tbl_member;

      �̸�    ��?       ����            
----- -------- ------------- 
ID    NOT NULL VARCHAR2(10)  
NAME  NOT NULL VARCHAR2(20)  
AGE            NUMBER(3)     
BIRTH          DATE          
TEL   NOT NULL CHAR(13)      
ETC            VARCHAR2(255) 
------------------------------------
�����ġ�
        ALTER TABLE ���̺��
        MODIFY (�÷��� datatype [DEFAULT ��]
               [,�÷��� datatype]...);

? �������� type, [size]***, default ���� ������ �� �ִ�.
? ���� ��� �÷��� �����Ͱ� ���ų� null ���� ������ ��쿡�� size�� ���� �� �ִ�.
? ������ Ÿ���� ������ CHAR�� VARCHAR2 ��ȣ���� ���游 �����ϴ�.
? ***�÷� ũ���� ������ ����� �������� ũ�⺸�� ���ų� Ŭ ��쿡�� �����ϴ�.
? NOT NULL �÷��� ��쿡�� size�� Ȯ�븸 �����ϴ�.
? �÷��� �⺻�� ������ �� ���Ŀ� ����INSERT�Ǵ� ����� ������ �ش�.
? �÷��̸��� [�������� ����]�� �Ұ����ϴ�.
? �÷��̸��� ������ ���������� ���� ���̺� ������ alias�� �̿��Ͽ� ������ �����ϴ�.
? alter table ... modify�� �̿��Ͽ� �������� constraint�� ������ �� ����.

------------------------------------
ALTER TABLE ���̺� ���� DDL��
  1) ���ο� �÷� �߰� ... add
    �����ġ��÷��߰�
        ALTER TABLE ���̺��
        ADD (�÷��� datatype [DEFAULT ��]
            [,�÷��� datatype]...);
? *** �ѹ��� add ������� ���� ���� �÷� �߰��� �����ϰ�, �ϳ��� �÷��� �߰��ϴ� ��쿡�� ��ȣ�� �����ص� �ȴ�.
? *** �߰��� �÷��� ���̺��� ������ �κп� �����Ǹ� ����ڰ� �÷��� ��ġ�� ������ �� ����
? �߰��� �÷����� �⺻ ���� ������ �� �ִ�.
? ���� �����Ͱ� �����ϸ� �߰��� �÷� ���� NULL�� �Է� �ǰ�, ���� �ԷµǴ� �����Ϳ� ���ؼ��� �⺻ ���� ����ȴ�.

  2) ���� �÷��� ���� 
  3) ���� �÷��� ����
  4) �������� �߰�
  5) �������� ����

------------------------------------

3. etc �÷����� bigo �÷������� ����
  ��. ��Īalias���� ����
SELECT etc bigo FROM tbl_member;
  ��. �ʵ���� ����
ALTER TABLE tbl_member
RENAME COLUMN etc TO bigo;
--Table TBL_MEMBER��(��) ����Ǿ����ϴ�.
------------------------------------

4. bigo �÷� ����
        ALTER TABLE tbl_member
        DROP COLUMN bigo;

DESC tbl_member;
------------------------------------

�����ġ�
        ALTER TABLE ���̺��
        DROP COLUMN �÷���; 

? �÷��� �����ϸ� �ش� �÷��� ����� �����͵� �Բ� �����ȴ�.
? �ѹ��� �ϳ��� �÷��� ������ �� �ִ�.
? ���� �� ���̺��� ��� �ϳ��� �÷��� �����ؾ� �Ѵ�.
? DDL������ ������ �÷��� ������ �� ����.

------------------------------------
5. tbl_member ���̺� �̸��� ���� ( tbl_customer )

RENAME tbl_member TO tbl_customer;