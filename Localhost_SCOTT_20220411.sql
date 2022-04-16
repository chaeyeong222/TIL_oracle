1. EMP ���̺��� ������� ��ȸ�ϴ� ���� �ۼ�.
  �����Լ� / �׷��Լ� / �������Լ�
  COUNT(), SUM(), AVG()]
  MAX(), MIN()
  STDDEV() ǥ������, VARIANCE()�л�
    
SELECT COUNT(*)  --NULL�� �����ؼ� 12
     --,COUNT(COMM) --NULL�� �����ؼ� 4
     --,SUM( sal+NVL(comm,0))totalpay
     --,SUM(sal+NVL(comm,0) )/COUNT(*) avg_pay
     --,AVG( sal+NVL(comm,0) ) avg_pay2
     ,MAX( sal+NVL(comm,0)) max_pay
     ,MIN(sal+NVL(comm,0)) min_pay
FROM emp;
--12
  --**������ �� ) NULL ���� ������ ***
--����) emp���̺��� �ְ�޿����� �޴� ����� ����?

SELECT *
FROM emp
WHERE sal+NVL(comm,0)=( SELECT MAX (sal+NVL(comm,0)) FROM emp );

SELECT *
FROM emp
WHERE sal+NVL(comm,0)=( SELECT MIN(sal+NVL(comm,0)) FROM emp );

--���� emp���̺��� �ְ�, ���� �޿��� �޴� ����� ����
���1)
SELECT *
FROM emp
WHERE sal+NVL(comm,0)=( SELECT MIN(sal+NVL(comm,0)) FROM emp )
      OR sal+NVL(comm,0)=( SELECT MAX(sal+NVL(comm,0)) FROM emp );
���2)
SELECT *
FROM emp
WHERE sal+NVL(comm,0)=( SELECT MAX (sal+NVL(comm,0)) FROM emp )
UNION
SELECT *
FROM emp
WHERE sal+NVL(comm,0)=( SELECT MIN(sal+NVL(comm,0)) FROM emp );

���3)
SELECT *
FROM emp
WHERE sal+NVL(comm,0) 
  IN(  ( SELECT MAX (sal+NVL(comm,0)) FROM emp )
           , (SELECT MIN(sal+NVL(comm,0))FROM emp));

--���� ������ FROM emp �ʿ�, �ƴϸ� ��������.

--�ְ� �޿�
SELECT *
FROM emp
WHERE sal+NVL(comm,0) >= ALL(SELECT sal+NVL(comm,0) FROM emp);

--�����޿�
SELECT *
FROM emp
WHERE sal+NVL(comm,0) <= ALL(SELECT sal+NVL(comm,0) FROM emp);

--WHERE �������� ���������� ����� �����Ѵٸ� TRUE ��ȯ --12�� ����
SELECT *
FROM emp
WHERE EXISTS(SELECT DISTINCT mgr FROM emp WHERE mgr IS NOT NULL);
WHERE EXISTS (SELECT deptno FROM dept);

2. ���� �ý�����   ��¥�� ����ϴ� ���� �ۼ�
SELECT SYSDATE
      ,CURRENT_DATE  --�ʱ���
      ,CURRENT_TIMESTAMP --�����ʱ���
FROM dual;
--22/04/11

3. SQL ���� �������� ������ ������ �ϼ���
SUM �հ�
AVG ���
COUNT ����

4. �Լ� ����
  ��. �ݿø� �Լ��� ���������� ���� �����ϼ��� 
  SELECT ROUND(��, �ݿø��� ��ġ) ��ġ�� +1�� ������ �ݿø� ��.
  FROM dual;
  ��. ����(����) �Լ��� ���������� ���� �����ϼ���.    
  TRUNC -- ��, ��ġ   
  FLOOR -- �Ҽ� ù°�ڸ�����, ������ ������
  ��. ����(�ø�) �Լ��� ���������� ���� �����ϼ���.    
  CEIL --��ġ ���� �ȵ�.
  
5. �Խ��ǿ��� �� �Խñ� ���� : 65 �� �̰�  �� �������� : 15���� �Խñ� ����� ��
    �� ������ ���� ����ϴ� ���� �ۼ�.
