
1. �̹� �� 1�� ���� ������ ������ �Ʒ��� ���� ��� 
     ( LEVEL �ǻ��÷� ��� )
������) 
  ��¥	       ����    ����(IW)
21/11/01	��	44
21/11/02	ȭ	44
21/11/03	��	44
21/11/04	��	44
21/11/05	��	44
21/11/06	��	44 
 :
21/11/29	��	48
21/11/30	ȭ	48
 
 
 
 SELECT TO_DATE('202204','YYYYMM')+(LEVEL-1)
 FROM dual
 CONNECT BY LEVEL <=EXTRACT ( DAY FROM LAST_DAY (TO_DATE('202204','YYYYMM')) );
 
 

 2-1.  �Ʒ��� ���� ���� ������ ����ϴ� ���� �ۼ�  ( �������� ���ǹ�)
������)
NAME		LEVEL   empno	mgr
------------------------------------
KING		1	7839	null
   JONES	2	7566	7839         
      FORD	3	7902	7566
         SMITH	4	7369	7902     
   BLAKE	2	7698	7839
      ALLEN	3	7499	7698
      WARD	3	7521	7698
      MARTIN	3	7654	7698
      TURNER	3	7844	7698
      JAMES	3	7900	7698
   CLARK	2	7782	7839
      MILLER	3	7934	7782
   
   SELECT LPAD ( ' ',(LEVEL-1)*3)||ename, level, empno, mgr
   FROM emp
   START WITH mgr is null
   CONNECT BY PRIOR empno=mgr;

2-2. ���� JONES �������� �����ϴ� ���� �ۼ�. 
������)
NAME		LEVEL   empno	mgr
------------------------------------
KING		1	7839	null
   BLAKE	2	7698	7839
      ALLEN	3	7499	7698
      WARD	3	7521	7698
      MARTIN	3	7654	7698
      TURNER	3	7844	7698
      JAMES	3	7900	7698
   CLARK	2	7782	7839
      MILLER	3	7934	7782
      
   ELECT LPAD ( ' ',(LEVEL-1)*3)||ename, level, empno, mgr
   FROM emp
   WHERE ename != 'JONES'
   START WITH mgr is null
   CONNECT BY PRIOR empno=mgr;
      

3.  MERGE : ���� , ���� ���̺��� ������ �ٸ� ���̺� ����(�߰�)

CREATE TABLE tbl_merge1
(
   id      number Primary key
   , name  varchar2(20)
   , pay  number
   , sudang number
)

CREATE TABLE tbl_merge2
(
   id      number Primary key 
   , sudang number
)

INSERT INTO tbl_merge1 (id, name, pay, sudang) VALUES (1, 'a', 100, 10);
INSERT INTO tbl_merge1 (id, name, pay, sudang) VALUES (2, 'b', 150, 20);
INSERT INTO tbl_merge1 (id, name, pay, sudang) VALUES (3, 'c', 130, 0);
    
INSERT INTO tbl_merge2 (id, sudang) VALUES (2,5);
INSERT INTO tbl_merge2 (id, sudang) VALUES (3,10);
INSERT INTO tbl_merge2 (id, sudang) VALUES (4,20);

COMMIT;

���� �� ���̺��� ����(merge)�ؼ� �Ʒ��� ���� ����� �������� �����ϼ���.
[ ���� ��� ]
SELECT * FROM tbl_merge1;
--
1	a	100	10
[2]	b	150	25 ( UPDATE )    
[3]	c	130	10 ( UPDATE )
4	        20 ( INSERT )    


MERGE INTO tbl_merge1
 USING (SELECT id, sudang FROM tbl_merge2) on tbl_merge1.id=tbl_merge2.id
 WHEN MATCHED THEN
  UPDATE SET tbl_merge1.sudang = tbl_merge1.sudang+tbl_merge.sudang
WHEN NOT MATCHED THEN
  INSERT (tbl_merge2.id, tbl_merge2.sudang )VALUES (4,20);



