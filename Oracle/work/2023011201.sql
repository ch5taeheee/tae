2023-0112-01)분기문
 - if 문과 case when ~then문 제공
1. IF문
 - 개발언어의 IF문과 동일기능 제공
 
 (사용형식 1)
 
  IF 조건 THEN
        명령문1;
  [ELSE
        명령문2;]
  END IF;
    
 (사용형식 2)
 
  IF 조건1 THEN
    명령문1;
  ELSIF 조건2 THEN
    명령문2;
      :
  ELSE
    명령문n;
  END IF; 
    
 (사용형식 3)
 
  IF 조건1 THEN
    IF 조건2 THEN
         명령문2;
      END IF;
      :
   ELSE
    명령문n;
  END IF; 
  
 사용예) 다음 수도 샤용량을 입력 받아 수도요금을 작성하시오. 
 
   수도 사용량      톤당 단가 
 -------------------------------
    01 - 10          120
    11 - 20          170
    21 - 30          250
      이상            360
      
   하수도 사용료
   톤 당 150원
   
   ex) 27톤을 사용한 경우 : 처음 10톤 10 * 120 = 1200 / 20톤까지 10 * 170 = 1700 / 나머지 7톤 7 * 250 = 1750 = 4650
                          하수도 사용료 27 * 150 = 4050 
                          4050 + 4650 = 8700원
   
    ACCEPT P_AMT PROMPT '물 사용량 입력: '
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
     
     DBMS_OUTPUT.PUT_LINE('수도 사용량 : '||L_AMT||'톤'); 
     DBMS_OUTPUT.PUT_LINE('사용요금 : '||TO_CHAR(L_SUM,'999,999')||'원');
     
     END;
     
 2.CASE WHEN 문
  - 표준 SQL문에서 사용하는 CASE WHEN 표현식과 동일하나 끝이 END CASE로 끝나야 함.
  
  (사용형식 1)
    CASE WHEN 조건 1 THEN
              명령 1;
         WHEN 조건 2 THEN
              명령 2;
               :
         ELSE 
              명령n;
    END CASE;

  (사용형식 2)
    CASE WHEN 값 1 THEN
              명령 1;
         WHEN 값 2 THEN
              명령 2;
               :
         ELSE 
              명령n;
    END CASE;
    
사용예) 1 - 100점 사이의 점수를 입력받아 
       90 - 100 : '매우 우수'
       80 - 89 : '우수'
       70 - 79 : '보통'
       60 - 69 : '미흡'
       50 - 59 : '매우 미흡' 을 출력하시오.
       
       
        ACCEPT P_SCORE PROMPT '점수 입력: '
        
        
        DECLARE
             L_INSCORE NUMBER := 88;
             L_GRADE VARCHAR2(50);
             L_SCORE NUMBER := 0;
        BEGIN
        L_SCORE := TRUNC(L_INSCORE/10);
            CASE WHEN L_SCORE = 10  THEN                   --CRUNC(N,-1) / L_SCORE = TRUNC(L_SCORE/10)
                      L_GRADE := '매우 우수';
                 WHEN L_SCORE = 9 THEN
                      L_GRADE := '매우 우수';
                 WHEN L_SCORE = 8  THEN
                      L_GRADE := '우수';
                 WHEN L_SCORE = 7  THEN
                      L_GRADE := '보통';
                 WHEN L_SCORE = 6  THEN
                      L_GRADE := '미흡';     
                 ELSE 
                      L_GRADE := '매우미흡';  
            END CASE;
            
            DBMS_OUTPUT.PUT('점수 '||L_INSCORE);
            DBMS_OUTPUT.PUT_LINE('의 평점은 '||L_GRADE||'입니다.');
        END ;
        
        
        
        DECLARE
             L_INSCORE NUMBER := 88;
             L_GRADE VARCHAR2(50);
             L_SCORE NUMBER;
        BEGIN
        L_SCORE := TRUNC(L_INSCORE/10);
            CASE L_SCORE WHEN 10  THEN                  
                                L_GRADE:= '매우 우수';
                         WHEN 9 THEN
                                L_GRADE:= '매우 우수';
                         WHEN 8  THEN
                                L_GRADE:= '우수';
                         WHEN 7  THEN
                                L_GRADE:= '보통';
                         WHEN 6  THEN
                                L_GRADE:= '미흡';     
                         ELSE 
                                L_GRADE:= '매우미흡';  
                         END CASE;
            
            DBMS_OUTPUT.PUT('점수 '||L_INSCORE);
            DBMS_OUTPUT.PUT_LINE('의 평점은 '||L_GRADE||'입니다');
            
        END ;
                  
   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    
    
    
    
    
    
    
    
    
    