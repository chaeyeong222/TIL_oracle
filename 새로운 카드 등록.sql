ī���� �� �ɹ�ȣ, ī���ȣ �ߺ�üũ

 CREATE OR REPLACE PROCEDURE regisnewcard
 (
  pcard_no IN starbuckscard.card_no%type
   ,ppin_no IN starbuckscard.pin_no%type
   --, pcard_name   starbuckscard.card_name%TYPE 
   --, pmember_id starbuckscard.member_id%type
 )
 IS
  vcardnoCheck NUMBER;
  vcardpinnoCheck NUMBER;
 BEGIN
            SELECT COUNT(*) INTO vcardnoCheck
            FROM starbuckscard
            WHERE card_no = pcard_no;
        
             SELECT COUNT(*) INTO vcardpinnoCheck
             FROM starbuckscard
             WHERE pin_no = ppin_no;  
    
        if vcardnoCheck =1 then     dbms_output.put_line('�̹� ��� �� ī���ȣ �Դϴ�');
        else --ī���ȣ �ߺ� �ƴ� ��
          if (length(pcard_no) !=16) then --ī���ȣ �߸��Է�
            dbms_output.put_line('�߸��� ī���ȣ ����Դϴ�');
          else  -- ī���ȣ ����� �Է���, �ɹ�ȣ üũ
             if(vcardpinnoCheck =1) then 
                 dbms_output.put_line('�̹� ��� �� �ɹ�ȣ�Դϴ�');
             else  --���ο� �ɹ�ȣ (���üũ)
               if (length(ppin_no) !=8 ) then
                dbms_output.put_line('�߸��� �ɹ�ȣ ����Դϴ�');
               else 
                dbms_output.put_line('ī�� ��� �Ϸ�');
                INSERT INTO starbuckscard ( card_no , pin_no ) VALUES ( pcard_no, ppin_no );
              --  INSERT INTO starbuckscard ( card_no, card_name, pin_no, member_id  ) VALUES ( pcard_no, pcard_name, ppin_no,  pmember_id );
          end if;
          end if;
          end if;
          end if;      
 END;
 
 
 exec regisnewcard ( 1244, 87445124 ); --ī���ȣ ��� �߸���
 exec regisnewcard ( 1245774588746610, 87445124 ); --�̹� ��ϵ� ī���ȣ
 exec regisnewcard ( 1154478488746610, 32767 ); -- �߸��� �ɹ�ȣ ���
 exec regisnewcard ( 1154478488746610, 32998767 );--�̹� ��� �� �ɹ�ȣ
 exec regisnewcard ( 1154478488746610, 87445132 );
 --exec regisnewcard ( 1154478488746610, 'testī��', 87445132, 'chaeyoung' ); --ī�� ��� �Ϸ