2023-0110-01) SEQUENCE 객체
1. SEQUENCE 
 - 순차적인 번호가 필요한 경우 사용
 - 기본키로 설정할 만한 항목이 없는 경우, 자동으로 연속적인 번호가 필요한 경우 사용
 -- 테이블과 독립적으로 실행. 여러 테이블에서 하나의 시퀀스를 사용가능. B, 주의가 필요함. 
 -- 시퀀스는 기본키를 설정해야 하는데 구할 수 없으면 자동되어 증가되는 값은 중복이 안되니 기본키로 쓰겠다는 말
 -- 시퀀스는 절대 뒤에 있는 값을 사용할 수가 없다. 이미 지나온 것은 쓰지 못 함. 현재값과 미래 값을 사용해야 함.
 --
 (사용형식)
    CREATE SEQUENCE 시퀀스명
        [START WITH n] -- 시퀀스 시작값 설정 생략하면 MINVALUE (: 내가 값을 지정할 때 사용하는 옵션)
        [INCREMENT BY n] -- 자동 증감값
        [MAXVALUE n|NOMAXVALUE] -- 최대값 설정 기본은 NOMAXVALUE이며 10^27까지 사용
        [MAXVALUE n|NOMINVALUE] -- 최소값 설정 기본은 NOMINVALUE이며 1
        [CYCLE|NOCYCLE] -- 최대/최소값 이후 다시 생성할지 여부 기본은 NOCYCLE
        [CACHE n|NOCACHE] -- 캐쉬 사용여부 기본은 CACHE 20 
        [ORDER | NOORDER] -- 정의한 대로 시퀀스 생성 보장여부 기본은 NOORDER
        
 - 시퀀스 의사칼럼(Pseudo Column)
 --------------------------------------------------------------
 의사컬럼               의미
 --------------------------------------------------------------
 시퀀스명.NEXTVAL       '시퀀스'의 다음 값 반환
 시퀀스명.CURRVAL       '시퀀스'의 현재 값 반환
 --------------------------------------------------------------
 시퀀스가 생성되고 처음 수행되어야 하는 의사컬럼은 NEXTVAL이어야 한다.
 
 사용예)LPROD 테이블에 다음 자료를 저장하시오.
 --------------------------------------------------------------
            LPROD_ID        LPROD_GU        LPROD_NM
            ------------------------------------------
              10             P501            농산물
              11             P502            임산물
              12             P601            농산가공식품

 -> LPROD_ID는 시퀀스를 사용하시오.
 CREATE SEQUENCE SEQ_LPROD_ID
    START WITH 10;
    
    INSERT INTO LPROD VALUES (SEQ_LPROD_ID.NEXTVAL,'P501','농산물');
    INSERT INTO LPROD VALUES (SEQ_LPROD_ID.NEXTVAL,'P502','임산물');
    INSERT INTO LPROD VALUES (SEQ_LPROD_ID.NEXTVAL,'P601','농산가공식품'); -- 지나간 것은 못 씀. 새롭게 만들어 써라.
    
    SELECT * FROM LPROD;
    
2. 동의어(SYNONYM)
 - 오라클 객체에 부여하는 별칭(Alias)
 - SELECT 문에서 사용되는 컬럼이나 테이블 별칭과의 차이점은 사용 범위이다. -- 적용범위(넓다)가 다르다. 오라클 내 모든 객체에 사용 가능. / 테이블 이나 컬럼은 해당 SQL안에서만 사용가능.
 - 주로 다른 계정 소유의 객체를 참조할 때 긴 서술부분을 짧게 별칭을 만들어 사용 
 
 (사용형식)
 CREATE [OR REPLACE] SYNONYM 동의어
    FOR 객체명
    . '객체명' 에 새로운 이름을 '동의어'로 부여
    
사용예)HR계정의 EMPLOYEES 테이블과 DEPARTMENTS테이블에 각각 EMP와 DEPT 별칭을 부여하여 사용하라.

CREATE OR REPLACE SYNONYM EMP FOR HR.EMPLOYEES;
CREATE OR REPLACE SYNONYM DEPT FOR HR.DEPARTMENTS;

SELECT * FROM HR.EMPLOYEES;
SELECT * FROM EMP; --테이블로는 존재하지 않으며 별칭으로만 존재. 

SELECT A.LAST_NAME,
       B.DEPARTMENT_NAME,
       A.HIRE_DATE,
       A.JOB_ID
   FROM EMP A, DEPT B
  WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
  ORDER BY B.DEPARTMENT_ID ;   
  
  SELECT 23457 * 2167134265
    FROM SYS.DUAL; --DUAL : 테이블이 필요하지는 않지만 SELECT 절에 필요한 의미없는 테이블, 형식 갖추기 위한 테이블이다. SYS. DUAL ; 내부에서 시놈한거.
    
CREATE OR REPLACE SYNONYM D1 FOR SYS.DUAL;



              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
 
 
 
 