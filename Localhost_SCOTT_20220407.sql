1. subquery �� ���� �����ϼ��� ?  
  ��. �ϳ��� SQL ������ ���� �μӵ� �� �ٸ� select ����,
       �� ���� ���Ǹ� �����ؾ� ���� �� �ִ� ����� �� ���� ���Ƿ� �ذ�
  ��.  >, >=, < , <=     + ������ (��������)
          IN SOME ANY
  ��. ���ǰ� �������� ���� �ٰŷ� �� �� ����
  ��. subquery�� mainquery�� �������� ���
     WHERE ������ �ȿ� (��������) 
  ��. subquery�� ����� main outer query�� ���� ���ȴ�
  ��. subquery�� ���� ������ subquery�� ���� �����ϰ�, �� ����� mainquery�� �����Ͽ� ����
  ��. WHERE, HAVING, INSERT������ INTO��,UPDATE������ SET��, SELECT /DELETE���� FROM �� ���� ��밡��
  ��. ���������� ORDER BY ���� ������ �� ����. INLINE VIEW ������ ��밡��(����)
  ��.
2. Inline View �� ���� �����ϼ��� ?
   FROM �� �ڿ� ���Ǵ� ��������
   FROM ���̺� ��, ���
         (��������) ��ġ ���̺� ó�� ���ȴ�.
         
3. WITH ���� ���� �����ϼ��� ? 
   ��. ���� �������� ����� �̸� �����Ͽ� �ݺ����
   ��. ����     -> WITH �� �ȿ� WITH �� ��� �Ұ�
    WITH �����̸�1 AS (SELECT �� ��������),
         �����̸�2 AS (SELECT �� ��������),
         �����̸�3 AS (SELECT �� ��������)
         ;
    ��. �ϳ��� with���� ���� ���� query block ����� �����ϴ�.
    ��. �������� ����ϸ� ���� ���ϵȴ�.(����) �ڵ��� ����, ������.(����)
    
4. �ڷ� ����( Data Dictionary ) �� ?  user_   all_   dba_   V$  ��
5. ROLE �̶� ?   ������ ��Ƴ��� ��, ���Ѻο����Ÿ� ���ϰ� �ϱ����� ���
        ��. �ѻ��� -> ���� �ο� ��-> �� ������ ���� �ο�
        
6. ��Ű��( Schema ) �� ?
7. LIKE �����ڿ� ���ؼ� �����ϼ��� ? 
   WHERE �÷��� LIKE '���ϵ�ī�� %, _(����)'   ESCAPE
   
8. REGEXP_LIKE() �Լ��� ���ؼ� �����ϼ��� ? 
  LIKE ������ ������: ����ǥ������ ���
  
  REGEXP_LIKE(�÷���, '����ǥ����', �Ķ���� i)
  
9. �������� ��� Oracle �Լ��� ���� �����ϼ��� .
   ��. NVL()   NVL2()
   ��. SUBSTR(���ڿ�, POSITION, LENGTH)
   ��. 
   ��.
   ��.
   ��.CONCAT
   ��.MOD() ������ ���ϴ� �Լ�
   ���
10. insa ���̺��� ������� ���� �μ����� �ߺ����� �ʰ� �Ʒ��� ����
    �����ؼ� ����ϼ���.
   SELECT �� Ű����, AS ��Ī, ALL, DISTINCT�ߺ�����
SELECT DISTINCT BUSEO  --,name, ssn  : 3���� Į���� ��� ���ƾ� �ߺ�
FROM insa
ORDER BY buseo ASC;
    
    [��°��]
BUSEO          
---------------
���ߺ�
��ȹ��
������
�λ��
�����
�ѹ���
ȫ����
11. insa ���̺��� 70���� ���ڻ���� �Ʒ��� ���� �ֹε�Ϲ�ȣ�� �����ؼ� ����ϼ���.
Ű����� �빮�� ����, ���̺��, �÷����� �ҹ��� ����

SELECT name
       -- ,ssn
        , CONCAT( SUBSTR(ssn,0,8),'******') RRN
