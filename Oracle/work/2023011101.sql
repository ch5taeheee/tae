2023-0111-01)INDEX
 - 자료의 검색효율성을 증대시키기 위한 도구
 - WHERE 절이 사용되는 명령문의 실행속도 증대
 - 정렬(ORDER BY), 또는 그룹화(GROUP BY)절에 사용되는 컬럼의 인덱스는 실행속도를 향상시킴
 - 인덱스의 생성과 유지에 많은 시간과 비용이 소요됨.
 - 과도한 인덱스의 사용은 데이터베이스 전체의 실행 효율성을 저하시킴. 
 
 
 - 인덱스의 종류
  . Unique / Non-Unique -- NULL값도 포함. 널의 개수1 개만 허용 / 중복 허용
  . Single / Composite -- 하나의 컬럼으로 구성된 인데스 / 컬럼 2개
  . Normal / Bitmap / Function 
  --  검색 TREE를 기본으로 한다. /
  
(인덱스 생성)
    CREATE [UNIQUE|BITMAP] INDEX 인덱스명
     ON 테이블명(컬럼명1[,컬럼명2,...]) [ASC|DESC]
     . '테이블명' : 대상 테이블명
     . 'ASC|DESC' : 오름차순 또는 내림차순 인덱스 생성
     
(사용예) 회원테이블에서 주민번호 뒷자리(MEM_REGNO2)로 인덱스로 구성하시오.
    CREATE INDEX IDX_MEM_REGNO
     ON MEMBER(MEM_REGNO2);
     
     SELECT * FROM MEMBER WHERE MEM_REGNO2 = '4447619';
     
     DROP INDEX IDX_MEM_REGNO;
     
      SELECT * FROM MEMBER WHERE SUBSTR(MEM_REGNO2,2,4) = '4476'; --인덱스에서 함수 사용했다면 WHERE절에도 함수 사용해서 찾ㅇ라ㅏ.
      
    CREATE INDEX IDX_MEM_REGNO1 ON MEMBER(SUBSTR(MEM_REGNO2,2,4)); 
    
**INDEX 재생성
 - 기준테이블과 인덱스가 다른 테이블 스페이스로 이동된 경우
 - 삭제행이 많아 인덱스를 재구성 해야하는 경우
 (사용형식)
    ALTER INDEX 인덱스명 REBUILD --자동으로 재구성됨.
      
      