2023-0113-01)저장 프로시져(Stored Procedure : Procedure)
 - 서버에 미리 컴파일되어 실행 가능한 형태로 서버에 저장된 모듈 
 - 사용자간 처리루틴 공유
 - 데이터베이스 내부구조에 대한 보안성 제공 -- 뷰와 공통점
 - 서버 보호 자료 무결성 권한 구현
 - 쿼리의 처리속도 향상 
 - 네트워크의 트래픽 감소
 
 -- 리턴값이 있다 함수, 없다 프로시져,
 -- 프로시져는 인서트, 업데이트, 딜리트 같이 되돌려 줄 값 없을 때만 사용
 -- 되돌릴 값 있을 때 함수사용
 
  1. 저장 프로시져(Stored Procedure : Procedure)
 - 프로시져명을 통해 반환 값이 존재하지 않는 모듈
(사용형식) 
    CREATE [OR REPLACE] PROCEDURE 프로시져명[(
        매개변수명 mode 타입명[:=디폴트 값][,]
                    :
        매개변수명 mode 타입명[:=디폴트 값])]
    IS | AS --익명블록의 DECLARE
        선언부
    BEGIN -- 서브쿼리가 아닌 이상 SELECT INTO 써야 함.
        실행부
        
        [EXCEPTION
            예외처리부 ]
    END [프로시져명];
    
    . 'mode' : 매개변수의 역할을 지정 IN(입력용), OUT(출력용), INOUT(입출력 공용) --변수
    . 타입명 : 크기를 기술하면 오류
    . := 디폴트 값 : 사용자가 매개변수를 선언하고 값을 배정하지 않은 경우 전달될 기본 값설정
    
 (프로시져 실행 사용형식)
    EXEC | EXECUTE 프로시져명[(매개변수list)]; --EXEC OR EXECUTE 둘중 하
    OR
    프로시져명[{매개변수list)]; => 익명블록, 다른 프로시져나 함수 등에서 실행하는 경우 --비긴엔드 OUT/ 매개변수를 사용할 때 이 방법 사용.
    
 (사용예) 년도와 월을 입력받아 해당 기간동안 매출수량 집계를 구하고 재고수불 테이블을 UPDATE하는 프로시져를 작성하시오.
       -- 보통 PROC로 시작 , 매개변수는 파라미터라고 해서 P로 시작, 모듈이 생략되거나 안쓰면 IN을 쓴걸로 간주?
         
         CREATE OR REPLACE PROCEDURE PROC_REMAIN_UPDATE(
            P_YEAR IN VARCHAR2,
            P_MONTH IN VARCHAR2) 
            
         IS
            L_PERIOD VARCHAR2(7):=P_YEAR ||P_MONTH || '%' ;
            L_DATE DATE:=LAST_DAY(TO_DATE(P_YEAR||P_MONTH||'01'));
            CURSOR CUR_CART01 IS 
            --해당기간동안 상품별 매출수량 집계
             SELECT CART_PROD,
                    SUM(CART_QTY) AS SAMT
                 FROM CART
                WHERE CART_NO LIKE L_PERIOD
                GROUP BY CART_PROD;
         BEGIN
            --해당기간동안 상품별 매출수량 집계
            FOR REC IN CUR_CART01 LOOP 
                UPDATE REMAIN A
                   SET A.REMAIN_O = A.REMAIN_O +REC.SAMT,
                       A.REMAIN_J_99 = A.REMAIN_J_99 - REC.SAMT,
                       A.REMAIN_DATE = L_DATE
                WHERE A.PROD_ID = REC.CART_PROD;
           END LOOP;
        COMMIT;
        EXCEPTION 
                WHEN OTHERS THEN -- 없는 
                 DBMS_OUTPUT.PUT_LINE('에외발생 : '||SQLERRM);
                 ROLLBACK;
                 
         END PROC_REMAIN_UPDATE; -- END; 로 끝나도 좋지만 저렇게 쓰는게 더 좋다.
            
 (실행)
  EXECUTE PROC_REMAIN_UPDATE('2020','04');
  
  SELECT * FROM REMAIN;
    
 (사용예) 매입테이블에서 2020년 시작날짜와 종료일자를 입력받아 상품별 매입수량 집계를 조사하여 재고수불테이블을 갱신하고 갱신 상품수를 반환하는 프로시져를 작성 하시오. 
 
  CREATE OR REPLACE PROCEDURE PROC_BUYPROD01(
        P_SDATE IN DATE, 
        P_EDATE IN DATE, 
        P_CNT OUT NUMBER )
    IS 
         L_CNT NUMBER := 0; -- 처리건수
         CURSOR CUR_BUYPROD IS
            SELECT BUY_PROD, SUM(BUY_QTY) AS SBMT
               FROM BUYPROD
              WHERE BUY_DATE BETWEEN P_SDATE AND P_EDATE
              GROUP BY BUY_PROD;   
    
    BEGIN
        FOR REC IN CUR_BUYPROD LOOP
            UPDATE REMAIN A
                SET A.REMAIN_I = A.REMAIN_I + REC.SBMT,
                    A.REMAIN_J_99 = A.REMAIN_J_99 + REC.SBMT,
                    A.REMAIN_DATE = LAST_DAY(P_EDATE)
                WHERE A.PROD_ID= REC.BUY_PROD;
                L_CNT := L_CNT +1;
                COMMIT;
        END LOOP;
        P_CNT := L_CNT;
    
    END PROC_BUYPROD01;
 
