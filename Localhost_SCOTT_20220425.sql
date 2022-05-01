-- SCOTT ���� ���� --  
-- ***** PL/SQL *****
-- 1. �͸� ���ν���
-- 2. ���� ���ν���( ��ǥ�� )

-- ��) �μ����̺� �μ���ȣ�� �Ķ���ͷ� �޾Ƽ� �μ� ���� : up_delDept
--     ���� ���ν����� ���� : execute �� , �͸����ν��� ����, �� �ٸ� ���� ���ν��� 
 
-- ��) DEPT ���̺� ���ο� �μ��� �߰��ϴ� ���� ���ν��� ����  up_incdept

-- 1) 
SELECT *
FROM dept;
--2-1) ������ Ȯ��
SELECT *
FROM user_sequences;
--2-2) seq_dept ������ ����
DROP SEQUENCE seq_dept;
--2-3) ������ ����  seq_dept
CREATE SEQUENCE seq_dept
INCREMENT BY 10
START WITH 50
MAXVALUE 90
NOCACHE;

-- 3)
INSERT INTO dept ( deptno, dname, loc  ) VALUES ( seq_dept.nextval, '???', '???' )
COMMIT;

-- 3-2) ���� ���ν��� ����
CREATE OR REPLACE PROCEDURE up_insDept
(
    pdname   dept.dname%TYPE := null
    , ploc   dept.loc%TYPE DEFAULT null
)
IS
BEGIN
   INSERT INTO dept ( deptno, dname, loc  ) VALUES ( seq_dept.nextval, pdname, ploc );
   -- COMMIT;  
--EXCEPTION
   -- ROLLBACK;
END;

-- Procedure UP_INSDEPT��(��) �����ϵǾ����ϴ�.

BEGIN
   -- UP_INSDEPT( pdname=>'QC', ploc=>'SEOUL' );
   -- UP_INSDEPT( 'QC', 'SEOUL' );
   -- UP_INSDEPT( ploc=>'SEOUL', pdname=>'QC' );
    UP_INSDEPT( pdname => 'QC' );
END;

--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
ROLLBACK;
SELECT * FROM dept;
COMMIT;

-- ��) DEPT ���̺��� �μ������� �����ϴ� ���� ���ν��� 

EXEC up_updDept( 60, 'QC', 'SEOUL' ); -- �μ���, ������ ����
EXEC up_updDept( 60, pdname => 'XX'  );  -- �μ��� ����
EXEC up_updDept( 60, ploc => 'YY' ); -- ������ ����


CREATE OR REPLACE PROCEDURE up_updDept
(
      pdeptno  IN dept.deptno%TYPE
    , pdname   IN dept.dname%TYPE := null
    , ploc     IN dept.loc%TYPE DEFAULT null
)
IS
  vdname  dept.dname%TYPE;  -- ������ ���� ���ڵ��� �μ���
  vloc    dept.loc%TYPE;   -- ������
BEGIN
   IF  pdname IS NULL OR ploc IS NULL  THEN
      SELECT dname, loc INTO vdname, vloc
      FROM dept
      WHERE deptno = pdeptno;
   END IF;

   UPDATE dept
   SET    dname = CASE 
                        WHEN pdname IS NULL THEN  vdname
                        ELSE pdname
                  END
          ,  loc = NVL( ploc, vloc  )
   WHERE deptno = pdeptno;
    
   -- COMMIT;  
--EXCEPTION
   -- ROLLBACK;
END;
-- Procedure UP_UPDDEPT��(��) �����ϵǾ����ϴ�.


-- ��) ��� �μ� ������ ��ȸ�ϴ� ���� ���ν���
-- ( ����� Ŀ���� ����� ���� )
CREATE OR REPLACE PROCEDURE up_selDept
IS
   CURSOR vcurdept IS (  SELECT * FROM dept );
   vrowdept dept%ROWTYPE;