FROM insa
WHERE REGEXP_LIKE(ssn,'^7.{5}-[13579]')  -. ���ĺ����,����,��� �����ǹ�
--WHERE REGEXP_LIKE(ssn,'^7[0-9][0-9][0-9][0-9][0-9]-[13579]')
--WHERE REGEXP_LIKE(ssn,'^7[0-9][0-9][0-9][0-9][0-9]-1[0-9][0-9][0-9][0-9][0-9][0-9]')
--WHERE REGEXP_LIKE( ssn, '^7')AND MOD( SUBSTR(ssn, -7,1),2) =1
--WHERE ssn LIKE '7%';
--WHERE SUBSTR(ssn,0,1) = '7';
ORDER BY SSN ASC;
NAME                 RRN           
-------------------- --------------
�����               721217-1******
���μ�               731211-1******
������               751010-1******
����               760105-1******
���ѱ�               760909-1******
�ּ���               770129-1******
����ȯ               771115-1******
ȫ�浿               771212-1******
�긶��               780505-1******
����ö               780506-1******
�ڹ���               780710-1******
�̻���               781010-1******
������               790304-1******
�ڼ���               790509-1******
�̱��               790604-1******

15�� ���� ���õǾ����ϴ�. 

12. insa ���̺��� 70��� 12���� ��� ��� �Ʒ��� ���� �ֹε�Ϲ�ȣ�� �����ؼ� ����ϼ���.
SELECT NAME, SSN
FROM insa
--WHERE ssn LIKE '7_12%'
WHERE REGEXP_LIKE (ssn,'^7\d12')
ORDER BY ssn;

NAME                 SSN           
-------------------- --------------
�����               721217-1951357
���μ�               731211-1214576
ȫ�浿               771212-1022432

13. LIKE �������� ESCAPE �� ���ؼ� �����ϼ���. 
  1) wildcard�� �Ϲ� ����ó�� ���� ���� ��쿡�� ESCAPE �ɼ��� ���
    ��. dept ���̺� ��ȸ
     SELECT *
     FROM dept;
    ��. dept ���̺� ���� Ȯ��
    DESC dept;
    
    �̸�     ��?       ����           
