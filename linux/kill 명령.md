

### pid 찾기

`> ps -efc|grep 'server1'`  

### kill 명령어

 - kill -9 [pid]  
   - 프로세스 강제 종료  
 - kill -15 [pid]
   - 작업종료 개념  


`kill -9 ps -ef | grep 'PROCESS_NAME' | awk '{print $2}'``  

1. kill -9 프로세스 ID로 프로세스 중지하겠다.  
2. ps -ef 프로세스 전체출력.  
3. grep 'PROCESS_NAME' 프로세스 이름 검색.  
4. awk '{print $2}' 위에서 검색된 줄에서 2번째 항목(PDI) 출력.  
