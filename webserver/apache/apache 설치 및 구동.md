
# apache 설치 및 구동
다운로드 사이트: [https://www.apachelounge.com/download/](https://www.apachelounge.com/download/)  

![apache](https://github.com/ixtears23/docs/blob/master/webserver/apache/img/apache01.PNG?raw=true)  

1. vc redist x64를 다운로드 합니다.  
  다운로드 받은 파일을 실행해서 Visual C++ 을 설치 합니다.  
  ![apache](https://github.com/ixtears23/docs/blob/master/webserver/apache/img/apache02.PNG?raw=true)  

2. Apache 2.4.37 Win64를 다운로드 합니다.  

---

3. 다운로드한 파일의 압축을 해제합니다.  
![apache](https://github.com/ixtears23/docs/blob/master/webserver/apache/img/apache07.PNG?raw=true)  

---

4. 압축을 해제한 뒤 Apache24 폴더만 webserver 경로로 지정할 위치에 옮겨 놓습니다.  
![apache](https://github.com/ixtears23/docs/blob/master/webserver/apache/img/apache08.PNG?raw=true)  

---

5. Apache24/conf 폴더로 이동해서 httpd.conf 파일을 실행 합니다.  
![apache](https://github.com/ixtears23/docs/blob/master/webserver/apache/img/apache09.PNG?raw=true)

---

6. httpd.conf 파일을 수정합니다.  
수정할 목록은 아래와 같습니다.
 - ServerRoot  
 ![apache](https://github.com/ixtears23/docs/blob/master/webserver/apache/img/apache03.PNG?raw=true)
 - ListenPort
 ![apache](https://github.com/ixtears23/docs/blob/master/webserver/apache/img/apache04.PNG?raw=true)
 - ServerName
 ![apache](https://github.com/ixtears23/docs/blob/master/webserver/apache/img/apache05.PNG?raw=true)
 - DocumentRoot
![apache](https://github.com/ixtears23/docs/blob/master/webserver/apache/img/apache06.PNG?raw=true)