BEGIN
   OPEN vcurdept;
   
   LOOP
     FETCH vcurdept INTO vrowdept;
     EXIT WHEN vcurdept%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE( vrowdept.deptno || ' / ' ||
                             vrowdept.dname || ' / ' ||  vrowdept.loc);
   END LOOP;
   
   CLOSE vcurdept;
--EXCEPTION
END;

-- ( �Ͻ��� Ŀ���� ����� ���� )
CREATE OR REPLACE PROCEDURE up_selDept
IS  
BEGIN
    FOR vrowdept  IN (  SELECT * FROM dept )
    LOOP
       DBMS_OUTPUT.PUT_LINE( vrowdept.deptno || ' / ' ||
                             vrowdept.dname || ' / ' ||  vrowdept.loc);
    END LOOP;  
--EXCEPTION
END;

-- Procedure UP_SELDEPT��(��) �����ϵǾ����ϴ�.
EXECUTE up_selDept;


-- 9:59 ���� ����~
-- ��) ���� ���ν����� �Ķ������ MODE ( IN/ [OUT] ��¿� /INOUT )�� ���ؼ� ���캸��.
--    insa���̺��� �����ȣ�� �Է¿��Ķ���ͷ� �Է��� �ϸ�
--    �� ����� �ֹι�ȣ ���ڸ� 6�ڸ��� ��¿��Ķ���� ����ϴ� ���� ���ν���.

CREATE OR REPLACE PROCEDURE up_rrn6Insa
(
    pnum IN insa.num%TYPE
    , prrn6 OUT VARCHAR2  -- ũ�� X
)
IS
  vssn insa.ssn%TYPE;
BEGIN
  SELECT ssn INTO vssn
  FROM insa
  WHERE num = pnum;
  
  prrn6 := SUBSTR( vssn, 0, 6 );
  
--EXCEPTION
END;

-- Procedure UP_RRN6INSA��(��) �����ϵǾ����ϴ�.

-- [ó������]  ��¿� �Ķ���͸� ���� ���� ���ν����� �׽�Ʈ 
DECLARE
  vssn6 VARCHAR2(6);
BEGIN
   UP_RRN6INSA( 1001,  vssn6 );
   DBMS_OUTPUT.PUT_LINE( 'vssn6 : ' || vssn6 );
END;

-------------------------------------------------------------------------------------
SELECT *
FROM tbl_score;


���� 1)tbl_score ���̺� ���ο� �л��� ���� ������ �����ϴ� ���ν��� : up_insScore
    p :   num, kor, eng, mat   �Է����� ������ 0 ó��
    ����, ���, ��� ������ ó���� �ǵ��� .. 

CREATE OR REPLACE PROCEDURE up_insScore
(
    pnum tbl_score.num%TYPE
    , pname tbl_score.name%TYPE 
    , pkor tbl_score.kor%TYPE  DEFAULT 0
    , peng tbl_score.eng%TYPE  DEFAULT 0 
    , pmat tbl_score.mat%TYPE  DEFAULT 0
)
IS 
  vtot tbl_score.tot%TYPE;
  vavg tbl_score.avg%TYPE;
  vgrade tbl_score.grade%TYPE;
BEGIN
   
   vtot := pkor + peng + pmat;
   vavg :=  TRUNC( vtot / 3 , 2 );
   vgrade := CASE
               WHEN vavg >= 90 THEN 'A'
               WHEN vavg >= 80 THEN 'B'
               WHEN vavg >= 70 THEN 'C'
               WHEN vavg >= 60 THEN 'D'
               ELSE 'F'
             END;

  INSERT INTO tbl_score (num, name, kor, eng, mat, tot, avg, grade ) 
  VALUES ( pnum, pname, pkor, peng, pmat, vtot, vavg, vgrade ) ;
  
  -- ���� ���ν��� �ȿ��� �� �ٸ� �������ν����� ȣ��...
  up_rankScore;
  
--EXCEPTION
END;

EXEC up_insScore(1100, '���̺�', 89,45,77);