4. ��������( Contratrint ) 
  ��. ���������̶� ?    
       
  ��. ���������� �����ϴ� 2���� ����� ���� �����ϼ���.
      �÷�����
      ���̺���
  
  ��. ���������� 5���� ���� 
      primar key
      foreign key
      unique key
      check key
      not null
      
  ��. emp ���̺��� �������� Ȯ�� ���� �ۼ� 
     SELECT *
     FROM user_constraints
     WHERE table_name ='EMP';
     
     
  ��. ������ ���Ἲ ���� �� ����
    1. ��ü���Ἲ -> ���̺� ����Ǵ� ���� ���ϼ��� �����ϱ� ���� ��������
    2. �������Ἲ -> ���̺� �������� �ϰ����� �����ϱ� ���� ��������
    3. �����ι��Ἲ -> �÷����� ������ Ÿ��, ���� , ���ϼ�, �� ��� ���� ��������

5. �Ʒ� ���̺� ���� ���� ���� [�÷� ����] ������� 
   ��. deptno �� PK �� ����
   ��. dname�� NN �� ����
CREATE TABLE tbl_dept
(
    DEPTNO  NUMBER(2)   CONSTRAINTS PK_TBLDEPT_DEPTNO PRIMARY KEY
   , DNAME VARCHAR2(14)  NOT NULL
   , LOC   VARCHAR2(13)      
);

6. �Ʒ� ���̺� ���� ���� ���� [���̺� ����] ������� 
   ��. deptno �� PK �� ����
   ��. dname�� NN �� ����       
CREATE TABLE tbl_dept
(
    DEPTNO  NUMBER(2) 
   , DNAME VARCHAR2(14) 
   , LOC   VARCHAR2(13) 
   ,  CONSTRAINTS PK_TBLDEPT_DEPTNO PRIMARY KEY (deptno)
   ,  CONSTRAINTS NOT NULL dname
);

7. tbl_dept ���̺��� ���� �� [��� �������� ����]�ϴ� ���� �ۼ�  ?


ALTER TABLE tbl_dept
 DROP ??


8. ALTER TABLE ���� ����ؼ� PK �������� ����. 

ALTER TABLE tbl_dept
  ADD CONSTRAINTS �������Ǹ� PRIMARY KEY;


9. UK ���� ���� ���� ���� �ۼ�
   ��) tbl_member���̺�  tel �÷��� UK_MEMBER_TEL �̶� �������Ǹ�����
     UNIQUE ���� ������ ������ ��� 
     
ALTER TABLE tbl_member
 DROP CONSTRAINTS UK_MEMBER_TEL UNIQUE KEY;


10. FK ���� ���� ���� �� �Ʒ� �ɼǿ� ���� �����ϼ���
   CONSTRAINT FK_TBLEMP_DEPTNO FOREIGN KEY ( deptno ) 
                                REFERENCES tbl_dept(deptno )
                                
   ��. ON DELETE CASCADE 
     �θ��� ������ �������� ��� ����
   ��. ON DELETE SET NULL 
   �θ��� ������ �������� ��� NULL ó����
   
--------------------------------------------------
   
--��. å ���̺�
CREATE TABLE book(
       b_id     VARCHAR2(10)  NOT NULL PRIMARY KEY --å id
      ,title      VARCHAR2(100) NOT NULL  --å ����
      ,c_name  VARCHAR2(100) NOT NULL  --
);
--Table BOOK��(��) �����Ǿ����ϴ�. 
--��. å �ܰ� ���̺�
CREATE TABLE danga(
      b_id  VARCHAR2(10)  NOT NULL  -- å id
      ,price  NUMBER(7) NOT NULL  -- å ����
      ,CONSTRAINT PK_dangga_id PRIMARY KEY(b_id)
      ,CONSTRAINT FK_dangga_id FOREIGN KEY (b_id)
              REFERENCES book(b_id)
              ON DELETE CASCADE
);
--Table DANGA��(��) �����Ǿ����ϴ�.
-- å ���̺� ���� ������ �װ��� �����ϴ� å �ܰ� ���̺� �������.
--��. �� ���̺�
CREATE TABLE gogaek(
      g_id       NUMBER(5) NOT NULL PRIMARY KEY -- �� id
      ,g_name   VARCHAR2(20) NOT NULL  --����
      ,g_tel      VARCHAR2(20) --������ó
);
--Table GOGAEK��(��) �����Ǿ����ϴ�.

