-- ����Ŭ �ּ� ó��
-- ��� ����� ���� ��ȸ(Ȯ��) ��� ����(SQL) �̴�.
SELECT *
FROM all_users;
-- ���� �����ϴ� ���
-- 1) �����ϰ����ϴ� ���� SQL �� ����SELECT�ϰ� F5Ű�� ������.
-- 2) �����ϰ����ϴ� ���� SQL �� ����SELECT�ϰ� Ctrl + ENTER
-- 3) Ŀ�� �ΰ�, Ctrl + ENTER

-- SCOTT ���� ���� SQL��
CREATE USER scott IDENTIFIED BY tiger;

GRANT RESOURCE, CONNECT TO scott;
