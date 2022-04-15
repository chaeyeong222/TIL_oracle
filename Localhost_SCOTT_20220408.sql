1. ���� �޽����� ���ؼ� �����ϼ��� .
 ��. ORA-01438: value larger than specified precision allowed for this column 
 Į���� ���� ���� �ʰ��� ��
 dname varchar2(14) 14byte  '�Ƹ��ٿ�μ�' 18byte
 ��. ORA-00001: unique constraint (SCOTT.PK_DEPT) violated      
 INSERT deptno =30  ����Ű �ߺ�
 ��. ORA-00923: FROM keyword not found where expected 
 from �� �� �ڿ� ���� �߸���
 
 ��. ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record found �ڽ� Ŭ�������� ã�� �� ����
 dept - 10,20,30,40  (pk)  �θ����̺�
 emp 60 �μ��� ����߰�   -> pk�� emp���� �����ϰ� ���� �ڽ����̺�
 �θ����̺��� pk�� �ڽ����̺��� fk�� �����Ѵ�. (����)
   -> fk �� ����ȴ�       
 
2. RR��  YY�� �������� ���ؼ� �����ϼ��� .
����ý����� 2000�⵵ /21����
RR 50-99  1900���  0-49 2000���
YY 2000���
yy�� �ý��� ��¥ ���� ����
rr�� �ý��� ��¥���� 50���� �������� ����� ����

3. JAVA :  5 % 2  �ڵ��� ����Ŭ�� ������ ���ؼ� ����ϴ� ������ �ۼ��ϼ���.
SELECT MOD(5,2)
FROM dual;

4. dept ���̺��� ����ؼ� �� DML���� ������ ����, ���� �ۼ��ϰ� �����ϼ���. 

INSERT INTO ���̺�� VALUES
UPDATE ���̺��
SET �÷��� =�÷���
[WHERE = ������]
DELETE FROM ���̺��
[WHERE = ������]
 ��. ���ο� �μ��� �߰�(insert)�ϴ� ���� �ۼ� �� Ȯ�� 
 DESC dept;
 
    1) (  50, QC, SEOUL )
    INSERT INTO dept ( deptno, dname, loc) VALUES (50, 'QC', 'SEOUL' );
    1 �� ��(��) ���ԵǾ����ϴ�.
    2) (  60, T100%, SEOUL )
    INSERT INTO dept ( deptno, dname, loc) VALUES (60, 'T100%', 'SEOUL' );
     1 �� ��(��) ���ԵǾ����ϴ�.
    3) (  70, T100T, BUSAN )
    INSERT INTO dept ( deptno, dname, loc) VALUES (70, 'T100T', 'BUSAN' );
     1 �� ��(��) ���ԵǾ����ϴ�.
 ��. 60�� �μ��� �μ���,  �������� ���� 
     ( ���� �μ��� �ڿ� 'X' ���ڿ� �߰��ؼ� ����, �������� DAEGU �� ���� ) 
     UPDATE dept 
     SET dname = dname || 'X',loc = 'DAEGU'
     WHERE deptno = 60;
 ��. LIKE �����ڸ� ����ؼ� �μ��� '%' ���ڰ� ���Ե� �μ� ���� ��ȸ�ϴ� ���� �ۼ�
 
 SELECT *
 FROM dept
 WHERE  dname LIKE '%\%%' ESCAPE '\';
 
 ��. REGEXP_LIKE() �Լ��� ����ؼ� �μ��� '%' ���ڰ� ���Ե� �μ� ���� ��ȸ�ϴ� ���� �ۼ�
 SELECT *
 FROM dept
 WHERE REGEXP_LIKE(dname, '%');
 
 ��. �μ���ȣ 50, 60, 70�� �μ� ����
 DELETE FROM dept
 WHERE deptno >=50;
 WHERE deptno IN (50,60,70);
 WHERE deptno BETWEEN 50 AND 70;
 
 
5. �ѱ� �� ���ڿ� ���ĺ� �� ���ڰ� �� ����Ʈ���� ����ϴ� ���� �ۼ�
SELECT VSIZE('��')
FROM dual;

SELECT VSIZE('A')
FROM dual;

