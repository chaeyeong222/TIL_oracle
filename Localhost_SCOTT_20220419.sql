
1. 이번 달 1일 부터 마지막 날까지 아래와 같이 출력 
     ( LEVEL 의사컬럼 사용 )
실행결과) 
  날짜	       요일    주차(IW)
21/11/01	월	44
21/11/02	화	44
21/11/03	수	44
21/11/04	목	44
21/11/05	금	44
21/11/06	토	44 
 :
21/11/29	월	48
21/11/30	화	48
 
 
 
 SELECT TO_DATE('202204','YYYYMM')+(LEVEL-1)
 FROM dual
 CONNECT BY LEVEL <=EXTRACT ( DAY FROM LAST_DAY (TO_DATE('202204','YYYYMM')) );
 
 

 2-1.  아래와 같이 계층 구조로 출력하는 쿼리 작성  ( 계층구조 질의문)
실행결과)
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

2-2. 위의 JONES 계층구조 제거하는 쿼리 작성. 
실행결과)
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
      

3.  MERGE : 병합 , 한쪽 테이블의 정보를 다른 테이블에 병합(추가)

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

위의 두 테이블을 병합(merge)해서 아래와 같이 결과가 나오도록 병합하세요.
[ 실행 결과 ]
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



4. 제약조건( Contratrint ) 
  ㄱ. 제약조건이란 ?    
       
  ㄴ. 제약조건을 설정하는 2가지 방법에 대해 설명하세요.
      컬럼레벨
      테이블레벨
  
  ㄷ. 제약조건의 5가지 종류 
      primar key
      foreign key
      unique key
      check key
      not null
      
  ㄹ. emp 테이블의 제약조건 확인 쿼리 작성 
     SELECT *
     FROM user_constraints
     WHERE table_name ='EMP';
     
     
  ㅁ. 데이터 무결성 종류 및 설명
    1. 개체무결성 -> 테이블에 저장되는 행의 유일성을 보장하기 위한 제약조건
    2. 참조무결성 -> 테이블간 데이터의 일관성을 보장하기 위한 제약조건
    3. 도메인무결성 -> 컬럼값의 데이터 타입, 길이 , 유일성, 널 허용 등의 제약조건

5. 아래 테이블 생성 쿼리 에서 [컬럼 레벨] 방식으로 
   ㄱ. deptno 를 PK 로 설정
   ㄴ. dname을 NN 로 설정
CREATE TABLE tbl_dept
(
    DEPTNO  NUMBER(2)   CONSTRAINTS PK_TBLDEPT_DEPTNO PRIMARY KEY
   , DNAME VARCHAR2(14)  NOT NULL
   , LOC   VARCHAR2(13)      
);

6. 아래 테이블 생성 쿼리 에서 [테이블 레벨] 방식으로 
   ㄱ. deptno 를 PK 로 설정
   ㄴ. dname을 NN 로 설정       
CREATE TABLE tbl_dept
(
    DEPTNO  NUMBER(2) 
   , DNAME VARCHAR2(14) 
   , LOC   VARCHAR2(13) 
   ,  CONSTRAINTS PK_TBLDEPT_DEPTNO PRIMARY KEY (deptno)
   ,  CONSTRAINTS NOT NULL dname
);

7. tbl_dept 테이블을 생성 후 [모든 제약조건 제거]하는 쿼리 작성  ?


ALTER TABLE tbl_dept
 DROP ??


8. ALTER TABLE 문을 사용해서 PK 제약조건 설정. 

ALTER TABLE tbl_dept
  ADD CONSTRAINTS 제약조건명 PRIMARY KEY;


9. UK 제약 조건 삭제 쿼리 작성
   예) tbl_member테이블에  tel 컬럼이 UK_MEMBER_TEL 이란 제약조건명으로
     UNIQUE 제약 조건이 설정된 경우 
     
ALTER TABLE tbl_member
 DROP CONSTRAINTS UK_MEMBER_TEL UNIQUE KEY;


10. FK 제약 조건 설정 시 아래 옵션에 대해 설명하세요
   CONSTRAINT FK_TBLEMP_DEPTNO FOREIGN KEY ( deptno ) 
                                REFERENCES tbl_dept(deptno )
                                
   ㄱ. ON DELETE CASCADE 
     부모가지 삭제시 하위가지 모두 삭제
   ㄴ. ON DELETE SET NULL 
   부모가지 삭제시 하위가지 모두 NULL 처리됨
   
--------------------------------------------------
   