--�Ǹ� ���̺�
CREATE TABLE panmai(
       id         NUMBER(5) NOT NULL PRIMARY KEY --�ǸŹ�ȣ, ���� seq
      ,g_id       NUMBER(5) NOT NULL CONSTRAINT FK_PANMAI_GID
                     REFERENCES gogaek(g_id) ON DELETE CASCADE --�����̺� ��id
      ,b_id       VARCHAR2(10)  NOT NULL CONSTRAINT FK_PANMAI_BID
                     REFERENCES book(b_id) ON DELETE CASCADE --å���̺� åid
      ,p_date     DATE DEFAULT SYSDATE  -- �Ǹų�¥(�⺻��sysdate)
      ,p_su       NUMBER(5)  NOT NULL -- �Ǹż���
);
--Table PANMAI��(��) �����Ǿ����ϴ�.
--�������̺�
CREATE TABLE au_book(
       id   number(5)  NOT NULL PRIMARY KEY --���ھ��̵�
      ,b_id VARCHAR2(10)  NOT NULL  CONSTRAINT FK_AUBOOK_BID --å ���̺� åid
            REFERENCES book(b_id) ON DELETE CASCADE
      ,name VARCHAR2(20)  NOT NULL --���ڸ�
);
--Table AU_BOOK��(��) �����Ǿ����ϴ�.
INSERT INTO book (b_id, title, c_name) VALUES ('a-1', '�����ͺ��̽�', '����');
INSERT INTO book (b_id, title, c_name) VALUES ('a-2', '�����ͺ��̽�', '���');
INSERT INTO book (b_id, title, c_name) VALUES ('b-1', '�ü��', '�λ�');
INSERT INTO book (b_id, title, c_name) VALUES ('b-2', '�ü��', '��õ');
INSERT INTO book (b_id, title, c_name) VALUES ('c-1', '����', '���');
INSERT INTO book (b_id, title, c_name) VALUES ('d-1', '����', '�뱸');
INSERT INTO book (b_id, title, c_name) VALUES ('e-1', '�Ŀ�����Ʈ', '�λ�');
INSERT INTO book (b_id, title, c_name) VALUES ('f-1', '������', '��õ');
INSERT INTO book (b_id, title, c_name) VALUES ('f-2', '������', '����');


INSERT INTO danga (b_id, price) VALUES ('a-1', 300);
INSERT INTO danga (b_id, price) VALUES ('a-2', 500);
INSERT INTO danga (b_id, price) VALUES ('b-1', 450);
INSERT INTO danga (b_id, price) VALUES ('b-2', 440);
INSERT INTO danga (b_id, price) VALUES ('c-1', 320);
INSERT INTO danga (b_id, price) VALUES ('d-1', 321);
INSERT INTO danga (b_id, price) VALUES ('e-1', 250);
INSERT INTO danga (b_id, price) VALUES ('f-1', 510);
INSERT INTO danga (b_id, price) VALUES ('f-2', 400);

