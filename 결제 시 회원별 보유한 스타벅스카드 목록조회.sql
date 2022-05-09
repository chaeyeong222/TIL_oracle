
-- 1. ȸ�� ��� ȣ��
CREATE OR REPLACE PROCEDURE up_customer
IS
    CURSOR vcurcus IS ( SELECT * FROM customer );
    vrowcus customer%ROWTYPE;
BEGIN
    OPEN vcurcus;
    
    LOOP
        FETCH vcurcus INTO vrowcus;
        EXIT WHEN vcurcus%NOTFOUND;
       DBMS_OUTPUT.PUT_LINE(vrowcus.member_id);
    END LOOP;
    
    CLOSE vcurcus;
--EXCEPTION
END;

EXECUTE up_customer;
-----------------------------
--2) ȸ���� ������ ��Ÿ���� ī�� ��� ��ȸ
CREATE OR REPLACE PROCEDURE up_cuscard
(
  pmember_id starbuckscard.member_id%type
)
IS
  vsql varchar2(1000);
  vrow starbuckscard%ROWTYPE;
  vcursor SYS_REFCURSOR; -- 9i  REF CURSOR
BEGIN
   vsql := 'SELECT * ';
   vsql := vsql || 'FROM starbuckscard ';
   vsql := vsql || 'WHERE member_id = :member_id ';
   

   OPEN  vcursor FOR vsql USING pmember_id;
   
   LOOP
      FETCH vcursor INTO vrow;
      EXIT WHEN vcursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE( vrow.member_id || ' | ' || vrow.card_name || ' | ' || vrow.card_balance||'��' );

   END LOOP;
   
   CLOSE vcursor;
END;


EXEC up_cuscard( 'chaeyoung' );
EXEC up_cuscard( 'seoyoung' );
EXEC up_cuscard( 'jimin' );


delete from starbuckscard where card_name = 'testī��';
delete from starbuckscard where pin_no = 87445132;
select * from starbuckscard;
commit;