

# jeus7 Managed Server 추가

Xshell5 로 접속

- jeuslicense 확인  
`jeusadmin -licensedue`  


- 환경변수 확인  
`printenv` 명령어 실행  
  - `JEUS_HOME` 확인  
  - `WEBTOBDIR` 확인  


- datasource 추가 방법  
`${JEUS_HOME}/lib/datasource` 해당 경로에 datasource 관련 jar 추가  
  - jeus 관련 명령어 위치  
  `${JEUS_HOME}`/bin  

### webAdminServer 실행/종료

- 실행  
  - `dsboot`  
  - `startDomainAdminServer -domain domain1 -u administrator -p administrator`  
  
- 종료  
  - `stopServer -host 203.254.160.35:9700 -u administrator -p administrator`  
  

### ManagedServer 실행/종료
 - 실행  
   - jeusadmin 에 접속하지 않고 실행하는 방법  
   `startManagedServer -domain domain명 -u user명 -p password`  
   - jeusadmin 접속해서 실행  
   `jeusadmin -port 9700 -u administrator -p administrator` 입력해서 접속  
   `start-server server명`  
   
 - 종료  
   - jeusadmin 에 접속하지 않고 종료하는 방법  
   `stopServer -host 호스트:포트 -u administrator -p administrator`  
   - jeusadmin 접속해서 종료  
   `jeusadmin -port 9700 -u administrator -p administrator` 입력해서 접속  
   `stop-server server명`  
   



### node 확인
`jeusadmin -port 9700 -u administrator -p administrator` 입력해서 DAS 접속 후  
  - 노드 전체 확인: `list-nodes`  
  - 특정 노드 확인: `show-node node명`  


