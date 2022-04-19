
SELECT *
FROM salgrade;

1	700	   1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999

1. emp , salgrade ���̺��� ����ؼ� �Ʒ��� ���� ���.

SELECT ename, sal
      , (CASE 
       WHEN sal+NVL(comm,0) BETWEEN 700 AND 1200 THEN 1
       WHEN sal+NVL(comm,0) BETWEEN 1201 AND 1400 THEN 2
       WHEN sal+NVL(comm,0) BETWEEN 1401 AND 2000 THEN 3
       WHEN sal+NVL(comm,0) BETWEEN 2001 AND 3000 THEN 4
       ELSE 5
       END)  grade
FROM emp;

1-2. emp , salgrade ���̺��� ����ؼ� �Ʒ��� ���� ���. [JOIN] ���

SELECT e.ename, e.sal, s.grade
FROM emp e, salgrade s
WHERE sal BETWEEN losal AND HISAL;


ename   sal    grade
---------------------
SMITH	800	    1
ALLEN	1900	3
WARD	1750	3
JONES	2975	4
MARTIN	2650	4
BLAKE	2850	4
CLARK	2450	4
KING	5000	5
TURNER	1500	3
JAMES	950	    1
FORD	3000	4
MILLER	1300	2

1-3.  ���� ������� ���(grade)�� 1����� ����� ��ȸ�ϴ� ���� �ۼ�
SELECT t.empno, t.ename, t.sal, t.grade
FROM (SELECT e.empno, e.ename, e.sal, s.grade
FROM emp e, salgrade s
WHERE sal BETWEEN losal AND HISAL
)t
WHERE t.grade =1;

SELECT *
FROM (
SELECT *
FROM emp, salgrade
WHERE sal BETWEEN losal AND HISAL
)
WHERE GRADE=1;

���)
     EMPNO ENAME             SAL      GRADE
---------- ---------- ---------- ----------
      7369 SMITH             800          1
      7900 JAMES             950          1  
      

2. emp ���� �ְ�޿��� �޴� ����� ���� ���

dept : dname
emp : ename, pay

--���� ���ϸ�
SELECT deptno, ename, sal+NVL(comm,0) pay
FROM emp
WHERE sal+NVL(comm,0) = (SELECT MAX(sal+NVL(comm,0)) FROM emp);

--���� ���
ORA-00918: column ambiguously defined 
�׳� deptno ���� ������. dept�� emp ��� �����ϱ⶧��
SELECT d.dname,d.deptno, ename, sal+NVL(comm,0) pay
FROM emp e JOIN dept d ON d.deptno= e.deptno --�θ�/�ڽ����̺�
WHERE sal+NVL(comm,0) = (SELECT MAX(sal+NVL(comm,0)) FROM emp);


SELECT d.dname, ename, sal+NVL(comm,0) max_pay
FROM emp e, dept d
WHERE sal+NVL(comm,0) = (SELECT MAX(sal+NVL(comm,0)) FROM emp)
       AND d.deptno =e.deptno;

DNAME          ENAME             PAY
-------------- ---------- ----------
ACCOUNTING     KING             5000

2-2. emp ���� �� �μ��� �ְ�޿��� �޴� ����� ���� ��� join

dept : dname, deptno
emp : deptno, ename, sal+NVL(comm,0) pay
-------------
SELECT deptno, ename, sal+NVL(comm,0) pay
FROM emp
GROUP BY deptno;
--ORA-00979: not a GROUP BY expression
------------
SELECT deptno,MAX(  sal+NVL(comm,0)) dept_max_pay
FROM emp
GROUP BY deptno;
30	2850
20	3000
10	5000
----------
--��� ���� ���� main query -sub query
SELECT dname, d.deptno, ename,sal+NVL(comm,0) pay
FROM emp e, dept d
WHERE sal+NVL(comm,0) =(SELECT MAX(sal+NVL(comm,0) ) FROM emp WHERE deptno= e.deptno)
   AND e.deptno=d.deptno;