------ -------- ------------ 
DEPTNO NOT NULL NUMBER(2)      --�ʼ� �Է»���   2�ڸ� ����
DNAME           VARCHAR2(14)                   14����Ʈ ���ڿ�
LOC             VARCHAR2(13)                   13����Ʈ ���ڿ�

    ��. ���ο� �μ��� �߰� DML - INSERT�� + COMMIT, ROLLBACK Ʈ������ ����
    INSERT INTO dept (deptno, dname, loc) VALUES (100, 'QC100%T','SEOUL');
    
    ���� ���� -
    ORA-01438: value larger than specified precision allowed for this column
    precision: ���е� P
    scale : s
    
    INSERT INTO dept (deptno, dname, loc) VALUES (40, 'QC100%T','SEOUL');
    ���� ���� -
    ORA-00001: unique constraint (SCOTT.PK_DEPT) violated
               ���ϼ�   ��������                      ����
               PK ==Primary Key
    INSERT INTO dept (deptno, dname, loc) VALUES (50, 'QC100%T','SEOUL');
    1 �� ��(��) ���ԵǾ����ϴ�.
    COMMIT;
    Ŀ�� �Ϸ�.
    
    ��. 
    SELECT * 
    FROM dept;
    
    ��. ������ ����  : DML - UPDATE�� + COMMIT, ROLLBACK
    
    30�� �μ��� �μ����� SALES ->SA%LES �� ����
      [����]
      UPDATE ���̺�� 
      SET   ������ Į��=�����Ұ�, ������ Į��=�����Ұ�,������ Į��=�����Ұ�...
      [WHERE ���ǽ�]
      
      UPDATE dept
      SET  dname = 'SA%LES'
      WHERE deptno = 30;   --WHERE �������� ������ ��� ��(���ڵ�) ����
      COMMIT;
    ��. Ȯ��
    SELECT *
    FROM dept;
    
    --CreateLeadUpdateDelete
    ��. 40�μ� ���� : DML - DELETE �� +COMMIT         / TRUNCATE�� /
      40	OPERATIONS	BOSTON
      [����]
      DELETE (FROM) ���̺��   --��� �� ������.WHERE ���� ������
      WHERE ���ǽ�;  -- ���� �����Ҷ� primary key�� ����(�ߺ��ȵǹǷ�)
      
      DELETE FROM dept
      WHERE deptno = 40;
      
      ROLLBACK;
      ����Ŭ ����(SESSION) = ����� �α��� ~ �α׾ƿ�
      ����Ŭ �ν��Ͻ� INSTANCE =??
      
      ����)
    INSERT INTO ���̺�� (�÷���...) VALUES (�÷���...) 
    COMMIT;
      
   o. ����) dept ���̺��� �μ���dname�� '%'���ڸ� �����ϴ� �μ����� ���(��ȸ)
   ��. LIKE ������ ���
   SELECT *
   FROM dept
   --'%���ϵ�ī��    %�ѹ���       %���ϵ�ī��'
   --             ���ϵ�ī�� ����
   WHERE dname LIKE '%\%%' ESCAPE '\';
   
   ����) 50���μ� ����, 30���μ��� 'SALES'�� ����
   DELETE FROM dept
   WHERE deptno = 50;
   --1 �� ��(��) �����Ǿ����ϴ�.
   
   UPDATE dept
   --SET dname = 'SALES'
   set dname = REPLACE(dname, '%', '')   
   WHERE deptno =30;
   --1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
   COMMIT;
   
   -- JAVA "SA%LES" -> "SALES"      "SA%LES".replace("%","")
   -- ORACLE : REPLACE('SA%LES','%','')
   --SELECT deptno, dname, loc, REPLACE('SA%LES','%','')
   --SELECT dept.*, REPLACE('SA%LES','%','')
   SELECT d.*, REPLACE('SA%LES','%','')
   FROM dept d
   WHERE dname LIKE '%\%%' ESCAPE '\';
   
   --����: FROM keyword not found where expected
   
   ����) dept ���̺��� �μ��� 'r'���ڿ��� �����ϸ� �μ���ȣ�� 1������Ű�� ����
   UPDATE dept
   SET deptno = deptno+1
   WHERE REGEXP_LIKE(dname, 'r', 'i');
   
      
   --integrity constraint (SCOTT.FK_DEPTNO)violated-child record found
   --    ���Ἲ     ��������    ����ȴ�   �ڽ� ���ڵ�(��) ã�Ҵ�.
   
   SELECT *
   FROM dept;
   
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON

   parent           deptno(����)        child
   dept ���̺�                          emp ���̺�
   �θ����̺��� �μ���ȣ                 �ڽ����̺��� �μ���ȣ(�ܷ�Ű,FK) �÷�

 
    
14. emp ���̺���
    pay(sal+comm)  1000 �̻�~ 3000 ���� �޴�  
    30�μ����� ������ ��� ����鸸 
    ename�� �������� �������� �����ؼ� ��ȸ�ϴ� ������ �ۼ��ϼ���.  
    ��. with �� ���  
--WITH �����̸� AS (��������)
WITH temp AS(
SELECT deptno, ename,   sal+NVL(comm,0) pay
FROM emp
--WHERE deptno !=30   ���⿡ �ᵵ ��
)
SELECT t.*
FROM temp t
WHERE t.pay BETWEEN 1000 AND 3000  AND t.deptno !=30;

    ��. inline view ���
SELECT t.*
FROM (
    SELECT deptno, ename,   sal+NVL(comm,0) pay
    FROM emp
    WHERE deptno !=30
) t
WHERE t.pay BETWEEN 1000 AND 3000;


    ��. �Ϲ� ���� ���.
SELECT deptno, ename,   sal+NVL(comm,0) pay
FROM emp
WHERE (sal+NVL(comm,0)BETWEEN 1000 AND 3000 )AND deptno !=30
ORDER BY ename ASC;

    DEPTNO ENAME             PAY
