2022-1222-02)
4. 기타 자료형(2진자료형)
  - 2진 자료를 저장하기 위한 자료형
  - BLOB, BFILE, RAW타입이 제공
  - 저장된 2진 자료를 조회할 때 오라클은 해석하거나 변환하여 출력하지 않음. -- 테이블 안에 저장, 속도는 빠르지만 꺼내고 입력하는 게 어렵다 BLOB / 다른 곳에 저장한 경로를 테이블에 저장, 바뀔 가능성 많은 것 - BFILE
  
  1) RAW 타입
  . 작은 규모의 2진자료를 처리하는 자료형
  . 최대 2000BYTE 까지 저장 가능
  . 인덱스처리 가능
  . 16진수와 2진수 저장
  . 주로 미디어자료 저장에 사용 
  
  (사용 형식)
    컬럼명 RAW(크기)
                                                                                             2022-12-23 
  (사용 예) CREATE TABLE TEMP08(
            COL1 RAW(100),
            COL2 RAW(2000));
            
            INSERT INTO TEMP08 VALUES('DC1A','1101110000011010'); 
            INSERT INTO TEMP08 VALUES(HEXTORAW('DC1A'),'DC1A'); 
            
            SELECT * FROM TEMP08; -- 저장되어진 자료형태만 
            
  2) BFILE 타입                  
  . 2진 자료 저장
  . 저장의 대상 자료를 데이터베이스 밖에 저장하고 데이터베이스에는 경로(PATH)와 파일명만 저장
  . 동일 이름의 자료내용이 자주 변경되는 경우 효과적
  . 최대 4GB 까지 처리 가능
  
  (사용형식)
  컬럼명 BFILE 
   . 경로를 갖고있는 디렉토리 명은 30BYTE, 파일명은 256BYTE 내의 데이터로 표현
   
   (사용 예) BFILE 타입으로 그림을 저장
    1) 저장할 그림 준비(JPEG타입)
    2) 디렉토리 객체 생성 
        CREATE DIRECTORY 디렉토리명 AS '경로명';
        
        CREATE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\Oracle\work';
        
     
    3) 테이블 준비
        CREATE TABLE TEMP09(
            COL1 BFILE);
            
            DROP TABLE TEMP09;
    
    4) 그림 삽입
        INSERT INTO TEMP09 VALUES(BFILENAME('TEST_DIR','sample.jpg'));
        
        SELECT * FROM TEMP09;
        
  3) BLOB(Binary Large OBject) 타입
  . 2진 자료 저장
  . 저장의 대상 자료를 데이터베이스 내부에 저장 -- 속도 빠름
  . 자료내용의 변경이 일어나지 않는 경우 효과적
  . 최대 4GB 까지 처리 가능
  
  (사용 예) D:\A_TeachingMaterial\Oracle\work에 저장된 sample.jpg파일을 BLOB 방식으로 저장하시오.
  
  1) 테이블 생성
     CREATE TABLE TEMP10(
        COL1 BLOB);
  2) 익명블록 자성
     DECLARE
        L_DIR VARCHAR(30) := 'TEST_DIR'; -- := 할당연산자
        L_FILE VARCHAR(255) := 'sample.JPG';
        L_BFILE BFILE;
        L_BLOB BLOB;
     BEGIN
       INSERT INTO TEMP10(COL1) VALUES(EMPTY_BLOB())
        RETURN COL1 INTO L_BLOB;
       
       L_BFILE := BFILENAME(L_DIR, L_FILE);
       DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
       DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
       DBMS_LOB.FILECLOSE(L_BFILE);
     END;
        
     SELECT * FROM TEMP10;
        
        
            
            
            
                                                                                                  
            
            
            
            
            
            
            
            
            
            
            
            