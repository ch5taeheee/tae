2022-1220-01) ����� ����
- �����(����Ŭ ��ü)�� ������ CREATE ����� ���, 
- ��ü�� ������ DROP ��� ���

(�������)
CREATE USER ������ IDENTIFIED BY ��ȣ;
 .'������'�� '��ȣ'�� ����� ���� �ܾ� ���
 . ��ȣ�� ��ҹ��� ����

- ���Ѻο�
 . ����Ŭ ����ڰ� ������ �� �ִ� ���� ���� ����
 . GRANT ����� ����Ͽ� ������ ����.
 . �ο��� ������ ȸ���� ������ REVOKE��� ���

(�������)
 GRANT ���Ѹ�[,���Ѹ�,...] TO ������;
    - ����� ���� �� �ο��ϴ� ������ ������ ���� CONNECT, RESOURCE, DBA ���� ����.
    

GRANT CONNECT, RESOURCE, DBA TO CTH98;
 
CREATE USER CTH98 IDENTIFIED BY java;
 
 - HR ���� Ȱ��ȭ
 . ALTER ��� ���
 ALTER USER HR ACCOUNT UNLOCK IDENTIFIED BY java;

DROP USER ������;