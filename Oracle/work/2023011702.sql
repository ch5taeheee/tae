2023-0117-02) 패키지(PACKAGE)
  - 업무적으로 관련성 있는 여러 오라클 PL/SQL 객체들을 묶어서 사용하기 위한 도구
  - 대형 프로젝트에 사용
  - 캡슐화 기능 제공
  - 선언부(변수, 상수, 커서, 함수, 프로시져 등을 선언) 와 본문부(선언부에서 선언된 서브프로그램의 구현 담당) 로 구성되며
    별도로 컴파일 되어야 함.
    
1) 선언부
 - 패키지에서 사용될 변수, 상수, 예외, 서브프로그램의 골격(PROTOTYPE) 선언
 
 (사용형식)
    CREATE OR REPLACE PACKAGE 패키지명 IS
        변수, 상수, 커서, 예외 선언;
        
        FUNCTION 함수명[(매개변수 [IN|OUT|INOUT] 타입,...)]
            RETURN 타입명;
                :
        PROCEDURE 프로시져명[(매개변수 [IN|OUT|INOUT] 타입,...)];
                :
    END [패키지명];
    
2) 본문부
 - 선언부에서 정의된 서브프로그램의 BODY 부분을 기술
 (사용형식)
     CREATE OR REPLACE PACKAGE BODY 패키지명 IS
        변수, 상수, 커서, 예외 선언;
        
        FUNCTION 함수명[(매개변수 [IN|OUT|INOUT] 타입,...)]
            RETURN 타입명;
         IS|AS
         
         BEGIN
         
         END[함수명];
                    :
         
        PROCEDURE 프로시져명[(매개변수 [IN|OUT|INOUT] 타입,...)];
         IS|AS
        
         BEGIN
        
         END[프로시져명];
                   :
     END [패키지명];
     
     
** 퇴직자 테이블 생성
  1) 테이블명 : RETIRE
  ------------------------------------------------------------
    컬럼           데이터 타입      N.N      PK&FK      DEFAULT
  ------------------------------------------------------------
  EMPLOYEE_ID      NUMBER(6)               PK&FK     
  RETIRE_DATE      DATE
  
     
     
     
    사용예) 사원번호를 입력받아 사원명을 반환하는 함수, 
            신규사원을 등록하는 프로시져,
            퇴사한 사원을 처리하는 프로시져로 구성되는 패키지를 작성하시오. (RETIRE PLAG를 Y로 바꾸고 정보를 RETIRE로 옮겨라)
            -- 되돌릴 값이 있으면 함수, 반환할 내용이 없으니 프로시져를 사용해라. 
   (선언부)         
    CREATE OR REPLACE PACKAGE hr_pkg IS 
    
        --사원번호를 입력받아 사원명을 반환하는 함수
     FUNCTION fn_get_emp_name(P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE)
        RETURN VARCHAR2;
        
    -- 신규사원을 등록하는 프로시져
        PROCEDURE proc_new_emp(
            P_EMP_NAME IN VARCHAR2,
            P_HDATE IN DATE);
            
    -- 퇴사한 사원을 처리
        PROCEDURE proc_retire_emp(
            P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE,
            P_DATE IN DATE);
        END hr_pkg;
        
        
 (본문부)       
    CREATE OR REPLACE PACKAGE BODY hr_pkg IS 
    
        --사원번호를 입력받아 사원명을 반환하는 함수
     FUNCTION fn_get_emp_name(P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE)
        RETURN VARCHAR2
     IS 
        L_ENAME VARCHAR2(100);
     BEGIN
        SELECT LAST_NAME INTO L_ENAME
            FROM EMPLOYEES
            WHERE EMPLOYEE_ID = P_EID;
            
          RETURN L_ENAME;
     END fn_get_emp_name;
        
    -- 신규사원을 등록하는 프로시져
        PROCEDURE proc_new_emp(
            P_EMP_NAME IN VARCHAR2,
            P_HDATE IN DATE)
        IS
            L_EID EMPLOYEES.EMPLOYEE_ID%TYPE;
        BEGIN
        SELECT MAX(EMPLOYEE_ID) + 1 INTO L_EID
            FROM EMPLOYEES;
            
            INSERT INTO EMPLOYEES( EMPLOYEE_ID,LAST_NAME,HIRE_DATE) --필수입력사항
                VALUES(L_EID, P_EMP_NAME, P_HDATE);
            COMMIT;
        END proc_new_emp;
            
    -- 퇴사한 사원을 처리
        PROCEDURE proc_retire_emp(
            P_EID IN HR.EMPLOYEES.EMPLOYEE_ID%TYPE,
            P_DATE IN DATE)
        IS
        BEGIN
            INSERT INTO RETIRE VALUES (P_EID, P_DATE);
            
            UPDATE EMPLOYEES
                SET RETIRE_FLAG = 'Y'
                WHERE EMPLOYEE_ID = P_EID;
        END proc_retire_emp;
        END hr_pkg;        
        
    (실행)
   SELECT HR_PKG.FN_GET_EMP_NAME(123) FROM DUAL;
   
   EXEC HR_PKG.PROC_NEW_EMP('이순신',SYSDATE);
        
   EXEC HR_PKG.PROC_RETIRE_EMP(184,SYSDATE);
        
        
        
        
        
        
        
        
 
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        
        