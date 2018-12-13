


## <context-param>

이 태그는 전체 context/web application 에 parameter를 제공합니다.  

실제 테스트를 해봤습니다.

web.xml 코드
~~~xml
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:spring/application-config.xml</param-value>
    </context-param>
~~~

스프링 컨트롤러에서 테스트 해봤습니다.
~~~java
	@RequestMapping("/test")
	public String test(HttpServletRequest request) {
		
		String initParameter = request.getServletContext().getInitParameter("contextConfigLocation");
		
		LOG.debug("contextConfigLocation ::: {}", initParameter);
		
		return "test";
	}
~~~

아래는 ouput 입니다.
~~~console
DEBUG: annotation.spring.web.controller.OneController - contextConfigLocation ::: classpath:spring/application-config.xml
~~~

web.xml 설정에 context-param 으로 지정한 값이 출력 됐습니다.
