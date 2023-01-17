2023-0109-02) VIEW 객체 --객체 생성은 CREATE
 - 테이블의 유사 객체(가상의 테이블)
 - 기존의 테이블이나 뷰 객체를 통하여 새로운 SELECT문의 결과에 이름을 부여하여 저장 -- SELECT문의 결과가 VIEW. / 결과 집합을 커서라고도 한다. 
 - VIEW 이용
    . 필요한 정보가 여러 테이블에 분산 저장된 경우 -- 
    . 테이블의 자료 일부분만 필요한 경우
    . 특정자료에 대한 접근 제한(보안) -- 
    -- 이름을 안 붙이면 저장이 안된다. 붙여야 한다.  -- 시스템이 제공하는 뷰 듀얼..
    -- 원본테이블 변경되면 즉시 VIEW도 변경 / VIEW가 변경되면 원본테이블도 변경 O
 (사용형식) 
    CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW 뷰이름[(컬럼list)] -- 뷰이름은 사용자가 생성
    AS 
     SELECT 문; 
     [WITH READ ONLY]
     [WITH CHECK OPTION]
     
     . 'OR REPLACE' : 이미 존재하는 뷰이면 대치하고 새로운 뷰 생성
     . 'FORCE | NOFORCE' : FORCE는 원본 테이블이 없어도 생성가능 default는 NOFORCE
     . '(컬럼list)' : 뷰에 사용할 컬럼명 
        - '(컬럼lixt)'가 기술되면 뷰의 컬럼명은 '(컬럼lixt)' 가 됨.
        - '(컬럼lixt)'가 생략되면 SELECT 문에 사용된 컬럼별칭이 뷰의 컬럼명이 됨.
        - '(컬럼lixt)'가 생략되고, SELECT 문에 사용된 컬럼별칭도 사용되지 않았으면 SELECT문의 컬럼명이 뷰의 컬럼명이 됨.
     . 'WITH READ ONLY' : 읽기전용 뷰 생성 -- 뷰를 DML명령을 이용하여 조작할 수 없다. INSERT, UPDATE, DELETE X. 뷰를 대상으로 할 수 있으나 원본테이블은 조작 가능O
     . 'WITH CHECK OPTION' : SELECT 문의 WHERE 조건을 위배하는 DML명령을 뷰에 실행했을때 오류 발생(단, 원본테이블은 WHERE 조건을 위배하는 DML 명령 제한없이 사용)
      -- WITH READ ONLY 와 WITH CHECK OPTION 같이 사용 X  
      
(사용예) 회원테이블에서 마일리지가 3000이상인 회원들의 회원번호, 회원명, 직업, 마일리지로 뷰를 생성하시오.

        CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MILE)
        AS
          SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명,MEM_JOB AS 직업,MEM_MILEAGE AS 마일리지
             FROM MEMBER
            WHERE MEM_MILEAGE >= 3000;
            
        CREATE OR REPLACE VIEW V_MEM01
        AS
        SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명,MEM_JOB AS 직업,MEM_MILEAGE AS 마일리지
            FROM MEMBER
           WHERE MEM_MILEAGE >= 3000; -- 앞서 만든 뷰를 덮어씌운다. 컬럼명과 다르게
           
        CREATE OR REPLACE VIEW V_MEM01
        AS
        SELECT MEM_ID, MEM_NAME, MEM_JOB, MEM_MILEAGE
            FROM MEMBER
           WHERE MEM_MILEAGE >= 3000; -- SELECT문의 컬럼명이 뷰의 컬럼명이 됨. 
           
사용예)뷰 V_MEM01 'h001' 라준호 회원의 마일리지를 2500으로 변경하시오.
    UPDATE V_MEM01
        SET MEM_MILEAGE = 2500 WHERE MEM_ID = 'h001';
        
    select * from V_MEM01;
    
    SELECT MEM_ID, MEM_NAME, MEM_MILEAGE 
      FROM MEMBER
      WHERE MEM_ID = 'h001'; -- 뷰 수정하면 원본테이블 변경됨. 
      
사용예) 회원테이블의 'n001' 회원과 'h001' 회원의 마일리지를 4500으로 변경하시오.
    UPDATE MEMBER
        SET MEM_MILEAGE = 4500 
            WHERE MEM_ID IN('h001','n001'); -- 테이블 변경하면 바로 뷰에도 적용.
            
        CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MILE)
        AS
          SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명,MEM_JOB AS 직업,MEM_MILEAGE AS 마일리지
             FROM MEMBER
            WHERE MEM_MILEAGE >= 3000
            WITH READ ONLY;
            
사용예) v_MEM01 뷰에서 'h001' 회원의 마일리지를 3150으로 변경하시오.
    UPDATE V_MEM01
        SET MILE = 3150 WHERE MEM_ID = 'h001'; -- READ ONLY 뷰는 수정 불가능.
        
사용예) V_MEM01 뷰에서 'n001' 회원의 정보를 삭제하시오.
    DELETE FROM V_MEM01 WHERE MID = 'n001'; -- READ ONLY 뷰는 수정 불가능.
    
** 회원테이블의 내용을 T_MEMBER에 복사하세요. --복사할 때 CREATE 사용 서브쿼리 이용해서 AS로 연결하면 서브쿼리의 결과가 그대로 테이블에 생성된다.
    CREATE TABLE T_MEMBER
    AS
        SELECT*FROM MEMBER; 
        
사용예) T_MEMBER 테이블에서 여성 회원이며 마일리지가 3000이상인 회원들의 회원번호, 회원명, 마일리지로 구성된 뷰를 생성하시오.

    CREATE OR REPLACE VIEW V_FMEMBER
    AS
    SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_MILEAGE AS 마일리지
        FROM T_MEMBER
        WHERE MEM_MILEAGE >= 3000 AND SUBSTR(MEM_REGNO2,1,1) IN('2','4')
        --WITH READ ONLY;
        WITH CHECK OPTION; -- 2개가 동시에 들어가면 안됨. / WHERE 조건 중에 어느 한 쪽 조건이라도 변경하려해도 뷰에서 변경할 수가 없다. 
        
사용예) T_MEMBER 테이블에서 'd001' 회원정보를 삭제하시오. 
    DELETE FROM T_MEMBER 
        WHERE MEM_ID= 'd001'; -- 뷰가 READ ONLY 여도 테이블에서 지우면 뷰에 즉시 반영(없어짐).
    
사용예) 뷰 V_MEMBER에서 'b001' 회원의 마일리지를 2500으로 변경 -- CHECK OPTION 뷰 자체가 변경이 되면 안되나봐.. 

    UPDATE V_FMEMBER
        SET 마일리지 = 2500 
        WHERE 회원번호 = 'b001' 

사용예) T_MEMBER에서 'b001' 회원의 마일리지를 2500으로 변경 -- 테이블에서 변경

    UPDATE T_MEMBER
        SET MEM_MILEAGE= 2500 
        WHERE MEM_ID = 'b001';
        
사용예) 뷰 V_MEMBER에서 'j001' 회원의 마일리지를 3412 를 5400으로 변경 -- READ ONLY 아니라서

    UPDATE V_FMEMBER
        SET 마일리지 = 5400 
        WHERE 회원번호 = 'j001'
        
** 뷰의 삭제
DROP VIEW 뷰이름

DROP VIEW V_FMEMBER;







        
        

        

    

            

            
            

     
     
      

    
    



      
      
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 