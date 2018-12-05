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
*NODE      PORT = "80,443"

*VHOST    PORT = "443",
               SSLFLAG = Y,
               SSLNAME = "ssl1"

*SSL         CertificateFile = "<cert.pem>",
               CertificateKeyFile = "<newreq.pem>",
               CertificateChainFile = "<caChain.pem>",
               RequiredCiphers = "HIGH:MEDIUM:!SSLv2:!PSK:!SRP:!ADH:!AECDH:!EXP:!RC4:!IDEA:3DES"
~~~




- 참고  
  - 실제 SSL 운영적용 시 웹 방화벽에 인증서 설치  
  - 웹방화벽에 인증서 설치는 전산실에서 업체에 맡겨서 설치  
  - 35번 서버는 웹방화벽을 통하지 않음.  
  - 35번 서버는 DMZ 안에 있지 않음.  
  - SSL붙는데 사용하는 인터넷 프로토콜이 존재하는데 옛날 프토토콜로 접속시도해서 실패 했을 것임.  
  

