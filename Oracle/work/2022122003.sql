2022-1220-03) 테이블 생성, 삭제, 변경

1. 테이블 생성
 - 사용자 자료를 저장하기 위한 저장공간 생성
 (사용 형식)
 CREATE TABLE 테이블명 (
    컬럼명 데이터타입[(크기 [BYTE|CHAR])] [NOT NULL] [DEFAULT 값],
                        :
    컬럼명 데이터타입[(크기 [BYTE|CHAR])] [DEFAULT 값],
    [CONSTRAINT 기본키 설정명 PRIMARY KEY(컬럼명[,컬럼명,...]),]
    [CONSTRAINT 외래키 설정명 FOREIGN KEY(컬럼명) REFERENCES 테이블명(컬럼명),]
                        :
    [CONSTRAINT 외래키 설정명 FOREIGN KEY(컬럼명) REFERENCES 테이블명(컬럼명),]
    
    
사용 예) 칠판의 ERD를 테이블로 설계하시오.

 1) 회원테이블(CUSTOMERS) 생성
    - 회원번호(CUST_ID), 회원명(CUST_NAME), 전화번호(CUST_TEL_NUM)
 2) 상품테이블(GOODS)
    - 상품번호(G_ID), 상품명(G_NAME), 가격(G_PRICE)
 3) 주문테이블(ORDERS)
    - 주문번호(ORDER_ID), 날짜(ORDER_DATE)
 4) 주문상품테이블(ORDERS_G00DS)
    - 수량(ORDER_QTY)

1   
CREATE TABLE CUSTOMERS(
    CUST_ID CHAR(4),
    CUST_NAME VARCHAR2(30) NOT NULL,
    CUST_TEL_NUM VARCHAR2(20),
    CONSTRAINT pk_customers PRIMARY KEY(CUST_ID));
    
2
CREATE TABLE GOODS(
    G_ID NUMBER(4) ,
    G_NAME VARCHAR2(50) NOT NULL,
    G_PRICE NUMBER(7) DEFAULT 0,
    CONSTRAINT pk_goods PRIMARY KEY(G_ID));
3 
CREATE TABLE ORDERS(
    ORDER_ID CHAR(12), --PK
    ORDER_DATE DATE DEFAULT SYSDATE, --데이터가 등록되는 시점의 날짜데이터
    CUST_ID CHAR(4), --FK
    CONSTRAINT pk_orders PRIMARY KEY(ORDER_ID), 
    CONSTRAINT fk_orders_cust FOREIGN KEY(CUST_ID)
        REFERENCES CUSTOMERS(CUST_ID));

 DROP TABLE ORDERS_GOODS;
4
CREATE TABLE ORDERS_GOODS (
    ORDER_QTY NUMBER(3),
    G_ID NUMBER(4), -- PK & FK
    ORDER_ID CHAR(12),  --PK & FK
    CONSTRAINT pk_ordergood PRIMARY KEY(G_ID,ORDER_ID),
    CONSTRAINT fk_org_goods FOREIGN KEY(G_ID)
        REFERENCES GOODS(G_ID),
    CONSTRAINT fk_org_orders FOREIGN KEY(ORDER_ID)
        REFERENCES ORDERS(ORDER_ID) );
 2022-12-21        
2. 테이블 삭제
 - DROP TABLE 명령으로 삭제
 - 관계(RELATIONSHIP)를 맺고있는 테이블 중 부모테이블은 자식테이블이 존재하면 삭제될 수 없음.
 
(사용 형식)
 DROP TABLE 테이블명;
 
3. 테이블 구조 변경(ALTER)
 - 테이블내의 컬럼의 추가, 변경, 삭제 및 컬럼명의 변경
 - 테이블명 변경 
 - 제약사항 추가 및 삭제
    
 1) 컬럼 추가
    . 테이블에 새로운 컬럼 추가
    
(사용 형식)
    ALTER TABLE 테이블명 ADD(컬럼명 데이터타입[(크기 [BYTE|CHAR])] [NOT NULL] [DEFAULT 값]);
    
 사용 예) HR계정의 EMPLOYEES 테이블에 EMP_NAME 컬럼을 추가하시오.
       해당 컬럼은 VARCHAR2(80)의 크기를 갖는다. 
        
    ALTER TABLE HR.EMPLOYEES ADD(EMP_NAME VARCHAR2(80));
    
 2) 컬럼 수정
    . 컬럼의 지료형과 크기를 변경
    . 크기변경시 원본크기보다 작게 할 수 없다.
    
 (사용 형식)
    ALTER TABLE 테이블명 MODIFY(컬럼명 데이터타입[(크기 [BYTE|CHAR])] [NOT NULL] [DEFAULT 값]);
    
 사용 예) HR계정의 EMPLOYEES 테이블에서 FIRST_NAME 컬럼(VARCHAR2(20))을 CHAR(20)으로 변경하시오.
    ALTER TABLE HR.EMPLOYEES MODIFY(FIRST_NAME CHAR(20));
    ALTER TABLE HR.EMPLOYEES MODIFY(FIRST_NAME NUMBER(20)); (X) 컬럼 아예 삭제 
    ALTER TABLE HR.EMPLOYEES MODIFY(FIRST_NAME VARCHAR2(15)); (X) 
    ALTER TABLE HR.EMPLOYEES MODIFY(FIRST_NAME VARCHAR2(25));
    
 3) 컬럼 삭제
    . 불필요한 컬럼을 삭제
 (사용 형식)
    ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
    
 (사용 예)HR계정의 EMPLOYEES 테이블에서 FIRST_NAME 컬럼을 삭제하시오.
    ALTER TABLE HR.EMPLOYEES DROP COLUMN FIRST_NAME;
    ROLLBACK;
    
    
    
 4) 컬럼명 수정
 (사용 형식)
    ALTER TABLE 테이블명 RENAME COLUMN old_컬럼명 TO NEW_컬럼명;

 5) 테이블명 변경
 (사용 형식)
    ALTER TABLE old_테이블명 RENAME TO new_테이블명;
 (사용 예) ORDERS_GOODS 테이블을 tbl_order_detail로 변경하시오.
    ALTER TABLE ORDERS_GOODS RENAME TO tbl_order_detail;
    
 5) 제약사항 추가 변경, 삭제
 (사용 형식)
    (추가) ALTER TABLE 테이블명 ADD CONSTRAINT 제약명 PRIMARY KEY|FOREIGN KEY (컬럼명)[,컬럼명,...])[REFERENCES 테이블명(컬럼명)];
    (삭제) ALTER TABLE 테이블명 DROP CONSTRAINT 제약명; --관계 끊을 때
    (수정) ALTER TABLE 테이블명 MODIFY 컬럼조건; -- 컬럼 제약사항(NOT NULL, DEFAULT 값 등의 수정)
    
 (사용 예) GOODS 테이블을 삭제하시오.
    DROP TABLE GOODS; (X)
    
    1) 관계삭제(자식테이블에 존재하는 관계 먼저 삭제)
    ALTER TABLE TBL_ORDER_DETAIL DROP CONSTRAINT FK_ORG_GOODS;
    DROP TABLE GOODS;
    
  (사용 예) CUSTOMERS 테이블을 삭제하시오.  
    DROP TABLE TBL_ORDER_DETAIL;
    DROP TABLE ORDERS;
    DROP TABLE CUSTOMERS;
    
    
    
    
    