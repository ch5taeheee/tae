2022-1228-01)함수
 - 특정 결과를 산출하기 위하여 요구되는 명령의 집합(모듈)
 - 함수(Function)은 결과 값을 함수가 사용된 위치에 반환함.
 - 문자열함수, 숫자함수, 날짜함수, 형변환함수, null처리함수, 분석함수, 집계함수 등이 제공
 -- 집계함수는 집계함수를 포함할 수 없다. 5가지 SUM, AVG, AVERAGE, MIN, MAX
 
 1. 문자함수
   1) 문자열 결합연산자(||)와 CONCAT(c1,c2)
    - 주어진 문자열 'c1'과 'c2'를 결합하여 새로운 문자열 자료를 반환
    
(사용예) SELECT 'Oracle'||'SQL',
                CONCAT('Oracle','SQL')
            FROM DUAL; -- 가상의 테이블, 
            
 문제] 회원테이블에서 여성회원들의 회원번호, 회원명, 주민번호, 직업, 마일리지를 조회하시오.
    단, 주민번호는 XXXXXX-XXXXXXX형식으로 출력하시오.
    
 1) SELECT MEM_ID AS 회원번호, 
        MEM_NAME AS 회원명, 
        CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2) AS 주민번호, 
        MEM_JOB AS 직업, 
        MEM_MILEAGE AS 마일리지
    FROM MEMBER
     WHERE SUBSTR(MEM_REGNO2,1,1)=2 OR SUBSTR(MEM_REGNO2,1,1)=4;
     
     
 2)  SELECT MEM_ID AS 회원번호, 
        MEM_NAME AS 회원명, 
        MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호, 
        MEM_JOB AS 직업, 
        MEM_MILEAGE AS 마일리지
    FROM MEMBER
     WHERE SUBSTR(MEM_REGNO2,1,1)=2 OR SUBSTR(MEM_REGNO2,1,1)=4;  
     
 2) LOWER(c1), UPPER(c1) -(**), INITCAP(c1) -(*)
  - LOWER : 'c1'의 문자 중 모든 대문자를 소문자로 변환하여 반환
  - UPPER : 'c1'의 문자 중 모든 소문자를 대문자로 변환하여 반환
  - INITCAP : 'c1'의 문자 중 모든 단어의 첫 글자를 대문자로 변환하여 반환
  
 (사용예) 상품테이블에서 분류코드가 'p201'에 속한 상품의 상품코드, 상품명, 매입단가, 매출단가

 
 SELECT PROD_ID AS 상품코드,
        PROD_NAME AS 상품명,
        PROD_COST AS 매입단가,
        PROD_PRICE AS 매출단가
 FROM PROD
 WHERE LOWER(PROD_LGU) = 'p201'
 
  3) LPAD(c1,n[,c2]), RPAD(c1,n[,c2]) -(***)
    - LPAD : 기억공간에 정의된 길이 n의 오른쪽부터 c1을 채우고 남는 공간(왼쪽)에 c2를 채움 --문자열을 숫자처럼 출력할 때
    - RPAD : 기억공간에 정의된 길이 n의 왼쪽부터 c1을 채우고 남는 공간(오른쪽)에 c2를 채움 --숫자를 문자열처럼 출력할 때
    -'C2'를 생략하면 공백을 채움
    
 (사용예) 상품테이블에 매입단가와 매출단가를 각각 7자리로 출력하되 매입단가는 오른쪽 정렬을 매출단가는 왼쪽 정렬을 수행하고 '*'를 빈 공간에 채워넣으시오.
         출력할 자료는 상품코드, 상품명, 매입단가, 매출단가
  SELECT * FROM PROD
  
  SELECT PROD_ID AS 상품코드,
         PROD_NAME AS 상품명,
         LPAD(PROD_COST,10,'*') AS  매입단가,
         RPAD(PROD_PRICE,10,'*') AS 매출단가
    FROM PROD
 
 사용예) 키보드로부터 분류코드를 입력받아 해당분류에 포함된 상품정보를 출력하는 익명 블록을 작성하시오.
        Alias는 상품코드, 상품명, 매출액, 조수익이며 조수익은 (매출단가-매입단가)이다. 
        
        ACCEPT B_CODE PROMPT '분류코드 입력'
        DECLARE
            L_PROFIT NUMBER:=0;
            L_RES VARCHAR2(255);
            CURSOR CUR_SAMPLE IS
                SELECT PROD_ID, PROD_NAME, PROD_PRICE, (PROD_PRICE-PROD_COST) AS PIT
                    FROM PROD
                    WHERE PROD_LGU = UPPER('&B_CODE');
        BEGIN
            FOR REC IN CUR_SAMPLE LOOP 
                L_RES:= REC.PROD_ID||' '||RPAD(REC.PROD_NAME,26)||
                    TO_CHAR(REC.PROD_PRICE,'9,999,999')||TO_CHAR(REC.PIT,'9,999,999');
                DBMS_OUTPUT.PUT_LINE(L_RES);
        END LOOP;
        END;
 
  4) SUBSTR(c,m[n]) - (****)  -- 자바는 0부터 오라클은 1부터
  - 주어진 문자열 c의 m번째 문자부터 n개의 문자를 추출하여 반환
  - 'n'이 생략되거나 남은 글자수 보다 큰 수이면 m번째 이후 모든 글자를 추출
  - m이 음수이면 오른쪽부터 처리됨.
  
  SELECT SUBSTR('OracleSQL과 PL/SQL',2,5),
         SUBSTR('OracleSQL과 PL/SQL',10,55),
         SUBSTR('OracleSQL과 PL/SQL',10),
         SUBSTR('OracleSQL과 PL/SQL',-10,5)
    FROM DUAL;
    
 (사용예) 2020년 6월 장바구니 테이블을 사용하여 상품의 매출이 발생된 날마다 첫번째로 구매한 고객을 조회하시오. 
         Alias는 날짜, 회원번호, 회원명, 직업, 마일리지

         SELECT DISTINCT SUBSTR(A.CART_NO,1,8) 날짜, --DISTINCT 중복제외
                A.CART_MEMBER AS 회원번호,
                B.MEM_NAME AS 회원명, 
                B.MEM_JOB AS 직업,
                B.MEM_MILEAGE AS 마일리지
             FROM CART A, MEMBER B
                WHERE SUBSTR(CART_NO,1,6)='202006' 
                    AND SUBSTR(CART_NO,9)=1
                    AND A.CART_MEMBER=B.MEM_ID
                    ORDER BY 1; 
                
  5) LTRIM(c1 [,c2]), RTRIM(c1 [,c2]) -(**)
    - LTRIM : 문자열 c1에서 왼쪽 시작하는 문자열이 c2와 일치하면 삭제하고 같은 패턴의 문자열이 c1에 존재하면 모두 삭제
    - RTRIM : 문자열 c1에서 오른쪽 시작하는 문자열이 c2와 일치하면 삭제하고 같은 패턴의 문자열이 c1에 존재하면 모두 삭제
    - c2가 생략되면 문자열 왼쪽(LTRIM) 또는 오른쪽(RTRIM)의 공백문자열을 삭제
      (단, 문자열 내부의 공백은 제거하지 못함)
    
 (사용예) SELECT LTRIM('APPLE AP AP ALLL','AP'),
                LTRIM('APPLE AP AP ALLL','A'),
                LTRIM('APPLE AP AP ALLL','P'),
                LTRIM('   APPLE AP AP ALLL'),
                RTRIM('APPLE AP AP ALLL','LE')
          FROM DUAL;
          
         SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
            FROM MEMBER
         WHERE MEM_NAME = LTRIM(' 김은대');
         
         SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
            FROM MEMBER
         WHERE MEM_NAME = ' 김은대';    (X) -- VARCHAR2 공백 X    
         
         SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
            FROM MEMBER
         WHERE MEM_NAME = RTRIM('김은대 ');     
        
        
  6) TRIM(c1) -(***)
   - 주어진 문자열 C1의 오른쪽과 왼쪽의 공백 모두를 제거
   - 단어 내부 공백제거는 불가능
   
         SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
            FROM MEMBER
         WHERE MEM_NAME = TRIM('김은대 ');  
         
         
 (사용예) 오늘이 2020년 6월 13일인 경우 장바구니 번호를 생성하시오. --
    (1) 오늘날짜의 가장 큰 장바구니번호 검색
        SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||
               TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000') -- (X) 공백까지 출력, 오라클 오류 EX)20200613 00003 
            FROM CART
             WHERE CART_NO LIKE TO_CHAR(SYSDATE,'YYYYMMDD')||'%';
             
        SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||
               TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000'))  -- (O) 공백제거
            FROM CART
             WHERE CART_NO LIKE TO_CHAR(SYSDATE,'YYYYMMDD')||'%';

        SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||
               TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000')), MAX(CART_NO)+1 
            FROM CART
             WHERE CART_NO LIKE TO_CHAR(SYSDATE,'YYYYMMDD')||'%';
             
 7) INSTR(c1,c2[,m[,n]]) -(**)
  - 찾는 문자열의 위치를 반환하는 함수
  - c1 문자열에서 c2문자열을 처음 만나는 위치를 반환.
  - m은 찾기를 시작할 위치, n은 반복횟수 지정
  
  (사용예) SELECT INSTR('Hello heidi', 'he'),
                 INSTR('Hello heidi', 'e',3),
                 INSTR('HELLO heidi', 'h',1,2)
            FROM DUAL;
  
 8) LENGTH(c1), LENGTHB(c1) - (**)
  - 문자열의 길이를 BYTE로(LENGTHB) 또는 문자의 수로(LENGTH) 반환 -- 영문자 1BYTE 한글 3BYTE(BYTE와 문자의 수가 다르다)
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
            