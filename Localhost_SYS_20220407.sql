--SYS ���� ���� --
--�ְ� ������ ����--

    CREATE PUBLIC SYNONYM arirang
  	FOR scott.emp;
-- SYNONYM ARIRANG��(��) �����Ǿ����ϴ�.
�����ġ�

	DROP PUBLIC SYNONYM arirang;
-- SYNONYM ARIRANG��(��) �����Ǿ����ϴ�.



--ORA-00942: table or view does not exist
SELECT * 
FROM emp;

--������ ������ �ִ��� ��Ű��.���̺�� ���� ����� �������� �ʴ´�.
SELECT *    --�̰� ���� �ȳ�.
FROM scott.emp;  -- ����  -> public �ó��(�ٸ� �̸� �����ϰ� ����)

