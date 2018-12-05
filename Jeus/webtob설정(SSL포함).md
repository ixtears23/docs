- webtob/jeus 홈 경로 확인  
`> printenv`  

- webtob 버전확인  
`> wscfl -v`  


- [jeus/webtob license 발급](https://technet.tmaxsoft.com/ko/front/main/main.do)  
> hotname 입력시 Linux/Unix 의 경우 `> hostname` 입력하면 hostname을 확인할 수 있다.  

- jeus license 확인  
`> jeusadmin -licensedue`  
`> jeusadmin -licenseinfo`  

- jeus license 경로  
`JEUS_HOME/license`  

- webtob license 확인  
`> wsadmin -i $WEBTOBDIR/license/license.dat`  

- webtob license 경로  
`WEBTOBDIR/license`  

- http.m 환경설정 파일 경로  
`WEBTOBDIR/config`  

- http.m 컴파일 명령어(컴파일 하면 해당경로에 wsconfig 파일 생성 됨)  
`> wscfl -i http.m`  

- webtob 서버 중지/가동 명령어  
`> wsdown`  
`> wsboot`  

- webtob VHOST 적용 시 도메인 발급  
  - 폐쇄망의 경우 담당자에게 해당 도메인 발급을 요청한다.  

- webtob ssl 적용  
  - 인증서 발급  
  newreq.pem, 도메인.p7b  
  - 도메인.p7b 파일 openssl을 사용해서 cert.pem 파일로 변환  
  `openssl pkcs7 -in www.gpki.go.kr.p7b -out cert.pem -print_certs -text`  
  - cert.pem 파일에서 특정 내용 복사해서 caChain.pem 파일로 생성  
  Certificate 라는 문구가 3번 나옴. 여기서 두번째 Certificate 부터 마지막까지 복사해서 caChain.pem 파일로 생성  
  - 폐쇄망의 경우 유효성 검사 ip, port를 연다.(outbound?)  
  - 폐쇄망의 경우 서버에서 https 를 적용하는 포트 (예:443) 을 연다.  


  - ssl 관련 파일 저장  
  cert.pem, newreq.pem, caChain.pem  
  - http.m 설정 파일에 ssl 설정 추가  
~~~linux
*NODE        PORT = "80,443"

*VHOST       PORT = "443",
             SSLFLAG = Y,
             SSLNAME = "ssl1"

*SSL         CertificateFile = "<cert.pem>",
             CertificateKeyFile = "<newreq.pem>",
             CertificateChainFile = "<caChain.pem>",
             RequiredCiphers = "HIGH:MEDIUM:!SSLv2:!PSK:!SRP:!ADH:!AECDH:!EXP:!RC4:!IDEA:3DES"
~~~

- RequiredCiphers 를 적용한 이유  
[참고](https://technet.tmaxsoft.com/ko/front/support/notice/viewNotice.do?board_seq=CUST-20160226-000003)  
2016년 01월부터 Client (IE11,edge, chrome48, fireFox 44 등등)에서 WebServer 로 SSL 통신시
WebServer 에서 RC4 Cipher Suite 를 허용하고 있는 경우, 접속이 제한.  
WebtoB 4.x 모든 버전에서 설정 가능.  
`*SSL.RequiredCiphers` 에 `"!RC4"` 설정을 추가하면 됩니다.  
ex) 한국전자인증 권고값 `"HIGH:MEDIUM:!SSLv2:!PSK:!SRP:!ADH:!AECDH:!EXP:!RC4:!IDEA:!3DES"` 으로 적용  
WebtoB 5.0 부터는 RC4 를 차단하는 것을 기본으로 설정.  
`*SSL.RequiredCiphers` 기본값 : `"HIGH:MEDIUM:!SSLv2:!PSK:!SRP:!ADH:!AECDH:!EXP:!RC4:!IDEA:!3DES"`  


- 참고  
  - 실제 SSL 운영적용 시 웹 방화벽에 인증서 설치  
  - 웹방화벽을 통하지 않는 경우는 제외   
  
  
> 프로젝트에서 개발서버는 DMZ 밖에 있고 웹방화벽을 통하지 않아서 웹방화벽에 인증서 설치할 필요가 없었음.  
  