SELECT CEIL( 65/15) "��������"
FROM dual;
6. emp ���̺��� ������� ��� �޿����� ���� �޿��� ������ 1
                                     ���� �޿��� ������ -1
                                     ������           0 
  �� ����ϴ� ���� �ۼ�.
SELECT t.ename, t.pay, t.avg_pay
   ,SIGN( t.pay-t.avg_pay   ) 
FROM (SELECT ename 
         , sal+NVL(comm,0) pay
         --, AVG( sal+NVL(comm,0) )
         ,( SELECT FLOOR (AVG( sal+NVL(comm,0) )) FROM emp) avg_pay
     FROM emp
) t;

7. insa���̺��� 80���( 80��~89��� )�� ����� ����鸸 ��ȸ�ϴ� ������ �ۼ�
  ��. LIKE ���
  WHERE ssn LIKE '8%'
  ��. REGEXP_LIKE ���
  WHERE REGEXP_LIKE (ssn,'^8')
  ��. BETWEEN ~ AND ���   
  WHERE SUBSTR(ssn,0,2)  BETWEEN 80 AND 89
  
8. insa ���̺��� �ֹε�Ϲ�ȣ�� 123456-1******  �������� ����ϼ��� . ( LPAD, RPAD �Լ� ���  )
[������]
ȫ�浿	770423-1022432	770423-1******
�̼���	800423-1544236	800423-1******
�̼���	770922-2312547	770922-2******
SELECT name, ssn
           ,RPAD(  SUBSTR( ssn, 0,8) ,14,'*')
FROM insa;

