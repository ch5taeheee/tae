2023-0111-02)PL/SQL(Procedure Language SQL) -- 구조적 언어 
 - 표준 SQL의 기능에 분기명령, 반복명령, 변수 등이 없기때문에 기능이 제한되어 있음.
 - 표준 SQL의 기능을 확장하여 모듈을 구성하고 해당 모듈을 컴파일하여 실행 가능한 객체를 생성하여 서버에 보관
 - 모듈화, 캡슐화 지원
 - 익명 블록(Anoymous Block), 사용자 정의 함수(User Defined Function), 저장 프로시져(Stored Procedure), 트리거(Trigger), 패키지(Package)등이 지원됨.
 -- 객체 지향 언어는 상속, 다형성, 캡슐화 필요
 1. 익명 블록(Anoymous Block)
    . 단순 스크립트에서 실행되며 서버에 저장되지 않음.
    . PL/SQL의 기본 구조
    
(사용형식)
    DECLARE
        선언부 - 변수/상수/커서 선언
    BEGIN
        비지니스 로직처리
        
     [EXCEPTION 처리부
     ]
     END; -- 반드시 ; 필요
     
     -- SELECT 컬럼list into 변수명 FROM 테이블명 (메인쿼리에서만)
     -- 변수 : 데이터 저장할 수 있는 기억장소 이름. / 상수: 변하지 않는 값 / 커서 : SELECT 의 결과 집합 (= 뷰, 커서)
     -- 변수는 하나의 값만 저장할 수 있는데 여러 개 저장하게 도와주는 것을 커서
     
사용예) 마일리지가 많은 3명의 회원의 2020년 5월 매출액 집계를 조회
       Alias는 회원번호, 회원명, 매출액 합계이다. 이를 익명블록으로 작성하시오.
       
 1) 마일리지가 많은 3명의 회원의 회원번호 검색
    SELECT A.MEM_ID
      FROM (SELECT MEM_ID
              FROM MEMBER
                ORDER BY MEM_MILEAGE DESC)A 
      WHERE ROWNUM<=3; --커서가 되어야 함. 
      
 2) 익명블록 작성
    DECLARE
      L_MID MEMBER.MEM_ID%TYPE; --회원번호
      L_MNAME MEMBER.MEM_NAME%TYPE; --회원명
      L_AMT NUMBER :=0;--매출액 합계 (:=대입연산자 ) , 0 넣지 않으면 NULL들어가서 오류 발생
      CURSOR CUR_CART01 IS
            SELECT A.MEM_ID,A.MEM_NAME 
                FROM (SELECT MEM_ID, MEM_NAME
                        FROM MEMBER
                         ORDER BY MEM_MILEAGE DESC)A 
                WHERE ROWNUM<=3; -- FETCH는 커서에 있는 것을 읽어 오는 것
    BEGIN
      OPEN CUR_CART01;
      DBMS_OUTPUT.PUT_LINE('회원번호    회원명    구매금액합계');
      DBMS_OUTPUT.PUT_LINE('------------------------------------'); 
      LOOP 
         FETCH CUR_CART01 INTO L_MID, L_MNAME; --FETCH 한 줄 읽어와서 INTO에 넣어줌.
         EXIT WHEN CUR_CART01%NOTFOUND; -- 자바의 BREAK;
           SELECT SUM(A.CART_QTY * B.PROD_PRICE) INTO L_AMT
             FROM CART A, PROD B 
           WHERE B.PROD_ID = A.CART_PROD
             AND A.CART_NO LIKE '202005%'
             AND A.CART_MEMBER = L_MID;
         
        DBMS_OUTPUT.PUT('  '||L_MID); -- PUT_LINE  줄 바꿔서 PUT 줄 바꾸지 않고 하지만 출력은 안됨. PUT_LINE만났을 때 출력
        DBMS_OUTPUT.PUT('    '||L_MNAME);
        DBMS_OUTPUT.PUT('    '||TO_CHAR(L_AMT,'999,999,990'));
        DBMS_OUTPUT.PUT_LINE('   ');
        DBMS_OUTPUT.PUT_LINE('------------------------------------'); -- DBMS출력창 
      END LOOP;
      CLOSE CUR_CART01;
    END;
 
 
 1.변수 및 상수 선언 -- 반드시 선언하고 사용해야 함. 
  - 실행영역에서 사용할 변수 선언
  - 변수의 종류는 SCLAR변수, REFERENCE 변수, BIND 변수, COMPOSITE 변수로 구분
(사용형식)
    변수명[상수명] [CONSTANT] 데이터타입 [:=값] -- CONSTANT 가 사용되면 변수가 상수가 되어짐. 상수가 될 때는 :=값을 생략하면 안된다.
    
 2. SCLAR 변수에 사용되는 데이터 타입
  - 표준 오라클에서 사용되는 데이터 타입,
  - PLS_INTEGER, BINARY_INTEGER : 4BYTE 길이의 정수(2147483647 ~ -2147483648)
  - BOOLEAN : true / false / null
  
 3. 참조형 변수
    열참조 : 테이블명.컬럼명%TYPE
    행참조 : 테이블명%ROWTYPE
    ABC MEMBER%ROWTYPE;
    ABC.MEM_JOB
    
 4. BIND 타입
  - 함수나 프로시져에서 데이터의 입출력에 사용되는 변수
  - 목적에 따라 IN(입력용), OUT(출력용), INOUT(입출력 공용)으로 구분
 
 5. COMPOSITE변수
  - PL/SQL에서 사용하는 배열 변수
  - RECORD TYPE, TABLE TYPE

사용예) 키보드로 부서번호를 입력받아 해당부서에서 맨 처음 입사한 한명의 사원정보를 출력하시오. 
       출력사항은 사원번호, 사원명, 입사일, 직무코드이다. -- 서브쿼리 써야 함.
       
       ACCEPT P_DID PROMPT '부서번호(10-110) 입력 : ' --ACCEPT 자바의 스캐너 PROMPT 메세지 출력, ;하지 않는다. 오류.
       DECLARE
          L_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE := '&P_DID'; -- 부서코드
          L_EID EMP.EMPLOYEE_ID%TYPE; -- 사원번호
          L_ENAME VARCHAR2(100); -- 사원명
          L_HDATE DATE;--EMP.HIRE_DATE%TYPE; --L_HDATE DATE; 이렇게 써도 됨. -- 입사일
          L_JID EMP.JOB_ID%TYPE; -- 직무코드
        
       BEGIN
         SELECT A.EMPLOYEE_ID,A.LAST_NAME,A.HIRE_DATE,A.JOB_ID
            INTO L_EID,L_ENAME,L_HDATE,L_JID --메인쿼리에는 INTO 필요
            FROM (SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, JOB_ID
                    FROM HR.EMPLOYEES
                     WHERE DEPARTMENT_ID = L_DID
                     ORDER BY 3)A
             WHERE ROWNUM =1;
             
          DBMS_OUTPUT.PUT_LINE('부서코드 : '||L_DID);   
          DBMS_OUTPUT.PUT_LINE('사원번호 : '||L_EID);   
          DBMS_OUTPUT.PUT_LINE('사원명 : '||L_ENAME);   
          DBMS_OUTPUT.PUT_LINE('입사일 : '||L_HDATE);   
          DBMS_OUTPUT.PUT_LINE('직무코드 : '||L_JID);   
       
       END;
       
       
       
       


       
       
       