SELECT * 
FROM tbl_score;
COMMIT;
ROLLBACK;
   
���� 2) tbl_score ���̺� ���ο� �л��� ���� ������ �����ϴ� ���ν��� : up_updScore     
   p  : num,   kor, eng, mat  �Է����� ������  ���� ���� ������ ó��
     ����, ���, ��� ������ ó���� �ǵ��� .. 


CREATE OR REPLACE PROCEDURE up_updScore
(
    pnum tbl_score.num%TYPE 
    , pkor tbl_score.kor%TYPE := NULL  
    , peng tbl_score.eng%TYPE := NULL   
    , pmat tbl_score.mat%TYPE := NULL
)
IS 
  vkor tbl_score.kor%TYPE   ;
  veng tbl_score.eng%TYPE   ;
  vmat tbl_score.mat%TYPE   ;
  
  vtot tbl_score.tot%TYPE;
  vavg tbl_score.avg%TYPE;
  vgrade tbl_score.grade%TYPE;
BEGIN
   SELECT kor, eng, mat INTO vkor, veng, vmat
   FrOM tbl_score
   WHERE num = pnum;

     IF pkor IS NOT NULL THEN  vkor := pkor; END IF;
     veng := NVL(peng, veng); 
     vmat := NVL(pmat, vmat); 
   
   vtot := vkor + veng + vmat;
   vavg :=  TRUNC( vtot / 3 , 2 );
   vgrade := CASE
               WHEN vavg >= 90 THEN 'A'
               WHEN vavg >= 80 THEN 'B'
               WHEN vavg >= 70 THEN 'C'
               WHEN vavg >= 60 THEN 'D'
               ELSE 'F'
             END;

  UPDATE tbl_score  
  SET   
      kor=vkor, eng =  veng, mat = vmat
      , tot = vtot
      , avg = vavg
      , grade = vgrade
  WHERE num = pnum;
  
  up_rankScore;
--EXCEPTION
END;

EXEC up_updScore ( 1100, 95,67,88);

SELECT * FROM tbl_score;
COMMIT;

���� 3)      tbl_score ���̺�  �����ϴ� ���ν��� : up_delScore
  p  : num  

CREATE OR REPLACE PROCEDURE up_delScore 
(
   pnum tbl_Score.num%TYPE
)
IS  
BEGIN    
  DELETE FROM  tbl_score
  WHERE num = pnum;
  
  up_rankScore;
  
--EXCEPTION
END;  

EXEC up_delScore(1100);

SELECT * FRom tbl_score;
COMMIT;
  
���� 4)   tbl_score ���̺�  ��� �л� ������ ��ȸ�ϴ� ���ν��� : up_selScore

CREATE OR REPLACE PROCEDURE up_selScore
IS
   CURSOR vcurScroe IS (  SELECT * FROM tbl_score );
   vrowscore tbl_score%ROWTYPE;
BEGIN
   OPEN vcurScroe;
   
   LOOP
     FETCH vcurScroe INTO vrowscore;
     EXIT WHEN vcurScroe%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE( vrowscore.num || ' / ' ||
                             vrowscore.name || ' / ' ||  vrowscore.tot|| ' / ' ||
                             vrowscore.avg || ' / ' ||  vrowscore.grade|| ' / ' ||
                             vrowscore.rank
                             );
   END LOOP;
   
   CLOSE vcurScroe;
--EXCEPTION
END;

EXEC up_selscore;

���� 5) ����� ó���ϴ� ���ν���  : up_rankScore

CREATE OR REPLACE PROCEDURE up_rankScore 
IS 
  vrank tbl_score.rank%TYPE;
BEGIN
    
  UPDATE tbl_score t  
  SET   rank = ( SELECT COUNT(*)+1 FROM tbl_score WHERE tot > t.tot  ) ;
  
--EXCEPTION
END;

EXEC  up_rankScore;

UPDATE tbl_score
SET rank = 1;
COMMIT;
SELECT * FROM tbl_score;



