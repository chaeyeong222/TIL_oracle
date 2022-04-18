TO_CHAR ���� ��¥ -> ���ڷ�

1.  TO_CHAR( ,  'format') �Լ����� 'format'�� ���Ǵ� ��ȣ�� ��������.
  ��. �⵵ : Y, [YY], YYY, [YYYY], SYYYY, I, IY,IYY, IYYY, IYYYY, YEAR, SYEAR, RR, RRRR
  ��. �� : MONTH, [MM], MON
  ��. ���� �� : [DD]
      ���� �� : D
      ���� �� : DDD
  ��. ���� : day
  ��. ���� ���� : W
      ���� ���� : WW ,IW
  ��. �ð�/24�ð� : HH/HH24   , HH12
  ��. �� : MI
  ��. �� : SS
  ��. �������� ���� �� : SSSSS  ms
  ��. ����/���� : AM/PM
   
  TS : �ð����� �����ϰ� ��Ÿ���� ��
  DS , DL : �⵵�� �����ϰ� ��Ÿ���� ��
  
2. ������ ���Ϸκ��� ���ñ��� ��ƿ� �ϼ�, ������, ����� ����ϼ���..
SELECT  CEIL (SYSDATE - TO_DATE ('1998.07.03')) "��ƿ� �� ��"
       ,  (MONTHS_BETWEEN(TO_DATE ('1998.07.03'),SYSDATE)) "���� ��" 
       ,ABS (MONTHS_BETWEEN(TO_DATE ('1998.07.03'),SYSDATE))/12 "���"
FROM dual;

3. emp  ����  comm �� null ����� ?? 

SELECT  --COUNT (COMM) NULL ���������� ����
        COUNT (*)
FROM emp
WHERE comm IS NULL;

SELECT COUNT (DECODE (comm, null, 'O'))
FROM emp;

SELECT COUNT (CASE 
       WHEN comm IS NULL THEN 'O'
       ELSE null
       END )
FROM emp;

4. 
  4-1. �̹� ���� �� �ϱ��� �ִ� Ȯ��.
  SELECT LAST_DAY(SYSDATE)
          ,TO_DATE( LAST_DAY(SYSDATE),'DD')
         -- ,EXTRACT( DATE FROM LAST_DAY(SYSDATE)  )
  FROM dual;
  --22/04/30
  4-2. ������ ���� �� ° ��, ���� �� °������ Ȯ��. 
SELECT TO_CHAR(SYSDATE, 'WW')  --��
         ,TO_CHAR(SYSDATE, 'IW')--��
         ,TO_CHAR(SYSDATE, 'W') --��
FROM dual;


5. emp ����  pay �� NVL(), NVL2(), COALESCE()�Լ��� ����ؼ� ����ϼ���.

SELECT sal+NVL(comm,0)
      , sal+ NVL2(comm,comm, 0)
      , NVL2( comm, sal+comm, sal)
      , sal+ COALESCE(comm,0)
      , COALESCE (sal+comm,sal,0)
FROM emp;


5-2. emp���̺��� mgr�� null �� ��� -1 �� ����ϴ� ���� �ۼ�
      ��. nvl()    
      ��. nvl2() 
      ��. COALESCE()
      
SELECT e.*
    ,NVL(MGR,-1)
    ,NVL2(MGR,MGR,-1)
    ,COALESCE( MGR, -1)
 FROM emp e
 WHERE MGR IS NULL;
    
      
6. insa ����  �̸�,�ֹι�ȣ, ����( ����/���� ), ����( ����/���� ) ��� ���� �ۼ�-
    ��. DECODE()
    
    SELECT name, ssn
            ,DECODE( MOD(SUBSTR(ssn, -7,1),2),1,'����','����') 
    FROM insa;
    
    ��. CASE �Լ�
    SELECT name, ssn
           ,CASE MOD(SUBSTR(ssn, -7,1),2)
           WHEN 1 THEN '����'
           ELSE '����'
           END gender
           ,CASE
           WHEN  MOD(SUBSTR(ssn, -7,1),2)=1 THEN '����'
           ELSE '����'
           END gender
    FROM insa;

