2023-0102-02) ROLLUP�� CUBE
 - GROUP BY ���� ����Ͽ� �پ��� �������� ��ȯ
1. ROLLUP
 - GROUP BY ���� ����Ͽ� ������ ���踦 ��ȯ
 (�������)
  GROUP BY ROLLUP(�÷���1, �÷��� 2,...�÷���n)
  . ���� �������� : '�÷���1, �÷��� 2,...�÷���n'�� �������� ���� ��ȯ
    �� ���� ���� ROLLUP(�÷���1, �÷��� 2,...�÷���n)�� �����ʺ��� �÷����� �ϳ��� ������ �������� 
    ���踦 ��ȯ�Ͽ� ���� ���������� ��� �÷����� ������ ����(��ü����)�� ��ȯ�Ѵ�.
    ��, ���� �÷��� n���� �� n+1���� ������ ������ ��ȯ
    
 (��뿹) �������̺��� 2020�� ����, ȸ����, ��ǰ�� ���踦 ���Ͻÿ�. (GROUP BY �� ���)
 --GROUP BY ���� �Ѱ� ����� ���踸 ����.
    SELECT SUBSTR(CART_NO,5,2) AS ��, 
           CART_MEMBER AS ȸ����ȣ, 
           CART_PROD AS ��ǰ��ȣ, 
           SUM(CART_QTY) AS �����������
        FROM CART
        WHERE SUBSTR(CART_NO,1,4) = '2020'
        GROUP BY SUBSTR(CART_NO,5,2), CART_MEMBER,CART_PROD
        ORDER BY 1;
        
 --(ROLLUP ���) 
     SELECT SUBSTR(CART_NO,5,2) AS ��, 
           CART_MEMBER AS ȸ����ȣ, 
           CART_PROD AS ��ǰ��ȣ, 
           SUM(CART_QTY) AS �����������
        FROM CART
        WHERE SUBSTR(CART_NO,1,4) = '2020'
        GROUP BY ROLLUP(SUBSTR(CART_NO,5,2), CART_MEMBER,CART_PROD)
        ORDER BY 1;
        
2. CUBE
  - GROUP BY ������ ����ϸ� ����� ��� �÷��� ���� ������ ������ŭ�� ���������� ��ȯ
 (�������)
  GROUP BY CUBE(�÷���1, �÷���2, ... �÷���n)
   . '�÷���1, �÷���2,...�÷���n' ���� ���� ������ ������ 2^n ��ŭ�� ������
   
 (��뿹) �������̺��� 2020�� ����, ȸ����, ��ǰ�� ���踦 ���Ͻÿ�. 
 (GROUP BY �� ���)
 
    SELECT SUBSTR(CART_NO,5,2) AS ��, 
           CART_MEMBER AS ȸ����ȣ, 
           CART_PROD AS ��ǰ��ȣ, 
           SUM(CART_QTY) AS �����������
        FROM CART
        WHERE SUBSTR(CART_NO,1,4) = '2020'
        GROUP BY SUBSTR(CART_NO,5,2), CART_MEMBER,CART_PROD
        ORDER BY 1;
        
 (CUBE�� ���)
    SELECT SUBSTR(CART_NO,5,2) AS ��, 
           CART_MEMBER AS ȸ����ȣ, 
           CART_PROD AS ��ǰ��ȣ, 
           SUM(CART_QTY) AS �����������
        FROM CART
        WHERE SUBSTR(CART_NO,1,4) = '2020'
        GROUP BY CUBE(SUBSTR(CART_NO,5,2), CART_MEMBER,CART_PROD)
        ORDER BY 1;
 

    

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 