-- WHERE sal+NVL(comm,0) = (deptno �ش� �μ��� �ְ� �޿���) ;


/*���� �� �ڵ� -�������� ������ ����
SELECT d.dname, ename, sal+NVL(comm,0) max_pay
FROM emp e, dept d
WHERE sal+NVL(comm,0) = (SELECT MAX(sal+NVL(comm,0)) FROM emp WHERE deptno=e.deptno)
;
*/

--�ٸ� �ڵ� - �����Լ� �̿�

SELECT *
FROM ( SELECT deptno, ename, sal+NVL(comm,0) pay
    ,RANK()OVER(PARTITION BY deptno ORDER BY sal+NVL(comm,0) DESC) pay_rank
From emp
)t
WHERE t.pay_rank =1;

--�μ��� ���� ��� dname ��� ���ؼ� join �ؾ��� -�ȿ��� ����
SELECT *
FROM ( SELECT d.deptno, dname, ename, sal+NVL(comm,0) pay
    ,RANK()OVER(PARTITION BY d.deptno ORDER BY sal+NVL(comm,0) DESC) pay_rank
From emp e JOIN dept d ON e.deptno = d.deptno
)t
WHERE t.pay_rank =1;

--- �ۿ��� ����
--[���1]
SELECT t.deptno, d.dname, t.ename, t.pay, t.pay_rank
FROM ( SELECT deptno, ename, sal+NVL(comm,0) pay
    ,RANK()OVER(PARTITION BY deptno ORDER BY sal+NVL(comm,0) DESC) pay_rank
From emp 
)t JOIN dept d ON t.deptno=d.deptno
WHERE t.pay_rank =1;
--[���2]
SELECT t.deptno, d.dname, t.ename, t.pay, t.pay_rank
FROM ( SELECT deptno, ename, sal+NVL(comm,0) pay
    ,RANK()OVER(PARTITION BY deptno ORDER BY sal+NVL(comm,0) DESC) pay_rank
From emp 
)t, dept d
WHERE t.pay_rank =1 AND t.deptno=d.deptno;

    DEPTNO DNAME          ENAME             PAY
---------- -------------- ---------- ----------
        10 ACCOUNTING     KING             5000
        20 RESEARCH       FORD             3000
        30 SALES          BLAKE            2850
        
        
? 3. emp ���� �� ����� �޿��� ��ü�޿��� �� %�� �Ǵ� �� ��ȸ.
--       ( %   �Ҽ��� 3�ڸ����� �ݿø��ϼ��� )
--            ������ �Ҽ��� 2�ڸ������� ���.. 7.00%,  3.50%     

SELECT SUM( sal+ NVL(comm,0) ) totalpay
FROM emp;

SELECT t.*
    ,TO_CHAR ( ROUND( PAY/TOTALPAY*100, 2) , '9,999.00') || '%' ����
FROM ( SELECT ename, sal+ NVL(comm,0) pay
     ,(SELECT SUM( sal+ NVL(comm,0)) FROM emp)  totalpay
FROM emp)t;

/*���� �� �ڵ�
SELECT t.ename, t. pay
        , SUM(sal+NVL(comm,0)) total_pay
        
FROM(SELECT ename, sal+NVL(comm,0) pay
      ,PERCENT_RANK() OVER(ORDER BY sal+NVL(comm,0)) "����"
FROM emp
)t;
*/
ENAME             PAY   TOTALPAY ����     
---------- ---------- ---------- -------
SMITH             800      27125   2.95%
ALLEN            1900      27125   7.00%
WARD             1750      27125   6.45%
JONES            2975      27125  10.97%
MARTIN           2650      27125   9.77%
BLAKE            2850      27125  10.51%
CLARK            2450      27125   9.03%
KING             5000      27125  18.43%
TURNER           1500      27125   5.53%
JAMES             950      27125   3.50%
FORD             3000      27125  11.06%
MILLER           1300      27125   4.79%

12�� ���� ���õǾ����ϴ�. 

