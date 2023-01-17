2022-1222-01) 숫자데이터 타입
 - 정수 및 실수 NUMBER로 수행자료저장
 - NUMBER로 수행
 (사용형식)
  컬럼명 NUMBER[(*|정밀도[,스케일])]
  . '*|정밀도' : 정밀도는 전체 공간의 크기를 나타내며 (1-38) 사이의 값을 사용하며, '*' 기술하면 시스템이 사용자가 정의한 값을 저장할 가장 적합한 크기를 설정해줌.
  . 표현범위 : 1.0E-130 ~ 9.9999..99E125
  . '스케일': 소숫점 이하의 자리수 의미 
  . 스케일을 생략하면 0으로 간주됨.
  . NUMBER(5,2)는 전체 5자리가 확보되고 주어진 수의 소숫점 이하 3번째 자리에서 반올림하여 소수 2번째 자리까지 저장되며, 정수부분은 3자리까지 허용. --
  . '스케일'이 음수이면 정수부분의 해당 위치에서 반올림 됨. 
  . '(*|정밀도[,스케일])'이 생략되면 사용자가 정의한 수를 그대로 저장
  
적용예) 
---------------------------------------------------------
        입력값          선언              저장된 값
---------------------------------------------------------
    12345.6789        NUMBER            12345.6789 
    12345.6789        NUMBER(6,2)       오류.68
    12345.6789        NUMBER(7,2)       12345.68
    12345.6789        NUMBER(7)         12346
    12345.6789        NUMBER(8,1)       12345.7
    12345.6789        NUMBER(*,3)       12345.679 -- *=8
    12365.6789        NUMBER(6,-2)      12400 --음수인 경우 해당위치에서 반올림 6에서 반올림
    
 CREATE TABLE TEMP05(
    COL1         NUMBER,   
    COL2         NUMBER(6,2),       
    COL3         NUMBER(7,2),      
    COL4         NUMBER(7),         
    COL5         NUMBER(8,1),      
    COL6         NUMBER(*,3),       
    COL7         NUMBER(6,-2));      
    
 INSERT INTO TEMP05 VALUES(12345.6789,12345.6789,12345.6789,12345.6789,12345.6789,12345.6789,12365.6789); -- 2번에서 오류
 INSERT INTO TEMP05 VALUES(12345.6789,2345.6789,12345.6789,12345.6789,12345.6789,12345.6789,12365.6789);
 
 SELECT *FROM TEMP05;
 
3.날짜 데이터 타입
 - 날짜(년,월,일)와 시각(시,분,초) 정보를 저장하기 위한 자료타입
 - DATE와 TIMESTAMP 타입 제공
 
 1) DATE 타입
 . 기본 날짜형(년,월,일,시,분,초) 자료 저장
 . '+'과 '-' 연산이 가능하다.
(사용형식)
 컬럼명 DATE
    
 ** SYSDATE : 시스템에서 제공하는 날짜 및 시각 정보
 사용 예) CREATE TABLE TEMP06(
            COL1 DATE,
            COL2 DATE,
            COL3 DATE);
            
         INSERT INTO TEMP06 VALUES(SYSDATE, SYSDATE-10, SYSDATE+10);
         INSERT INTO TEMP06 VALUES('20221010', '2022-10-10',TO_DATE(20221010));
         INSERT INTO TEMP06(COL1) VALUES(TO_DATE('20221010 13:20:35', 'YYYYMMDD HH24:MI:SS'));
         
         SELECT *FROM TEMP06;
         
         SELECT TO_CHAR(COL1,'YYYY-MM-DD HH24:MI:SS') AS "COL1",
                TO_CHAR(COL2,'YYYY-MM-DD HH24:MI:SS') AS "COL2",
                TO_CHAR(COL3,'YYYY-MM-DD HH24:MI:SS') AS "COL3" FROM TEMP06;

  2) TIMESTAMP 타입
  . 시간대역 정보와 정교한 시각정보(10억분의 1초)를 저장하는 자료형
  . TIMESTAMP -- 시간대역 정보 없이 정교한 시각정보
    TIMESTAMP WITH TIME ZONE -- 서버가 위치한 지역의 시간대역 정보 대륙/도시
    TIMESTAMP WITH LOCAL TIME ZONE -- 로컬서버의 시간대역정보(TIMESTAMP와 동일)를 정의하므로 별도의 시간대역 정보없이 저장
    
  
    CREATE TABLE TEMP07(
        COL1 TIMESTAMP,
        COL2 TIMESTAMP WITH TIME ZONE,
        COL3 TIMESTAMP WITH LOCAL TIME ZONE );
        
    INSERT INTO TEMP07 VALUES(SYSDATE, SYSDATE, SYSDATE);
    SELECT * FROM TEMP07;
    
  
  DROP TABLE TEMP07;
  
  
  
  
  
  
  
  