8-2. emp ���̺��� 30�� �μ��� PAY�� ��� �� ����׷����� �Ʒ��� ���� �׸��� ���� �ۼ�
   ( �ʿ��� �κ��� ��� �м��ϼ���~    PAY�� 100 ������ # �Ѱ� , �ݿø�ó�� )
   
SELECT deptno, ename
        ,sal + NVL(comm,0) pay
        , ROUND(sal + NVL(comm,0),-2)/100
        ,RPAD( ' ', ROUND(sal + NVL(comm,0),-2)/100+1, '#')
FROM emp
WHERE deptno = 30;
   
[������]
DEPTNO ENAME PAY BAR_LENGTH      
---------- ---------- ---------- ----------
30	BLAKE	2850	29	 #############################
30	MARTIN	2650	27	 ###########################
30	ALLEN	1900	19	 ###################
30	WARD	1750	18	 ##################
30	TURNER	1500	15	 ###############
30	JAMES	950	    10	 ##########

8-3. insa ���̺���  �ֹι�ȣ�� �Ʒ��� ���� '-' ���ڸ� �����ؼ� ���
[������]
NAME    SSN             SSN_2
ȫ�浿	770423-1022432	7704231022432
�̼���	800423-1544236	8004231544236
�̼���	770922-2312547	7709222312547

SELECT ssn
       ,REPLACE(ssn, '-','')
       ,INSTR(ssn, '-')
       ,SUBSTR(ssn, 0,6) || SUBSTR(ssn, -7)
FROM insa;

9. emp ���̺��� �� ����� �ٹ��ϼ�, �ٹ� ������, �ٹ� ����� ����ϼ���.

��¥ - ��¥ = �ϼ�
��¥ + ���� = ��(����)�� ������ ��¥
��¥ - ���� = ���� ���� ��¥
��¥ +- ����/24 = �ð��� +- �� ��¥

-- �ٹ��ϼ� / 365 = �ٹ���� + ������

SELECT empno, ename, hiredate
     , CEIL ( ABS( hiredate - SYSDATE)) �ٹ��ϼ�
FROM emp;

--MONTHS_BETWEEN() : ��¥ ������ ������ �����ϴ� �Լ�
SELECT ROUND (ABS(MONTHS_BETWEEN(hiredate, SYSDATE)),2) �ٹ�������
       ,ROUND(ABS(MONTHS_BETWEEN(hiredate, SYSDATE))/12 ,2) �ٹ����
FROM emp;


10. �����Ϸκ��� ���ó�¥������ �����ϼ� ?  --��/��/������ ����
( ������ : 2022.2.15 )

--ORA-00932: inconsistent datatypes: expected CHAR got DATE
-- �ڷ��� �ٸ� '2022~'�� ���ڿ��� �ν��ؼ� ������ ��
SELECT '2022.02.15'- SYSDATE
FROM dual;

/*TO_DATE �Լ���
CHAR, VARCHAR2, NCHAR, NVARCHAR2 ������Ÿ����
DATE ������Ÿ������ ��ȯ�Ѵ�*/

--�ùٸ� ��
SELECT  TO_DATE( '2022.02.15')- SYSDATE
      -- ORA-01843: not a valid month
      --,TO_DATE( '02/15/2022')- SYSDATE
      ,TO_DATE( '02/15/2022', 'MM/DD/YYYY')- SYSDATE
FROM dual;




10-2.  ���ú��� �����ϱ��� ���� �ϼ� ?  
( ������ : 2022.7.29 ) 

SELECT  CEIL (TO_DATE( '2022.07.29')- SYSDATE)
FROM dual;

10-3. emp ���̺��� �� ����� �Ի����� �������� 100�� �� ��¥, 10���� ��¥, 1�ð� �� ��¥, 3���� �� ��¥ ���

SMITH	80/12/17	81/03/27	80/12/07	80/12/17	81/03/17	80/09/17
ALLEN	81/02/20	81/05/31	81/02/10	81/02/20	81/05/20	80/11/20
WARD	81/02/22	81/06/02	81/02/12	81/02/22	81/05/22	80/11/22

SELECT ename, hiredate
       ,hiredate + 100
       ,hiredate -10
       ,hiredate +1/24
       ,ADD_MONTHS(hiredate, 3) "3������"
       ,ADD_MONTHS(hiredate, -3) "3������"
FROM emp;

MONTHS_BETWEEN () ������

SELECT t.f, t.s
       ,MONTHS_BETWEEN(t.f, t.s)
FROM ( SELECT TO_DATE ('03-01-2022', 'MM-DD-YYYY')   F
         ,TO_DATE ('02-01-2022', 'MM-DD-YYYY')  S
      FROM dual
      )t;

--ADD_MONTHS()
SELECT ADD_MONTHS(TO_DATE ('02-01-2022', 'MM-DD-YYYY'), 1)
       ,ADD_MONTHS(TO_DATE ('02-28-2022', 'MM-DD-YYYY'),1)  --3.31
       ,ADD_MONTHS(TO_DATE ('02-27-2022', 'MM-DD-YYYY'),1)   --3.27
FROM dual;

--LAST_DAY() �� Ư�� ��¥�� ���� ���� ���� ������ ��¥�� ��ȯ

SELECT LAST_DAY(SYSDATE)
   --       �� �� ������ �ʹ�?
       ,TO_CHAR( LAST_DAY(SYSDATE), 'DD')
       ,EXTRACT( DAY FROM LAST_DAY(SYSDATE))
FROM dual;

--������ �ݿ��� �ް�?
--��õ� ������ ���ƿ��� ���� �ֱ� ��¥
-- ��1 ��2 ȭ3 ...
SELECT SYSDATE 
        ,TO_CHAR(SYSDATE,'D') 
        ,TO_CHAR(SYSDATE,'DY') 
        ,TO_CHAR(SYSDATE,'DAY') 
        ,NEXT_DAY( SYSDATE , '�ݿ���')
        ,NEXT_DAY( SYSDATE , '������')
FROM dual;

11. function ����
 ��. ASCII()
 ��. CHR()
 ��. GREATEST()
 ��. LEAST()
 ��. UPPER()
 ��. LOWER()
 ��. LENGTH()
 ��. SUBSTR()
 ��. INSTR()
 
 SELECT ASCII('��'), ASCII('A')
      ,CHR(15380608), CHR(65)
      ,GREATEST(1,2,3,4,5), LEAST(1,2,3,4,5)
 FROM dual;
 
12. 
SELECT TRUNC( SYSDATE, 'YEAR' ) --22/01/01 
      , TRUNC( SYSDATE, 'MONTH' )     -- 22/04/01
      , TRUNC( SYSDATE  )     --22/04/11
    FROM dual;
    ���� ������ ����� �������� . 
    
����) �̹��� �� �� ���ҳ�?
SELECT SYSDATE
      ,LAST_DAY(SYSDATE)
      ,LAST_DAY(SYSDATE) -SYSDATE 