? 4. emp ���� ���� ���� �Ի��� ��� �� ���� �ʰ�(�ֱ�) �Ի��� ����� ���� �ϼ� ? 
--[���1]
SELECT MAX(hiredate),MIN(hiredate) 
     ,MAX(hiredate)-MIN(hiredate)
FROM emp;

ORDER BY hiredate DESC;
--[���2] FIRST_VALUE , LAST_VALUE
SELECT ename, hiredate
  ,FIRST_VALUE(hiredate) OVER (ORDER BY hiredate DESC) A --����������� ó�� ��
 -- ,LAST_VALUE(hiredate) OVER (ORDER BY hiredate DESC) --����������� ������ ��
 ,FIRST_VALUE(hiredate) OVER (ORDER BY hiredate ASC) B
 ,FIRST_VALUE(ename) OVER (ORDER BY hiredate DESC)c
 ,FIRST_VALUE(ename) OVER (ORDER BY hiredate ASC) d
FROM emp;


5. insa ���� ������� ������ ����ؼ� ���
  ( ������ = ���س⵵ - ����⵵          - 1( ������������ ������) )
;

SELECT t.name, t.ssn
    , CASE 
      WHEN t.ischeck = -1 THEN t.birth_year - t.now_year -1
      ELSE t.birth_year - t.now_year
FROM (
SELECT name, ssn
    , TO_CHAR( SYSDATE ,'YYYY') now_year
    ,SUBSTR(ssn, 0,2)
    , CASE
      WHEN  SUBSTR( ssn, -7,1) IN (1,2,5,6) THEN 1900 + SUBSTR(ssn, 0,2)
      WHEN  SUBSTR( ssn, -7,1) IN (3,4,7,8)THEN 2000 + SUBSTR(ssn, 0,2)
      ELSE 1800 + SUBSTR(ssn, 0,2)
      END birth_year   
    , SIGN (TRUNC( SYSDATE) - TO_DATE (SUBSTR( ssn, 3,4),'MMDD')) ischeck
FROM insa
)t;

/*  
  SELECT t.name, t.ssn
        , CASE t.ischeck
        WHEN -1 THEN t.b_day_year - t.n_year
        ELSE t.b_day_year - t.n_year
  FROM(
       SELECT  name, ssn
       , SUBSTR(ssn, 0,2)
       , TO_CHAR(SYSDATE,'YYYY') n_year
       , CASE 
        WHEN SUBSTR(ssn,8,1) In (1,2,5,6)  THEN 1900 + SUBSTR(ssn, 0,2)
        WHEN SUBSTR(ssn,8,1) In (3,4,7,8)  THEN 2000 + SUBSTR(ssn, 0,2)
        ELSE 1800+ SUBSTR(ssn, 0,2)
        END b_day_year
        , SIGN( TRUNC(SYSDATE) - TO_DATE(SUBSTR(ssn,3,4),'MMDD') ) ischeck
    FROM insa
    )t;
*/
  
6. insa ���̺��� �Ʒ��� ���� ����� ������ ..
     [�ѻ����]      [���ڻ����]      [���ڻ����] [��������� �ѱ޿���]  [��������� �ѱ޿���] [����-max(�޿�)] [����-max(�޿�)]
---------- ---------- ---------- ---------- ---------- ---------- ----------
        60                31              29           51961200                41430400                  2650000          2550000
      SELECT COUNT(*) �ѻ����
          ,COUNT (DECODE ( MOD( SUBSTR(ssn,-7,1),2), 1,'����'))  ���ڻ����
          , COUNT ( CASE MOD(  SUBSTR(ssn,-7,1),2)
          WHEN 0 THEN 'o'
          ELSE null
          END) ���ڻ����
          , SUM( DECODE ( MOD( SUBSTR(ssn,-7,1),2), 1,basicpay)) "����� �ѱ޿���"
          , SUM( DECODE ( MOD( SUBSTR(ssn,-7,1),2), 0,basicpay)) "����� �ѱ޿���"
          , MAX( DECODE ( MOD( SUBSTR(ssn,-7,1),2), 1,basicpay)) "����� �ְ�޿�"
          , MAX( DECODE ( MOD( SUBSTR(ssn,-7,1),2), 0,basicpay)) "����� �ְ�޿�"
      FROM insa;
          