--�Ǹ�(���ǻ�) -> ��(����)
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (1, '�츮����', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (2, '���ü���', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (3, '��������', '333-3333');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (4, '���Ｍ��', '444-4444');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (5, '��������', '555-5555');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (6, '��������', '666-6666');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (7, '���ϼ���', '777-7777');


INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (1, 1, 'a-1', '2000-10-10', 10);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (2, 2, 'a-1', '2000-03-04', 20);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (3, 1, 'b-1', DEFAULT, 13);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (4, 4, 'c-1', '2000-07-07', 5);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (5, 4, 'd-1', DEFAULT, 31);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (6, 6, 'f-1', DEFAULT, 21);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (7, 7, 'a-1', DEFAULT, 26);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (8, 6, 'a-1', DEFAULT, 17);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (9, 6, 'b-1', DEFAULT, 5);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (10, 7, 'a-2', '2000-10-10', 15);


INSERT INTO au_book (id, b_id, name) VALUES (1, 'a-1', '���Ȱ�');
INSERT INTO au_book (id, b_id, name) VALUES (2, 'b-1', '�տ���');
INSERT INTO au_book (id, b_id, name) VALUES (3, 'a-1', '�����');
INSERT INTO au_book (id, b_id, name) VALUES (4, 'b-1', '������');
INSERT INTO au_book (id, b_id, name) VALUES (5, 'c-1', '������');
INSERT INTO au_book (id, b_id, name) VALUES (6, 'd-1', '���ϴ�');
INSERT INTO au_book (id, b_id, name) VALUES (7, 'a-1', '�ɽ���');
INSERT INTO au_book (id, b_id, name) VALUES (8, 'd-1', '��÷');
INSERT INTO au_book (id, b_id, name) VALUES (9, 'e-1', '���ѳ�');
INSERT INTO au_book (id, b_id, name) VALUES (10, 'f-1', '������');
INSERT INTO au_book (id, b_id, name) VALUES (11, 'f-2', '�̿���');

COMMIT;

SELECT * FROM book;
SELECT * FROM danga;
SELECT * FROM gogaek;
SELECT * FROM panmai;
SELECT * FROM au_book;
-----------------------------
[EQUI JOIN]
�� �� �̻��� ���̺� ����Ǵ� �÷����� ���� ��ġ�ϴ� ��� Natural JOIN ����
book(PK)        danga
b_1  1    ==   b_1(FK,PK)  price
--����1) EQUI JOIN
-- åID, å ����, ���ǻ� c_name, å�ܰ� �÷� ��ȸ
-- BOOK ���̺� : b_id, title, c_name
-- DANGA ���̺� : price

��.
SELECT book.b_id, title, c_name, price
FROM book, danga
WHERE book.b_id = danga.b_id; --�񱳿����� = (����) ��� -> equi ����

��. book b, danga d ��Ī ���
SELECT b.b_id, b.title, b.c_name, d.price
FROM book b, danga d
WHERE b.b_id = d.b_id;

��. ���� ���̺��� �ִ� �͵��� ��Ī���� ��밡��.
SELECT b.b_id, title, c_name, price
FROM book b, danga d
WHERE b.b_id = d.b_id;

��. JOIN - ON ���� ���
SELECT b.b_id, title, c_name, price
FROM book b JOIN danga d ON b.b_id = d.b_id;

��. USING �� ���( ��ü��, ��Ī ��� ����)
SELECT b_id, title, c_name, price
FROM book JOIN danga USING( b_id);

��. NATURAL JOIN ���� ��� (���߿�)
SELECT b_id, title, c_name, price
FROM BOOK NATURAL JOIN danga; --���� ������ ��� ��.

[����2] 'KING'����� �μ� Ȯ�� �� NULL�� ����

SELECT *
FROM emp
WHERE ename ='KING';

UPDATE emp
SET deptno = null
WHERE empno=7839; --pk ������ �����ϱ�

commit;

[����3 ]dept, emp �����ؼ� empno, deptno, dname, ename, hiredate�÷� ��ȸ

�θ����̺� dept : deptno(PK), dname
�ڽ����̺� emp : empno(PK), deptno(FK), ename, hiredate

��. join on 
SELECT empno, e.deptno, dname, ename, hiredate
FROM emp e JOIN dept d ON e.deptno=d.deptno;

��. using��
SELECT empno, deptno, dname, ename, hiredate
FROM emp JOIN dept USING (deptno);

��. alias ���
SELECT empno, e.deptno, dname, ename, hiredate
FROM emp e , dept d 
WHERE e.deptno=d.deptno;

--������: king ����� ��µ��� �ʴ´�. ��? ���������̱� ������
SELECT *
FROM dept;
FROM emp;

--EQUI JOIN : join ���̺� ��� �־�� ��µȴ�.

[����4]åid,�Ǹż���, �ܰ�, ������(��), �Ǹűݾ�(�Ǹż���+�ܰ�)��ȸ
book : b_id, 
panmai : p_su, g_id,
gogaek : g_name
danga : price * panmai :  p_su

SELECT b.b_id, title,  p_su, price, g_name, (price * p_su) �Ǹűݾ�
FROM book b, panmai p, danga d , gogaek g
WHERE (b.b_id = p.b_id) AND b.b_id =d.b_id AND p.g_id = g.g_id ;

SELECT b_id, title,  p_su, price, g_name, (price * p_su) �Ǹűݾ�
FROM book b JOIN panmai p ON b.b_id = p.b_id
            JOIN danga d ON b.b_id =d.b_id
            JOIN gogaek g ON p.g_id = g.g_id;

    [����5] ���ǵ� å���� �� �������?
   åID, å����, �� �ǸűǼ�, �ܰ��÷� ���
 book - b_id, title
 panmai - p_su
 danga - price
--1�ܰ�)
SELECT b.b_id, title,  p_su, price
FROM book b JOIN panmai p ON b.b_id = p.b_id
            JOIN danga d ON b.b_id =d.b_id;

