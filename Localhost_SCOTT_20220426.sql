--1)ȸ�������Ҷ� id �ߺ�üũ�ϴ� �������ν���
--> emp���̺��� empno(ID)�� �����ؼ� Ǯ��
-- ��¿� �Ķ���� ���� 0 ��밡�� 1 ���Ұ�

CREATE OR REPLACE PROCEDURE up_idCheck
(
  pempno IN emp.empno%TYPE  --id
  , pemonoCheck OUT NUMBER --0 ��밡�� 1 ���Ұ�
)
IS
BEGIN

   SELECT COUNT(*)INTO pemonoCheck --������ 1 �������� �ƴϸ� 0��
   FROM emp
   WHERE empno=pempno;      
--EXCEPTION
END;
--Procedure UP_IDCHECK��(��) �����ϵǾ����ϴ�.

DECLARE
 vempnoCheck NUMBER;
BEGIN
   UP_IDCHECK(7369, vempnoCheck);
   DBMS_OUTPUT.PUT_LINE(vempnoCheck);
END;

--����2. ȸ������ �� �Ŀ� ID(empno)/PW(ename) �Է��ϰ� �α���(����)
--      �α��� ����, ����(ID����X, ��й�ȣ X) ����
/*
CREATE OR REPLACE PROCEDURE up_logon
(
  pempno IN emp.empno%TYPE  --id
  , pename IN emp.ename%TYPE --pw
  , plogonCheck OUT NUMBER --0 �α��μ��� ���� - ( 1-id����x, -1 id����, ���x)
)
IS
  vename emp.ename%TYPE;
BEGIN
   SELECT COUNT(*)INTO plogonCheck --������ 1 �������� �ƴϸ� 0��
   FROM emp
   WHERE empno=pempno;  
   
   IF plogonCheck !=0 THEN  --���̵� ���� (����� üũ�ϸ� ��)
     
      SELECT ename INTO vename
      FROM emp
      WHERE empno = pempno;
       
      IF vename = pename THEN --��й�ȣ���� ��ġ�ϸ� �α��� ����
        plogonCheck := 0;
   ELSE
       plogonCheck := -1; --��й�ȣ ����ġ -1
   END IF;      --if�� �ȸ����� �׳� 1�� üũ�ȴ�
   ELSE
      plogonCheck := 1;
END IF;
--EXCEPTION
END;
*/
create or replace procedure up_idCheck
(
    pempno in emp.empno%type --id
    , pename in emp.ename%type --��й�ȣ ��ſ� ��� 
    , plogonCheck out number --�α��ΰ����ϸ� 0 1(id ����x) -1 (id���������� ��� Ʋ��) 
) 
is 
vename emp.ename%type;
begin
    select count(*) into  plogonCheck --id �������� ������ 0
    from emp 
    where empno=empno;
    --id�� �����ϸ�, ��й�ȣ�� �´��� üũ  
    if plogonCheck = 1 then 
        select ename into vename
        from emp
        where empno=pempno;
         
        --id����, �����ȣ ��ġ 
        if vename=pename then
       plogonCheck := 0; --�α��μ��� 
        else  --id ����, ��й�ȣx 
        plogonCheck:= -1; --�α��� ���� 
        end if;
else 
    plogonCheck := 1;
    end if; 
end;

--Procedure UP_LOGON��(��) �����ϵǾ����ϴ�.
---------------
DECLARE
 VlogonCheck NUMBER;
BEGIN
   UP_LOGON(7369, 'SMITCH', vlogonCheck)
   DBMS_OUTPUT.PUT_LINE(vempnoCheck);
END;
---------------------
--�����Լ�(stored function)
SELECT num, name, ssn, case mod(substr(ssn, -7,1),2)
                          when 1 then '��'
                          else '��'
                      end gender
FROM insa;
--ssn�ֹε�Ϲ�ȣ�� �Ķ���ͷ� �Ѱ��ָ� ����/���ڸ� ��ȯ�ϴ� ���� �Լ�
--�����Լ� (���ϰ�o)=  �������ν���(���ϰ�x) ������ ������: ���ϰ� ����
CREATE OR REPLACE FUNCTION uf_idCheck
(
  
)
RETURN �����ڷ���
IS
BEGIN
     RETURN (���ϰ�);
     RETURN ���ϰ�;
--EXCEPTION
END;

--����) �ֹε�Ϲ�ȣ �Է¹޾Ƽ� ������ȯ�ϴ� �Լ�   uf_gender