FROM dual;

--����Ŭ ����ȯ �Լ�
TO_NUMBER() : ���� -> ���� ����ȯ
TO_DATE()
TO_CHAR()

SELECT '10' --��������
        ,10   --����������
        ,TO_NUMBER('10')
        ,'10'+10
FROM dual;

SELECT *
FROM insa
WHERE SUBSTR(ssn, -7,1)=1 ; -- '1' �Ͻ��� ����ȯ

SELECT TO_DATE( '2022.02.15')
       ,TO_DATE( '02.15.2022','MM.DD.YYYY')
       ,TO_DATE('2022','YYYY') 
       --2022/04/01  --�⵵�� �ִ� ���ڿ��� TO_CHAR�� ��¥��ȯ�ϸ� �� ���� 1�� ��¥�� ��.
       ,TO_DATE('2022.03','YYYY.MM') --1�Ϸ� ����
       ,TO_DATE('20','DD') --2022/4/20
FROM dual;
    
SELECT SYSDATE 
--       ,TO_CHAR(SYSDATE, 'YYYY') --��¥���� ���ڿ� '2022'�⵵�� ������
--       ,TO_CHAR(SYSDATE, 'MM')
--       ,TO_CHAR(SYSDATE, 'DD')
--       ,TO_CHAR(SYSDATE, 'HH')
--       ,TO_CHAR(SYSDATE, 'HH24')
--       ,TO_CHAR(SYSDATE, 'SS')
--       ,TO_CHAR(SYSDATE, 'D')
--       ,TO_CHAR(SYSDATE, 'DY')
--       ,TO_CHAR(SYSDATE, 'DAY'
         ,TO_CHAR(SYSDATE, 'CC')  --21����
         ,TO_CHAR(SYSDATE, 'Q') --2(�б�)
         ,TO_CHAR(SYSDATE, 'WW')--�� �߿� ���° ��
         ,TO_CHAR(SYSDATE, 'IW')   --1�� �� ���° ��
         ,TO_CHAR(SYSDATE, 'W') --�� �߿� ���° ��
FROM dual;

--SYSDATE�� TO_CHAR ����ؼ� '2022�� 4�� 11�� ���� 12:40:12'�� ���
-- . �� / �ܿ� �ٸ� ���� �ְ� �ʹٸ� " �ֵ���ǥ �ִ´�
SELECT TO_CHAR(SYSDATE, 'YYYY"�� "MM"�� "DD"�� "TS')
FROM dual;

------------���ڸ� ���ڷ�
SELECT 1234567
 --3�ڸ����� �޸� ���� ���ڿ��� ��ȯ
 , TO_CHAR(1234567 ,'9,999,999') --###### �߸� �ڸ� ����
 , TO_CHAR(1234567 ,'L9,999,999.99') --�빮�� L ���̸� ��ȭ��ȣ
 , TO_CHAR(12,'0009')  --0012 ���ڸ��� 0���� ä��
FROM dual;

--
SELECT ename, TO_CHAR(  sal+NVL(comm,0) , 'L9,999') pay
FROM emp;

SELECT name, TO_CHAR( basicpay + sudang, 'L9,999,999') pay
FROM insa;

--EMP ���̺��� �� ����� �Ի���¥�� �������� 10��5����20��° �Ǵ� ����?

SELECT ename, hiredate
        ,ADD_MONTHS( hiredate + 20, 10*12 + 5) 
FROM emp;

--���ڿ� '2021�� 12�� 23��' ���ڿ��� ��¥������ ��ȯ
ORA-01821: date format not recognized
SELECT TO_DATE( '2021�� 12�� 23��', 'YYYY"��" MM"�� "DD"��"')
FROM dual;

--INSA ���̺��� SSN �ֹι�ȣ�� ���ؼ� ���� �������� + ���ñ������� ���� �����ٸ� -1, �����̸� 0, ���������� 1
SELECT name, ssn
         ,TO_CHAR( TO_DATE( SUBSTR(ssn,3,4) ,'MMDD' ),'YY/MM/DD HH24:MI:SS' ) BIRTHDAY   --�⵵�� ����ý��� �⵵�� �� 2022
         , TO_CHAR ( TRUNC(SYSDATE) , 'YY/MM/DD HH24:MI:SS')
         , SIGN( TO_DATE( SUBSTR(ssn,3,4) ,'MMDD'  )- TRUNC(SYSDATE) )
FROM insa;

-- COALESCE() ���� ���������� üũ�ؼ� NULL �� �ƴ� ���� ��ȯ�ϴ� �Լ�

[����]
 COALESCE( expr[,expr,expr,expr,..])
 
SELECT ename, sal, comm
       , sal + NVL(comm,0) pay
       , sal + NVL2(comm, comm, 0) pay
       , sal + COALESCE(comm,0)
       , COALESCE (sal+comm, sal,0) pay
       ,COALESCE ( sal, commpay)
FROM emp;

--*****DECODE() �Լ� **
--1. ���α׷� ���(�ڹ�)�� IF ��
--   3. IF( == ���ǽ�) ����(=) �񱳿����� �� ��� ���� 
--2. FROM �������� ��� �Ұ� **
--4. DECODE() �Լ��� Ȯ���Լ��� CASE() �Լ�. 
--5. PL/SQL���� ����� �������� ���� ����Ŭ �Լ�.
-- �ڹ� 
int x = 10;
if( x= 11) {
  return c;
}
--> DECODE(x,11,c);  --  x=11�̸� c����


if(x = 10) {
  return a;
}else { 
  return b;
}
--> DECODE(x,10,a,b); --  x=10�̸� a���� �ƴϸ� b����


if(x = 1) {
   return a;
}else if (x= 10) {
  return b;
} else if (x= 15) {
  return c;
} else {
    return d;  
}
--> DECODE(x,1,a,10,b,15,c,d);

--���� )insa ���̺��� ssn �ֹε�Ϲ�ȣ ���� ���ͼ�
      ���� �������� (����) , �����̸� (������) , ���������� (������)
