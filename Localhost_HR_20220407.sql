 -- HR ���� ���� -- 

23. hr �������� ����
    employees ���̺��� first_name, last_name �̸� �ӿ� 'ev' ���ڿ� �����ϴ� ��� ���� ���
    
FIRST_NAME           LAST_NAME         NAME                NAME                                                                                                                                                                                    
-------------------- ------------- ------------- ----------------------
Kevin                Feeney          Kevin Feeney        K[ev]in Feeney                                                                                                                                                                          
Steven               King            Steven King         St[ev]en King                                                                                                                                                                           
Steven               Markle          Steven Markle       St[ev]en Markle                                                                                                                                                                         
Kevin                Mourgos         Kevin Mourgos       K[ev]in Mourgos                                                                                                                                                                         

SELECT T.* ,  REPLACE( t.name, 'ev' , '<span color=red>ev</span>')
FROM (
 SELECT first_name , last_name
           ,first_name || '' ||last_name name
 FROM employees
 ) t
 WHERE  t.name LIKE '%ev%';
 
-- 00942. 00000 -  "table or view does not exist"-- EMP�� SCOTT����
SELECT * 
FROM emp;   

SELECT *    --�̰͵� ������
FROM scott.emp; 

SELECT*
FROM arirang;

--SQL ����: ORA-01031: insufficient privileges
DELETE FROM arirang
WHERE empno = 7369;  

scott ������ ������ emp���̺��� �ִٸ�
emp ���̺��� �����ڴ� scott �̴�.

emp ����Ϸ��� emp���̺� ����� �� �ִ� ������ scott(������)���� �ο��ް�(sys�� ����)
����� ���� ��Ű��.emp ��� ����� �Ѵ�.