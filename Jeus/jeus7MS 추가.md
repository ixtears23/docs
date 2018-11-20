

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


### DAS 접속 방법
`jeusadmin -port 9700 -u administrator -p administrator`  

- jeusadmin 에서 managed server start  
`start-server server명`  

- jeusadmin 에서 managed server stop  
`stop-server server명`  


- node 확인
노드 전체 확인: `list-nodes`  
특정 노드 확인: `show-node node명`  


### webAdminServer 실행/종료

- 실행  
  - `dsboot`  
  - `startDomainAdminServer -domain domain1 -u administrator -p administrator`  
  
- 종료  
  - `stopServer -host 203.254.160.35:9700 -u administrator -p administrator`  
  

### ManagedServer 실행/종료
 - jeusadmin 에 접속하지 않고 실행하는 방법  
`startManagedServer -domain domain명 -u user명 -p password`  


### nodeManager 실행
`startNodeManager` 명령어 실행  