7. TOP-N ������� Ǯ�� ( ROWNUM �ǻ� �÷� ���: �࿡ ���� �Ű���)  ROWID :�࿡ ������ ���̵� �ٿ���
   emp ���� �ְ�޿��� �޴� ����� ���� ���  
  
    DEPTNO ENAME             PAY   PAY_RANK
---------- ---------- ---------- ----------
        10 KING             5000          1
/* ����
SELECT ROWNUM
FROM (
        ORDER BY
)
WHERE ROWNUM = 1;
*/

SELECT T.*, ROWNUM PAY_RANK
FROM (
       SELECT deptno, ename, sal+NVL(comm,0) pay
       FROM emp
        ORDER BY pay DESC
)T
WHERE ROWNUM = 1;
        
8-1.����(RANK) �Լ� ����ؼ� Ǯ�� 
   emp ���� �� �μ��� �ְ�޿��� �޴� ����� ���� ���
   
    DEPTNO ENAME             PAY DEPTNO_RANK
---------- ---------- ---------- -----------
        10 KING             5000           1
        20 FORD             3000           1
        30 BLAKE            2850           1

��.  + emp ����
SELECT t.deptno, e.ename, e.sal
FROM (
SELECT deptno, MAX(SAL) maxpay
FROM emp
GROUP BY deptno
) t, emp e
WHERE t.deptno = e.deptno  AND t.maxpay = e.sal;

��. �����ű�� �Լ�  -> �ٽ� ����
SELECT *
FROM ( SELECT d.deptno, dname, ename, sal+NVL(comm,0) pay
    ,RANK()OVER(PARTITION BY d.deptno ORDER BY sal+NVL(comm,0) DESC) pay_rank
From emp e JOIN dept d ON e.deptno = d.deptno
)t
WHERE pay_rank =1; 



SELECT deptno, ename, sal+NVL(comm,0) pay
       , ROWNUM 
FROM emp
WHERE sal+NVL(comm,0) = (SELECT MAX( sal+NVL(comm,0)) FROM emp)


8-2. ���()���������� ����ؼ� Ǯ�� 
   emp ���� �� �μ��� �ְ�޿��� �޴� ����� ���� ��� 
   
9.  emp���̺��� �� �μ��� �����, �μ��ѱ޿���, �μ������ �Ʒ��� ���� ����ϴ� ���� �ۼ�.
���)
    DEPTNO       �μ�����       �ѱ޿���    	     ���
---------- ---------- 		---------- 	----------
        10          3      	 8750    	2916.67
        20          3     	  6775    	2258.33
        30          6     	 11600    	1933.33      
 ;
 
SELECT deptno, COUNT(*)  "�μ�����"  
       , SUM(sal+NVL(comm,0)) "�ѱ޿���"
       , ROUND ( AVG(sal+NVL(comm,0)),2)  "���"
FROM emp
GROUP BY deptno
ORDER BY deptno;
         
10-1.  emp ���̺��� 30���� �μ��� �ְ�, ���� SAL�� ����ϴ� ���� �ۼ�.
���)
  MIN(SAL)   MAX(SAL)
---------- ----------
       950       2850
[���1]
 SELECT MIN ( sal+NVL(comm,0)) "MIN(SAL)"
       , MAX(sal+NVL(comm,0)) "MAX(SAL)"
 FROM emp
 WHERE deptno =30;
       
[���2] HAVING �� :GROUP BY �� ������
SELECT deptno
       , MAX(sal+NVL(comm,0)),  MIN( sal+NVL(comm,0))
FROM emp
GROUP BY deptno
HAVING deptno =30; 