7. emp ���� ���PAY ���� ���ų� ū ����鸸�� �޿����� ���.
SELECT SUM( sal+NVL(comm,0))/COUNT( *) avg_pay 
       ,AVG( sal+NVL(comm,0)) avg_pay   
FROM emp; 
--2260.416666666666666666666666666666666667

SELECT SUM( sal+NVL(comm,0)) total_pay
FROM emp
WHERE sal+NVL(comm,0) 
     >= ( SELECT AVG( sal+NVL(comm,0)) FROM emp);
--18925 

--WHERE sal+NVL(comm,0) > = 2260.416666666666666666666666666666666667;
SELECT --t.ename, t.pay, t.avg_pay
   -- ,SIGN( t.pay - t.avg_pay) 
    SUM ( DECODE (SIGN( t.pay - t.avg_pay) , -1, null, t.pay) )TOTAL_PAY
    ,  SUM ( 
    CASE SIGN( t.pay - t.avg_pay)
    WHEN -1 THEN null
    ELSE t.pay
    END
    )
FROM (
SELECT ename, sal+NVL(comm,0)pay
      , (SELECT AVG( sal+NVL(comm,0)) FROM emp ) AVG_PAY
FROM emp
)t;

8. emp ����  ����� �����ϴ� �μ��� �μ���ȣ�� ���

SELECT DISTINCT deptno
FROM emp;
8-2. emp ����  ����� �������� �ʴ� �μ��� �μ���ȣ�� ���

SELECT deptno
FROM dept
MINUS
SELECT DISTINCT deptno
FROM emp;


9. �Լ� ����
    9-1. NULLIF() �Լ� ����  -> 
    9-2. COALESCE() �Լ� ����  -> null �� �ƴ� ���� ��ȯ
    9-3. DECODE() �Լ� ����  -> 
    9-4. LAST_DAY() �Լ� ���� -> ������ �� �˷���
    9-5. ADD_MONTHS() �Լ� ����  -> ������ ������
    9-6. MONTHS_BETWEEN() �Լ� ����  -> �� ��¥ ������ ���� �� �˷���
    9-7. NEXT_DAY() �Լ� ����  -> ���ƿ��� ���� �ֱ��� �� �˷���
    9-8. EXTRACT() �Լ� ����  ->

10. emp ���̺��� ename, pay , �ִ�pay�� 5000�� 100%�� ����ؼ�
   �� ����� pay�� ��з��� ����ؼ� 10% �� ���ϳ�(*)�� ó���ؼ� ���
   ( �Ҽ��� ù ° �ڸ����� �ݿø��ؼ� ��� )

SELECT -- ename, sal+NVL(comm,0) pay,
    MAX( sal+NVL(comm,0)) max_pay
    ,MIN ( sal+NVL(comm,0))
FROM emp;

SELECT t.*
      , t.pay*100/t.max_pay ||'%' "percent"
      , ROUND (( t.pay*100/t.max_pay )/10) START_COUNT
      , RPAD( ' ', ROUND (( t.pay*100/t.max_pay )/10)+1,'*')
FROM (
SELECT ename, sal+NVL(comm,0) pay
      , (SELECT MAX( sal+NVL(comm,0)) FROM emp ) max_pay
FROM emp
)t;



11. �Ʒ� �ڵ���  DECODE()�� ����ؼ� ǥ���ϼ���.
    ��. [�ڹ�]
        if( A == B ){
           return X;
        }
           -> DECODE ( A,B,X)
    
    ��. [�ڹ�]
        if( A==B){
           return S;
        }else if( A == C){
           return T;
        }else{
           return U;
        }
       -> DECODE ( A,B,S,C,T,U)
    ��.  [�ڹ�]
        if( A==B){
           return XXX;
        }else{
           return YYY;
        }
        -> DECODE ( A,B,XXX,YYY)
        
12. insa���̺��� 1001, 1002 ����� �ֹι�ȣ�� ��/�� �� 10��10�Ϸ� �����ϴ� ������ �ۼ� 

SELECT name,ssn,
         REPLACE( ssn, TO_CHAR(SUBSTR(ssn, 3,4)), '1010')
FROM insa
WHERE num = 1001 OR num = 1002;

