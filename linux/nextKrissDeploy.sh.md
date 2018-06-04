
- 이건 한번 나중에 찾아보자..
#!/bin/sh  

- 변수 선언 (변수명=값)
krissSource="/home1/ekriss/nextKriss";

1. jeus7 서버 중지 (cd 를 붙여주지 않은 이유는 뭘까나..)
/home1/ekriss/jeus7/bin/stopServer -host localhost:9710 -u administrator -p jeusadmin  

2. krissSource 경로 이동 후 design,META-INF,WEB-INF 폴더와 폴더의 하위 파일 모두 삭제.
cd $krissSource
rm -r /home1/ekriss/nextKriss/design
rm -r /home1/ekriss/nextKriss/META-INF
rm -r /home1/ekriss/nextKriss/WEB-INF

~~~
rm에 덧붙여 사용할 수 있는 옵션에는 다음과 같은 것이 있다.:

> -r, 디렉터리를 삭제한다, 하위의 내용을 먼저 삭제한다. (하위에 존재하는 파일이 남아있으면 안 되기 때문에) ("recursive", 재귀적으로)  
> -i, 삭제를 할 때에 매번 삭제 여부를 사용자에게 묻는다. ("interactive", 대화식으로)  
> -f, 존재하지 않는 파일을 무시하고 어떠한 확인 메시지도 보여주지 않는다. ("force", 강제로)  
> -v, 삭제를 하는 동안 삭제되는 내용을 보여준다 ("verbose", 장황하게)  
> rm은 실수로 삭제되는 것을 방지하기 위해 "rm -i"으로 alias 하여 많이 사용한다.  
이 경우 만약 이용자가 많은 양의 파일을 확인 없이 삭제하고자 할 때에는 -f 옵션을 붙여 사용한다.  
("rm -i -f"와 같이 두 옵션을 모두 지정한 경우 뒤쪽의 옵션이 우선순위를 갖게 된다.)  
~~~

3. krissSource 경로 이동 후 war 파일 풀기
cd $krissSource
jar -xvf $krissSource/web.krisstar-3.5.0.war
~~~
#### -cvf 압축하기  
tar -cvf [파일명.tar] [폴더명]  
> tar -cvf aaa.tar abc  
tar -zcvf [파일명.tar.gz] [폴더명]  
> tar -cvf aaa.tar.gz abc  
jar -cvf [파일명.jar] [폴더명]  
> jar -xvf aaa.jar abc  

#### -xvf 압출풀기  
> jar -xvf $krissSource/web.krisstar-3.5.0.war
~~~

4. krissSource 경로 이동 후 web.krisstar-3.5.0.war 파일이 존재하면 삭제
cd $krissSource
rm -f web.krisstar-3.5.0.war

5. jeus7 서버 시작
/home1/ekriss/jeus7/bin/jeusadmin -port 9700 -u administrator -p jeusadmin << EOF
start-server server1  
Exit  
EOF  

exit 0  