SELECT name, ssn
      ,SIGN( TRUNC( SYSDATE ) -  TO_DATE( SUBSTR(ssn,3,4) ,'MMDD')  )
       -- -1 ������, 1������ 0���û���
    ,DECODE( SIGN( TRUNC( SYSDATE ) -  TO_DATE( SUBSTR(ssn,3,4) ,'MMDD'))
       ,-1,'������',1,'������','���û���')
FROM insa;

--���� )insa ���̺��� ssn �ֹε�Ϲ�ȣ ������ �������
SELECT name, ssn
      ,MOD( SUBSTR(ssn,8,1),2)
      ,DECODE( MOD( SUBSTR(ssn,8,1),2),1,'����','����')
FROM insa;

-- (+) ���ڻ���� ���ڻ���� ���ϸ�?
--���1
SELECT '���ڻ����' "����", COUNT(*) "�����"
FROM insa
WHERE  MOD ( SUBSTR( ssn, -7,1),2)=1
UNION
SELECT '���ڻ����', COUNT(*) 
FROM insa
WHERE MOD ( SUBSTR( ssn, -7,1),2)=0
UNION
SELECT '�ѻ����', COUNT(*) 
FROM insa ;

--���2
SELECT COUNT(*) �ѻ����
        , COUNT(DECODE( MOD( SUBSTR(ssn,8,1),2),1,'����')) ���ڻ����
        , COUNT(DECODE( MOD( SUBSTR(ssn,8,1),2),0,'����')) ���ڻ����
FROM insa ;

--
SELECT ssn
        ,  MOD( SUBSTR(ssn,8,1),2) gender
FROM insa;

--����  emp���̺��� �ѻ����, 10���μ� ��� ��...~ 30���μ� �����

SELECT COUNT(*)
        ,COUNT(DECODE( deptno,10,'10���μ�')) "10���μ�"
        ,COUNT(DECODE( deptno,20,'20���μ�')) "20���μ�"
        ,COUNT(DECODE( deptno,30,'30���μ�')) "30���μ�"
