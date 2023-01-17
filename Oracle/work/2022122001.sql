2022-1220-01) 사용자 생성
- 사용자(오라클 객체)의 생성은 CREATE 명령을 사용, 
- 객체의 삭제는 DROP 명령 사용

(기술형식)
CREATE USER 유저명 IDENTIFIED BY 암호;
 .'유저명'과 '암호'는 사용자 정의 단어 사용
 . 암호는 대소문자 구별

- 권한부여
 . 오라클 사용자가 수행할 수 있는 일의 범위 설정
 . GRANT 명령을 사용하여 권한을 설정.
 . 부여된 권한을 회수할 때에는 REVOKE명령 사용

(사용형식)
 GRANT 권한명[,권한명,...] TO 계정명;
    - 사용자 생성 후 부여하는 권한의 종류는 보통 CONNECT, RESOURCE, DBA 등이 있음.
    

GRANT CONNECT, RESOURCE, DBA TO CTH98;
 
CREATE USER CTH98 IDENTIFIED BY java;
 
 - HR 계정 활성화
 . ALTER 명령 사용
 ALTER USER HR ACCOUNT UNLOCK IDENTIFIED BY java;

DROP USER 유저명;