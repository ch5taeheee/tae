2023-0112-02) 반복문
1) 커서(CURSOR) -- SELECT INTO FROM SELECT다음에 변수가 나옴 사용되어지는 변수는 한순간에 하나씩의 데이터만 저장, 
                -- 컬럼들은 여러개의 자료를 가질 수 있다. SELECT문에 나오는 여러 자료를 커서로 만들어 놓고 FETCT 로 한행씩읽어
 - 커서는 광의로 오라클 DML 명령으로 영향 받는 행들의 집합이고, 협의로는 SELECT문의 결과 집합임
 - 커서는 결과 집합 내의 자료를 개발자가 조작하기 위해 제공 --결과집합 안으로 들어가는 방법을 제공하는 것이 커서다.

 
 - 익명커서
   . 이름이 없는 커서로 일반적인 SELECT에 의한 뷰를 의미함.
   . 익명커서는 생성과 동시에 CLOSE 되어 개발자가 개입할 수가 없음 -- 명시적커서(4단계 (19)): 권한 부여, --묵시적커서
   . 익명커서 속성
   ----------------------------------------------------------------------
     커서속성            의미 ---(익명커서는 항상 SQL, 커서는 커서명%)
     --------------------------------------------------------------------
     SQL%ISOPEN        커서가 OPEN 상태이면 TRUE 닫힌 상태이면 FALSE
                       익명커서는 항상 FALSE
     SQL%NOTFOUND      커서 내부에 FETCH 할 자료가 있으면 FALSE, 없으면 TRUE -- 실행되어지려면 FETCH가 실행되어야 함.
     SQL%FOUND         커서 내부에 FETCH 할 자료가 있으면 TRUE, 없으면 FALSE -- 실행되어지려면 FETCH가 실행되어야 함.
     SQL%ROWCOUNT      커서 내부의 행의 수
     --------------------------------------------------------------------
    
  - 커서의 실행 순서
  . 커서 생성(선언부) => OPEN => FETCH => CLOSE -- 열어서(OPEN) 행단위로 읽어옴(FETCH) 
  
  (1) 커서 생성
  . 선언부에서 선언
  
    (선언형식)
     CURSOR 커서명[(변수명 타입 [,변수명 타입,...])] IS -- 타입명에 절대 크기를 써서는 안 된다. 참조형 타입 사용 가능, 변수는 OPEN문에서 값을 배정, 
       SELECT 문;
       
  (2) OPEN문
  . 커서를 사용하기 전 반드시 OPEN 해야함
  . 실행영역에서 수행
  .
  
    (사용 형식)
    OPEN 커서명 [(매개변수,...)];
     . '매개변수' : 커서선언문에 전달할 값
     
 (사용예) 키보드로 부서번호를 입력받아 해당부서에 속한 사원의 사원번호, 사원명, 입사일, 급여를 출력하는 커서를 작성하시오.
        
        ACCEPT P_DID PROMPT '부서번호(10-110) : ' -- OPEN CURSOR 사원들골라내 결과집합 가지고 있다. 이게 바로 커서다. ㅋ
        DECLARE --L_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE:='&P_DID' 
                L_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; -- 이런게 참조형변수
                L_ENAME VARCHAR2(45);
                L_HDATE DATE;
                L_SALARY HR.EMPLOYEES.SALARY%TYPE;
                
                CURSOR CUR_EMP02(HR.DEPARTMENTS.DEPARTMENT_ID%TYPE L_DID
                    IS SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY     --BEGIN 블록에서 SELECT INTO FROM 절 사용(메인쿼리에서만 서브쿼리X) , CURSOR은 사용X
                            FROM HR.EMPLOYEES
                                WHERE DEPARTMENT_ID = L_DID;
        BEGIN 
            OPEN CUR_EMP02('&P_DID')
        END;
        
  (3) FETCH문     
  . 커서결과 집합에서 행단위로 데이터를 읽어오는 명령
  
  (사용형식) 
   FETCH 커서명 INTO 변수명 [,변수명,...];
   
  - 커서문의 SELECT 절의 컬럼의 갯수와 FETCH 문 INTO 절의 변수의 갯수는 일치해야 한다. 
  - 결과 집합에서 맨 첫번째 행부터 차례대로 행단위로 데이터를 가져와 INTO 다음의 변수에 할당
  - 보통 FETCT 문은 반복문 내부에 존재해야 함.

  (4) CLOSE문
  . 사용이 끝난 커서는 반드시 닫아야 재 OPEN 될 수 있음.
  
  (사용형식)
  CLOSE 커서명;
  

2) 반복문
 - 오라클 PL/SQL에 사용되는 반복문은 LOOP, WHILE, FOR문이 제공되고 있음. --루프는 무한루프 존재
 - 반복문은 대부분 커서를 사용할 목적으로 이용됨.
 
 (1) LOOP문 
  . 무한루프를 지원하는 반복문의 기본 구조를 지원
  (사용형식)
   LOOP 
     반복명령문(들); 
     [EXIT WHEN 조건;]--커서%NOTFOUND
     [반복명령문(들);]
    END LOOP;
    
    . 'EXIT WHEN 조건' : 조건이 성립하면 반복을 벗어남
    
    
        ACCEPT P_DID PROMPT '부서번호(10-110) : ' -- OPEN CURSOR 사원들골라내 결과집합 가지고 있다. 이게 바로 커서다. ㅋ
        DECLARE --L_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE:='&P_DID' 
                L_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; -- 이런게 참조형변수
                L_ENAME VARCHAR2(45);
                L_HDATE DATE;
                L_SALARY HR.EMPLOYEES.SALARY%TYPE;
                --
                L_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME%TYPE;
                
                CURSOR CUR_EMP02(L_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) 
                    IS 
                    SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY     --BEGIN 블록에서 SELECT INTO FROM 절 사용(메인쿼리에서만 서브쿼리X) , CURSOR은 사용X
                            FROM HR.EMPLOYEES
                                WHERE DEPARTMENT_ID = L_DID;
        BEGIN 
            OPEN CUR_EMP02('&P_DID'); --부서번호 출력
            --
            SELECT DEPARTMENT_NAME INTO L_DNAME FROM HR.DEPARTMENTS WHERE DEPARTMENT_ID = '&P_DID';
            DBMS_OUTPUT.PUT_LINE('부서번호 : &P_DID' || '부서명 : '||L_DNAME);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            LOOP -- 나머지
                FETCH CUR_EMP02 INTO L_EID,L_ENAME,L_HDATE,L_SALARY;
                EXIT WHEN CUR_EMP02%NOTFOUND; -- 더 이상 읽을 자료가 존재하지 않으면 참 -> LOOP 끝
        
            DBMS_OUTPUT.PUT_LINE('사원번호 : '||L_EID);
            DBMS_OUTPUT.PUT_LINE('사원명 : '||L_ENAME);
            DBMS_OUTPUT.PUT_LINE('입사일 : '||L_HDATE);
            DBMS_OUTPUT.PUT_LINE('급여 : '||L_SALARY);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            
             END LOOP;
            DBMS_OUTPUT.PUT_LINE('전체 인원 : '|| CUR_EMP02%ROWCOUNT);
            CLOSE CUR_EMP02;
        END;
        
 (2)WHILE 문
  . 조건을 부여하여 조건의 평가 결과에 따라 반복 수행여부를 결정하는 반복문
  (사용형식)
  WHILE 조건 LOOP
    반복처리문(들);
  END LOOP;
   . '조건'이 참(true)이면 반복 수행
   
 사용예) 구구단의 7단을 출력하시오. 
 
     DECLARE
        L_CNT NUMBER:=1;
     BEGIN
        WHILE L_CNT <= 9 LOOP 
         DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT || ' = ' || 7 * L_CNT);
         L_CNT := L_CNT +1;
        END LOOP;
     END;
     
     
        ACCEPT P_DID PROMPT '부서번호(10-110) : ' -- OPEN CURSOR 사원들골라내 결과집합 가지고 있다. 이게 바로 커서다. ㅋ
        DECLARE --L_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE:='&P_DID' 
                L_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; -- 이런게 참조형변수
                L_ENAME VARCHAR2(45);
                L_HDATE DATE;
                L_SALARY HR.EMPLOYEES.SALARY%TYPE;
                --
                L_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME%TYPE;
                
                CURSOR CUR_EMP02(L_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) 
                    IS 
                    SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY     --BEGIN 블록에서 SELECT INTO FROM 절 사용(메인쿼리에서만 서브쿼리X) , CURSOR은 사용X
                            FROM HR.EMPLOYEES
                                WHERE DEPARTMENT_ID = L_DID;
        BEGIN 
            OPEN CUR_EMP02('&P_DID'); --부서번호 출력
            --
            SELECT DEPARTMENT_NAME INTO L_DNAME FROM HR.DEPARTMENTS WHERE DEPARTMENT_ID = '&P_DID';
            DBMS_OUTPUT.PUT_LINE('부서번호 : &P_DID' || '부서명 : '||L_DNAME);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            FETCH CUR_EMP02 INTO L_EID,L_ENAME,L_HDATE,L_SALARY;
 --(WHILE 사용)
            WHILE (CUR_EMP02%FOUND) LOOP 
           
            DBMS_OUTPUT.PUT_LINE('사원번호 : '||L_EID);
            DBMS_OUTPUT.PUT_LINE('사원명 : '||L_ENAME);
            DBMS_OUTPUT.PUT_LINE('입사일 : '||L_HDATE);
            DBMS_OUTPUT.PUT_LINE('급여 : '||L_SALARY);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            
            FETCH CUR_EMP02 INTO L_EID,L_ENAME,L_HDATE,L_SALARY;
            
             END LOOP;
            DBMS_OUTPUT.PUT_LINE('전체 인원 : '|| CUR_EMP02%ROWCOUNT);
            CLOSE CUR_EMP02;
        END;
 
  (3)FOR 문
   . 반복횟수를 정확히 알고 있거나 반복횟수가 중요한 경우 사용하는 반복문
 (일반 FOR문)
   (사용형식)
    FOR 인덱스 IN [REVERSE] 초기값...최종값 LOOP
        반복처리명령문(들);
    END LOOP;
    
     . '인덱스'에 초기값을 배정한 후 최종값이 될 때 1씩 증가 또는 감소([REVERSE]) 시키면서 반복처리명령문(들)을 수행함.
     . '인덱스'는 시스템에서 자동으로 설정해주는 변수이다.
     