---------- ---------- ----------
        10 MILLER           1300
        10 CLARK            2450
        20 JONES            2975
        20 FORD             3000

15. insa���̺��� ssn �÷��� ���ؼ� year, month, date, gender ���

  SSN          YEAR MONTH DATE GENDER  
---------- ------ ---- ----- -----
771212-1022432	77	12	12	1
801007-1544236	80	10	07	1
770922-2312547	77	09	22	2
790304-1788896	79	03	04	1
811112-1566789	81	11	12	1
:
60�� ���� ���õǾ����ϴ�. 

SELECT ssn
       ,SUBSTR(ssn, 0 ,2 ) year
       ,SUBSTR(ssn, 3 ,2 ) month
       ,SUBSTR(ssn, 5 ,2 ) "DATE"  --�ֵ���ǥ �ָ� ����
       --,SUBSTR(ssn, 5 ,2 ) date   -> date�̸� ���ǰ� �ִ� ������ ����: ��¥�ڷ���
    ,SUBSTR(ssn, 8 ,1 ) gender
FROM insa;
--00923. 00000 -  "FROM keyword not found where expected"

16. emp ���̺��� �Ի�⵵ �÷����� ��,��,�� ã�Ƽ� ���
    ��. �⵵ ã�� ���� TO_CHAR() �Լ� ���
    ��. �� ã�� ���� SUBSTR() �Լ� ���
    ��. �� ã�� ���� EXTRACT() �Լ� ���
    
ENAME      HIREDATE YEAR MONTH DATE
---------- -------- ---- -- --
SMITH      80/12/17 1980 12 17
ALLEN      81/02/20 1981 02 20
WARD       81/02/22 1981 02 22
JONES      81/04/02 1981 04 02
MARTIN     81/09/28 1981 09 28
BLAKE      81/05/01 1981 05 01
CLARK      81/06/09 1981 06 09
KING       81/11/17 1981 11 17
TURNER     81/09/08 1981 09 08
JAMES      81/12/03 1981 12 03
FORD       81/12/03 1981 12 03
MILLER     82/01/23 1982 01 23

12�� ���� ���õǾ����ϴ�. 
-- JAVA : Date, Calendar, LocalDate, LocalDateTime
-- ORACLE : DATE, TIMESTAMP
-- TO_CHAR(��¥Į��, '����FORMATT', ,[NLS PARAM])

SELECT ename, hiredate
          ,TO_CHAR(hiredate, ) year
FROM emp;

--RR �� YY��ȣ�� ������
      '97/01/12'    '03/12/21'
RR    1997/01/12      2003/12/21
YY    2097/01/12     2003/12/21
        2000���(SYSDATE)

����) ���� �ý����� ��¥/�ð� ������ ������ �ڵ�
--JAVA : Date d =  new Date();   d.toLocalString();
--       Calendar c = Calendar.getInstance();    c.toString();
--Oracle : SYSDATE �Լ�


--2000��� 21����
SELECT  SYSDATE,hiredate
            , TO_CHAR(hiredate, 'yyyy') year
            , SUBSTR(hiredate, 4,2) month
            , EXTRACT(DAY FROM hiredate ) "DATE"
FROM emp;   --4���� �� ���ڵ�



17. emp ���̺��� ���ӻ��(mgr)�� ����  ����� ������ ��ȸ�ϴ� ���� �ۼ�.
SELECT empno, ename, NVL(mgr,0)
FROM emp
WHERE mgr IS NULL;

     EMPNO ENAME             MGR
---------- ---------- ----------
      7839 KING                0
      
18. ��� ��( ROLE ) Ȯ��
19. RESOUCE ���� ��� ���� Ȯ��
20. scott ������ �ο����� �� Ȯ��

21. YY�� RR�� �������� ���ؼ� �����ϼ��� . 