10-2.  emp ���̺��� 30���� �μ��� �ְ�, ���� SAL�� �޴� ����� ���� ����ϴ� ���� �ۼ�.

���)
     EMPNO ENAME      HIREDATE        SAL
---------- ---------- -------- ----------
      7698 BLAKE      81/05/01       2850
      7900 JAMES      81/12/03        950  
      
[���1]
 SELECT MAX( sal),MIN( sal)
 FROM emp
 WHERE deptno =30;

/*
SELECT empno, ename, hiredate, sal
 FROM emp
 WHERE deptno =30 AND sal IN ( SELECT MAX( sal),MIN( sal)  FROM emp
 WHERE deptno =30) ;
--ORA-00913: too many values
�ΰ� �ѹ����� �ȵ�. ���ε��� �������� �־��ֱ�. 
*/
[���2]
SELECT empno, ename, hiredate, sal
 FROM emp
 WHERE deptno =30 AND sal IN ( 
                       (SELECT MAX( sal) FROM emp  WHERE deptno =30 ) 
                       ,(SELECT MIN( sal) FROM emp  WHERE deptno =30 )
                        );
[���3]UNION ALL ����
[���4]
SELECT empno, ename, hiredate, sal
FROM ( SELECT MAX( sal) maxsal ,MIN( sal) minsal  
    FROM emp
    WHERE deptno =30
  )t, emp e
WHERE e.deptno=30 AND t.maxsal=e.sal OR t.minsal=e.sal;

11.  insa ���̺��� 
[������]
�μ���     �ѻ���� �μ������ ����  ���������  ��/��%   �μ�/��%   ��/��%
���ߺ�	    60	    14	      F	    8	    23.3%	  13.3%	    57.1%
���ߺ�	    60	    14	      M	    6	    23.3%	  10%	    42.9%
��ȹ��	    60	    7	      F	    3	    11.7%	5%	4       2.9%
��ȹ��	    60	    7	      M	    4	    11.7%	6.7%	    57.1%
������	    60	    16	      F	    8	    26.7%	13.3%	    50%
������	    60	    16	      M	    8	    26.7%	13.3%	    50%
�λ��	    60	    4	      M	    4	    6.7%	6.7%	    100%
�����	    60	    6	      F	    4	    10%	    6.7%	    66.7%
�����	    60	    6	      M	    2	    10%	    3.3%	    33.3%
�ѹ���	    60	    7	      F	    3	    11.7%	5%	        42.9%
�ѹ���	    60	    7	      M 	4	    11.7%	6.7%	    57.1%
ȫ����	    60	    6	      F	    3	    10%	    5%	        50%
ȫ����	    60	    6	      M	    3	    10%	    5%	        50%             
;
WITH temp AS 
(
        SELECT t.buseo
               ,(SELECT COUNT(*) FROM insa ) �ѻ����
               ,(SELECT COUNT(*) FROM insa WHERE buseo =t.buseo) �μ������ --�����������
               , gender
               , COUNT (*) "���������"
        FROM (                                                  --�ζ��κ�
            SELECT buseo, name, ssn
                     , DECODE ( MOD ( SUBSTR(ssn, -7,1),2),1,'M','F') gender
            FROM insa
        )t
        GROUP BY buseo, gender
        ORDER BY buseo, gender
)
SELECT temp.*
     , ROUND( �μ������/�ѻ����*100,2)||'%' "��/��%"
     , ROUND( ���������/�ѻ����*100,2)||'%' "�μ�/��%"
     , ROUND( ���������/�μ������*100,2)||'%' "��/��%"
FROM temp;

--GROUP BY /HAVING ��
12. insa���̺��� �����ο����� 5�� �̻��� �μ��� ���.  
SELECT *
FROM(
    SELECT buseo,COUNT(*) ���ڻ����
    FROM insa
    WHERE MOD(SUBSTR(ssn,-7,1),2)=0
    GROUP BY buseo
)t
WHERE  ���ڻ���� >=5 ;