FROM emp;

--EMP ���̺��� �� �μ��� �޿��� ��ȸ
SELECT SUM( sal+ NVL(comm,0)) total_pay
FROM emp
WHERE deptno =10;

SELECT SUM ( DECODE( deptno,10,sal +NVL(comm,0)) ) PAY_10
      ,SUM ( DECODE( deptno,20,sal +NVL(comm,0)) ) PAY_20
      ,SUM ( DECODE( deptno,30,sal +NVL(comm,0)) ) PAY_30
      ,SUM ( sal +NVL(comm,0))  TOTALPAY
FROM emp;

���� )EMP ���� �� ������� ��ȣ, �̸�, �޿� ���, 
    10�� �μ����̶�� 15% �λ�
    20�� �μ����̶�� 5% �λ�
    �������μ�����  10% �λ�
    
SELECT empno,deptno, ename, sal+NVL(comm,0) pay
       ,DECODE( deptno, 10,'15%',20,'5%','10%')||'�λ�'  "�λ���"
       , DECODE( deptno,10, (sal+NVL(comm,0))*1.15
                        ,20,(sal+NVL(comm,0))*1.05
                        ,(sal+NVL(comm,0))*1.1)  "�λ�ݾ�"        
FROM emp;

����) insa ���̺��� �� ����� �Ҽӵ� �μ��� ������ �?

SELECT COUNT (DISTINCT buseo)
FROM insa;

--CASE �Լ�
--���� = �񱳿����ڸ� ����� �� �ִ�
-- ���, ��, ���� �پ��� �����ڸ� ����� �� �ֵ��� Ȯ���
�����ġ�
	CASE �÷���|ǥ���� WHEN ����1 THEN ���1
			  [WHEN ����2 THEN ���2
                                ......
			   WHEN ����n THEN ���n
			  ELSE ���4]
	END ��Ī

���� )EMP ���� �� ������� ��ȣ, �̸�, �޿� ���, 
    10�� �μ����̶�� 15% �λ�
    20�� �μ����̶�� 5% �λ�
    �������μ�����  10% �λ�
    
    SELECT deptno, empno, ename, sal+NVL(comm,0) pay
          ,CASE deptno
                 WHEN 10 THEN  (sal+NVL(comm,0))*1.15
                 WHEN 20 THEN  (sal+NVL(comm,0))*1.05
                 ELSE          (sal+NVL(comm,0)) *1.1
           END pay2
    FROM emp
    ORDER BY deptno ASC;
���� )insa ���̺��� ssn �ֹε�Ϲ�ȣ ������ ������� case

SELECT name, ssn
    ,CASE MOD( SUBSTR(ssn, 8,1),2)
      WHEN 1 THEN '����'
      ELSE '����'
      END gender
    , CASE 
      WHEN MOD( SUBSTR(ssn, 8,1),2)=1 THEN '����'
      ELSE '����'
      END gender
    , CASE 
      WHEN SUBSTR(ssn, 8,1) IN (1,3,5,7,9) THEN '����'
      ELSE '����'
      END gender
FROM insa;

����) SELECT �� 7���� �� GROUP BY 
WITH
  SELECT
FROM
WHERE 
GROUP BY
HAVING
  ORDER BY
----------------------------
--�λ����̺��� ����/���� ����� ���

SELECT COUNT (DECODE ( MOD( SUBSTR(ssn, 8,1),2),1 ,'����')) ���ڻ����
     ,COUNT (DECODE ( MOD( SUBSTR(ssn, 8,1),2),0 ,'����')) ���ڻ����
FROM insa;

--GROUP BY �� ����ؼ� ����

SELECT MOD( SUBSTR(ssn, 8,1),2), COUNT(*) "�ο���"
FROM insa
GROUP BY MOD( SUBSTR(ssn, 8,1),2) ;

EMP���̺��� �� �μ��� ������� �����ȸ
--���� ) ����� ���� �μ��� ���/��ȸ �Ұ�.

SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
ORDER BY deptno;

select *
from emp;