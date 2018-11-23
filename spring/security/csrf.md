#### CSRF 공격


 - CSRF 예방을위한 일반적인 요구 사항.
CSRF 공격으로부터 보호하기위한 첫 번째 단계는 웹 사이트가 적절한 HTTP 동사를 사용하는지 확인  
(애플리케이션이 상태를 수정하는 모든 것에 대해 PATCH, POST, PUT 및 DELETE 사용하는지 확인)  
HTTP GET에 개인 정보를 포함하면 정보가 유출 될 수 있기 때문  



2. CSRF 보호 구성

일부 프레임 워크는 사용자의 세션을 무효로하여 유효하지 않은 CSRF 토큰을 처리  
대신 기본적으로 Spring Security의 CSRF 보호는 HTTP 403 액세스가 거부되도록 만듭니다.  
InvalidCsrfTokenException을 다르게 처리하도록 AccessDeniedHandler를 구성하여 사용자 정의  

스프링 시큐리티 4.0부터 CSRF 보호는 기본적으로 XML 설정으로 가능합니다.  
CSRF 보호를 비활성화하려면 해당 XML 구성을 아래에 표시하십시오.  

~~~xml
<http>
    <!-- ... -->
    <csrf disabled="true"/>
</http>
~~~
~~~java
@EnableWebSecurity
public class WebSecurityConfig extends
WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .csrf().disable();
    }
}
~~~

3. CSRF 토큰을 포함 시키자

#### 양식(form) 제출  
마지막 단계는 모든 PATCH, POST, PUT 및 DELETE 메소드에 CSRF 토큰을 포함시키는 것입니다.  
이 문제에 접근하는 한 가지 방법은 `_csrf` 요청 속성을 사용하여 현재 `CsrfToken`을 얻는 것입니다.  
JSP로 이것을 수행하는 예제는 아래와 같습니다.  
~~~html
<c:url var="logoutUrl" value="/logout"/>
<form action="${logoutUrl}"
    method="post">
<input type="submit"
    value="Log out" />
<input type="hidden"
    name="${_csrf.parameterName}"
    value="${_csrf.token}"/>
</form>
~~~

더 쉬운 방법은 Spring Security JSP 태그 라이브러리의 csrfInput 태그를 사용하는 것입니다.  


Spring MVC `<form:form>` 태그 또는 Thymeleaf 2.1+을 사용하고 `@EnableWebSecurity`를 사용하는 경우  
`CsrfToken`이 자동으로 포함됩니다 (CsrfRequestDataValueProcessor 사용).  

#### Ajax 및 JSON 요청
JSON을 사용하는 경우 HTTP 매개 변수 내에서 CSRF 토큰을 제출할 수 없습니다.  
대신 HTTP 헤더 내에서 토큰을 제출할 수 있습니다.  
전형적인 패턴은 메타 태그 내에 CSRF 토큰을 포함하는 것입니다. 다음은 JSP 예제입니다.  

~~~html
<html>
<head>
    <meta name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <!-- ... -->
</head>
<!-- ... -->
~~~
메타 태그를 수동으로 생성하는 대신 Spring Security JSP 태그 라이브러리에서보다 간단한 csrfMetaTags 태그를 사용할 수 있습니다.  
그런 다음 모든 Ajax 요청 내에 토큰을 포함시킬 수 있습니다. jQuery를 사용했다면 다음과 같이 할 수있다.  
~~~javascript
$(function () {
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(document).ajaxSend(function(e, xhr, options) {
    xhr.setRequestHeader(header, token);
});
});
~~~

jQuery의 대안으로 cujoJS의 rest.js를 사용하는 것이 좋습니다.  
rest.js 모듈은 RESTful 방식으로 HTTP 요청 및 응답 작업을위한 고급 지원을 제공합니다.  
핵심 기능은 클라이언트에 인터셉터를 연결하여 필요에 따라 HTTP 클라이언트를 상황에 맞게 추가 할 수있는 기능입니다.  
~~~javascript
var client = rest.chain(csrf, {
token: $("meta[name='_csrf']").attr("content"),
name: $("meta[name='_csrf_header']").attr("content")
});
~~~


