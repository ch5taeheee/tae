2023-0111-01)INDEX
 - �ڷ��� �˻�ȿ������ �����Ű�� ���� ����
 - WHERE ���� ���Ǵ� ��ɹ��� ����ӵ� ����
 - ����(ORDER BY), �Ǵ� �׷�ȭ(GROUP BY)���� ���Ǵ� �÷��� �ε����� ����ӵ��� ����Ŵ
 - �ε����� ������ ������ ���� �ð��� ����� �ҿ��.
 - ������ �ε����� ����� �����ͺ��̽� ��ü�� ���� ȿ������ ���Ͻ�Ŵ. 
 
 
 - �ε����� ����
  . Unique / Non-Unique -- NULL���� ����. ���� ����1 ���� ��� / �ߺ� ���
  . Single / Composite -- �ϳ��� �÷����� ������ �ε��� / �÷� 2��
  . Normal / Bitmap / Function 
  --  �˻� TREE�� �⺻���� �Ѵ�. /
  
(�ε��� ����)
    CREATE [UNIQUE|BITMAP] INDEX �ε�����
     ON ���̺��(�÷���1[,�÷���2,...]) [ASC|DESC]
     . '���̺��' : ��� ���̺��
     . 'ASC|DESC' : �������� �Ǵ� �������� �ε��� ����
     
(��뿹) ȸ�����̺��� �ֹι�ȣ ���ڸ�(MEM_REGNO2)�� �ε����� �����Ͻÿ�.
    CREATE INDEX IDX_MEM_REGNO
     ON MEMBER(MEM_REGNO2);
     
     SELECT * FROM MEMBER WHERE MEM_REGNO2 = '4447619';
     
     DROP INDEX IDX_MEM_REGNO;
     
      SELECT * FROM MEMBER WHERE SUBSTR(MEM_REGNO2,2,4) = '4476'; --�ε������� �Լ� ����ߴٸ� WHERE������ �Լ� ����ؼ� ã����.
      
    CREATE INDEX IDX_MEM_REGNO1 ON MEMBER(SUBSTR(MEM_REGNO2,2,4)); 
    
**INDEX �����
 - �������̺�� �ε����� �ٸ� ���̺� �����̽��� �̵��� ���
 - �������� ���� �ε����� �籸�� �ؾ��ϴ� ���
 (�������)
    ALTER INDEX �ε����� REBUILD --�ڵ����� �籸����.
      
      