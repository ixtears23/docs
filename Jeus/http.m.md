
##### 필수항목
1)	Domain Name = string
31자 이내의 string 형식으로 정의한다. 31자를 초과하는 이름을 사용할 경우, 컴파일 에러는 나지 않으나, 내부적으로 31자까지만 인식하게 된다.  
31자 이내로 이름을 설정하게 되어있는 기타 다른 절들의  항목에서도 이 점은 동일하다.  
Domain 이름은 호스트 이름과 함께 암호화 되어 시스템의 License 확인에 사용된다.  
~~~
*DOMAIN
 JEUS_Web_Server1
~~~
위의 예는 도메인 절을 정의하고 있다.  
JEUS_Web_Server1은 도메인의 이름으로, DOMAIN절에서 정의되어야 하는 유일한 필수 항목이다.   


##### 필수항목
1)	Node Name = string 31자 이내의 string으로 정의한다.  
31자를 초과하는 이름을 사용 할 경우 에는 컴파일 에러는 나지 않으나 내부적으로 31자까지만 인식한다.  
Node 이름은 실제 등록된 Host의 이름을 말한다. 예를 들어 UNIX의 경우 “uname –n” 명령으로 각 Host의 이름을 확인할 수 있다.   
또한 해당 Node명은 반드시 “/etc/hosts” 파일에 등록되어 있어야 한다.   
하나의 Domain은 하나 이상의 Node로 이루어지므로, NODE절에는 최소한 하나 이상의 Node 이름이 정의되어야 한다.  
2)	WEBTOBDIR = literal  
크기 : 255자 이내.  
3)	SHMKEY = numeric (32768 ~ 262143)  
공유 메모리 세그먼트(Shared Memory Segment)를 가리키는 값이다.  
JEUS Web Server를 이루는 Process들이, 서로 정보를 공유하기 위한 공유 메모리 Key값을 정의할 필요가 있다.  
공유 메모리 Key 값을 정의하기 전에 이 Key 값들이, 다른 프로그램 또는 다른 업무에서 사용되는지 반드시 확인해야 한다.  
그렇지 않으면 JEUS Web Server가 Booting시에 이 프로그램과 충돌을 일으켜서 실행이 되지 않는다.   
현재 JEUS Web Server에서 정의되는 Shared Memory의 Key값은 최소 32768에서 최대 262143까지 이다.  
따라서, 이 범위 내에 있는 값을 이용하면 된다.  

4)	DOCROOT = literal  
JEUS Web Server가 Web을 통해 Service 하는 **모든 문서를 포함하는 루트 디렉토리의 경로**이다.  
즉, JEUS Web Server는 DOCROOT가 지정한 디렉토리를 최상위로 하여 문서를 Service하게 된다.  
Client가 요구한 URL은 DOCROOT의 경로 뒤에 추가되어 실제 경로명을 이루게 된다.   
JEUS Web Server는 이 경로를 가지고 파일에 접근하게 된다.   

##### 선택항목
1)	HTH = numeric	(Default Number: 1, Max Number: 20)  
JEUS Web Server에서 가장 중요한 역할을 담당하고 있는 HTH (HTTP Request Handler) Process의 개수를 설정한다.  
HTH는 실질적으로 Client Browser와 JEUS Web Server 내부 Service Process 사이를 중계하는 Process이다.  
즉, Client의 요청을 받아 Service를 받을 수 있도록 적당한 Process에 넘겨주고, 다시 처리된 결과를 수신하여 Client에게 되돌려 준다.  
JEUS Web Server에서는 모든 Client가 이 HTH Process에 연결되도록 설계되어 있다.  
따라서 많은 수의 동시 접속자를 유지하기 위해서는 이 수를 적당히 늘려주는 것도 필요하다.  
그러나 보통 하나의 HTH Process가 적어도 800개 이상의 Client를 수용할 수 있기 때문에 하나의 HTH로도 큰 문제는 되지 않을 것이다.  
만약 1000명 이상의 동시 사용자를 수용하여야 하는 시스템에서는, 두 개 이상의 HTH Process를 구동하여야 한다.  
현재 JEUS Web Server에서는 최대 20개까지의 HTH Process를 구동하는 것이 가능하다.  
따라서 약 16000명의 사용자를 동시에 처리하는 것이 가능하다.  

2)	PORT = literal	(Default Port: 80)  
JEUS Web Server의 HTTP Listener 포트 번호를 설정한다.  
이는 기본적으로 Web Service를 하기 위해서는 반드시 필요한 설정으로, 이 항목은 반드시 설정해야 한다.  
보통 일반적인 Web Server는 80 Port를 이용한다.  
그러므로 이 항목을 설정하지 않았을 경우에는 default로 80 Port가 설정된다.  
그러나 다른 용도나 Internet 등의 경우에는 임의의 Port를 설정하여 이용할 수 있다.  
Virtual Host를 사용하는 경우, Port 번호는 VHOST 절에서 재정의 해야 한다.  
또한, JEUS Web Server의 경우 여러 개의 Port를 동시에 정의하는 것도 가능하다.  
현재는 최대 10개의 Port를 동시에 설정하는 것이 가능하다.  
즉, PORT의 설정을 통해서 여러 개의 Port가 동시에 Listen하는 것이 가능하다는 것이다.  
이에 대한 간단한 예는 다음과 같다.
PORT = “9090, 9091”
위와 같은 Setting이 이루어지면, JEUS Web Server는 9090과 9091 Port에서 모두 Web Service를 받아들일 수 있다.   
한가지 주의할 점은 이것은 Listen 항목과 동시에 운영할 수 없다는 것이다.  
Listen 항목에서 특정 Port를 지정하는 경우 이 Port만을 이용하게 된다.  
즉, 중요한 것은 Listen 항목에서 지정된 Port가 PORT 항목에서 지정된 것보다 우선된다는 것이다.  
물론 Listen 항목에서도 여러 개의 Port를 지정하는 것이 가능하다. 이에 대한 예는 Listen 항목의 설명에서 할 것이다.  