--2)GROUP BY �� ��� - b_id
 
SELECT b.b_id, SUM(p_su)
FROM book b JOIN panmai p ON b.b_id = p.b_id
            JOIN danga d ON b.b_id = d.b_id
GROUP BY b.b_id
ORDER BY b.b_id asc;

--3. ORA-00979: not a GROUP BY expression
SELECT b.b_id, title, price, SUM(p_su)
FROM book b JOIN panmai p ON b.b_id = p.b_id
            JOIN danga d ON b.b_id = d.b_id
GROUP BY b.b_id, title, price
ORDER BY b.b_id asc;

4. �����������

[����6] ������ å�� ��ü �Ǹŷ��� ���ۼ�Ʈ�� �ش�?

-- 163�� 
SELECT SUM(p_su) total_qty 
FROM panmai; 


SELECT b.b_id
        ,title, price
        , SUM(p_su) bid_qty
        , (SELECT SUM(p_su) FROM panmai) total_qty
        , ROUND( SUM(p_su) / (SELECT SUM(p_su) FROM panmai) *100,2) pc
FROM panmai p JOIN book b ON p.b_id = b.b_id
            JOIN danga d ON b.b_id = d.b_id
GROUP BY b.b_id, title, price
ORDER BY pc DESC;

--[����] book ���̺��� �ǸŰ� �� ���� ����/�ִ� å���� ������ ��ȸ
--b_id, title, price

1. å �� ���? 9��
SELECT COUNT (*) --9
FROM book;

2. �Ǹŵ� �� �ִ� å (�������� �͸� ����ϰڴ� equi join�� ���� �˸� ��)

[���1]
--�ִ�
SELECT b.b_id, title, price
FROM book b JOIN danga d ON b.b_id = d.b_id
WHERE b.b_id IN (SELECT DISTINCT b_id FROM panmai);

--����
SELECT b.b_id, title, price
FROM book b JOIN danga d ON b.b_id = d.b_id
WHERE b.b_id not IN (SELECT DISTINCT b_id FROM panmai);

[���2]

--a
WITH 
a AS (
    SELECT DISTINCT b_id 
    FROM panmai
),
b AS (
    SELECT b.b_id, title, price
    FROM book b JOIN danga d ON b.b_id = d.b_id
)
SELECT b.b_id, title, price
FROM a JOIN b ON a.b_id = b.b_id;
--a��b equl join

[���3]
SELECT b.b_id, title, price
FROM book b JOIN ( SELECT DISTINCT b_id   FROM panmai) p ON b.b_id = p.b_id
            JOIN danga d ON b.b_id =d.b_id;
            
            (+) OUTER JOIN ����ؼ� Ǯ��ȴ�.
