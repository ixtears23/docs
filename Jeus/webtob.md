- webtob 홈 경로 확인  
`> printenv`  

- webtob 버전확인  
`> wscfl -v`  

- webtob license 확인  
`> jeusadmin -licensedue`  

- webtob license 경로  
`WEBTOBDIR/license`  

- http.m 환경설정 파일 경로
`WEBTOBDIR/config`  

- http.m 컴파일 명령어(컴파일 하면 해당경로에 wsconfig 파일 생성 됨)  
`> wscfl -i http.m`  

- webtob 서버 중지/가동 명령어  
`> wsdown`  
`> wsboot`  

- http.m 파일 ssl 적용  
  - ssl 관련 파일 저장  
  cert.pem, newreq.pem, caChain.pem  
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
  