(실행)
     DECLARE
         RES NUMBER:=0;
     BEGIN
         PROC_BUYPROD01(TO_DATE('20200101'),TO_DATE('20200730'),RES);
         DBMS_OUTPUT.PUT_LINE('처리건수 : ' ||RES);
     END;
    
    SELECT * FROM REMAIN;
    
 사용예) 신입사원정보를 입력받아 HR계정의 EMPLOYEES 테이블에 자료를 삽입하고 입력 사원명을 반환 받는 프로시져를 작성하시오.
        [신입사원자료] 
        ------------------------------------------------
            사원명      직무코드     부서코드      급여
        ------------------------------------------------
            홍길동      MK_MAN        70        11000
            이순신      AC_MGR       100        10000
            강감찬      PU_MAN        50         8500        
            
        - 사원번호는 현재 사원번호의 다음 번호로 할당하고 입사일자는 오늘로 설정 -- 출력할 값 건수 
        
        CREATE OR REPLACE PROCEDURE PROC_EMP_INSERT(
            P_ENAME IN HR.EMPLOYEES.LAST_NAME%TYPE,
            P_JID IN HR.EMPLOYEES.JOB_ID%TYPE,
            P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE,
            P_SALARY NUMBER,
            P_NAME OUT VARCHAR2)
        IS
            L_EID NUMBER:=0;-- 사원번호
        BEGIN
            SELECT MAX(EMPLOYEE_ID) +1 INTO L_EID
                FROM HR.EMPLOYEES;
            INSERT INTO HR.EMPLOYEES(EMPLOYEE_ID,LAST_NAME,HIRE_DATE,JOB_ID,SALARY,DEPARTMENT_ID)
                VALUES(L_EID, P_ENAME, SYSDATE,P_JID, P_SALARY,P_DID);
                COMMIT;
                P_NAME := P_ENAME; -- 아웃 매개변수이기 때문에 밖으로 나간다. 출력이라는 건가?               
        END;
        
        DECLARE 
            L_ENAME VARCHAR2(80);
        BEGIN
           PROC_EMP_INSERT('홍길동','MK_MAN',70,11000,L_ENAME);
           DBMS_OUTPUT.PUT_LINE(L_ENAME);
        END;
            
        SELECT * FROM  EMPLOYEES;
            
    
     
    
    
    
    
    
    
    
    