;
[���4]
--�Ǹ�X
SELECT b.b_id, title, price, NVL( P_SU,0)
FROM book b LEFT JOIN panmai p ON b.b_id = p.b_id --LEFT OUTER JOIN
                 JOIN danga d ON b.b_id =d.b_id  --INNER JOIN == EQUI JOIN 
WHERE p_su is null;               
 -------------------
 [����] ���� ���� �ǸŰ� �� å�� ����
    åid, ����, ����, �� �Ǹŷ�;

[���1] top-n, rownum
SELECT t.*  --, ROWNUM
FROM (
SELECT b.b_id, title, price, SUM( p_su) qty
FROM  book b JOIN panmai p  ON b.b_id = p.b_id
               JOIN danga d ON p.b_id =d.b_id
GROUP BY b.b_id, title, price
ORDER BY qty desc
 )t
 WHERE ROWNUM=1;
 
[���2] rank() �Լ�

SELECT *
FROM (
SELECT b.b_id, title, price, SUM( p_su) qty
     ,RANK() OVER (ORDER BY SUM( p_su) desc) qty_rank
FROM  book b JOIN panmai p  ON b.b_id = p.b_id
               JOIN danga d ON p.b_id =d.b_id 
GROUP BY b.b_id, title, price
--HAVING �� qty_rank;
)t
WHERE qty_rank=1;

[����9] ���� �Ǹŵ� å TOP3  WHERE���� �����ϸ� �� WHERE qty_rank <=3
[����10] ���� ���� �Ǹŵ� å desc�� ���� -> �Ǹŵ� �� �߿� ���� ���� ��
SELECT t.*  --, ROWNUM
FROM (
SELECT b.b_id, title, price, SUM( p_su) qty
FROM  book b JOIN panmai p  ON b.b_id = p.b_id
               JOIN danga d ON p.b_id =d.b_id
GROUP BY b.b_id, title, price
ORDER BY qty 
 )t
 WHERE ROWNUM=1;
 
 [����11] ��� å �߿� ���� ���� �ȸ� ��? - outer join ���
SELECT t.*  --, ROWNUM
FROM (
 SELECT b.b_id, title, price, SUM( p_su) qty
 FROM  book b RIGHT JOIN panmai p  ON b.b_id = p.b_id
               JOIN danga d ON p.b_id =d.b_id
 GROUP BY b.b_id, title, price
 ORDER BY qty 
 )t
 WHERE ROWNUM=1;
 
 
 [����12] �� �ǸűǼ��� 10���̻��� å�� ���� ���
        åid, ����, ����, �� �Ǹŷ�;
  
 SELECT *
 FROM (SELECT b.b_id, title, price,  SUM( p_su) qty  
        FROM  book b JOIN panmai p  ON b.b_id = p.b_id
               JOIN danga d ON p.b_id =d.b_id
        GROUP BY b.b_id, title, price
 )t
 WHERE qty >=10;

SELECT b.b_id, title, price,  SUM( p_su) qty  
FROM  book b JOIN panmai p  ON b.b_id = p.b_id
               JOIN danga d ON p.b_id =d.b_id
GROUP BY b.b_id, title, price
HAVING SUM( p_su) >=10
ORDER BY qty DESC;
---------------------
--[? NON-EQUI JOIN :]
--����Ǵ� �÷��� ��Ȯ�� ��ġ���� �ʴ� ��쿡 ���Ǵ� JOIN�� ����
--WHERE ���� BETWEEN ... AND ... �����ڸ� ���

emp/salgrade JOIN ����� �޿����

SELECT empno, sal , grade
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-------------------
+  (���) ��������� �߿� ����������
    (�� ����) ���׿����� 

? : (���) ���ǿ�����
     (�װ���) ���׿�����
   
INNER JOIN == EQUI JOIN ��� ����.
  �� �̻��� ���̺��� JOIN ������ �����ش� �ุ ��ȯ.

     
