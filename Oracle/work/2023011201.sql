2023-0112-01)�б⹮
 - if ���� case when ~then�� ����
1. IF��
 - ���߾���� IF���� ���ϱ�� ����
 
 (������� 1)
 
  IF ���� THEN
        ��ɹ�1;
  [ELSE
        ��ɹ�2;]
  END IF;
    
 (������� 2)
 
  IF ����1 THEN
    ��ɹ�1;
  ELSIF ����2 THEN
    ��ɹ�2;
      :
  ELSE
    ��ɹ�n;
  END IF; 
    
 (������� 3)
 
  IF ����1 THEN
    IF ����2 THEN
         ��ɹ�2;
      END IF;
      :
   ELSE
    ��ɹ�n;
  END IF; 
  
 ��뿹) ���� ���� ���뷮�� �Է� �޾� ��������� �ۼ��Ͻÿ�. 
 
   ���� ��뷮      ��� �ܰ� 
 -------------------------------
    01 - 10          120
    11 - 20          170
    21 - 30          250
      �̻�            360
      
   �ϼ��� ����
   �� �� 150��
   
   ex) 27���� ����� ��� : ó�� 10�� 10 * 120 = 1200 / 20����� 10 * 170 = 1700 / ������ 7�� 7 * 250 = 1750 = 4650
                          �ϼ��� ���� 27 * 150 = 4050 
                          4050 + 4650 = 8700��
   
    ACCEPT P_AMT PROMPT '�� ��뷮 �Է�: '
    DECLARE
        L_AMT NUMBER := TO_NUMBER('&P_AMT');
        L_SUM NUMBER := 0;
    BEGIN
        IF L_AMT <= 10 THEN
           L_SUM := 120 * L_AMT;
        ELSIF L_AMT <=20 THEN
            L_SUM := 1200 + (L_AMT -10) * 170;
        ELSIF L_AMT <=30 THEN
            L_SUM:= 1200 + 1700 + (L_AMT -20) * 250;
        ELSE
            L_SUM := 1200 + 1700 + 2500 + (L_AMT -30) * 360;
        END IF;
            L_SUM:=L_SUM+(L_AMT * 150);
     
     DBMS_OUTPUT.PUT_LINE('���� ��뷮 : '||L_AMT||'��'); 
     DBMS_OUTPUT.PUT_LINE('����� : '||TO_CHAR(L_SUM,'999,999')||'��');
     
     END;
     
 2.CASE WHEN ��
  - ǥ�� SQL������ ����ϴ� CASE WHEN ǥ���İ� �����ϳ� ���� END CASE�� ������ ��.
  
  (������� 1)
    CASE WHEN ���� 1 THEN
              ��� 1;
         WHEN ���� 2 THEN
              ��� 2;
               :
         ELSE 
              ���n;
    END CASE;

  (������� 2)
    CASE WHEN �� 1 THEN
              ��� 1;
         WHEN �� 2 THEN
              ��� 2;
               :
         ELSE 
              ���n;
    END CASE;
    
��뿹) 1 - 100�� ������ ������ �Է¹޾� 
       90 - 100 : '�ſ� ���'
       80 - 89 : '���'
       70 - 79 : '����'
       60 - 69 : '����'
       50 - 59 : '�ſ� ����' �� ����Ͻÿ�.
       
       
        ACCEPT P_SCORE PROMPT '���� �Է�: '
        
        
        DECLARE
             L_INSCORE NUMBER := 88;
             L_GRADE VARCHAR2(50);
             L_SCORE NUMBER := 0;
        BEGIN
        L_SCORE := TRUNC(L_INSCORE/10);
            CASE WHEN L_SCORE = 10  THEN                   --CRUNC(N,-1) / L_SCORE = TRUNC(L_SCORE/10)
                      L_GRADE := '�ſ� ���';
                 WHEN L_SCORE = 9 THEN
                      L_GRADE := '�ſ� ���';
                 WHEN L_SCORE = 8  THEN
                      L_GRADE := '���';
                 WHEN L_SCORE = 7  THEN
                      L_GRADE := '����';
                 WHEN L_SCORE = 6  THEN
                      L_GRADE := '����';     
                 ELSE 
                      L_GRADE := '�ſ����';  
            END CASE;
            
            DBMS_OUTPUT.PUT('���� '||L_INSCORE);
            DBMS_OUTPUT.PUT_LINE('�� ������ '||L_GRADE||'�Դϴ�.');
        END ;
        
        
        
        DECLARE
             L_INSCORE NUMBER := 88;
             L_GRADE VARCHAR2(50);
             L_SCORE NUMBER;
        BEGIN
        L_SCORE := TRUNC(L_INSCORE/10);
            CASE L_SCORE WHEN 10  THEN                  
                                L_GRADE:= '�ſ� ���';
                         WHEN 9 THEN
                                L_GRADE:= '�ſ� ���';
                         WHEN 8  THEN
                                L_GRADE:= '���';
                         WHEN 7  THEN
                                L_GRADE:= '����';
                         WHEN 6  THEN
                                L_GRADE:= '����';     
                         ELSE 
                                L_GRADE:= '�ſ����';  
                         END CASE;
            
            DBMS_OUTPUT.PUT('���� '||L_INSCORE);
            DBMS_OUTPUT.PUT_LINE('�� ������ '||L_GRADE||'�Դϴ�');
            
        END ;
                  
   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    
    
    
    
    
    
    
    
    
    