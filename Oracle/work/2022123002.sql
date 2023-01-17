2022-1230-02) 형 변환 함수
 - 함수가 사용된 위치에서 대상의 데이터타입을 명시적이고 일시적으로 형을 변환  -- ALTER 아예 형을 변환시키려면,
 - TO_CHAR, TO_DATE, TO_NUMBER, CAST가 제공   --CAST는 날짜, 문자 숫자, 다     -- 일시적인 변환
 
1. CAST(expr AS type명)
 - 'expr'의 값을 type형으로 변환
 
 (사용예)
    SELECT PROD_ID AS 상품코드,
        CAST(PROD_NAME AS CHAR(40)) AS 상품명,
        CAST(PROD_COST AS VARCHAR2(10)) AS 매입단가, 
        PROD_PRICE AS 매출단가
     FROM PROD;
     
2. TO_CHAR(c), TO_CHAR(d [,fmt]), TO_CHAR(n [,fmt])
 - 'c'는 고정길이 문자열타입(CHAR)이나 CLOB 타입을 VARCHAR2타입으로 변환
 - 날짜(d)를 특정형식(fmt)의 문자열 자료로 변환
 - 숫자(n)을 특정형식(fmt)의 무자열 자료로 변환
 
 ** 날짜 지정형식
 -----------------------------------------------------------------------------------------------------------------------
         형식 문자열                설명                                예
 -----------------------------------------------------------------------------------------------------------------------
            CC                     세기               SELECT TO_CHAR(SYSDATE,'CC') FROM DUAL;
          AD, BC                   서기               SELECT TO_CHAR(SYSDATE, 'CC BC') FROM DUAL;            
      YYYY,YYY,YY,Y                년도               SELECT TO_CHAR(SYSDATE, 'YYY') FROM DUAL; --YYY:022 오른쪽에서 잘림
           YEAR              문자로 표현된 년도         SELECT TO_CHAR(SYSDATE, 'YYYY YEAR') FROM DUAL;    
            Q                      분기               SELECT TO_CHAR(SYSDATE, 'Q') FROM DUAL;  
          MM,RM                    D월                SELECT TO_CHAR(SYSDATE, 'MM RM') FROM DUAL;  
        MONTH, MON              '월' 출력             SELECT TO_CHAR(SYSDATE, 'MONTH MON') FROM DUAL;   
          W, WW                    주차               SELECT TO_CHAR(SYSDATE, 'W WW') FROM DUAL;  
            DD                   월의 날짜             SELECT TO_CHAR(SYSDATE, 'DD') FROM DUAL;
          D, DDD                주, 년의 날짜          SELECT TO_CHAR(SYSDATE, 'D DDD') FROM DUAL;
         DY, DAY                   요일               SELECT TO_CHAR(SYSDATE, 'DY DAY') FROM DUAL;
      AM,PM,A.M,P.M              오전/오후            SELECT TO_CHAR(SYSDATE, 'A.M') FROM DUAL;
       HH,HH12,HH24                시간               SELECT TO_CHAR(SYSDATE, 'HH24 : HH12 :HH24') FROM DUAL;
            MI                      분                SELECT TO_CHAR(SYSDATE, 'MI') FROM DUAL;
         SS,SSSSS                   초                SELECT TO_CHAR(SYSDATE, 'SS SSSSS') FROM DUAL;
            J                     줄리안(기년전 4713년 12월 31일 이후 요일의 수)
            
         "문자열"              사용자 정의 형식 문자     SELECT TO_CHAR(SYSDATE,'YYYY "년" MM "월" DD "일"') FROM DUAL;
-----------------------------------------------------------------------------------------------------------------------

** 숫자지정형식 --연산이 안된다. (,), 원화기호, <>, - : 숫자로 바뀔 수 없는 기호들이라 연산 X/ 숫자로 바뀔 수 있는 것은 . 밖에 없다. 숫자로 꼭 바꾸고 싶다 하면 TO_NUMBER을 써야 한다. 
-----------------------------------------------------------------------------------------------------------------------
        형식문자열             설명                                                     예
-----------------------------------------------------------------------------------------------------------------------
            9           해당위치에 대응되는 유효숫자는 출력,                
                        무효의 0은 공백처리
            0           해당위치에 대응되는 유효숫자는 출력, 
                        무효의 0도 '0' 출력
           $,L          데이터 왼쪽에 화폐기호 출력
           PR           음수인 경우 '< >' 안에 출력
           MI           음수인 경우 '-' 부호를 숫자 오른쪽 끝에 출력
        ,(COMMA)        3자리 자리점
         .(DOT)         소숫점

(사용예) SELECT TO_CHAR(23450,'9999999'),  
               TO_CHAR(23450,'9,999,999'),
               TO_CHAR(23450,'L99,999'),
               TO_CHAR(23450.459,'99,999.99'), --자동으로 반올림 됨.
               TO_CHAR(23450.4,'99,999.99'),
               TO_CHAR(-23450,'99,999MI'),
               TO_CHAR(23450,'99,999MI'),
               TO_CHAR(-23450,'99,999PR') --음수인 경우 <>, 양수인 경우 그대로
            FROM DUAL;
            
        SELECT TO_CHAR(23450,'0000000'),
               TO_CHAR(23450,'0,000,000'),
               TO_CHAR(23450,'L00,000'),
               TO_CHAR(23450.459,'00,000.00'), --자동으로 반올림 됨.
               TO_CHAR(23450.4,'00,000.00'),
               TO_CHAR(-23450,'00,000MI'),
               TO_CHAR(23450,'00,000MI'),
               TO_CHAR(-23450,'00,000PR') 
            FROM DUAL;
            
3. TO_NUMBER(c [,fmt])
 - 문자열 자료 c를 숫자형으로 변환
 - 'fmt'는 TO_CHAR 함수의 숫자지정 형식 문자열과 동일
 
 (사용예) 
    SELECT TO_NUMBER('234'), -- 0 234
           TO_NUMBER('23,450','00,000'), --X  ,때문에 숫자 변형 X ->  X를 오른쪽에 대응시켜 왼쪽이 되게 하는 것. -> 23,450
           TO_NUMBER('$234,567.90','$999,999.99'),
           TO_NUMBER('<12,450>','99,999PR')
        FROM DUAL;
        
4. TO_DATE(c|n [,fmt])
 - 문자열 자료 c나 숫자자료 n을 날짜형으로 변환
 - 'fmt'는 TO_CHAR 함수의 날짜지정 형식문자열과 동일
 
 (사용예) --기본 타입으로 바뀜 (0000/00/00) (공백, /, -, 아무것도 없을 때)
    SELECT TO_DATE('20201217'),
           TO_DATE(20201217),
           TO_DATE('2020/12/17'),ㄴ
           TO_DATE('2020-12-17'),
           TO_DATE('2020 12 17')
      FROM DUAL;
      
    SELECT TO_DATE('20201217 17:25:50','YYYYMMDD HH24:MI:SS') FROM DUAL; --시간은 안 나옴. 시간 나오게 하려면 TO_CHAR 사용.
           
            
            
            
            
              
               

            
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
 