----------
UPDATE insa
SET  ssn = SUBSTR(ssn, 0,2) || '1010' || SUBSTR(ssn,7)
WHERE num IN ( 1001,1002);

COMMIT;

--2�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

--Ŀ�� �Ϸ�.
12-2. insa���̺��� '2022.10.10'�� �������� �Ʒ��� ���� ����ϴ� ���� �ۼ�.  

SELECT name, ssn
     --     , TO_CHAR( TO_DATE('2022.10.10'), 'HH24:MI:SS')
     --     ,TO_CHAR(TO_DATE ( SUBSTR( ssn, 3,4) ,'MMDD'),'HH24:MI:SS')
          ,DECODE ( SIGN( TO_DATE('2022.10.10') - TO_DATE( SUBSTR( ssn, 3,4) ,'MMDD')   )
                       ,-1, '���� ��',0,'���� ����' ,1,'���� ��')
          , CASE SIGN( TO_DATE('2022.10.10') - TO_DATE( SUBSTR( ssn, 3,4) ,'MMDD'))
                WHEN 1 THEN '���� ��'
                WHEN -1 THEN '���� ��'
                ELSE '���� ����'
                END
FROM insa;


���)
����ö	780506-1625148	���� ��
�迵��	821011-2362514	���� ��
������	810810-1552147	���� ��
������	751010-1122233	���� ����
������	801010-2987897	���� ����
���ѱ�	760909-1333333	���� ��

12-3. insa���̺��� '2022.10.10'�������� �� ���� ������ �����,���� �����, �� ���� ������� ����ϴ� ���� �ۼ�. 


SELECT COUNT (*) "�����" 
FROM insa
GROUP BY  DECODE ( SIGN( TO_DATE('2022.10.10') - TO_DATE( SUBSTR( ssn, 3,4) ,'MMDD')   )
                       ,-1, '���� ��',0,'���� ����' ,1,'���� ��') ;                       

----------���1
SELECT  COUNT(DECODE ( S,0,'O' )) "���� ������ �����"
     ,COUNT(CASE WHEN S=1 THEN 'O' ELSE NULL END) "���� �� ��� ��" 
     , COUNT(CASE WHEN S=-1 THEN 'O' ELSE NULL END) "���� �� ��� ��" 
  -- t.name, t.ssn, t.s, DECODE ( S,0,'O' )
  , COUNT(*) "��ü ��� ��"
     
FROM 
(
    SELECT name, ssn
          , TO_DATE( '2022.10.10')
          , TO_DATE(SUBSTR(ssn,3,4),'MMDD')
          , SIGN( TO_DATE( '2022.10.10') - TO_DATE(SUBSTR(ssn,3,4),'MMDD') ) S
    FROM insa
)t;

--    GROUP BY �� ���
SELECT DECODE( t.S, -1,'���� ��',0,'���û���', 1,'���� ��'), COUNT(*)
FROM 
(
    SELECT name, ssn
          , SIGN( TO_DATE( '2022.10.10') - TO_DATE(SUBSTR(ssn,3,4),'MMDD') ) S
    FROM insa
)t
GROUP BY t.S;

���)
������ ������ ����� ���� ������ �����  ���� ���� �����   ��ü�����
----------- 	     ---------- 	 ----------    ------
7	                  44	           9	         60
          
13.  emp ���̺��� 10�� �μ�������  �޿� 15% �λ�
                20�� �μ������� �޿� 10% �λ�
                30�� �μ������� �޿� 5% �λ�
                40�� �μ������� �޿� 20% �λ�
  �ϴ� ���� �ۼ�.     

SELECT deptno, ename, sal + NVL(comm,0) pay
    ,DECODE( deptno, 10,15,20,10,30,5,40,20)||'%�λ�' "�λ��"
    , (sal+ NVL( comm,0))*DECODE( deptno, 10,15,20,10,30,5,40,20)/100 "�λ�ݾ�" 
     , CASE deptno
       WHEN 10 THEN (sal+ NVL( comm,0))*1.15
       WHEN 20 THEN (sal+ NVL( comm,0))*1.1
       WHEN 30 THEN (sal+ NVL( comm,0))*1.05
       WHEN 40 THEN (sal+ NVL( comm,0))*1.2
       END �λ�ȱݾ�
FROM emp;


          
14. emp ���̺��� �� �μ��� ������� ��ȸ�ϴ� ����
SELECT COUNT( DECODE(deptno,10,'O' ) ) "10�� �μ� �����"
        ,COUNT( DECODE(deptno,20,'O' ) ) "20�� �μ� �����"
        ,COUNT( DECODE(deptno,30,'O' ) ) "30�� �μ� �����"
        ,COUNT( DECODE(deptno,40,'O' ) ) "40�� �μ� �����"
        ,COUNT(*) "�ѻ����"
FROM emp;

----GROUP BY �� ���
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;

15. emp, salgrade �� ���̺��� �����ؼ� �Ʒ� ��� ��� ���� �ۼ�.

SELECT *
FROM salgrade;

��� LOSAL  HISAL
1	700	    1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999



SELECT ename, sal
     ,CASE
                   -- LOSAL     HISAL Į��
       WHEN sal BETWEEN 700 AND 1200  THEN 1
       WHEN sal BETWEEN 1201 AND 1400  THEN 2
       WHEN sal BETWEEN 1401 AND 2000  THEN 3
       WHEN sal BETWEEN 2001 AND 3000  THEN 4
       WHEN sal BETWEEN 3001 AND 9999  THEN 5
       END grade
FROM emp;

-- ���� JOIN ���  -> �ߺ����� �����Ƿ� ��Ī �ȳ־ ��.
SELECT e.ename, e.sal, s.grade
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.LOSAL AND s.HISAL;
--WHERE e.name = 'SMITH' AND e.sal BETWEEN s.LOSAL AND s.HISAL;



-- ���� : deptno, [dname], empno, ename, hiredate, job �÷� ���
SELECT deptno, empno, ename, hiredate, job
FROM emp;

SELECT dname
FROM dept;
--dname ��� �Ұ� dept ���� �����;���.
-- �ڽ� - emp ���̺� : deptno(fk), empno, ename, hiredate, job
-- �θ� - dept ���̺� :  deptno(pk), dname
-- emp�� dept ���̺��� deptno �÷����� �����ǰ� �ִ� (���� �ξ���).
--[���� ] FROM A JOIN B ON ��������;

SELECT deptno,dname, empno, ename, hiredate, job
FROM dept JOIN emp ON dept.deptno = emp.deptno;
--ORA-00918: column ambiguously defined ������.
--              Į���� ��ȣ�ϰ� �����
SELECT dept.deptno,dname, empno, ename, hiredate, job
FROM dept JOIN emp ON dept.deptno = emp.deptno;

--��Ī ��
SELECT d.deptno,dname, empno, ename, hiredate, job
FROM dept d JOIN emp e ON d.deptno = e.deptno;
--JOIN ON ��� , WHERE �ᵵ ��
SELECT d.deptno,dname, empno, ename, hiredate, job
FROM dept d, emp e 
WHERE d.deptno = e.deptno; --JOIN ���õ� ���ǽ�


ENAME   SAL     GRADE
----- ----- ---------
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


16. emp ���̺��� �޿��� ���� ���� �޴� ����� empno, ename, pay �� ���.

SELECT MAX( sal+NVL(comm,0)) max_pay
FROM emp;

------
SELECT ename, empno, sal+NVL(comm,0)
FROM emp
WHERE sal+NVL(comm,0) >=  ALL(SELECT sal+NVL(comm,0) FROM emp);
WHERE sal+NVL(comm,0) = (SELECT MAX( sal+NVL(comm,0)) max_pay FROM emp);

�񱳿����� + SOME,ANY, ALL      
EXISTS
----

SELECT sal+NVL(comm,0) FROM emp;
16-2. emp ���̺��� �� �μ��� �޿��� ���� ���� �޴� ����� pay�� ���
--���1)
SELECT 10, MAX (sal+NVL(comm,0))max_pay
        ,MIN (sal+NVL(comm,0))min_pay
FROM emp
WHERE deptno=10
UNION ALL
SELECT 20, MAX (sal+NVL(comm,0))max_pay
        ,MIN (sal+NVL(comm,0))min_pay