구성된 클라이언트는 CSRF 보호 자원에 요청해야하는 응용 프로그램의 모든 구성 요소와 공유 할 수 있습니다.  
rest.js와 jQuery의 중요한 차이점 중 하나는 구성된 클라이언트로 만들어진 요청에만 CSRF 토큰,  
즉 모든 요청에 토큰이 포함되는 jQuery가 포함된다는 것입니다.  
요청이 토큰을 받는 범위를 지정하는 기능을 통해 CSRF 토큰이 제 3자에게 유출되는 것을 방지 할 수 있습니다.  
rest.js에 대한 자세한 내용은 rest.js 참조 문서를 참조하십시오.  


#### 쿠키 Csrf 토큰 저장소

사용자가 CsrfToken을 쿠키에 유지하려는 경우가 있을 수 있습니다.  
기본적으로 CookieCsrfTokenRepository는 XSRF-TOKEN 이라는 쿠키에 쓰고 X-XSRF-TOKEN 또는 HTTP 매개 변수 _csrf라는 헤더에서 읽습니다.  
이러한 기본값은 AngularJS에서 가져옵니다.  

다음을 사용하여 XML로 CookieCsrfTokenRepository를 구성 할 수 있습니다.  
~~~xml
<http>
    <!-- ... -->
    <csrf token-repository-ref="tokenRepository"/>
</http>
<b:bean id="tokenRepository"
    class="org.springframework.security.web.csrf.CookieCsrfTokenRepository"
    p:cookieHttpOnly="false"/>
~~~

이 샘플에서는 명시 적으로 cookieHttpOnly = false를 설정합니다.  
이는 자바 스크립트 (즉, AngularJS)에서 읽을 수 있도록 하기 위해 필요합니다.  
JavaScript로 직접 쿠키를 읽을 필요가 없는 경우 보안을 향상 시키려면 cookieHttpOnly = false를 생략하는 것이 좋습니다.  

다음을 사용하여 Java Configuration에서 CookieCsrfTokenRepository를 구성 할 수 있습니다.  

~~~java
@EnableWebSecurity
public class WebSecurityConfig extends
        WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .csrf()
                .csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse());
    }
}
~~~
이 샘플에서는 명시 적으로 cookieHttpOnly = false를 설정합니다. 
이는 자바 스크립트 (즉, AngularJS)에서 읽을 수 있도록하기 위해 필요합니다.  
JavaScript로 직접 쿠키를 읽을 필요가없는 경우 보안을 향상시키기 위해  
cookieHttpOnly = false (new CookieCsrfTokenRepository ()를 대신 사용)를 생략하는 것이 좋습니다.  


## CSRF 경고

CSRF를 구현할 때 몇 가지주의 사항이 있습니다.  

#### Timeouts

한 가지 문제는 예상 된 CSRF 토큰이 HttpSession에 저장되므로 HttpSession이 만료되는 즉시  
구성된 AccessDeniedHandler가 InvalidCsrfTokenException을 수신한다는 것입니다.  
기본 AccessDeniedHandler를 사용하는 경우 브라우저에 HTTP 403이 표시되고 오류 메시지가 표시됩니다.  

일반적으로 예상 CsrfToken이 쿠키에 기본적으로 저장되지 않는 이유를 묻습니다.  
이는 다른 도메인에서 헤더 (즉, 쿠키를 지정)를 설정할 수있는 알려진 취약점이 있기 때문입니다.  
이것은 X-Requested-With 헤더가있을 때 Ruby on Rails가 CSRF 검사를 더 이상 건너 뛰지 않는 것과 같은 이유입니다.  
익스플로잇 수행 방법에 대한 자세한 내용은이 webappsec.org 스레드를 참조하십시오.  
또 다른 단점은 상태 (즉, 타임 아웃)를 제거하면 토큰이 손상된 경우 강제로 종료 할 수 없다는 것입니다.  