--ㄱ. 책 테이블
CREATE TABLE book(
       b_id     VARCHAR2(10)  NOT NULL PRIMARY KEY --책 id
      ,title      VARCHAR2(100) NOT NULL  --책 제목
      ,c_name  VARCHAR2(100) NOT NULL  --
);
--Table BOOK이(가) 생성되었습니다. 
--ㄴ. 책 단가 테이블
CREATE TABLE danga(
      b_id  VARCHAR2(10)  NOT NULL  -- 책 id
      ,price  NUMBER(7) NOT NULL  -- 책 가격
      ,CONSTRAINT PK_dangga_id PRIMARY KEY(b_id)
      ,CONSTRAINT FK_dangga_id FOREIGN KEY (b_id)
              REFERENCES book(b_id)
              ON DELETE CASCADE
);
--Table DANGA이(가) 생성되었습니다.
-- 책 테이블 먼저 만들어야 그것을 참조하는 책 단가 테이블 만들어짐.
--ㄷ. 고객 테이블
CREATE TABLE gogaek(
      g_id       NUMBER(5) NOT NULL PRIMARY KEY -- 고객 id
      ,g_name   VARCHAR2(20) NOT NULL  --고객명
      ,g_tel      VARCHAR2(20) --고객연락처
);
--Table GOGAEK이(가) 생성되었습니다.

--판매 테이블
CREATE TABLE panmai(
       id         NUMBER(5) NOT NULL PRIMARY KEY --판매번호, 순번 seq
      ,g_id       NUMBER(5) NOT NULL CONSTRAINT FK_PANMAI_GID
                     REFERENCES gogaek(g_id) ON DELETE CASCADE --고객테이블 고객id
      ,b_id       VARCHAR2(10)  NOT NULL CONSTRAINT FK_PANMAI_BID
                     REFERENCES book(b_id) ON DELETE CASCADE --책테이블 책id
      ,p_date     DATE DEFAULT SYSDATE  -- 판매날짜(기본값sysdate)
      ,p_su       NUMBER(5)  NOT NULL -- 판매수량
);
--Table PANMAI이(가) 생성되었습니다.
--저자테이블
CREATE TABLE au_book(
       id   number(5)  NOT NULL PRIMARY KEY --저자아이디
      ,b_id VARCHAR2(10)  NOT NULL  CONSTRAINT FK_AUBOOK_BID --책 테이블 책id
            REFERENCES book(b_id) ON DELETE CASCADE
      ,name VARCHAR2(20)  NOT NULL --저자명
);
--Table AU_BOOK이(가) 생성되었습니다.
INSERT INTO book (b_id, title, c_name) VALUES ('a-1', '데이터베이스', '서울');
INSERT INTO book (b_id, title, c_name) VALUES ('a-2', '데이터베이스', '경기');
INSERT INTO book (b_id, title, c_name) VALUES ('b-1', '운영체제', '부산');
INSERT INTO book (b_id, title, c_name) VALUES ('b-2', '운영체제', '인천');
INSERT INTO book (b_id, title, c_name) VALUES ('c-1', '워드', '경기');
INSERT INTO book (b_id, title, c_name) VALUES ('d-1', '엑셀', '대구');
INSERT INTO book (b_id, title, c_name) VALUES ('e-1', '파워포인트', '부산');
INSERT INTO book (b_id, title, c_name) VALUES ('f-1', '엑세스', '인천');
INSERT INTO book (b_id, title, c_name) VALUES ('f-2', '엑세스', '서울');


INSERT INTO danga (b_id, price) VALUES ('a-1', 300);
INSERT INTO danga (b_id, price) VALUES ('a-2', 500);
INSERT INTO danga (b_id, price) VALUES ('b-1', 450);
INSERT INTO danga (b_id, price) VALUES ('b-2', 440);
INSERT INTO danga (b_id, price) VALUES ('c-1', 320);
INSERT INTO danga (b_id, price) VALUES ('d-1', 321);
INSERT INTO danga (b_id, price) VALUES ('e-1', 250);
INSERT INTO danga (b_id, price) VALUES ('f-1', 510);
INSERT INTO danga (b_id, price) VALUES ('f-2', 400);