22. emp ���̺��� ����̸���   'la' ���ڿ��� �����ϴ� ��� ���� ���
   ��. LIKE ���
   WHERE ename LIKE '%' || UPPER('la') || '$'
   WHERE ename LIKE  UPPER('%la%')
   ��. REGEXP_LIKE() ���
   WHERE REGEXP_LIKE (ename, 'la',i)
   
    DEPTNO ENAME     
---------- ----------
        30 BLAKE     
        10 CLARK    

23. hr �������� ����
    employees ���̺��� first_name, last_name �̸� �ӿ� 'ev' ���ڿ� �����ϴ� ��� ���� ���
    
FIRST_NAME           LAST_NAME         NAME                NAME                                                                                                                                                                                    
-------------------- ------------- ------------- ----------------------
Kevin                Feeney          Kevin Feeney        K[ev]in Feeney                                                                                                                                                                          
Steven               King            Steven King         St[ev]en King                                                                                                                                                                           
Steven               Markle          Steven Markle       St[ev]en Markle                                                                                                                                                                         
Kevin                Mourgos         Kevin Mourgos       K[ev]in Mourgos                                                                                                                                                                         
 


 --Ȯ�� --
 
 SELECT *
 FROM dept;
--�μ��߰�   50, �Ƹ��ٿ� �μ�, ����
INSERT INTO dept (deptno, dname, loc) VALUES ( 50, '�Ƹ��ٿ� �μ�', '����');

--���� ���� -
ORA-12899: value too large for column "SCOTT"."DEPT"."DNAME" (actual: 19, maximum: 14)
INSERT INTO dept (deptno, dname, loc) VALUES ( 50, '�Ƹ��ٿ�μ�', '����');

DESC dept;
DNAME           VARCHAR2(14)   -- 14����Ʈ ���ڿ� �ѱ� 4���ڱ����� ���� 
�ѱ� 6���� =18����Ʈ
�ѱ� 1���� = 3����Ʈ

--VSIZE() �Լ�  �� ����ư�� Ȯ���ϴ� �Լ�
SELECT VSIZE('��')  --3����Ʈ
        ,VSIZE('�Ƹ��ٿ�μ�')  --18����Ʈ
        ,VSIZE('A')   --1����Ʈ
FROM dual;


--����) dept ���̺� 40,50,60,70 �μ� ����    -> PL/SQL
   DELETE FROM dept    WHERE deptno = 40;
   DELETE FROM dept    WHERE deptno = 50;
   DELETE FROM dept    WHERE deptno = 60;
   DELETE FROM dept    WHERE deptno = 70;
   
   --
   DELETE FROM dept 
   WHERE deptno = 40 OR deptno = 50 OR deptno = 60 OR deptno = 70;
   --
   DELETE FROM dept
   WHERE deptn IN (40,50,60,70);
   --
   DELETE FROM dept
   WHERE deptno BETWEEN 40 AND 70;
   
   --����) insa ���̺��� ����ó(tel)�� ���� ����� '����ó��Ͼȵ�'����ϴ� ����
SELECT num, name, tel
        ,NVL(tel,'����ó��Ͼȵ�')
FROM insa
WHERE tel IS NULL;

   --����) insa ���̺��� num, name, tel �÷� ����� �� ����ó(tel)���� ����� x
                                                              �ִ� ����� o
          ����) ���ߺθ�                      
SELECT num, name 
     ,NVL2(tel,'O','X') tel
FROM insa
WHERE buseo LIKE '%����%';

--[����Ŭ ������]

--[����Ŭ �Լ�]

--[����Ŭ �ڷ���]
1. �񱳿�����   where ������ ���    ����, ��¥, ����    true, false, null
           > >= < <= != ^= <>
SELECT 3>5
FROM dept;
  --LOB�� �� �����ڸ� ����� �� ������, PL/SQL������ CLOB �����͸� ���� �� �ִ�
  -- ANY, SOME, ALL  SQL ������

2. �������� : WHERE ������ ���, AND , OR, NOT ������  true, false, null
3. SQL ������ : [NOT] IN (list)
           [NOT] BETWEEN  a AND b
           [NOT] LIKE 
           IS [NOT] NULL
  ANY, SOME, ALL  SQL ������ + �񱳿�����
  [NOT] EXISTS          SQL ������      WHERE   (��������  �����ϸ� TRUE)
   == [NOT] IN