타임 아웃이 발생한 활성 사용자를 완화하는 간단한 방법은 세션이 만료 될 예정임을 알리는 JavaScript를 사용하는 것입니다.  
사용자는 버튼을 클릭하여 세션을 계속 진행하고 새로 고칠 수 있습니다.  

또는 사용자 지정 AccessDeniedHandler를 지정하면 원하는 방식으로 InvalidCsrfTokenException을 처리 할 수 있습니다.  
AccessDeniedHandler를 사용자 정의하는 방법의 예는 xml 및 Java 구성에 대해 제공된 링크를 참조하십시오.  

마지막으로, 만료되지 않을 CookieCsrfTokenRepository를 사용하도록 애플리케이션을 구성 할 수 있습니다.  
앞서 언급했듯이, 이것은 세션을 사용하는 것만 큼 안전하지는 않지만, 많은 경우에 충분할 수 있습니다.  


#### 로그인

로그인 요청을 위조하는 것을 방지하기 위해 CSRF 공격에 대해서도 로그인 양식을 보호해야합니다.  
CsrfToken은 HttpSession에 저장되므로 CsrfToken 토큰 속성에 액세스 하는 즉시 HttpSession이 만들어집니다.  
RESTful/stateless 아키텍처에서는 이것이 좋지 않지만 현실은 실질적인 보안을 구현하는 데 상태가 필요하다는 것입니다.  
국가가 없으면 토큰이 손상되면 아무 것도 할 수 없습니다.  
실질적으로 말해서, CSRF 토큰은 크기가 아주 작아서 아키텍처에 거의 영향을 미치지 않아야합니다.  
양식을 로그에 저장하는 일반적인 방법은 양식 제출 전에 유효한 CSRF 토큰을 얻기 위해 JavaScript 함수를 사용하는 것입니다.  
이렇게하면 이전에 설명한 세션 시간 초과에 대해 생각할 필요가 없습니다.  
그 이유는 세션이 양식 제출 직전에 만들어지기 때문입니다(대신 CookieCsrfTokenRepository가 구성되지 않았다는 가정하에).  
사용자가 로그인 페이지에 머무를 수 있습니다.  
원하는 경우 사용자 이름/암호를 제출하십시오.  
이를 달성하기 위해 Spring Security가 제공하는 CsrfTokenArgumentResolver를 활용하고 여기에 설명 된 것과 같은 엔드 포인트를 노출 할 수 있습니다.  

#### 로그아웃
CSRF를 추가하면 HTTP POST 만 사용하도록 LogoutFilter가 업데이트됩니다.  
이렇게하면 로그 아웃시 CSRF 토큰이 필요하며 악의있는 사용자는 강제로 사용자를 로그 아웃 할 수 없습니다.  
하나의 접근법은 양식을 사용하여 로그 아웃하는 것입니다.  
링크가 실제로 필요한 경우 자바 스크립트를 사용하여 링크가 POST를 수행하도록 할 수 있습니다 (즉 숨겨진 양식 일 수 있음).  
JavaScript가 비활성화 된 브라우저의 경우 선택적으로 링크를 통해 POST를 수행 할 로그 아웃 확인 페이지로 이동할 수 있습니다.  
정말로 HTTP GET을 로그 아웃과 함께 사용하고 싶다면 그렇게 할 수는 있지만, 일반적으로 권장하지는 않는다.  
예를 들어, 다음 Java 구성은 URL/로그 아웃이 HTTP 메소드로 요청되면 로그 아웃을 수행합니다.  

~~~java
@EnableWebSecurity
public class WebSecurityConfig extends
WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .logout()
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"));
    }
}
~~~
 
