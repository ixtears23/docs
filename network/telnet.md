
# telnet 접속방법


### window 10 환경설정
- 윈도우에서 telnet 사용시  
제어판 > 프로그램 > 프로그램 및 기능 > Windows 기능 사용/사용 안 함 > 텔넷 클라이언트 '체크' > 확인  

 
### ping
> ~~해당 컴퓨터가 올바르게 인터넷에 연결되어 있는지 확인할 때 사용한다.~~  
`> ping [ip]`  
`> ping [domain]`  

도메인을 입력하고 ping 명령어를 사용하면 해당 도메인에 대한 ip를 알 수 있다.  

예) `ping 210.10.254.235`  
예) `ping www.naver.com` 

### telnet
`> telnet [ip] [port]`  
예) `telnet 210.100.254.32 542`  

### tracert
> traceroute 혹은 tracert는 인터넷을 통해 거친 **경로를 표시**하고 그 **구간의 정보를 기록**하고
인터넷 프로토콜 네트워크를 통해 패킷의 전송 지연을 측정하기 위한 컴퓨터 네트워크 진단 유틸리티이다.  
특정 


`> tracert [ip]`  
예) `tracert 210.100.254.32 542`  




`TODO`  
telnet으로 smtp서버에 메일 전송  