6. insa ���̺��� ���ڴ� 'X', ���ڴ� 'O' �� ����(gender) ����ϴ� ���� �ۼ�

���1)
SELECT t.*
     ,REPLACE( REPLACE(t.gender, '1','X'),'2','O') gender
FROM (--�ζ��� ��
    SELECT name, ssn
          ,SUBSTR(ssn,8,1)GENDER
    FROM insa
)t;

���2) NULL ���õ� �Լ�  NVL2()  NUL() 
  NULLIF(?,?) ������ NULL ��ȯ �ٸ��� ���� �� ��ȯ

SELECT name,ssn
      , SUBSTR(ssn, -7,1) gender
      , MOD(SUBSTR(ssn,-7,1),2) gender  --0 ����,1����
      ,NVL2( NULLIF( MOD(SUBSTR(ssn, -7,1),2) ,1),'O','X') gender
FROM insa;

WITH temp AS (
    SELECT name, ssn
          ,REPLACE ( SUBSTR(ssn,8,1), NULL)
    FROM insa
    WHERE SUBSTR(ssn,8,1) = 1
)
SELECT name, ssn
      ,NVL2(SUBSTR(ssn,8,1),'x','o')
FROM insa;

�����
���� ���� ���� -> ���ڿ� '1'
���� ������ ���� -> ���� 1

      ,NVL(REPLACE(SUBSTR(ssn,8,1),1,null)
FROM insa

    NAME                 SSN            GENDER
    -------------------- -------------- ------
    ȫ�浿               771212-1022432    X
    �̼���               801007-1544236    X
    �̼���               770922-2312547    O
    ������               790304-1788896    X
    �Ѽ���               811112-1566789    X

7. insa ���̺��� 2000�� ���� �Ի��� ���� ��ȸ�ϴ� ���� �ۼ�
SELECT name, ibsadate
FROM insa
WHERE TO_CHAR(ibsadate,'YYYY')>=2000     --'2000' >=2000
WHERE ibsadate >='2000.01.01'
WHERE EXTRACT(YEAR FROM ibsadate) >=2000 ;

    NAME                 IBSADATE
    -------------------- --------
    �̹̼�               00/04/07
    �ɽ���               00/05/05
    �ǿ���               00/06/04
    ������               00/07/07
    
8-1. Oracle�� ��¥�� ��Ÿ���� �ڷ��� 2������ ��������.
   ��. DATE
   ��. TIMESTAMP
   
8-2. ���� �ý����� ��¥/�ð� ������ ����ϴ� ������ �ۼ��ϼ���.

--SYSDATE �Լ� : ���� �ý����� ��¥, �ð� �� �� ��ȯ
--CURRENT _DATE : ���� SESSION�� ��¥ ������ ��/��/�� 24��:��:�� �������� ��ȯ
--         ��ȯ�Ǵ� DATE ������Ÿ���� GREGORIAN CALENDAR�̴�
--CURRENT_TIMESTAMP : 

--����Ŭ - �ν��Ͻ� : DB ���� ���۽��� ���� ���� ���� ��������
--����Ŭ - ���� : ���� ����ڰ� �α��� �� �������� �α׾ƿ� �� ��������

SELECT SYSDATE, CURRENT_DATE, CURRENT_TIMESTAMP
FROM dual;

22/04/08   ,  22/04/08   ,22/04/08 10:50:05.000000000 ASIA/SEOUL
9. HR �������� �����ؼ� 
   SELECT * FROM scott.dept;
   ���� ������ �����ϸ� ORA-00942: table or view does not exist ������ �߻��Ѵ�.
   �׷���
   HR ���������� scott.dept ���̺��� SELECT�� �� �ֵ��� ���Ѻο� �� arirang �̶� �̸����� 
   �ó��( SYNONYM )�� �����ؼ�
   HR ���������� SELECT * FROM arirang ������ ����� �� �ֵ��� �����ϰ� �׽�Ʈ�ϴ� 
   ��� ������ ������� �ۼ��ϼ���. 
   
  1) sys���� �����ؼ�
   CREATE PUBLIC SYNONYM arirang
   FOR scott.dept;
  2)
   scott ���� �����ؼ�
   GRANT SELECT ON dept TO HR;
  3) 
   hr���� �����ؼ�
   SELECT *
   FROM arirang;
   
   
   