FROM emp
WHERE deptno=20
UNION ALL
SELECT 30, MAX (sal+NVL(comm,0))max_pay
        ,MIN (sal+NVL(comm,0))min_pay
FROM emp
WHERE deptno=30
UNION ALL
SELECT 40, MAX (sal+NVL(comm,0))max_pay
        ,MIN (sal+NVL(comm,0))min_pay
FROM emp
WHERE deptno=40;

--���2 group by �� ���
SELECT deptno ||'�� �μ�' 
        , MAX (sal+NVL(comm,0))max_pay
        ,MIN (sal+NVL(comm,0))min_pay
FROM emp
GROUP BY deptno;

--���3 --���� �ڵ��� �ƴ�
 SELECT( SELECT MAX(sal+NVL(comm,0)) FROM emp WHERE deptno=10)
       ,( SELECT MAX(sal+NVL(comm,0)) FROM emp WHERE deptno=20)
       ,( SELECT MAX(sal+NVL(comm,0)) FROM emp WHERE deptno=30)
       ,( SELECT MAX(sal+NVL(comm,0)) FROM emp WHERE deptno=40)
FROM dual;


--ORA-00979: not a GROUP BY expression
--empno ������ ������
SELECT --empno, 
       deptno, MAX( sal + NVL(comm,0)) max_pay
FROM emp
GROUP BY deptno;


---------
SELECT deptno, ename, sal+NVL(comm,0) pay
FROM emp
WHERE deptno =30 AND sal+NVL(comm,0)= 2850
OR deptno =20 AND sal+NVL(comm,0)= 3000
OR deptno =10 AND sal+NVL(comm,0)= 5000 ;

-----***
-- ������� correlated ���� ����
--main query �� �� e.deptno �� ������������ ����� ��
--������� �ٽ� ���� �������� ���

SELECT deptno, ename, sal+NVL(comm,0) pay
FROM emp e
WHERE sal+NVL(comm,0) = ( SELECT MAX(sal+NVL(comm,0)) FROM emp WHERE deptno=e.deptno );

--�������� ���� ���?



--�� �μ����� �� �μ��� ��� �޿����� ũ�� ��������� ����ϼ���
(���1)
SELECT deptno, ename, sal+ NVL(comm,0) pay
        , (SELECT AVG(sal+ NVL(comm,0)) FROM emp WHERE deptno = e.deptno) deptno_avg_pay
FROM emp e
WHERE sal+ NVL(comm,0) > (SELECT AVG(sal+ NVL(comm,0)) FROM emp WHERE deptno = e.deptno)
ORDER BY deptno;
--�ΰ� ����? ���� ������ �μ��� ��ձ��� ���ϴ� ���� ����
(���2)
SELECT deptno, ename, sal+ NVL(comm,0) pay
FROM emp e
WHERE sal+NVL(comm,0) 
    >= (SELECT AVG( sal+NVL(comm,0)) FROM emp WHERE deptno=e.deptno )
ORDER BY deptno;



--����) insa ���̺��� 
  -- java days10.EX05_05
--(  ������ =  ���� �⵵ - ���ϳ⵵ )   �������� ���ο� ���� ���� �ȳ����� -1
--   ���� ���� =  ���س⵵ -���ϳ⵵ +1

--�ֹε�Ϲ�ȣ -[����] 1,2,5,6 -> 1900  3,4,7,8 ->2000  9,0 ->1800
SELECT t.name, t.ssn
       ,CASE t.isbCheck
       WHEN -1 THEN t.now_year - t.birth_year -1   --���� ��������
       ELSE         t.now_year - t.birth_year 
       END amerianAge
       ,t.now_year - t.birth_year + DECODE(t.isbCheck,-1,-1,0) amerianAge
       , t.now_year - t.birth_year + 1 countingAGE
FROM(
    SELECT name, ssn
        ,TO_CHAR( SYSDATE, 'YYYY') now_year  
        , CASE
        WHEN SUBSTR(ssn,-7,1) IN (1,2,5,6)  THEN 1900 + SUBSTR(ssn,0,2)
        WHEN SUBSTR(ssn,8,1) IN (3,4,7,8) THEN 2000 + SUBSTR(ssn,0,2)
        ELSE 1800+ SUBSTR(ssn,0,2)
        END birth_year
        , SIGN ( TRUNC( SYSDATE) - TO_DATE(SUBSTR(ssn, 3,4),'MMDD')) isbCheck
      
FROM insa)t;

