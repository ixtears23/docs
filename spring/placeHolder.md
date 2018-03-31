

### 스프링 xml 설정에서 placeholder SPEL로 사용하는 방법
~~~xml
<context:property-placeholder location="classpath:org/uengine/uengine_#{ systemProperties['SYSTYPE']}.properties" />
~~~
**위 코드 처럼 `#{ systemProperties['SYSTYPE']} ` 스프링 `SPEL` 을 사용하려면**  
**`TOMCAT`에서 설정한다.**  

**톰캣 서버 탭에서 톰캣 서버를 더블클릭한다.**  
![01](./img/01.PNG)  

**Open launch configuration 을 클릭한다.**  
![02](./img/02.PNG)  

**아래 창이 뜬다.**  
**`-D` 옵션으로 `SYSTYPE`에 값을 주면**  
**`#{systemProperties['SYSTYPE']}` 으로 읽을 수 있다.**  
![03](./img/03.PNG)  