10. emp ���̺��� �����(ename)�� 'e'���ڸ� ������ ����� �˻��ؼ� �Ʒ��� ���� ���.

SELECT ename, REPLACE(ename, 'E','[E]') SEARCH_ENAME
FROM emp
WHERE ename LIKE UPPER('%e%');

SELECT ename
        ,REPLACE( ename, UPPER( :input ), '['|| UPPER(:input) || ']'  )SEARCH_NAME
FROM emp
WHERE REGEXP_LIKE(ename, :input, 'i');


   : ������ 
   ��. ���ε庯�� bind variable
   ��. ���� session �� �����Ǵ� ���� ��� ������ ����
   
    ENAME   SEARCH_ENAME
    --------------------
    ALLEN	ALL[E]N
    JONES	JON[E]S
    BLAKE	BLAK[E]
    TURNER	TURN[E]R
    JAMES	JAM[E]S
    MILLER	MILL[E]R

11.   UPDATE ���� WHERE �������� ���� ���� ��� �ǳ� ?  ����..?
11-2. DELETE ���� WHERE �������� ���� ���� ��� �ǳ� ? ���λ���

12. DML( INSERT, UPDATE, DELETE ) �� ���� �� �ݵ�� ������ �� �־�� �ϳ� ? 
commit �Ǵ� rollback

13. insa ���̺��� 
   ��. �������(city)�� ��õ�� ����� ����(name,city,buseo)�� ��ȸ�ϰ�
   ��. �μ�(buseo)�� ���ߺ��� ����� ����(name,city,buseo)�� ��ȸ�ؼ�
   �� ������� ������(UNION)�� ����ϴ� ������ �ۼ��ϼ���. 
   ( ���� : SET(����) ������ ��� )
   SELECT name, city, buseo
   FROM insa
   WHERE city = '��õ'
   UNION
   SELECT name, city, buseo
   FROM insa
   WHERE buseo = '���ߺ�';
   
   
   3 [6] 8 ==17��
   ----------------
   SELECT name, city, buseo
   FROM insa
   WHERE city = '��õ'
   UNION ALL
   SELECT name, city, buseo
   FROM insa
   WHERE buseo = '���ߺ�';

��õ    ��õ &����    ���ߺ�    
3            6        8      U 17��
                            UA 23��
 UA -> �ߺ��Ǵ��� �ι� ����ϰڴ�(������)
 
--------------
SELECT ename, sal   --,comm Į�� �� �ٸ��� ������ / Ÿ�� �޶� ����   
FROM emp
UNION
SELECT name, basicpay
FROM insa;
----------------
  SELECT name, city, buseo
   FROM insa
   WHERE city = '��õ'
   MINUS
   SELECT name, city, buseo
   FROM insa
   WHERE buseo = '���ߺ�';

--������
--�����	��õ	��ȹ��
--������	��õ	������
--�ּ���	��õ	ȫ����

SELECT name, city, buseo
FROM insa
WHERE city = '��õ' AND buseo != '���ߺ�';

---------
SELECT name, city, buseo
FROM insa
WHERE city = '��õ'
INTERSECT
SELECT name, city, buseo
FROM insa
WHERE buseo = '���ߺ�';
--������
SELECT name, city, buseo
FROM insa
WHERE city = '��õ' AND buseo = '���ߺ�';
---------
IS NAN
IS INFINITE
IS NULL --���̴�?
-------------
--����Ŭ �Լ�
1. ������ ������ -> ������ ó�� (����) -> ��� ��ȯ
2. �Լ��� ���
   ��. ������ ���     ��Ʈ 4=2  -> sqrt(4)
   ��. ������ ����     UPPER('abc')
   ��. �׷��� ����� ���     �׷��Լ� �׷��Լ�(group function) = �����Լ� COUNT()
   ��. ��¥ ������ ���� TO_CHAR()
   ��. �÷� ������ Ÿ�� ����
       ��¥�� -> ���ڿ�, ���ڿ�-> ��¥�� ����
       ���ڿ� <-> ������
   
   ����) insa ���̺��� �� ����� ���?
