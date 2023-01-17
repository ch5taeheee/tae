2022-1221-01) 데이터 타입

 - 오라클에서 사용하는 자료형은 크게 문자열, 숫자, 날짜, 기타(이진) 자료타입으로 구분
 
1. 문자열 자료형 -- string
 - 오라클은 문자열 자료를 ' ' 안에 기술하고 ' ' 에 기술된 문자는 대소문자를 구별함.
 - 오라클은 문자 자료형이 없음 --char
 - 문자열형은 고정길이(CHAR)와 가변길이(VARCHAR,VARCHAR2,LONG,CLOB,NVARCHAR2,NCLOB 등) 자료형이 제공됨.
 
 1) CHAR(n [BYTE|CHAR]) -- 생략가능 생략하면 byte. 글자 CHAR
  . 고정길이 자료를 저장
  . 최대 2000BYTE 까지 처리 가능
  . 한글 1글자는 3BYTE로 처리됨 
  . 'n [BYTE|CHAR]' : n이 문자 수인지 바이트 값인지 구별. 생략하면 BYTE로 간주.
  . 한글은 최대 666글자만 저장 가능.
 
 사용 예) CREATE TABLE TEMP01(
            COL1 CHAR(20 BYTE),
            COL2 CHAR(20 CHAR),
            COL3 CHAR(20));
            
        INSERT INTO TEMP01(COL1,COL2,COL3) VALUES('APPLE PERSIMMON', '대전시 중구', 'oracle SQL과 PL/SQL'); -- 자료 저장, 공백도 1글자, "대전시 중구" 16바이트 + 14바이트
    
        SELECT * FROM TEMP01; -- 검사 명령) SELECT * FROM * WHERE 출력할 열을 담당. * = ALL, FROM 절은 TABLE, VIEW. WHERE 조건 : 출력할 행, WHERE 생략 = ALL
    
        SELECT LENGTHB(COL1) AS 컬럼1, LENGTHB(COL2) AS 컬럼2, LENGTHB(COL3) AS 컬럼3 FROM TEMP01; --길이를 BYTE로 출력하시오.
    
 2) VARCHAR2(n [BYTE|CHAR])
  . 가변길이 데이터를 저장.
  . 최대 4000BYTE를 처리함.
  . VARCHAR와 동일 기능이며, NVARCHAR2는 UTF-8방식으로 저장함. 
  . VARCHAR2는 오라클에서만 제공되는 데이터 타입.
  
 사용 예) CREATE TABLE TEMP02(
            COL1 VARCHAR2(4000),
            COL2 VARCHAR2(4000 BYTE),
            COL3 VARCHAR2(4000 CHAR)); --빈 공간X
            
         INSERT INTO TEMP02 VALUES('무궁화 꽃이 피었습니다','무궁화 꽃이','IL POSTINO');
         
         SELECT * FROM TEMP02;
         
         SELECT LENGTHB(COL1) AS 컬럼1, LENGTHB(COL2) AS 컬럼2, LENGTHB(COL3) AS 컬럼3 FROM TEMP02; --AS : 별칭 (이 쿼리 안에서만) 제목으로 사용됨. 
         SELECT LENGTHB(COL1), LENGTHB(COL2) AS 컬럼2, LENGTHB(COL3) AS 컬럼3 FROM TEMP02; --별칭의 목적 : 참조되어질 수 있게! 
         SELECT LENGTHB(COL1) 컬럼1, LENGTHB(COL2) AS 컬럼2, LENGTHB(COL3) AS 컬럼3 FROM TEMP02; -- AS 생략 가능.
         
 3) LONG
 . 초기 대용량 문자 자료 저장에 사용
 . 최대 2GB까지 처리 가능
 . 한 테이블에 하나의 컬럼에서만 LONG 타입으로 설정할 수 있음.
 . 현재 기능개선 서비스가 종료됨 => CLOB로 개선된 타입이 제공.
 . 일부 함수는 LONG타입에 사용할 수 없음 : 기억공간이 크기 때문
 . SELECT문의 SELECT절, UPDATE문의 SET절, INSERT문의 VALUES절에서만 사용 가능
 
  사용 예) 
            CREATE TABLE TEMP03(COL1 VARCHAR2(4000),COL2 LONG, COL3 LONG); --오류 LONG 2개
            CREATE TABLE TEMP03(COL1 VARCHAR2(4000),COL2 LONG); -- LONG 가변길이!!
            
            INSERT INTO TEMP03 VALUES('무궁화 꽃이 피었습니다','무궁화 꽃이');
            SELECT * FROM TEMP03;
            SELECT LENGTHB(COL1), LENGTHB(COL2)컬럼2 FROM TEMP03; --LONG이 너무 크기 때문에 LENGTHB, LENGTH 사용 X
 22.12.22           
 4) CLOB(Character Large OBject)
    . 가변 문자열 데이터 저장
    . 최대 4GB까지 저장 가능
    . 하나의 테이블에 여러 개의 CLOB타입 컬럼이 존재할 수 있음.
    . 일부 기능은 DBMS_LOB API(Application Programming Interface)의 지원을 받아야 함.
    
 사용 예) CREATE TABLE TEMP04 (
            COL1 CLOB,
            COL2 LONG, --하나의 테이블에 1개
            COL3 CLOB,
            COL4 VARCHAR2(4000));
            
         INSERT INTO TEMP04(COL1,COL2,COL4) VALUES('무궁화 꽃이 피었습니다-김진명','태백산맥','누가 그 많은 싱아를...-박완서');
            
         SELECT * FROM TEMP04;
         
         Substr(문자열,시작,갯수) 
         
         SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL4)FROM TEMP04; --오류 ? LENGHTB 지원 X(CLOB, LONG)
         SELECT SUBSTR(COL1,7,4),SUBSTR(COL2,7,4),DBMS_LOB.SUBSTR(COL1,7,4),DBMS_LOB.GETLENGTH(COL1,7,4) FROM TEMP04; --오류? 컬럼2 LONG 타입은 SUBSTR X CLOB SUBSTR O
         SELECT SUBSTR(COL1,7,4),DBMS_LOB.SUBSTR(COL1,7,4),DBMS_LOB.GETLENGTH(COL1,7,4) FROM TEMP04;
         -- DBMS_LOB 대용량 자료 조작하기 위해 사용되어지는 함수들의 모임 / SUBSTR(A,7,4) 4번째 글자에서 7글자! 
         SELECT SUBSTR(COL1,7,4),LENGTHB(COL1),DBMS_LOB.SUBSTR(COL1,7,4),DBMS_LOB.GETLENGTH(COL1,7,4) FROM TEMP04; --LENGTHB 사용 X
         SELECT SUBSTR(COL1,7,4),LENGTH(COL1),DBMS_LOB.SUBSTR(COL1,7,4),DBMS_LOB.GETLENGTH(COL1,7,4) FROM TEMP04; -- LENGTHB 사용 O 글자 수
    
    
    
    
    
    
    
    

            
 