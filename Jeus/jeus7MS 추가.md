

# jeus7 Managed Server 추가

Xshell5 로 접속

- jeuslicense 확인
`jeusadmin -licensedue`  


- 환경변수 확인  
`printenv` 명령어 실행  

`JEUS_HOME` 확인  
`WEBTOBDIR` 확인  


- datasource 추가 방법  
`${JEUS_HOME}/lib/datasource` 해당 경로에 datasource 관련 jar 추가  


- jeus 관련 명령어 위치
`${JEUS_HOME}`/bin  

DAS (domain administration server) server 기동 명령어  
startDomainAdminServer -u user -p passwod

