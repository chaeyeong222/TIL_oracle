--SYS 계정 접속 --
--최고 관리자 계정--

    CREATE PUBLIC SYNONYM arirang
  	FOR scott.emp;
-- SYNONYM ARIRANG이(가) 생성되었습니다.
【형식】

	DROP PUBLIC SYNONYM arirang;
-- SYNONYM ARIRANG이(가) 삭제되었습니다.



--ORA-00942: table or view does not exist
SELECT * 
FROM emp;

--권한을 가지고 있더라도 스키마.테이블명 으로 적어야 오류나지 않는다.
SELECT *    --이건 오류 안남.
FROM scott.emp;  -- 불편  -> public 시노님(다른 이름 간단하게 지정)