SELECT empno, ename, dname
FROM emp e JOIN dept d ON e.deptno =d.deptno;
FROM emp e INNER JOIN dept d ON e.deptno =d.deptno;


OUTER JOIN
--JOIN ������ �������� �ʴ� ���� ���� ���� �߰����� JOIN�� ����
EX. emp deptno=null      emp deptno = 10,20,30,40
      KING
FULL OUTER JOIN�� ���� �������� UNION�� �̿��� ����� ������ ����� ��´�.

��. LEFT [OUTER] JOIN 
��. RIGHT [OUTER] JOIN 
��. FULL [OUTER] JOIN 

SELECT empno, ename, NVL( dname,'�μ�����')
FROM emp e LEFT JOIN dept d ON e.deptno =d.deptno;

SELECT empno, ename, NVL( dname,'�μ�����')
FROM dept d RIGHT JOIN emp e ON e.deptno =d.deptno;
FROM dept d JOIN emp e ON e.deptno(+) =d.deptno;

SELECT empno, ename, NVL( dname,'�μ�����')
FROM dept d JOIN emp e ON e.deptno =d.deptno(+);
FROM emp e LEFT JOIN dept d ON e.deptno =d.deptno;

SELECT empno, ename, dname
FROM emp e FULL JOIN dept d ON e.deptno =d.deptno;

[����14] �� �μ��� ����� ��ȸ OUTER JOIN ���
SELECT d.deptno, count(e.deptno) --*���� null�����ϹǷ� 40���μ�1����
FROM dept d LEFT JOIN emp e ON  e.deptno = d.deptno
GROUP BY d.deptno
ORDER BY d.deptno ASC;

--null ���Ե��� ���� ������ count�ϱ�
SELECT d.deptno, count(ename) 
FROM dept d FULL JOIN emp e ON  e.deptno = d.deptno
GROUP BY d.deptno
ORDER BY d.deptno ASC;
-----------
? CROSS JOIN :
Cartesian Product�� ������ ����� ����.
�� cartesian product�� �ſ� ���� ���� �����ϹǷ� "���� �幰��" ���ȴ�.
�� ���̺� ���� 100���� ���� ������ �ִٸ�, 10000���� cartesian product ����� �����Ǳ� �����̴�.

? ANTIJOIN : 
���������� ��� �ӿ� �ش� �÷��� �������� �ʴ� ���� NOT IN�� �����

? SEMIJOIN :
���������� ��� �ӿ� �ش� �÷��� �����ϴ� ���� EXISTS�� �����

------------------------
-- ���α׷��ӽ� SQL - JOIN ����
--1��
SELECT AO.ANIMAL_ID, AO.NAME
FROM ANIMAL_INS AI RIGHT JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE AI.DATETIME IS NULL;


SELECT AO.ANIMAL_ID, AO.NAME
FROM ANIMAL_INS AI RIGHT JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE AO.ANIMAL_ID NOT IN (SELECT ANIMAL_ID FROM ANIMAL_INS)
ORDER BY AO.ANIMAL_ID;
--2��
SELECT AI.ANIMAL_ID, AI.NAME
FROM ANIMAL_INS AI JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE AI.DATETIME > AO.DATETIME
ORDER BY AI.DATETIME ASC;

--3��
SELECT t.name, t.datetime 
FROM(
    SELECT AI.NAME, AI.DATETIME
       ,ROWNUM
    FROM ANIMAL_INS AI LEFT JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
    WHERE AI.ANIMAL_ID NOT IN(SELECT DISTINCT ANIMAL_ID FROM ANIMAL_OUTS)
    ORDER BY AI.DATETIME
)t
WHERE ROWNUM <=3 ;

--4��
SELECT AI.ANIMAL_ID, AI.ANIMAL_TYPE, AI.NAME
FROM ANIMAL_INS AI RIGHT JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE SEX_UPON_INTAKE != SEX_UPON_OUTCOME