SELECT COUNT(*) �ѻ����
FROM insa;
    ������ ���?
SELECT COUNT(*) �ѻ����
FROM insa
WHERE buseo; 

------------

����)emp ���̺� ���� �� �μ��� ��� ���� �� ������� �ľ�
  10�� �μ� : 3��
  20�� �μ� : 4�� ...
    �� ����� : 12��
    
SELECT COUNT(*)
FROM emp
WHERE deptno = 10
UNION ALL
SELECT COUNT(*)
FROM emp
WHERE deptno = 20
UNION ALL
SELECT COUNT(*)
FROM emp
WHERE deptno = 30
UNION ALL
SELECT COUNT(*)
FROM emp;
-------------
�Լ��� ����

��. ������ �Լ�
SELECT ename, UPPER(ename), LOWER(ename)
FROM emp;
��. ������ �Լ� = �׷��Լ�

SELECT COUNT(*)
FROM emp;

4. ������ �Լ��߿� '�����Լ�'
SELECT SQRT(4)  --������, ��Ʈ
         --,SIN(),COS(),TAN()
         ,LOG()
         ,LN() --�ڿ��αװ�
         ,POWER(2,3) ---����, ����
         ,MOD(5,2)-- ������
         ,ABS(100), ABS(-100) --���밪
FROM dual;
   ��. ROUND(NUMBER  [, ��ġ]) : Ư�� ��ġ���� �ݿø�  
     -- ���� ROUND( n [,INTEGER])
     ROUND(a,b)�� a�� �Ҽ��� ���� b+1 �ڸ����� �ݿø��Ͽ� b���� ����Ѵ�
     b�� ������(b=0) �Ҽ��� ù��° �ڸ����� �ݿø�,
     b���� �����̸� �Ҽ��� ���� b�ڸ����� �ݿø��Ѵ�
     
 SELECT 3.141592 PI
      ,ROUND(3.141592 )  --3
      ,ROUND(3.641592)  --4
      ,ROUND(3.141592, 2)  --  3.14  b=2   +1  -> �Ҽ��� 3��° �ڸ����� �ݿø�
      ,ROUND(123.141592, -2 ) --10���ڸ����� �ݿø�  -> 100 
 FROM dual;
 
 ��. ���� emp ���̺��� pay(sal+comm) �ѱ޿���(27125)/�ѻ����(12) => ��ձ޿���
    ����) �Ҽ���3�ڸ����� �ݿø�
 SELECT *
 FROM emp;

SELECT COUNT(*) total_number
FROM emp;

-- SUM() �����Լ�=�׷��Լ�
SELECT SUM (sal + NVL(comm,0)) total_pay
FROM emp;

--2260.416666666666666666666666666666666667 
--2260.42
SELECT ROUND( (SELECT SUM (sal + NVL(comm,0)) FROM emp)/(SELECT COUNT(*) FROM emp),2) AVG_PAY
FROM dual;
 
 SELECT SUM(sal+NVL(comm, 0))
       ,COUNT(*)
       ,SUM((sal+NVL(comm, 0))/COUNT(*)
 FROM emp;
 
 SELECT count(*), sal+NVL(comm,0) as pay, ROUND((count(*)+ pay)/2),1)
 FROM emp;


FROM emp;

  ��. TRUNC(n,m)  ���� �Լ�(����) + ������ Ư����ġ    -> ������, �Ǽ�
      FLOOR()  ���� �Լ�(����)  + ������ �Ҽ� ù°�ڸ�  -> ������
      
      TRUNC(n) == FLOOR(n) == TRUNC(n,0)

SELECT 123.141592
        ,FLOOR(123.141592) -- 123 �Ҽ��� ù��° �ڸ����� ����
         ,FLOOR(123.941592) -- 123 �Ҽ��� ù��° �ڸ����� ����
         ,TRUNC(123.141592)
         ,TRUNC(123.941592,0)
         ,TRUNC(123.941592,1)  -- 123.9 �Ҽ��� �ι��� �ڸ����� ����
         ,TRUNC(123.941592,-1)  -- 120 �����ڸ����� ����
FROM dual;

��. CEIL()  �Ҽ��� ù��° �ڸ����� �ø��ϴ� �Լ�, Ư����ġ���� �ø�X