CREATE OR REPLACE FUNCTION uf_gender
(
  prrn VARCHAR2
)
RETURN VARCHAR2   --����/����
IS
 vgender VARCHAR2(6) := '����';
BEGIN

    IF MOD(SUBSTR(prrn, -7,1),2)=1 THEN
      vgender :='����';
    END IF;

     RETURN vgender;
--EXCEPTION
END;

--Function UF_GENDER��(��) �����ϵǾ����ϴ�.

SELECT num, name, ssn, scott.uf_gender(ssn) gender
FROM insa;
-----------
--����) uf_sum(10)
-- 1~10������ ���� ��ȯ�ϴ� �Լ� + �׽�Ʈ �ڵ�
CREATE OR REPLACE FUNCTION uf_sum
(
    pnum NUMBER
)
RETURN NUMBER
IS
    vsum NUMBER := 0;
BEGIN
    FOR vnum IN REVERSE 1 .. pnum
    LOOP
        --DBMS_OUTPUT.PUT_LINE( vnum );
        vsum := vsum + vnum;
    END LOOP;
    
    RETURN vsum;
--EXCEPTION
END;


SELECT uf_sum(10)
FROM dual;

-----
--����) �ֹε�Ϲ�ȣ �Է¹޾Ƽ� ������� (yyyy.mm.dd)�� ��ȯ�ϴ� �Լ� uf_birth()
CREATE OR REPLACE FUNCTION uf_birth
(
  prrn NUMBER
)
RETURN VARCHAR2
IS
  vbirth VARCHAR2(10);
  vgender number(1);
  vcentry number(2);
  vrrn6 VARCHAR2(6);
BEGIN
   
   vrrn6 := SUBSTR(prrn, 0,6);
   vgender := SUBSTR(prrn, -7,1);
   vcentry := CASE 
             when vgender in (1,2,5,6) then 19
             when vgender in (3,4,7,8) then 20
             else 18
           END;
   vbirth := TO_CHAR (TO_DATE( CONCAT(vcentry , vrrn6)),'YYYY.MM.DD');
   RETURN vbirth;
--EXCEPTION
END;
--Function UF_BIRTH��(��) �����ϵǾ����ϴ�.

SELECT name, ssn
           , uf_birth(ssn)
FROM insa;


-- ����) �ֹε�Ϲ�ȣ �Է¹޾Ƽ� ������ ��ȯ�ϴ� �Լ� uf_age()

CREATE OR REPLACE FUNCTION uf_age
(
  prrn VARCHAR2
)
RETURN NUMBER 
IS
   vischeck number(1);
   vt_year  number(4);
   vb_year  number(4);
   vage     number(3);
BEGIN
   vischeck :=  SIGN(  TRUNC( SYSDATE ) -  TO_DATE(  SUBSTR( prrn, 3,4), 'MMDD') );
   vt_year  := TO_CHAR( SYSDATE  , 'YYYY');
   vb_year  := CASE  
                 WHEN SUBSTR( prrn, 8, 1 ) IN (1,2,5,6) THEN '1900' + SUBSTR( prrn, 1,2)
                 WHEN SUBSTR( prrn, 8, 1 ) IN (3,4,7,8) THEN '2000' + SUBSTR( prrn, 1,2)
                 ELSE                                       '1800'  + SUBSTR( prrn, 1,2)
             END;
   vage     :=  CASE  VISCHECK
                WHEN -1 THEN  -- ���� ��������
                 vt_year - vb_year-1
                ELSE   -- 0, 1
                 vt_year - vb_year
            END  ;        
   RETURN vage;         
--EXCEPTION
END;
-- Function UF_AGE��(��) �����ϵǾ����ϴ�.
--
SELECT name, ssn, UF_AGE(ssn) age
FROM insa;

---------
--����) �������ν��� mode: in out in out ����¿� �Ķ����(�Ű�����)
-- ��ȭ��ȣ 8765-8956
--         8765 ��ȭ��ȣ ���ڸ��� ���

create or replace procedure up_tel
(
 pphone IN OUT VARCHAR2
)
IS
BEGIN
  pphone := SUBSTR(pphone, 0,4);
END;
--Procedure UP_TEL��(��) �����ϵǾ����ϴ�.

DECLARE
  vphone varchar2(9) := '8765-8956';
BEGIN
  up_tel(vphone);
  
  DBMS_OUTPUT.PUT_LINE(vphone);
END;



