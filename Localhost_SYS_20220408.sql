--SYS ���� ���� --
--�ְ� ������ ����--

GRANT SELECT ON dept TO HR;

SELECT * 
FROM all_tables;

SELECT * 
FROM all_synonyms
WHERE synonym_name LIKE '%arirang%';

CREATE PUBLIC SYNONYM arirang FOR scott.dept;

SELECT *
FROM arirang;


-- �ó�� ����
DROP PUBLIC SYNONYM arirang;
-- ���� ����

