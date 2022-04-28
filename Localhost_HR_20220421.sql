1. book, panmai, danga, gogaek �����Ͽ� ������ ��� �Ѵ�.
  -- å�̸�(title) ����(g_name) �⵵(p_date) ����(p_su) �ܰ�(price) �ݾ�(p_su*price)
  -- ��, �⵵ �������� ���
 
 SELECT title, g_name,p_date, p_su, price , p_su*price
 FROM book b JOIN panmai p ON b.b_id = p.b_id
             JOIN danga d ON b.b_id = d.b_id
             JOIN gogaek g ON p.g_id = g.g_id
ORDER BY p_date DESC;

TITLE            G_NAME               P_DATE         P_SU      PRICE         �ݾ�
---------------- -------------------- -------- ---------- ---------- ----------
�ü��         ��������             21/11/03          5        450       2250
����             ���Ｍ��             21/11/03         31        321       9951
�����ͺ��̽�     ���ϼ���             21/11/03         26        300       7800
�����ͺ��̽�     ��������             21/11/03         17        300       5100
������           ��������             21/11/03         21        510      10710
�ü��         �츮����             21/11/03         13        450       5850
�����ͺ��̽�     �츮����             00/10/10         10        300       3000
�����ͺ��̽�     ���ϼ���             00/10/10         15        500       7500
����             ���Ｍ��             00/07/07          5        320       1600
�����ͺ��̽�     ���ü���             00/03/04         20        300       6000

2. book ���̺�, panmai ���̺�, gogaek ���̺��� b_id �ʵ�� g_id �ʵ带 �������� �����Ͽ� 
������ �ʵ� ��� �Ѵ�. 
��, book ���̺��� ��� ���� ��� �ǵ��� �Ѵ�.(OUTER ����)
  ( �ǸŰ� �ȵ� å ������ ��� )

 SELECT b.b_id, b.title, g.g_id, g_name , p_su
 FROM book b LEFT JOIN panmai p ON b.b_id = p.b_id 
             LEFT JOIN gogaek g ON p.g_id = g.g_id
ORDER BY p_date ASC;
 
  
åID       ����                     G_ID G_NAME                     �Ǹż���
---------- ------------------- ---------- -------------------- ----------
b-1        �ü��                     1 �츮����                     13
a-1        �����ͺ��̽�                 1 �츮����                     10
a-1        �����ͺ��̽�                 2 ���ü���                     20
d-1        ����                         4 ���Ｍ��                     31
c-1        ����                         4 ���Ｍ��                      5
b-1        �ü��                     6 ��������                      5
a-1        �����ͺ��̽�                 6 ��������                     17
f-1        ������                       6 ��������                     21
a-2        �����ͺ��̽�                 7 ���ϼ���                     15
a-1        �����ͺ��̽�                 7 ���ϼ���                     26
e-1        �Ŀ�����Ʈ                                                     
f-2        ������                                                        
b-2        �ü��       


3. �⵵, ���� �Ǹ� ��Ȳ ���ϱ�

�⵵   ��        �Ǹűݾ�( p_su * price )
---- -- ----------
2000 03       6000
2000 07       1600
2000 10      10500
2021 11      41661

--1.
SELECT p.b_id, p_su, price, p_date
FROM danga d JOIN panmai p ON p.b_id = d.b_id  ;

--2.

 SELECT TO_CHAR( p_date, 'YYYY') , sum(p_su * price) �Ǹűݾ�
 FROM danga d JOIN panmai p ON p.b_id = d.b_id 
 GROUP BY TO_CHAR( p_date, 'YYYY');
 
 --������..
  SELECT TO_CHAR( p_date, 'YYYY') , TO_CHAR( p_date, 'MM') 
         ,SUM(p_su * price) �Ǹűݾ�
 FROM book b JOIN panmai p ON b.b_id = p.b_id
 GROUP BY TO_CHAR( p_date, 'YYYY'), TO_CHAR( p_date, 'MM') 
 ORDER BY TO_CHAR( p_date, 'YYYY'), TO_CHAR( p_date, 'MM');

4. ������ �⵵�� �Ǹ���Ȳ ���ϱ� 

panmai - p_date, p_su
gogaek - g_id, g_name
danga - price

 SELECT TO_CHAR( p_date, 'YYYY'),g.g_id, g_name, SUM(P_SU*PRICE) �Ǹűݾ�
 FROM panmai p JOIN danga d ON p.b_id = d.b_id
             JOIN gogaek g ON p.g_id = g.g_id
 GROUP BY TO_CHAR( p_date, 'YYYY'), g_name,g.g_id
 ORDER BY TO_CHAR( p_date, 'YYYY'), g_name;


�⵵         ����ID ������                �Ǹűݾ�
---- ---------- -------------------- ----------
2000          7 ���ϼ���                   7500
2000          2 ���ü���                   6000
2000          4 ���Ｍ��                   1600
2000          1 �츮����                   3000
2021          6 ��������                  18060
2021          7 ���ϼ���                   7800
2021          4 ���Ｍ��                   9951
2021          1 �츮����                   5850


8�� ���� ���õǾ����ϴ�. 
 

5. ���� ���� �ǸŰ� ���� å(������ ��������) 

åID       ����       �Ǽ�
---------- ----------------
a-1        �����ͺ��̽�  43
 
-- TOP-N ���, RANK() �Լ�
book   b_id, title
panmai p_su  �ѱǼ�
--1
SELECT b.b_id, title, p_su
FROM book b JOIN panmai p ON b.b_id = p.b_id
ORDER BY b.b_id;
--2
SELECT b.b_id, title, SUM(p_su) �ѱǼ�
FROM book b JOIN panmai p ON b.b_id = p.b_id
GROUP BY b.b_id, title
ORDER BY b.b_id;
--3-1. RANK()  --�ٽ�
SELECT t.* ,RANK() OVER (ORDER BY p_su DESC) seq
FROM ( SELECT b.b_id, title, SUM(p_su) �ѱǼ�
       
FROM book b JOIN panmai p ON b.b_id = p.b_id
GROUP BY b.b_id, title
ORDER BY b.b_id)t
WheRE seq=1;



--3-2.TOP-N���
SELECT t.* --, ROWNUM
FROM (
SELECT b.b_id, title, SUM(p_su) �ѱǼ�
FROM book b JOIN panmai p ON b.b_id = p.b_id
WHERE TO_CHAR( sysdate, 'YYYY') = TO_CHAR( p_date, 'YYYY')
GROUP BY b.b_id, title
ORDER BY b.b_id
)t
WHERE ROWNUM=1;

 
6. ������ �Ǹ���Ȳ ���ϱ�

�����ڵ�  ������  �Ǹűݾ���  ����(�Ҽ��� ��°�ݿø�)  
---------- -------------------------- ----------------
7	    ���ϼ���	15300		26%
4	    ���Ｍ��	11551		19%
2	    ���ü���	6000		10%
6	    ��������	18060		30%
1	    �츮����	8850		15%

gogaek
panmai
danga

SELECT g.g_id, g_name, SUM(p_su*price) ���������Ǹž�
      ,(SELECT SUM(p_su*price) FROM panmai p JOIN danga d ON p.b_id = d.b_id )��ü�Ǹž�
      , ROUND( SUM(p_su*price)/(SELECT SUM(p_su*price) FROM panmai p JOIN danga d ON p.b_id = d.b_id )*100)||'%' ����
FROM gogaek g JOIN panmai p ON g.g_id = p.g_id
               JOIN danga d ON p.b_id = d.b_id
GROUP BY g.g_id, g_name;
----------------------------------------------------------------