(사용예) 구구단의 7단을 출력
    DECLARE 
    BEGIN
      FOR I IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE('7 * '||I||' = '||7*I);
      END LOOP;
    END;
    
    --------------------------------------------------------------------------------------------------------
    DECLARE 
    BEGIN
      FOR I IN REVERSE 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE('7 * '||I||' = '||7*I);
      END LOOP;
    END;
    
 (커서용 FOR문)
   (사용형식)
    FOR 레코드명 IN 커서명|IN-LINE 커서문 LOOP
        반복처리명령문(들);
    END LOOP;
    
    . 커서를 FOR문에 사용하면 OPEN, FETCH, CLOSE가 불필요함.
    . 커서 선언문 대신 IN 다음 IN_LINE 서브쿼리로 기술가능
    . 커서의 컬럼의 참조는 '레코드명.커서SELECT문의 컬럼명' 형식으로 수행
    
    
        ACCEPT P_DID PROMPT '부서번호(10-110) : ' 
        DECLARE 
                L_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME%TYPE;
                CURSOR CUR_EMP02
                    IS 
                     SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY    
                            FROM HR.EMPLOYEES
                            WHERE DEPARTMENT_ID = '&P_DID';
        BEGIN -- 커서 FOR문은 OPEN문 필요 X
            SELECT DEPARTMENT_NAME INTO L_DNAME FROM HR.DEPARTMENTS WHERE DEPARTMENT_ID = '&P_DID';
            DBMS_OUTPUT.PUT_LINE('부서번호 : &P_DID' || '부서명 : '||L_DNAME);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            --커서 FOR문
           FOR REC IN CUR_EMP02 LOOP 
           
            DBMS_OUTPUT.PUT_LINE('사원번호 : '||REC.EMPLOYEE_ID);
            DBMS_OUTPUT.PUT_LINE('사원명 : '||REC.LAST_NAME);
            DBMS_OUTPUT.PUT_LINE('입사일 : '||REC.HIRE_DATE);
            DBMS_OUTPUT.PUT_LINE('급여 : '||REC.SALARY);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            
             END LOOP;
            
        END;    
    ------------------------------------------------------------------------------------------------- 커서를 안 써서 할 수도 있음.
       ACCEPT P_DID PROMPT '부서번호(10-110) : ' 
        DECLARE 
                L_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME%TYPE;
                
        BEGIN -- 커서 FOR문은 OPEN문 필요 X
            SELECT DEPARTMENT_NAME INTO L_DNAME 
                FROM HR.DEPARTMENTS 
              WHERE DEPARTMENT_ID = '&P_DID';
              
            DBMS_OUTPUT.PUT_LINE('부서번호 : &P_DID' || '부서명 : '||L_DNAME);
            
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
--커서 FOR문
           FOR REC IN (SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY     --IN 다음에 커서명 대신에 SELECT문 /  OPEN, FETCH, CLOSE 생략
                            FROM HR.EMPLOYEES
                            WHERE DEPARTMENT_ID = '&P_DID') LOOP 
           
            DBMS_OUTPUT.PUT_LINE('사원번호 : '||REC.EMPLOYEE_ID);
            DBMS_OUTPUT.PUT_LINE('사원명 : '||REC.LAST_NAME);
            DBMS_OUTPUT.PUT_LINE('입사일 : '||REC.HIRE_DATE);
            DBMS_OUTPUT.PUT_LINE('급여 : '||REC.SALARY);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');
            
             END LOOP;
            
        END;   
     
    
   
   
   
   
   
   
   

   
   
   
   
   
   
   
   
   
   
   
   
 
        

    
        
     

    
    
  
  
  
  
  
  
  
                                
                                
        
        
   
 
        