13. insa ���̺��� �޿�(pay= basicpay+sudang)�� ���� 15%�� �ش�Ǵ� ����� ���� ��� 
  (�޿����� 9����� ���)
SELECT COUNT(*) FROM insa; --60�� 
SELECT 60 * 0.15   --9��
FROM dual;

SELECT *
FROM (
    SELECT buseo, name, basicpay+sudang pay
           ,RANK() OVER (ORDER BY basicpay+sudang DESC) pay_rank
    FROM insa
)
WHERE pay_rank <= (SELECT COUNT(*) FROM insa) *0.15;
--WHERE pay_rank <= 9;


14. emp ���̺��� sal�� ��ü��������� ��� , �μ��������� ����� ����ϴ� ���� �ۼ�

--RANK �Լ� ���
SELECT deptno, ename, sal
    ,RANK() OVER ( ORDER BY sal DESC) ��ü���
    , RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) �μ����
FROM emp
ORDER BY deptno;

--��� ���� ����

SELECT deptno, ename, sal
    ,(SELECT COUNT(*)+1 FROM emp WHERE sal > e.sal ) �������
    ,(SELECT COUNT(*)+1 FROM emp WHERE sal > e.sal AND deptno=e.deptno) �μ������
FROM emp e
ORDER BY deptno ASC, �μ������ ASC;

---------------------------
�� �ڿ� �ִ� Ư�� ���� ����
SELECT '***ADMIN***'
      --  , REPLACE ( '***ADMIN***','*','')
      --  , TRIM( 'Ư������' FROM ���ڿ� ) -> Ư������ ���� ���鵵 ����
      ,TRIM ( '*' FROM '***ADMIN***')
FROM dual;

------------
TO_DATE / TO_CHAR( ����/��¥, 'fmt' [,nls param]   )

nls param = nls parameter (�Ű�����, ����)
--nls?
1. National Language Support
2. 3���� ���� �з� (�켱����)
   SESSION  >  CLIENT  >  SERVER

SELECT ename, sal, TO_CHAR(hiredate, 'YY/MON/DAY', 'NLS_DATE_LANGUAGE =JAPANESE')
FROM emp;
------------
-- GROUP BY ��,  HAVING ��
SELECT 
   COUNT(*) --��ü�����
   , COUNT( DECODE ( deptno,10, 'o')) --10�� �μ� �����
   , COUNT( DECODE ( deptno,20, 'o')) --20�� �μ� �����
   , COUNT( DECODE ( deptno,30, 'o')) --30�� �μ� �����
   , COUNT( DECODE ( deptno,40, 'o')) --40�� �μ� �����
FROM emp;

--�μ��� �ο� �� �ľ� (40���μ� ��� X) OUTER JOIN
-- ORA-00904: "DEPTNO": invalid identifier
SELECT 0 deptno, COUNT(*) 
FROM emp
UNION ALL
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;

--����) emp ���̺��� 
     1) 20��, 40�� �μ��� ���ܽ�Ű��
     2) �� �� �μ��� ������� ���
     3) �� ������� 4���̻��� �μ������� ��ȸ
     (���� : �μ���ȣ, �μ���, �����)
 ;
 
SELECT d.deptno, dname, t.cnt
 FROM (
     SELECT deptno, COUNT(*) cnt
     FROM emp
     WHERE deptno NOT IN (20,40)
     GROUP BY deptno
     )t JOIN dept d ON d.deptno = t.deptno
WHERE cnt >=4;
     
--�׷�ȭ ���� + ���� (having)
--ORA-00918: column ambiguously defined
/* �����Լ� �ܿ��� ��� group by ���� ���� �Ѵ�.
SELECT d.deptno, dname, COUNT(*)
FROM emp e JOIN dept d ON e.deptno =d.deptno
WHERE deptno NOT IN (20,40)
GROUP BY deptno
HAVING COUNT(*) >=4;
*/
SELECT d.deptno, dname, COUNT(*)
FROM emp e JOIN dept d ON e.deptno =d.deptno
WHERE d.deptno NOT IN (20,40)
GROUP BY d.deptno, dname
HAVING COUNT(*) >=4;