--판매(출판사) -> 고객(서점)
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (1, '우리서점', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (2, '도시서점', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (3, '지구서점', '333-3333');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (4, '서울서점', '444-4444');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (5, '수도서점', '555-5555');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (6, '강남서점', '666-6666');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (7, '강북서점', '777-7777');


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


INSERT INTO au_book (id, b_id, name) VALUES (1, 'a-1', '저팔개');
INSERT INTO au_book (id, b_id, name) VALUES (2, 'b-1', '손오공');
INSERT INTO au_book (id, b_id, name) VALUES (3, 'a-1', '사오정');
INSERT INTO au_book (id, b_id, name) VALUES (4, 'b-1', '김유신');
INSERT INTO au_book (id, b_id, name) VALUES (5, 'c-1', '유관순');
INSERT INTO au_book (id, b_id, name) VALUES (6, 'd-1', '김하늘');
INSERT INTO au_book (id, b_id, name) VALUES (7, 'a-1', '심심해');
INSERT INTO au_book (id, b_id, name) VALUES (8, 'd-1', '허첨');
INSERT INTO au_book (id, b_id, name) VALUES (9, 'e-1', '이한나');
INSERT INTO au_book (id, b_id, name) VALUES (10, 'f-1', '정말자');
INSERT INTO au_book (id, b_id, name) VALUES (11, 'f-2', '이영애');

COMMIT;

SELECT * FROM book;
SELECT * FROM danga;
SELECT * FROM gogaek;
SELECT * FROM panmai;
SELECT * FROM au_book;
-----------------------------
[EQUI JOIN]
두 개 이상의 테이블에 관계되는 컬럼들의 값이 일치하는 경우 Natural JOIN 동일
book(PK)        danga
b_1  1    ==   b_1(FK,PK)  price
--문제1) EQUI JOIN
-- 책ID, 책 제목, 출판사 c_name, 책단가 컬럼 조회
-- BOOK 테이블 : b_id, title, c_name
-- DANGA 테이블 : price

ㄱ.
SELECT book.b_id, title, c_name, price
FROM book, danga
WHERE book.b_id = danga.b_id; --비교연산자 = (같다) 사용 -> equi 조인

ㄴ. book b, danga d 별칭 사용
SELECT b.b_id, b.title, b.c_name, d.price
FROM book b, danga d
WHERE b.b_id = d.b_id;

ㄷ. 한쪽 테이블에만 있는 것들은 별칭없이 사용가능.
SELECT b.b_id, title, c_name, price
FROM book b, danga d
WHERE b.b_id = d.b_id;

ㄹ. JOIN - ON 구문 사용
SELECT b.b_id, title, c_name, price
FROM book b JOIN danga d ON b.b_id = d.b_id;

ㅁ. USING 절 사용( 객체명, 별칭 사용 못함)
SELECT b_id, title, c_name, price
FROM book JOIN danga USING( b_id);

ㅂ. NATURAL JOIN 구문 사용 (안중요)
SELECT b_id, title, c_name, price
FROM BOOK NATURAL JOIN danga; --조인 조건이 없어도 됨.

[문제2] 'KING'사원의 부서 확인 후 NULL로 수정

SELECT *
FROM emp
WHERE ename ='KING';

UPDATE emp
SET deptno = null
WHERE empno=7839; --pk 값으로 설정하기

commit;

[문제3 ]dept, emp 조인해서 empno, deptno, dname, ename, hiredate컬럼 조회

부모테이블 dept : deptno(PK), dname
자식테이블 emp : empno(PK), deptno(FK), ename, hiredate

ㄱ. join on 
SELECT empno, e.deptno, dname, ename, hiredate
FROM emp e JOIN dept d ON e.deptno=d.deptno;

ㄴ. using절
SELECT empno, deptno, dname, ename, hiredate
FROM emp JOIN dept USING (deptno);

ㄷ. alias 사용
SELECT empno, e.deptno, dname, ename, hiredate
FROM emp e , dept d 
WHERE e.deptno=d.deptno;

--문제점: king 사원은 출력되지 않는다. 왜? 이퀄조인이기 때문에
SELECT *
FROM dept;
FROM emp;

--EQUI JOIN : join 테이블에 모두 있어야 출력된다.

[문제4]책id,판매수량, 단가, 서점명(고객), 판매금액(판매수량+단가)조회
book : b_id, 
panmai : p_su, g_id,
gogaek : g_name
danga : price * panmai :  p_su

SELECT b.b_id, title,  p_su, price, g_name, (price * p_su) 판매금액
FROM book b, panmai p, danga d , gogaek g
WHERE (b.b_id = p.b_id) AND b.b_id =d.b_id AND p.g_id = g.g_id ;

SELECT b_id, title,  p_su, price, g_name, (price * p_su) 판매금액
FROM book b JOIN panmai p ON b.b_id = p.b_id
            JOIN danga d ON b.b_id =d.b_id
            JOIN gogaek g ON p.g_id = g.g_id;

    [문제5] 출판된 책들이 총 몇권인지?
   책ID, 책제목, 총 판매권수, 단가컬럼 출력
 book - b_id, title
 panmai - p_su
 danga - price
--1단계)
SELECT b.b_id, title,  p_su, price
FROM book b JOIN panmai p ON b.b_id = p.b_id
            JOIN danga d ON b.b_id =d.b_id;