7)	HostName = literal  
이 항목을 설정하면 Http Response Header의 host name Field에 기록을 남겨준다.  
JEUS Web Server 가 설치된 machine의 Domain name을 “www.tmax.co.kr”과 같이 넣어주면 된다.  

8)	JSVPort = numeric 	(Default Port: 9999)  
JEUS Web Server 와 Java Servlet 수행 Server간의 연결 Port 번호이다 .  

20)	IndexName = literal (Default : index.html)  
Client가 특정 파일 이름을 지정하지 않고 Service Directory에 요구를 보낼 때 기본적으로 Service되는 파일 이름을 설정한다.   
따로 설정하지 않으면 index.html이 설정된다.    

26)	Logging = literal  
뒤의 Logging절에서 설정하는 Logging Name을 써준다. 이 이름을 가지고 이 Node에서 그에 해당하는 Log를 남기게 되는 것이다.  

28)	ErrorLog = literal  
오류 발생시 설정하는 Logging 정보 이름을 써준다. 이 이름 또한 뒤의 Logging절에서 설정하는 Logging Name을 써준다.  

4.3.3	SVRGROUP 절  
JEUS Web Server 를 통해 응용 Server Process를 접근하는 경우  
Server Process의 논리적인 연관성에 따라 이들을 그룹으로 관리할 필요가 있게 된다.  
이 절에서는 이러한 그룹에 대한 환경 설정이 이루어 진다. Node 이름, Server의 종류, 호스트의 이름 등을 등록한다.   
이 밖에 NODE 절이나 VHOST절에서 정의한 내용이 Server Group 에 따라 새롭게 정의할 수 있으며  
데이터베이스를 사용하는 경우 데이터 베이스 접근과 관련된 정보들이 정의될 수 있다.  
SVRGROUP 절에는 기본적으로 다음과 같은 내용이 정의될 수 있다:  
~~~
SVRGROUP Name	NODENAME,SVRTYPE
[,VhostName][,Cousin][,Backup][,Load]
[,AppDir][,UsrLogDir][,AuthentName][,DBName]
[,OpenInfo][,CloseInfo][,MinTms][,MaxTms]
[,LOGGING][,EnvFile]
~~~

 - Server Group name = string  
크기 : 31자 이하  
Server Group에 대한 논리적인 이름으로서 SVRGROUP절 내에서 유일한 값이어야 한다.  
SVRGROUP절 이름은 SERVER 절의 SVGNAME 항목에서 사용된다.  

 - NODENAME = string  
Server Group이 존재하는 Node를 정의한다.  
사용되는 NODENAME은 NODE 절에서 정의한 Node 이름이어야 하며, Node 이름은 유닉스 명령어 “uname -n”을 이용해서 확인해 볼 수 있다.  

- SVRTYPE = string  
Server Group의 속성, 즉 어떠한 Service를 제공하는가를 명시한다.  
Server 타입으로 HTML, CGI, JSV, WEBSTD, TPSTD, SSI 등을 명시할 수 있다.  

4.3.4	SERVER 절  
SERVER절에서는 실질적으로 제공하는 Service들을 등록한다.  
JEUS Web Server 는 등록된 Service만을 처리하기 때문에  
새로운 Server 프로그램이 추가되는 경우 Server절의 환경파일에 반드시 등록하여야 한다.  
JEUS Web Server 가 제공하는 대부분의 Service는 SERVER 절에서 등록이 가능하며  
비즈니스 로직을 JEUS Web Server 를 통해 직접 호출하는 경우에만 SERVICE 절의 등록이 필요하다.  
각각의 Server는 위의 Server Group절에 정의된 Service 종류에 따라 HTML, CGI, JSV 등으로 구분되며  
Server Group 이름과 Process의 가능한 개수 등이 같이 등록된다.   
SERVER절에는 다음과 같은 내용이 정의된다:   

- 각 Server Process가 속하는 Server Group.  
- Server Process의 최소 개수와 최대 개수.  
SERVER절의 기본 형식은 다음과 같다:  
~~~
ServerName		SVGNAME=server-group-name,
[,Clopt][,SeqNo][,MinProc][,MaxProc]
[,UsrLogDir][,UriDir][,MaxQCount]
[,ASQCount][,MaxRestart][,SvrCPC]
[,SVRTYPE]
~~~

##### 필수항목
 - Server Name = string   
크기 :  31자 이하   
Server의 실행 파일 이름으로서 일반적으로 Server 이름은 유일(Unique) 해야 한다.  
즉 하나의 Server 이름은 SERVER절에 단 한번만 정의되어야 한다.  
같은 이름을 중복하여 이용하면 환경 파일의 Compile시에 Error가 발생하게 된다.   


 - SVGNAME = string   
Server가 속해 있는 Server Group을 정의한다.  
여기에 사용되는 값은 반드시 SVRGROUP 절에서 정의된 Server Group 이름이어야 한다.  
Server와 SVRGROUP 절의 연결을 통해서 Server가 어떤 Node에서 동작할 것인지,  
어떤 리소스 매니저(데이터 베이스)를 사용하는지 알 수 있으며. 해당 리소스 매니저를 열 때 필요한 파라미터를 넘겨 줄 수 있다.  