### Multipart (file upload)
CSRF 보호를 multipart / form-data와 함께 사용하는 데는 두 가지 옵션이 있습니다. 각 옵션에는 절충점이 있습니다.  

Spring Security의 CSRF 보호와 다중 파일 업로드를 통합하기 전에 먼저 CSRF 보호없이 업로드 할 수 있는지 확인하십시오.  
Spring에서 multipart 폼을 사용하는 것에 대한 더 많은 정보는  
Spring 레퍼런스와 MultipartFilter javadoc의 17.10 Spring의 multipart (파일 업로드) 지원 섹션에서 찾을 수있다.  

#### 스프링 보안 이전에 MultipartFilter 배치하기

첫 번째 옵션은 Spring Security 필터 전에 MultipartFilter가 지정되었는지 확인하는 것입니다.  
Spring Security 필터를 사용하기 전에 MultipartFilter를 지정하면 MultipartFilter를 호출 할 권한이 없다는 것을 의미합니다.  
이는 누군가가 서버에 임시 파일을 배치 할 수 있음을 의미합니다.  
그러나 권한이 부여 된 사용자 만 응용 프로그램에서 처리하는 파일을 제출할 수 있습니다.  
일반적으로 이것은 임시 파일 업로드가 대부분의 서버에 무시할 수있는 영향을 미치므로 권장되는 방법입니다.  

Java 구성을 사용하는 Spring Security 필터 전에 MultipartFilter가 지정되도록하려면  
사용자는 beforeSpringSecurityFilterChain을 다음과 같이 무시할 수 있습니다.  
~~~java
public class SecurityApplicationInitializer extends AbstractSecurityWebApplicationInitializer {

    @Override
    protected void beforeSpringSecurityFilterChain(ServletContext servletContext) {
        insertFilters(servletContext, new MultipartFilter());
    }
}
~~~

XML 구성을 사용하여 Spring Security 필터 앞에 MultipartFilter를 지정하려면  
MultipartFilter의 <filter-mapping> 요소가 아래 표시된 것처럼 web.xml의 springSecurityFilterChain 앞에 있어야합니다.  
~~~xml
<filter>
    <filter-name>MultipartFilter</filter-name>
    <filter-class>org.springframework.web.multipart.support.MultipartFilter</filter-class>
</filter>
<filter>
    <filter-name>springSecurityFilterChain</filter-name>
    <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
</filter>
<filter-mapping>
    <filter-name>MultipartFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
<filter-mapping>
    <filter-name>springSecurityFilterChain</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
~~~

#### 실행중인 CSRF 토큰 포함
권한이없는 사용자가 임시 파일을 업로드하는 것을 허용 할 수 없다면,  
Spring Security 필터 뒤에 MultipartFilter를 놓고 폼의 action 속성에 CSRF를 쿼리 매개 변수로 포함 시키십시오.  
jsp를 사용한 예가 아래에 나와 있습니다.  
~~~html
<form action="./upload?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
~~~
이 접근법의 단점은 쿼리 매개 변수가 유출 될 수 있다는 것입니다.  
더 진부하게, 유출되지 않도록 본문 또는 헤더 내에 중요한 데이터를 배치하는 것이 가장 좋습니다.  
추가 정보는 RFC 2616 섹션 15.1.3 URI의 중요한 정보 인코딩에 있습니다.  

#### HiddenHttpMethodFilter
HiddenHttpMethodFilter는 Spring Security 필터 앞에 위치해야합니다.  
일반적으로 이것은 사실이지만 CSRF 공격으로부터 보호 할 때 추가적인 의미를 가질 수 있습니다.  

HiddenHttpMethodFilter는 POST에서 HTTP 메서드를 재정의하므로 실제적인 문제는 거의 발생하지 않을 것입니다.  
그러나 Spring Security의 필터 앞에 배치하는 것이 가장 좋습니다.






 