--2)GROUP BY 절 사용 - b_id
 
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

4. 상관서브쿼리

[문제6] 각각의 책이 전체 판매량의 몇퍼센트에 해당?

-- 163권 
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

--[문제] book 테이블에서 판매가 된 적이 없는/있는 책들의 정보를 조회
--b_id, title, price

1. 책 총 몇권? 9권
SELECT COUNT (*) --9
FROM book;

2. 판매된 적 있는 책 (공통적인 것만 출력하겠다 equi join의 조건 알면 됨)

[방법1]
--있는
SELECT b.b_id, title, price
FROM book b JOIN danga d ON b.b_id = d.b_id
WHERE b.b_id IN (SELECT DISTINCT b_id FROM panmai);

--없는
SELECT b.b_id, title, price
FROM book b JOIN danga d ON b.b_id = d.b_id
WHERE b.b_id not IN (SELECT DISTINCT b_id FROM panmai);

[방법2]

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
--a랑b equl join

[방법3]
SELECT b.b_id, title, price
FROM book b JOIN ( SELECT DISTINCT b_id   FROM panmai) p ON b.b_id = p.b_id
            JOIN danga d ON b.b_id =d.b_id;
            
            (+) OUTER JOIN 사용해서 풀면된다.
;
[방법4]
--판매X
SELECT b.b_id, title, price, NVL( P_SU,0)
FROM book b LEFT JOIN panmai p ON b.b_id = p.b_id --LEFT OUTER JOIN
                 JOIN danga d ON b.b_id =d.b_id  --INNER JOIN == EQUI JOIN 
WHERE p_su is null;               
 -------------------
 [문제] 가장 많이 판매가 된 책의 정보
    책id, 제목, 가격, 총 판매량;

[방법1] top-n, rownum
SELECT t.*  --, ROWNUM
FROM (
SELECT b.b_id, title, price, SUM( p_su) qty
FROM  book b JOIN panmai p  ON b.b_id = p.b_id
               JOIN danga d ON p.b_id =d.b_id
GROUP BY b.b_id, title, price
ORDER BY qty desc
 )t
 WHERE ROWNUM=1;
 
[방법2] rank() 함수

SELECT *
FROM (
SELECT b.b_id, title, price, SUM( p_su) qty
     ,RANK() OVER (ORDER BY SUM( p_su) desc) qty_rank
FROM  book b JOIN panmai p  ON b.b_id = p.b_id
               JOIN danga d ON p.b_id =d.b_id 
GROUP BY b.b_id, title, price
--HAVING 절 qty_rank;
)t
WHERE qty_rank=1;

[문제9] 많이 판매된 책 TOP3  WHERE절만 수정하면 됨 WHERE qty_rank <=3
[문제10] 가장 적게 판매된 책 desc만 빼기 -> 판매된 것 중에 가장 적은 것
SELECT t.*  --, ROWNUM
FROM (
SELECT b.b_id, title, price, SUM( p_su) qty
FROM  book b JOIN panmai p  ON b.b_id = p.b_id
               JOIN danga d ON p.b_id =d.b_id
GROUP BY b.b_id, title, price
ORDER BY qty 
 )t
 WHERE ROWNUM=1;
 
 [문제11] 모든 책 중에 가장 적게 팔린 것? - outer join 사용
SELECT t.*  --, ROWNUM
FROM (
 SELECT b.b_id, title, price, SUM( p_su) qty
 FROM  book b RIGHT JOIN panmai p  ON b.b_id = p.b_id
               JOIN danga d ON p.b_id =d.b_id
 GROUP BY b.b_id, title, price
 ORDER BY qty 
 )t
 WHERE ROWNUM=1;
 
 
 [문제12] 총 판매권수가 10권이상인 책의 정보 출력
        책id, 제목, 가격, 총 판매량;
  
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
--관계되는 컬럼이 정확히 일치하지 않는 경우에 사용되는 JOIN의 형태
--WHERE 절에 BETWEEN ... AND ... 연산자를 사용

