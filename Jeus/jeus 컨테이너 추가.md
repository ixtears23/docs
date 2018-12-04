
#### UNIX 환경변수 확인
**host**: 203.254.160.35  
**port**: 22(기본포트)  

putty 또는 Xshell5 접속

- 모든 환경 변수 확인  
-> `printenv`  

- 환경변수 이름으로 확인  
-> `echo $환경변수이름`  
예)  
-> `echo $JEUS_HOME`  


#### 용량 확인
-> `df -h`  

#### Jeus 명령어

- 현재 jeus 버전 확인  
-> jeusadmin -version  
- 현재 jeus 풀버전 확인  
-> jeusadmin -fullversion  
- 현재 webtob 버전 확인  
-> wscfl -version  
- 현재 Jeus License 남은 일자 확인  
-> jeusadmin -licensedue  

#### Jeus WebAdmin 경로
`/home1/ekriss/jeus7/domains/domain1/config/domain.xml`  
listen-port 를 확인한다.  
~~~
<server>
  <listen-port>9700
~~~



#### 컨테이너 설정

- JEUSMain.xml 경로  
  - `JEUS_HOME\config\<node-name>\JEUSMain.xml`  

- WEBMain.xml 경로  
  - `JEUS_HOME\config\<node-name>\<node-name>_servlet_<engine-name1>\WEBMain.xml`
  - `JEUS_HOME\config\<node-name>\<node-name>_servlet_<engine-name2>\WEBMain.xml`


`WEBMain.xml`은 JEUSMain.xml에 추가된 JEUS 웹 컨테이너를 설정하는 파일로 웹 컨테이너의 설정 디
렉터리에 해당 파일이 존재해야한다.