--����) emp ���̺��� pay�� ���� �޴� 3�� ��� (TOP-N ���)
SELECT ROWNUM, t.*
FROM (
        SELECT deptno, ename, sal+ NVL(comm,0) pay
        FROM emp
        ORDER BY PAY DESC
)t
WHERE ROWNUM <=3;
WHERE ROWNUM <=1;
WHERE ROWNUM  BETWEEN 3 AND 5; -- ������ �ݵ�� TOP1�� ���ԵǾ�� �Ѵ�. 

--[������ �ű�� �Լ�]
1. DENSE_RANK()
 ��. �׷� ������ ���ʷ� �� ���� rank�� ����Ͽ� NUMBER ������Ÿ������ ������ ��ȯ
 ��. �ش� ���� ���� �켱������ ����(�ߺ� ���� ��� ����) 
��Aggregate ���ġ�
      DENSE_RANK ( expr[,expr,...] ) WITHIN GROUP
        (ORDER BY expr [[DESC ? ASC] [NULLS {FIRST ? LAST} , expr,...] )
��Analytic ���ġ�
      DENSE_RANK ( ) OVER ([query_partion_clause] order_by_clause )

2. RANK()
��. �ش� ���� ���� �켱������ ����(�ߺ� ���� ��� ��) 
����) emp ���̺��� pay�� ���� �޴� 3�� ��� ( DENSE_RANK���)
WITH pay_rank_emp AS (
        SELECT ename, sal+NVL(comm,0) pay
              ,DENSE_RANK() OVER( ORDER BY sal+NVL(comm,0) DESC) seq
        FROM emp
)
SELECT e.*
FROM pay_rank_emp e
where e.seq BETWEEN 3 AND 5;
WHERE e.seq <=5;
WHERE e.seq =1;


-------
WITH pay_rank_emp AS (
        SELECT ename, sal pay
              ,DENSE_RANK() OVER( ORDER BY sal DESC) dr_seq
              ,RANK() OVER( ORDER BY sal DESC) r_seq
              ,ROW_NUMBER ()OVER( ORDER BY sal DESC)rn_seq
        FROM emp
)
SELECT e.*
FROM pay_rank_emp e;

-- ROWNUM --> �Լ�X, �ǻ�Į�� = ��¥Į��
3. ROW_NUMBER() �Լ�

--���� ) emp ���̺��� �� �μ����� �޿��� ���� ���� �޴� ��� 1�� ���

--1. �ϳ��ϳ� �����ͼ� UNION ALL ������ ���(������)
SELECT MAX(sal) max_pay
FROM emp
WHERE deptno =20 
WHERE deptno =10 ;

--2. ��� ���� ���� MQ <-> SQ
SELECT deptno, sal max_pay
FROM emp e
WHERE sal = (SELECT MAX(sal) FROM emp WHERE deptno =e.deptno);

--3. ���� �Լ� ���
SELECT t.*
FROM (
SELECT deptno , sal pay
       -- , RANK( ) OVER( ORDER BY  sal DESC) seq  --��ü����
       -- , RANK( ) OVER( PARTITION BY deptno ORDER BY  sal DESC) seq
       -- , DENSE_RANK( ) OVER( PARTITION BY deptno ORDER BY  sal DESC) seq
        , ROW_NUMBER( ) OVER( PARTITION BY deptno ORDER BY  sal DESC) seq
FROM emp)t
WHERE t.seq <=2;

--12:100 = ?:20
--? = 240/100
--   = 2.4

--���� emp ���̺��� sal pay �� ���� 20%������ �������
SELECT t.*
FROM (
SELECT deptno ,ename,  sal pay
       ,RANK( ) OVER( ORDER BY sal DESC) r_seq
FROM emp)t
WHERE t.r_seq <= FLOOR( 2.4);

-- PERCENT_RANK()
��Analytic ���ġ�
       PERCENT_RANK() OVER ( 
                             [query_partition_clause]
                              order_by_clause
                            )
---