4. null ������
   is null    is not null
   
5. ���� ������ concat
6. ��� ������  + - * /   ������ ���ϴ� !�Լ�! mod()

�ǹ��� :  dual ?
SELECT 5+3
       ,5-3
       ,5*3
       ,5/3
       ,MOD(5,3)
FROM dual;

SELECT  --5/0  ���� divisor is equal to zero
        --5.0/0
        MOD(5,0)     --5
        ,MOD(5.0,0)  --5
FROM dual;
  
***[dual]�̶�?***
1. SYS������ ������ �����ϰ� �ִ� ���̺�( ����Ŭ ǥ�� ���̺�)
2. �� 1 ��, �÷�1���� DUMMY ���̺�
DESC dual;
DUMMY �÷� VARCHAR2(1)
3. �Ͻ������� ��¥�� ��� ������ �� �����
--������ �̷��� ����ϴµ�
SELECT SYSDATE, CURRENT_DATE --22/04/07   22/04/07
            ,CURRENT_TIMESTAMP --22/04/07 16:15:48.000000000 ASIA/SEOUL
FROM sys.dual;

4. ��Ű��.���̺��( sys.dual) -> PUBLIC �ó�� (SYNONYM) �����߱� ������
SELECT SYSDATE
FROM dual;
5. dual ���̺��� ����Ŭ ��ġ�ϸ� �ڵ����� ��������� ���̺��̴�
����Ŭ�Լ� : ��Ʈ4==2==sqrt(4)

--SYNONYM �ó�� �̶�?
1. HR �����ؼ� 
SELECT * 
FROM emp;

2. public �����ϸ� private �ó��
�����ġ�
	CREATE [PUBLIC] SYNONYM [schema.]synonym��
  	FOR [schema.]object��;
3. PUBLIC �ó���� ��� ����ڰ� ���� �����ϱ� ������ ���� �� ������ ���� DBA���� �� �� �ִ�.
4. �ó�� ���� ����

1) SYSTEM �������� �����Ѵ�.
2) PUBLIC �ɼ��� ����Ͽ� �ó���� �����Ѵ�.
3) ������ �ó�Կ� ���� ��ü �����ڷ� �����Ѵ�.
4) �ó�Կ� ������ �ο��Ѵ�.

 GRANT SELECT ON emp TO HR; 
 --Grant��(��) �����߽��ϴ�.

5. �ó�� ����
�����ġ�
	DROP [PUBLIC] SYNONYM synonym��;
 ------------------------
 6.
 --FLOOR() �Լ��� ROUND() �Լ��� ������
 --MOD       :n2 - n1 * FLOOR(n2/n1)  �����Լ�
 --REMAINDER :n2 - n1 * ROUND(n2/n1)  �ݿø��Լ�
 
 SELECT MOD(5,2)   --  **�길 ��
       ,REMAINDER(5,2)
 FROM dual;
 
7. SET ���� ������
  ��.UNION ������ - ������

SELECT deptno, empno, ename, job
FROM emp
WHERE deptno = 20
UNION
SELECT deptno, empno, ename, job
FROM emp
WHERE job = 'MANAGER';

--��� 5��
10	7782	CLARK	MANAGER
20	7369	SMITH	CLERK
20	7566	JONES	MANAGER
20	7902	FORD	ANALYST
30	7698	BLAKE	MANAGER

SELECT deptno, empno, ename, job
FROM emp
WHERE deptno = 20;

--3��
20	7369	SMITH	CLERK
20	7566	JONES	MANAGER
20	7902	FORD	ANALYST

SELECT deptno, empno, ename, job
FROM emp
WHERE job = 'MANAGER';

--3��
20	7566	JONES	MANAGER
30	7698	BLAKE	MANAGER
10	7782	CLARK	MANAGER
  
  ��.UNION ALL ������ - ������+ALL
  ��.INTERSECT ������  - ������
  ��.MINUS ������      -������
    
