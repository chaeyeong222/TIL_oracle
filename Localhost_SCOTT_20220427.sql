

PL/SQL 
�͸� ���ν���
���� ���ν���
���� �Լ�
 [ Ʈ���� ] 
 
1. Ʈ���� �������ǹ�: ��Ƽ� - �ڵ����� �Ѿ��� ���ư�
2. � �۾� ��(before) �Ǵ� ��(after)�� Ʈ���ſ� ������ ������ �����ϴ� PL/SQL�� ������
3. ���(���̺�)�� �̸� Ʈ���Ÿ� �����ϸ� 
    � �̺�Ʈ(DML)�� �߻��� �� �ڵ����� ������ Ʈ���Ű� �۵�(Ȱ��)�ϵ����� ��ü�� Ʈ���Ŷ�� �Ѵ�
4. ��) 
    �԰����̺�
    �ڵ� �̸� ��¥ ����
    101 LG����� 2022.4.27 10
    
    ������̺� (�ڵ����� �������� �����ϴ� Ʈ����)
    LG����� 120+10=130  update�� ����
    
    
5. Ʈ���� Ű���� (�����)

��. �۾� ���� �ڵ�ó���Ǵ� Ʈ���� : BEFORE
��. �۾� �Ŀ� �ڵ�ó���Ǵ� Ʈ���� : AFTER
��. FOR EACH ROW : �ึ�� ó���Ǵ� Ʈ���� (�� Ʈ����)
��. REFERENCING ���� �޴� ���� �� ����
��. : OLD �����Ǳ� �� ��(�÷�)�� ��
��. : NEW ������ �� ��(�÷�)�� ��



6. Ʈ���� ����

�����ġ� 
	CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ� [BEFORE ? AFTER]
	  trigger_event ON ���̺��
	  [FOR EACH ROW [WHEN TRIGGER ����]]  --Ʈ���Ű� �߻��Ǵ� ����
	DECLARE
	  ����
	BEGIN
	  PL/SQL �ڵ�
    EXCEPTION
      ����ó���κ�
	END;





7. Ʈ���� Ȯ��
SELECT *
FROM user_triggers;
FROM user_sequences
FROM user_constraints;
FROM user_tables;



8. Ʈ���� ����, ����, Ȱ��ȭ/��Ȱ��ȭ


9. Ʈ���� �׽�Ʈ
CREATE TABLE tbl_trigger1(
   id NUMBER PRIMARY KEY
   , name VARCHAR2(20)
);
-- Table TBL_TRIGGER1��(��) �����Ǿ����ϴ�.

CREATE TABLE tbl_trigger2(
  memo VARCHAR2(100) --�α׳���
  , ilja DATE DEFAULT SYSDATE
);
--Table TBL_TRIGGER2��(��) �����Ǿ����ϴ�.





9-2. tbl_trigger1 ���̺� �� ���ڵ�(��)�� insert
     ���(tbl_trigger1 ���̺�)�� DML�� �߻��ϸ� tbl_trigger2 ���̺�
     �ڵ����� �α׸� ����ϴ� Ʈ���� ����



10. Ʈ���� ����

CREATE OR REPLACE TRIGGER ut_exam01 AFTER 
INSERT OR UPDATE OR DELETE ON tbl_trigger1 
--FOR EACH ROW ��Ʈ����
--DECLARE 
BEGIN 
    IF INSERTING THEN
    INSERT INTO tbl_trigger2 (memo) VALUES ('tbl_trigger1 ���̺� �߰���');
    ELSIF UPDATING THEN
    INSERT INTO tbl_trigger2 (memo) VALUES ('tbl_trigger1 ���̺� ������');
    ELSIF DELETING THEN
    INSERT INTO tbl_trigger2 (memo) VALUES ('tbl_trigger1 ���̺� ������');
    END IF;
--EXCEPTION
END;



--���� ���ν����� Ŀ���ؾ�������
--Ʈ���Ŵ� �ڵ����� Ŀ��, �ѹ�ȴ�


SELECT * FROM tbl_trigger1;
SELECT * FROM tbl_trigger2;

INSERT INTO tbl_trigger1 VALUES (1, 'admin');
commit;

--AFTER Ʈ���Ŵ� �������ǿ� �ɸ��� �۵����� �ʴ´�
INSERT INTO tbl_trigger1 VALUES (2, 'hong');
commit;


rollback;

--dml (update)
UPDATE tbl_trigger1
SET name = 'kim'
WHERE id=2;


--dml (DELETE)
DELETE FROM tbl_trigger1
WHERE id=2;



---
����) tbl_trigger1 ���̺� �ٹ��ð�X, �ָ�(��,��)X���� INSERT, UPDATE, DELETE 
�ϸ� ���� �߻�

--���ԵǱ� ���� Ʈ���Ű� �߻��� �Ǿ �ٹ�/�ָ��� üũ �Ŀ� ���� ����
INSERT INTO tbl_trigger1 VALUES (2, 'hong');

--before Ʈ���� ����

CREATE OR REPLACE TRIGGER ut_exam02 BEFORE 
INSERT OR UPDATE OR DELETE ON tbl_trigger1 
--FOR EACH ROW ��Ʈ����
--DECLARE 
BEGIN 
    IF NOT (TO_CHAR (SYSDATE, 'HH24') BETWEEN 12 AND 18) OR TO_CHAR(SYSDATE, 'DY') IN ('��', '��') THEN
        --������ �����߻���Ű�� I,U,D (DML)���� ���
        RAISE_APPLICATION_ERROR(-20000, '������ �ٹ� �ð� �� �Ǵ� �ָ��̱⿡ �۾��� �ȵ˴ϴ�');
   
    END IF;
--EXCEPTION
END;



SELECT SYSDATE
        , TO_CHAR (SYSDATE, 'HH24')
        , TO_CHAR (SYSDATE, 'DAY')
        , TO_CHAR (SYSDATE, 'DY')
FROM DUAL;














-------


create table tbl_trg1
(
    hak varchar2(10) primary key
  , name varchar2(20)
  , kor number(3)
  , eng number(3)
  , mat number(3)
);
-- Table TBL_TRG1��(��) �����Ǿ����ϴ�.
create table tbl_trg2
(
  hak varchar2(10) primary key
  , tot number(3)
  , avg number(5,2)
  , constraint fk_test2_hak foreign key(hak)   references tbl_trg1(hak)
);
-- Table TBL_TRG2��(��) �����Ǿ����ϴ�.

SELECT * FROM tbl_trG1; --�й� �̸� ���� ���� ����
SELECT * FROM tbl_trg2; --�й� ���� ���



-- ��) �� �л��� ��,��,��,��,�� -> tbl_trg1 �� INSERT
--     �ڵ�����
--     tbl_trg2 ���̺� tot,avg INSERT �Ǵ� Ʈ���� ���� -> �׽�Ʈ
INSERT INTO tbl_trg1 ( hak, name, kor, eng, mat ) VALUES ( 1, 'hong', 90,78, 99 );

:new Ű����

--Ʈ����
CREATE OR REPLACE TRIGGER ut_trg1DML AFTER 
INSERT ON tbl_trg1
FOR EACH ROW    --��Ʈ���� :new:old �����ִ�(����)
DECLARE 
    vtot NUMBER(3);
    vavg NUMBER(5,2);
BEGIN
    vtot := :NEW.KOR + :NEW.ENG + :NEW.MAT;
    vavg := vtot/3;
    INSERT INTO tbl_trg2 (hak, tot, avg) VALUES (:NEW.hak, vtot, vavg);
--EXCEPTION
END;

--ORA-04082: NEW or OLD references not allowed in table level triggers
���̺����� Ʈ���ſ��� :new, :old ��� ����

commit;


SELECT * FROM tbl_trG1;
SELECT * FROM tbl_trg2;

-- �й��� 1���� ����� ������ ����(update) -> �ڵ����� TBL_TRG2 ���̺��� ����,��� ����
UPDATE TBL_TRG1
SET kor = 87, eng = 67, mat = 100
WHERE hak = 1;

CREATE OR REPLACE TRIGGER ut_trg1DML AFTER 
INSERT OR UPDATE ON tbl_trg1
FOR EACH ROW    --��Ʈ���� :new:old �����ִ�(����)
DECLARE 
    vtot NUMBER(3);
    vavg NUMBER(5,2);
BEGIN
    vtot := :NEW.KOR + :NEW.ENG + :NEW.MAT;
    vavg := vtot/3;
    
    if inserting then
    INSERT INTO tbl_trg2 (hak, tot, avg) VALUES (:NEW.hak, vtot, vavg);
    elsif updating then
    update tbl_trg2
    set tot=VTOT, avg=VAVG
    WHERE hak = :OLD.hak ; -- == new.hak
    end if;
--EXCEPTION
END;


COMMIT

create table tbl_trg1
(
    hak varchar2(10) primary key
  , name varchar2(20)
  , kor number(3)
  , eng number(3)
  , mat number(3)
);
-- Table TBL_TRG1��(��) �����Ǿ����ϴ�.
create table tbl_trg2
(
  hak varchar2(10) primary key
  , tot number(3)
  , avg number(5,2)
  , constraint fk_test2_hak foreign key(hak)   references tbl_trg1(hak)
);

����) TBL_TRG1 ���̺� �й�1�� �л��� ������ �ϸ� �ڵ����� TBL_TRG2 ���̺��� �й� 1�л��� �����Ǵ� Ʈ���Ÿ�
���� �׽�Ʈ


DELETE FROM TBL_TRG1
WHERE HAK=1;

CREATE OR REPLACE TRIGGER ut_trg1DML AFTER 
INSERT OR UPDATE or delete ON tbl_trg1
FOR EACH ROW    --��Ʈ���� :new:old �����ִ�(����)
DECLARE 
    vtot NUMBER(3);
    vavg NUMBER(5,2);
BEGIN
    vtot := :NEW.KOR + :NEW.ENG + :NEW.MAT;
    vavg := vtot/3;
    
    if inserting then
    INSERT INTO tbl_trg2 (hak, tot, avg) VALUES (:NEW.hak, vtot, vavg);
    
    elsif updating then
    update tbl_trg2
    set tot=VTOT, avg=VAVG
    WHERE hak = :OLD.hak ; -- == new.hak
    
    ELSIF deleting then
    delete tbl_trg2
    WHERE hak = :OLD.hak ;
    end if;
--EXCEPTION
END;



ROLLBACK;