SELECT CEIL(3.141592)  --4
      ,CEIL(3.941592)  --4
FROM dual;

    -ROUND(), CEIL(), FLOOR(), TRUNC()

����) �Խ��ǿ��� 
    �� �Խñ� ���� ; 652
    �� �������� ����� �Խñ� �� : 15
    �� ������ ��?
    
SELECT CEIL(652/15)
FROM dual;

����) �Ҽ��� 3�ڸ����� �ø� , 10�� �ڸ����� ����
SELECT 1234.5678
      ,CEIL(1234.5678*100)/100
      ,CEIL(1234.5678/100)*100
FROM dual;

  ��. SIGN(n)  ���� ���� ���� ������ 1,0�̶�� 0, ������� -1 ��ȯ�ϴ� �Լ�
  
SELECT SIGN(100), SIGN(0), SIGN(-100)
from dual;

����) emp���̺� ��� �޿����� ���� ������ 1 ���Թ����� -1 ������ 0��� �ǵ��� �ϱ�

SELECT ename, sal+NVL(comm,0)pay
       ,ROUND( AVG(sal+NVL(comm,0)),2) avg_pay
FROM emp;
--ORA-00937: not a single-group group function
-- ���� ���ϱ׷�, �׷��Լ� �ƴ�.
-- �����Լ��� �Ϲ�Į���� �Բ� ����� �� ����. ***

SELECT t.*
     , ABS( t.pay-t.avg_pay)
    ,NVL2(NULLIF( SIGN(t.pay - t.avg_pay),1),'����','����')
FROM (SELECT ename, sal+NVL(comm,0)pay
       ,(SELECT ROUND( AVG(sal+NVL(comm,0)),2) FROM emp) avg_pay
       FROM emp
      )t;

SELECT SUM(sal+NVL(comm,0))pay
       ,ROUND( AVG(sal+NVL(comm,0)),2) avg_pay
FROM emp;

SELECT AVG(sal+NVL(comm,0))
      ,ROUND( AVG(sal+NVL(comm,0)),2) avg_pay
FROM emp;
  
--------�����Լ�

SELECT 'Kbs'
      , UPPER('Kbs') --'KBS'
      , LOWER('Kbs') --'kbs'
      ,INITCAP('kbs')--'Kbs'
FROM dual;

SELECT job
    ,LENGTH(job) --���ڿ� ���̸� �������� �Լ�
    ,CONCAT (empno, ename)
FROM emp;

--INSTR  (string, substring [,position [ ,occurence]])
SELECT ename
          , INSTR(ename, 'I') --ã�� ���ڿ� �ִ� ��ġ
FROM emp;

SELECT
    INSTR('corporate floor','or')  --2
    ,INSTR('corporate floor','or',3)--5
    ,INSTR('corporate floor','or',3,2)--14
    ,INSTR('corporate floor','or',-3,2) --�ڿ��� 3��°���� ã�ƶ�
FROM dual;

  ����) ��ȭ��ȣ ���̺�
       ���̺� �� TBL_TEL
       ��ȣ(����) NUMBER
       ��ȭ��ȣ   02)123-1234
                054)7223-2323
                031)9837-8933
 -- CREATE TABLE ���̺��              

SELECT *
FROM tbl_tel;

����) ����Ŭ ����, ���� �Լ� ����ؼ�
   ��ȣ,  ��ȭ��ȣ�� ������ȣ�� ���, �߰� ��ȣ�� ���, ������ ��ȣ�� ���
   
   --������ȣ ��� ���� ) �� ��ġ ���� ã��
SELECT no ,tel
      ,INSTR(tel, ')')       ")��ġ"
      ,INSTR(tel, '-',-1)    "-��ġ"
      ,SUBSTR(tel, 0, INSTR(tel, ')')-1)
      ,SUBSTR(tel,INSTR(tel, ')')+1,    INSTR(tel, '-')-1  -INSTR(tel, ')'))
      ,SUBSTR(tel, INSTR(tel, '-')+1)
FROM tbl_tel;

----- RPAD, LPAD
[����]
   RPAD(expr1, n[,expr2])
   