----
����) insa ���̺��� 
     �� �μ����� ���� ?, �븮?, ���? ��� ���޺� ������� ���
     
SELECT buseo, name, jikwi
FROM insa
WHERE buseo = '���ߺ�'
ORDER BY JIKWI;

-------(1��) �μ����� �׷�, (2��)�μ� �ȿ��� ���޺� �׷�
SELECT buseo, jikwi, COUNT(*) ���޻����
FROM insa
GROUP BY buseo, jikwi
ORDER BY buseo ASC, jikwi ASC;

--���� ) insa ���̺��� ���ڻ���鸸 �μ����� ������� ���ؼ� 6���̻��� �μ��� ���
   --     (�μ���, ���ڻ����)
--- WHERE/ GROUP BY/ HAVING �� �����ؼ� ���

SELECT �μ���, ���ڻ����
FROM insa
WHERE ���ڻ����
GROUP BY �μ���
HAVING ���ڻ���� >=6; 

--ORA-00904: "���ڻ����": invalid identifier ó�������� ���� HAVING �����ڻ���� �νĸ���
SELECT buseo, COUNT(*) ���ڻ����
FROM insa
WHERE MOD( SUBSTR(ssn, 8,1),2) =1
GROUP BY buseo
HAVING COUNT(*) >=6; 

-- GROUP BY �� ���� ROLLUP, CUBE ����
 -- ROLLUP�� GROUP BY ���� �׷� ���ʿ� ���� ��ü ���� �׷�ȭ�ϰ�
 --  �� �׷쿡 ���� �κ����� ���ϴ� �������̴�
   
   ���� )insa ���̺��� ���ڻ����, ���ڻ������ ���(��ȸ) -group by �� ���
   
   SELECT DECODE ( MOD( SUBSTR(ssn, 8,1),2),1,'����','����') GENDER
          ,COUNT(*)
   FROM insa
   GROUP BY MOD( SUBSTR(ssn, 8,1),2)
   UNION ALL
   SELECT '�ѻ����', COUNT(*)   FROM insa;
   
   
GENDER COUNT(*)
---    --- 
����	   31
����	   29
�ѻ����  60

-- ROLL UP ������ ��� ���� ���� ó��
�׷�ȭ �� �κ����� ���� ���ؼ� ������ �� �ʿ� ���� RULLUP �����ڿ� ���ؼ� �κ��� ���
   SELECT DECODE(  MOD( SUBSTR(ssn, 8,1),2),1,'����',0,'����','�ѻ����') GENDER
          ,COUNT(*)
   FROM insa
   GROUP BY ROLLUP ( MOD( SUBSTR(ssn, 8,1),2));

-------------
  SELECT DECODE(  MOD( SUBSTR(ssn, 8,1),2),1,'����',0,'����','�ѻ����') GENDER
          ,COUNT(*)
   FROM insa
   GROUP BY CUBE ( MOD( SUBSTR(ssn, 8,1),2));

--���� )   insa ���̺��� 
          �� �μ����� 1���׷�ȭ, �� ������ 2���׷�ȭ COUNT(), SUM(), AVG()
    SELECT buseo, jikwi, COUNT(*) �����
    FROM insa
    GROUP BY buseo , jikwi
--    ORDER BY buseo, jikwi
    UNION ALL
    SELECT buseo, ' ', COUNT(*)
    FROM insa
    GROUP BY buseo
    UNION ALL
    SELECT '','',COUNT(*)
    FROM insa;
    
    ORDER BY buseo ASC ;
