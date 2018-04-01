



## JSP 컴파일 위치

1. `TomcatServer`를 더블클릭한다.  
![이미지제목](./img/JSP컴파일03.PNG "이미지제목")  
  
2. `Open launch configuration` 를 클릭한다.  
![이미지제목](./img/JSP컴파일02.PNG "이미지제목")  
  
3. `Arguments` 탭을 클릭하고 `VM arguments:` 를 확인한다.
![이미지제목](./img/JSP컴파일01.PNG "이미지제목")

~~~
-Dcatalina.base="C:\dev\spring-workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0" 
~~~
`Dcatalina.base` 경로 아래에  
`\work\Catalina\localhost\` 경로에 컴파일 된다.  

![이미지제목](./img/JSP컴파일04.PNG "이미지제목")