-- ORA-01722: invalid number    () �־ ���� ó���ǰԲ� �ϸ� ���� �ذ�
SELECT ename, sal+NVL(comm,0) pay
          ,LPAD ('��' || (sal+NVL(comm,0)) ,10,'*') -- 10�ڸ� Ȯ���ϰ� �ݾ� ����,�����ڸ��� *-
          ,RPAD (sal+NVL(comm,0) ,10,'*')
FROM emp;

����) PAY 10�ڸ����� �ݿø��ϰ� 100���� ������ ���� �� ��ŭ # ����.
SELECT ename, sal+NVL(comm,0) pay
      ,ROUND( (sal+NVL(comm,0))/100)  "#����"
      ,RPAD(' ',ROUND( (sal+NVL(comm,0))/100)+1,'#')
FROM emp;

SMITH	800      ########
ALLEN	1900     ## (19��)
WARD	1750     ##(18�� - �ݿø�)
JONES	2975
MARTIN	2650
BLAKE	2850
CLARK	2450
KING	5000
TURNER	1500
JAMES	950
FORD	3000
MILLER	1300

����) RPAD �̿��ؼ� �ֹι�ȣ ���ڸ� * ǥ��
SELECT name, ssn
      , RPAD( SUBSTR(ssn,0,8) , 14, '*')
FROM insa;

--ASCII(char)   ����Ŭ ���� �ڷ��� : char

SELECT ename
      ,SUBSTR(ename, 0 ,1)
      ,ASCII( SUBSTR(ename, 0 ,1))
      , ASCII('��')  --3����Ʈ
      ,CHR(65)   --�����ڵ尪�� �ٽ� ���ڷ�
      , CHR(15380608)
FROM emp;

------------- 
GREATEST(?,?,?)
LEAST(?,?,?)
 -- ���� ���� ����

SELECT
    GREATEST(500,10,200)
    ,LEAST(500,10,200)
    ,GREATEST('KBS','ABC','XYZ')
    ,LEAST('KBS','ABC','XYZ')
FROM dual;

-------��¥ �Լ�
SELECT SYSDATE    -- ���� �ý��� 
       ,CURRENT_DATE   --���� ����
       ,CURRENT_TIMESTAMP
FROM dual;

  TRUNC(date) ��¥ ���� Ư����ġ
   ROUND(date) ��¥ �ݿø� Ư����ġ

--���� �Լ�
   TRUNC(number) ���� Ư����ġ
   ROUND(number) �ݿø� Ư����ġ
   
   --,ROUND(date [,format]) formate ������ ��������, ������ format����
SELECT SYSDATE  --22/04/08
    ,ROUND(SYSDATE) --22/04/09 / ������ �������� ��¥�� �ݿø��Ͽ� �����Ѵ�.
    ,ROUND(SYSDATE,'DD') --15�� ����
    ,ROUND(SYSDATE,'MM')   --���� ����
    ,ROUND(SYSDATE,'YY')
    ,ROUND(SYSDATE,'DAY')
FROM dual;

--TRUNC(date) ���� ���
SELECT CURRENT_TIMESTAMP
    ,TRUNC( CURRENT_TIMESTAMP)
    ,SYSDATE
    ,TRUNC(SYSDATE)
FROM dual;
--��� ��?
-- ��������, ��ǥ  22.3.1.9��~ 22.4.8.����  ->�ð�üũ


--��¥�� + ����  = ��¥��
--��¥�� - ����  = ��¥��
--��¥�� - ��¥  = �� ��( ����)
--��¥�� + ����/24 (�ð�)  = ��¥��

SELECT SYSDATE   --22/04/08
      ,SYSDATE +3  --22/04/11
      ,SYSDATE -3 --22/04/05
      
FROM dual;

--����) EMP���̺��� ������� �ٹ��ϼ� ��ȸ

SELECT ename, hiredate  --DATE ��¥ �ڷ���
      ,SYSDATE  --DATE ��¥ �ڷ���
      ,CEIL(ABS(hiredate-SYSDATE)) "�ٹ��ϼ�"
  --���ݺ��� 2�ð� �Ŀ� ������
      ,TO_CHAR(SYSDATE + 2/24
      ,'YYYY/MM/DD HH:MI:SS')
FROM emp;