emp/salgrade JOIN 사원의 급여등급

SELECT empno, sal , grade
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-------------------
+  (기능) 산술연산자 중에 덧셈연산자
    (항 갯수) 이항연산자 

? : (기능) 조건연산자
     (항갯수) 삼항연산자
   
INNER JOIN == EQUI JOIN 결과 동일.
  둘 이상의 테이블에서 JOIN 조건을 만족해는 행만 반환.

     
SELECT empno, ename, dname
FROM emp e JOIN dept d ON e.deptno =d.deptno;
FROM emp e INNER JOIN dept d ON e.deptno =d.deptno;


OUTER JOIN
--JOIN 조건을 만족하지 않는 행을 보기 위한 추가적인 JOIN의 형태
EX. emp deptno=null      emp deptno = 10,20,30,40
      KING
FULL OUTER JOIN은 이전 버전에서 UNION을 이용한 연산과 동일한 결과를 얻는다.

ㄱ. LEFT [OUTER] JOIN 
ㄴ. RIGHT [OUTER] JOIN 
ㄷ. FULL [OUTER] JOIN 

SELECT empno, ename, NVL( dname,'부서없음')
FROM emp e LEFT JOIN dept d ON e.deptno =d.deptno;

SELECT empno, ename, NVL( dname,'부서없음')
FROM dept d RIGHT JOIN emp e ON e.deptno =d.deptno;
FROM dept d JOIN emp e ON e.deptno(+) =d.deptno;

SELECT empno, ename, NVL( dname,'부서없음')
FROM dept d JOIN emp e ON e.deptno =d.deptno(+);
FROM emp e LEFT JOIN dept d ON e.deptno =d.deptno;

SELECT empno, ename, dname
FROM emp e FULL JOIN dept d ON e.deptno =d.deptno;

[문제14] 각 부서별 사원수 조회 OUTER JOIN 사용
SELECT d.deptno, count(e.deptno) --*쓰면 null포함하므로 40번부서1나옴
FROM dept d LEFT JOIN emp e ON  e.deptno = d.deptno
GROUP BY d.deptno
ORDER BY d.deptno ASC;

--null 포함되지 않은 값으로 count하기
SELECT d.deptno, count(ename) 
FROM dept d FULL JOIN emp e ON  e.deptno = d.deptno
GROUP BY d.deptno
ORDER BY d.deptno ASC;
-----------
? CROSS JOIN :
Cartesian Product를 수행한 결과와 같다.
이 cartesian product는 매우 많은 행을 생성하므로 "극히 드물게" 사용된다.
두 테이블에 각각 100개의 행을 가지고 있다면, 10000개의 cartesian product 결과가 생성되기 때문이다.

? ANTIJOIN : 
서브쿼리한 결과 속에 해당 컬럼이 존재하지 않는 경우로 NOT IN을 사용함

? SEMIJOIN :
서브쿼리한 결과 속에 해당 컬럼이 존재하는 경우로 EXISTS을 사용함

------------------------
-- 프로그래머스 SQL - JOIN 문제
--1번
SELECT AO.ANIMAL_ID, AO.NAME
FROM ANIMAL_INS AI RIGHT JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE AI.DATETIME IS NULL;


SELECT AO.ANIMAL_ID, AO.NAME
FROM ANIMAL_INS AI RIGHT JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE AO.ANIMAL_ID NOT IN (SELECT ANIMAL_ID FROM ANIMAL_INS)
ORDER BY AO.ANIMAL_ID;
--2번
SELECT AI.ANIMAL_ID, AI.NAME
FROM ANIMAL_INS AI JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE AI.DATETIME > AO.DATETIME
ORDER BY AI.DATETIME ASC;

--3번
SELECT t.name, t.datetime 
FROM(
    SELECT AI.NAME, AI.DATETIME
       ,ROWNUM
    FROM ANIMAL_INS AI LEFT JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
    WHERE AI.ANIMAL_ID NOT IN(SELECT DISTINCT ANIMAL_ID FROM ANIMAL_OUTS)
    ORDER BY AI.DATETIME
)t
WHERE ROWNUM <=3 ;

--4번
SELECT AI.ANIMAL_ID, AI.ANIMAL_TYPE, AI.NAME
FROM ANIMAL_INS AI RIGHT JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE SEX_UPON_INTAKE != SEX_UPON_OUTCOME