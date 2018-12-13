
# web.xml

[metawerx 사이트](http://wiki.metawerx.net) 를 참고 했습니다.  

## context-param

`<context-param>` 태그는 전체 `context/web application` 에 `parameter`를 제공합니다.  

실제 테스트를 해봤습니다.  

`web.xml` 코드
~~~xml
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:spring/application-config.xml</param-value>
    </context-param>
~~~

`spring` `Controller` 에서 테스트 해봤습니다.
~~~java
	@RequestMapping("/test")
	public String test(HttpServletRequest request) {
		
		String initParameter = request.getServletContext().getInitParameter("contextConfigLocation");
		
		LOG.debug("contextConfigLocation ::: {}", initParameter);
		
		return "test";
	}
~~~

아래는 `ouput` 입니다.
~~~console
DEBUG: contextConfigLocation ::: classpath:spring/application-config.xml
~~~

`web.xml` 설정에 `context-param` 으로 지정한 값이 출력 됐습니다.  


## init-param
`<init-param>` 태그는 단일 `servlet` 또는 `filter`에 `parameter`를 제공합니다.  
`<param-name>` 은 `parameter`명 입니다.  
`<param-value>` 는 값 입니다.  

실제 테스트 입니다.  
~~~xml
    <servlet>
        <servlet-name>dispatcherServlet</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>/WEB-INF/mvc-web-config.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>
~~~

동일하게 `spring Controller`에서 테스트 했습니다.
~~~java
	@Autowired
	private ServletConfig servletConfig;
	
	@RequestMapping("/test")
	public String test(HttpServletRequest request) {
		
		String servletInitParam = servletConfig.getInitParameter("contextConfigLocation");
		LOG.debug("servletInitParam ::: {}", servletInitParam);
		
		return "test";
	}
~~~

`output` 입니다.
~~~console
DEBUG: servletInitParam ::: /WEB-INF/mvc-web-config.xml
~~~