--ORA-00933: SQL command not properly ended
--ORDER BY ���� �׻� �� ������������ �� �� �ִ�


    SELECT buseo, jikwi, COUNT(*) �����
    FROM insa
    --GROUP BY ROLLUP ( buseo , jikwi)
    GROUP BY CUBE( buseo , jikwi)
    ORDER BY buseo , jikwi;
    
    GROUP BY N=2�� buseo, jikwi
    ROLLUP N+1 =3 (�μ�+���� �����, �μ������,  ��ü �����)
    CUBE 2*N=4  (�μ�+���� �����, �μ������, ���������, ��ü �����)

���ߺ�	����	2
���ߺ�	�븮	2
���ߺ�	����	1
���ߺ�	���	9
��ȹ��	�븮	3
��ȹ��	����	2
��ȹ��	���	2
������	����	1
������	�븮	5
������	����	2
������	���	8
�λ��	����	1
�λ��	�븮	1
�λ��	���	2
�����	����	1
�����	����	1
�����	���	4
�ѹ���	����	2
�ѹ���	����	1
�ѹ���	���	4
ȫ����	����	1
ȫ����	�븮	2
ȫ����	���	3

-----------------------
--���� ) emp ���̺��� JOB ���� ����� �� �� ��ȸ
��. GROUP BY ��
SELECT job, COUNT(*)
FROM emp
GROUP BY job;

��. DECODE() �Լ�
SELECT COUNT ( DECODE ( JOB, 'CLERK','O')) CLERK
       ,COUNT ( DECODE ( JOB, 'SALESMAN','O'))  SALESMAN
       ,COUNT ( DECODE ( JOB, 'PRESIDENT','O') ) PRESIDENT
       ,COUNT ( DECODE ( JOB, 'MANAGER','O'))  MANAGER
       ,COUNT ( DECODE ( JOB, 'ANALYST','O') ) ANALYST
FROM emp;

** ��. PIVOT (�ǹ�) **
--  ����� ����/���� - �ǹ� ��� 
-- ���� �߽����� ȸ����Ű��. ���� -> ���� (�ǹ�)/ ����-> ���� (���ǹ�)

1)����Ŭ 11g ���� �����ϴ� �Լ�
2) ��� ���� ������ �Լ�
3) ����
 SELECT * 
 FROM (�ǹ� ��� ������)  -- �ǹ���� ��������
 PIVOT (�׷��Լ�(�����÷�) FOR �ǹ��÷� IN(�ǹ��÷� �� AS ��Ī...))

SELECT *
FROM ( SELECT job FROM emp)
PIVOT (COUNT (job) FOR job IN ('CLERK', 'SALESMAN','PRESIDENT','MANAGER','ANALYST'  ))


SELECT job
FROM emp;

CLERK
SALESMAN
SALESMAN
MANAGER
SALESMAN
MANAGER
MANAGER
PRESIDENT


-- ����) emp ���̺���
       �� job �� 1��, 2�� �Ի��� ������� ��ȸ.
SELECT * 
  FROM (SELECT job , TO_CHAR(hiredate, 'FMMM') || '��' hire_month
         FROM emp
       )
   PIVOT(
         COUNT(*)
         FOR hire_month IN ('1��', '2��','3��','4��','5��','6��','12��')
        );

-- ����) insa ���̺��� ������ ����� ��ȸ
 
 1. GROUP BY ���
SELECT COUNT(*)
FROM insa
GROUP BY MOD ( SUBSTR(ssn, 8,1),2 );

  2. DECODE() ���
  SELECT DECODE ( MOD ( SUBSTR(ssn, 8,1),2 ),'1','����')
       ,DECODE ( MOD ( SUBSTR(ssn, 8,1),2 ),'0','����')
  FROM insa;
  
  3. PIVOT() ���
 SELECT * 
 FROM (�ǹ� ��� ������)  -- �ǹ���� ��������
 PIVOT (�׷��Լ�(�����÷�) FOR �ǹ��÷� IN(�ǹ��÷� �� AS ��Ī...))
 
 SELECT *
 FROM ( SELECT  MOD(SUBSTR(ssn, 8,1),2) gender FROM insa)
 PIVOT ( COUNT(*) FOR gender IN( 1 AS "����",0 AS "����"));




