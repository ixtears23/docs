


### 서버폴더파일목록
![toacat서버](./img/server.GIF "서버폴더파일목록")  

tomcat 서버 파일 수정
 - server.xml
 - context.xml
 - web.xml


### server.xml

`GlobalNamingResources` 태그안에  
`Resource` 추가  

~~~xml
<Resource auth="Container" defaultAutoCommit="false" driverClassName="com.tmax.tibero.jdbc.TbDriver"
            maxIdle="10" maxTotal="20" maxWaitMillis="-1" name="jdbc/homepageDS" password="password"
            type="javax.sql.DataSource" url="jdbc:tibero:thin:@ip:port:sid" username="username"/>
~~~

![toacat서버](./img/server.xml.GIF "server.xml")  

### context.xml
![toacat서버](./img/context.xml.GIF "context.xml")  

### web.xml
![toacat서버](./img/web.xml.GIF "web.xml")  

