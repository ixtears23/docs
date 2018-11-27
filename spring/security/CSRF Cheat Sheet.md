# [CSRF 치트 시트](https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)_Prevention_Cheat_Sheet)

## 소개
[CSRF(Cross-Site Request Forgery)](https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF))는 
악의적인 웹 사이트, 전자 메일, 블로그, 인스턴트 메시지 또는 프로그램으로 인해  
사용자가 인증한 신뢰할 수 있는 사이트에서 원치 않는 작업을 수행 할 때 발생하는 공격 유형입니다.  
브라우저 요청이 사용자의 세션 쿠키, IP 주소 등과 같이 사이트와 관련된 자격 증명을 자동으로 포함하기 때문에 CSRF 공격이 작동합니다.  
따라서 사용자가 사이트에 대해 인증을 받으면 사이트는 희생자가 보낸 위조 된 요청이나 합법적 인 요청을 구분할 수 없습니다.  
공격자가 액세스 할 수 없으며 공격자가 시작하는 위조 된 요청과 함께(쿠키와 같이) 전송되지 않는 토큰/식별자가 필요합니다.  
CSRF에 대한 자세한 내용은 OWASP [CSRF(Cross-Site Request Forgery)](https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)) 페이지를 참조하십시오.  

성공적인 CSRF 공격의 영향은 취약한 응용 프로그램에 의해 노출되는 기능으로 제한됩니다.  
예를 들어,이 공격으로 자금 이체, 암호 변경 또는 사용자 자격 증명으로 구매할 수 있습니다.  
실제로 CSRF 공격은 사용자가 인지하지 못하는 상태에서 트랜잭션이 커밋 되도록 대상 브라우저를 통해 사용됩니다.  

성공적인 CSRF 공격의 영향은 각 희생자의 권한에 따라 크게 달라집니다.  
일반 사용자를 대상으로 할 때 CSRF 공격이 성공하면 최종 사용자 데이터 및 관련 기능이 손상 될 수 있습니다.  
대상 최종 사용자가 관리자 계정 인 경우 CSRF 공격은 전체 웹 응용 프로그램을 손상시킬 수 있습니다.  
소셜 엔지니어링을 사용하여 공격자는 전자 메일이나 웹 사이트에 악의적인 HTML 또는 JavaScript 코드를 포함시켜 
특정 '작업 URL'을 요청할 수 있습니다.  
그런 다음 작업은 직접 또는 크로스 사이트 스크립팅 결함을 사용하여 사용자의 의도와는 상관없이 실행됩니다.  
예를 들어, [Samy MySpace Worm](https://en.wikipedia.org/wiki/Samy_(computer_worm))을 참조하십시오.  


## 새로운 것은 무엇입니까?
OWASP의 오래된 CSRF 예방 치트 시트를 본 적이 있다면 이 새로운 버전에서 많은 변화가 있음을 알 수 있습니다.  
주요 변경 사항 중 하나는 "표준 헤더로 동일한 출처 확인" CSRF 방어가 심층 방어 섹션으로 이동되었지만  
토큰 기반 완화는 기본 방어 섹션으로 이동되었습니다(이 스위치에 대한 기술적 인 이유가 각 섹션에 추가됨).  
새로운 섹션 추가(HMAC 기반 토큰 보호, 자동 CSRF 완화 기술, 로그인 CSRF, 널리 사용되지 않는 CSRF 완화 및 CSRF 완화 신화)는  
새로운 컨텐츠를 추가하는 것 외에도 기존 섹션에 쓸모없는 컨텐츠를 제거 하였습니다.  
각 완화와 관련된 보안 문제/의 사항도 포함되었습니다.

## 경고 : XSS (Cross-Site Scripting) 취약점 없음
CSRF가 작동하려면 (Cross-Site Scripting)이 필요하지 않습니다.  
그러나 모든 Cross-Site Scripting 취약점을 사용하여 현재 시장에서 사용 가능한 모든 CSRF 완화 기술을 무력화 할 수 있습니다  
(사용자 상호 작용과 관련된 완화 기술은 나중에 설명합니다).  
이는 XSS 페이로드가 XMLHttpRequest (동일한 페이지에있는 경우 직접 DOM 액세스가 가능함)를 사용하여 사이트의 모든 페이지를  
간단히 읽을 수 있고 응답에서 생성 된 토큰을 얻고 위조 된 요청과 함께 해당 토큰을 포함하기 때문입니다.  
이 기술은 [MySpace (Samy)](https://en.wikipedia.org/wiki/Samy_(computer_worm))
웜이 2005 년 MySpace의 anti-CSRF 방어를 무력화시켜 웜 전파를 가능하게했습니다.  

CSRF 방어가 회피 될 수 없도록하는 XSS 취약점이 존재하지 않도록하는 것이 필수적입니다.  
XSS 결함을 방지하는 방법에 대한 자세한 지침은 [OWASP XSS 예방 치트 시트](https://www.owasp.org/index.php/XSS_(Cross_Site_Scripting)_Prevention_Cheat_Sheet)를 참조하십시오.  

## CSRF 취약점으로부터 보호되어야하는 리소스
다음 목록에서는 상태 변경 작업에 GET 요청을 사용하여 [RFC2616, 9.1.1절](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.1.1)을 위반하지 않는다고 가정합니다.  
참고 : 위반한 경우 해당 자원을 보호해야합니다. 대부분이 기본 양식 태그 [GET 메소드], href 및 src 속성으로 수행됩니다.  
- POST를 사용한 form 태그  
- Ajax/XHR 호출  

CSRF 국방 권고 요약
토큰 기반 CSRF 방어 (상태 저장/상태 비 저장)를 응용 프로그램의 CSRF를 줄이기 위한 기본 방어책으로 사용할 것을 권장합니다.  
매우 민감한 작업의 경우에만 토큰 기반 완화와 함께 사용자 상호 작용 기반 보호 (6.5 절에서 자세히 설명한 재 인증/일회용 토큰)를 권장합니다.  
심층 방어 차원에서 심층 완화 (Deep Depth Mitigations) 섹션에서 하나의 완화를 구현하는 것을 고려하십시오 (해당 문제에서 언급 한 문제를 고려하여 귀하의 생태계에 맞는 완화를 선택할 수 있습니다).  
이러한 심층 방어 완화 기법은 응용 프로그램에서 CSRF를 완화하기 위해 토큰 기반 완화없이 자체적으로 사용하는 것은 좋지 않습니다.  

## Primary Defense Technique

### 토큰 기반 완화
이 방어는 CSRF를 완화하기 위한 가장 보편적이며 권장되는 방법 중 하나입니다.  
상태 (동기화 기 토큰 패턴) 또는 상태 비 저장 (암호화/해시 기반 토큰 패턴) 중 하나를 사용하여 수행 할 수 있습니다.  
애플리케이션에서 로그인 CSRF를 완화하는 방법은 4.3 절을 참조하십시오.  
모든 완화 조치에 있어 일반적인 보안 원칙을 준수해야한다는 것은 암시 적입니다.  
- 강력한 암호화 / HMAC 기능을 준수해야합니다.  
참고 : 조직의 필요에 따라 알고리즘을 선택할 수 있습니다. 암호화에는 AES256-GCM을, HMAC에는 SHA256/512를 권장합니다.  
엄격한 키 순환 및 토큰 수명 정책을 유지해야합니다.  
정책은 조직의 필요에 따라 설정할 수 있습니다. OWASP의 일반 키 관리 지침은 [여기](https://www.owasp.org/index.php/Key_Management_Cheat_Sheet)에서 찾을 수 있습니다.  

#### 동기화 토큰 패턴
임의의 상태 변경 동작은 CSRF 공격을 방지하기 위해 안전한 랜덤 토큰 (예 : CSRF 토큰)을 요구한다.  
CSRF 토큰은 사용자 세션마다 고유해야하며 큰 임의 값을 가져야하며 암호로 안전한 난수 생성기로 생성되어야합니다.  
CSRF 토큰은 AJAX 호출의 양식 헤더/매개 변수에 대한 숨김 필드로, GET을 통해 상태 변경 작업이 발생하면 URL 내에 추가됩니다.  
아래의 "URL에 토큰 공개"절을 참조하십시오. CSRF 토큰이 유효성 검사에 실패하면 서버는 요청 된 작업을 거부합니다.  

"투명하지만 가시적 인"CSRF 솔루션을 용이하게하기 위해 개발자는 동기화 토큰 패턴과 유사한 패턴을 채택하는 것이 좋습니다(이 동기화 프로그램 토큰 패턴의 원래 의도는 양식에서 중복 제출을 탐지하는 것이 었습니다).  
[싱크로 나이저 토큰 패턴](http://www.corej2eepatterns.com/Design/PresoDesign.htm)은 사용자의 현재 세션과 관련된 임의의 "챌린지"토큰을 생성해야합니다.  
이 챌린지 토큰은 중요한 서버 측 작업과 관련된 HTML 양식 및 호출 내에 삽입됩니다.  
이 토큰의 존재와 정확성을 확인하는 것은 서버 응용 프로그램의 책임입니다.  
개발자는 각 요청에 도전 토큰을 포함시킴으로써 사용자가 실제로 원하는 요청을 제출할 의도가 있는지를 확인할 수 있습니다.  
민감한 비즈니스 기능과 관련된 HTTP 요청에 필요한 보안 토큰을 포함하면 CSRF 공격을 완화하는 데 도움이됩니다.  
공격자가 대상 피해자의 세션에 대해 임의로 생성 된 토큰을 알고 있다고 가정합니다.  

참고 :이 토큰은 침입자 웹 사이트에서 브라우저로 만들어진 위조 된 요청으로 자동 전송되는 쿠키와 같지 않습니다.  
이것은 공격자가 목표 피해자의 세션 식별자를 추측 할 수있는 것과 유사합니다.  
다음은 요청 내에 챌린지 토큰을 통합하는 일반적인 방법을 설명합니다.  

웹 응용 프로그램이 요청을 공식화 할 때 응용 프로그램에는 Ajax 호출의 헤더/매개 변수 값/"CSRFToken"(양식의 경우)과 같은  
공통 이름의 숨겨진 입력 매개 변수가 포함되어야합니다.  
이 토큰의 값은 공격자가 추측 할 수 없도록 임의로 생성되어야합니다.  
Java 응용 프로그램에 대해 java.security.SecureRandom 클래스를 사용하여 충분히 긴 임의의 토큰을 생성하는 것을 고려하십시오.  
대체 생성 알고리즘에는 256 비트 BASE64로 인코딩 된 해시가 포함됩니다.  
이 생성 알고리즘을 선택하는 개발자는 임의의 토큰을 생성하기 위해 해시 된 데이터에 임의성과 고유성이 있는지 확인해야합니다.  
~~~html
<form action="/transfer.do" method="post">

<input type="hidden" name="CSRFToken" 
value="OWY4NmQwODE4ODRjN2Q2NTlhMmZlYWEwYzU1YWQwMTVhM2JmNGYxYjJiMGI4MjJjZDE1ZDZMGYwMGEwOA==">
...
</form>
~~~

일반적으로 개발자는 현재 세션에 대해이 토큰을 한 번만 생성하면됩니다.  
이 토큰의 초기 생성 후에 값은 세션에 저장되고 세션이 만료 될 때까지 각 후속 요청에 사용됩니다.  
최종 사용자가 요청을 발행하면 서버 측 구성 요소는 사용자 세션에서 발견 된 토큰과 비교하여  
요청에서 토큰의 존재와 유효성을 확인해야합니다.  
토큰이 요청 내에서 발견되지 않거나 제공된 값이 사용자 세션 내의 값과 일치하지 않으면  
요청을 중단하고 진행중인 잠재적 CSRF 공격으로 이벤트를 기록해야합니다.  

제안된 설계의 보안을 강화하려면 각 요청에 대해 CSRF 토큰 매개 변수 이름 및/또는 값을 무작위로 고려하십시오.  
이 접근법을 구현하면 세션 당 토큰이 아닌 요청 당 토큰이 생성됩니다.  
이것은 도난당한 토큰을 악용하는 공격자의 시간 범위가 최소이기 때문에 세션 당 토큰보다 안전합니다.  
그러나 이로 인해 사용성 문제가 발생할 수 있습니다.  
예를 들어, 이전 페이지에는 더 이상 유효하지 않은 토큰이있을 수 있으므로 "뒤로"버튼 브라우저 기능이 종종 방해받습니다.  
이 이전 페이지와 상호 작용하면 서버에서 CSRF 오 탐지 (false positive) 보안 이벤트가 발생합니다.  
높은 보안이 필요한 응용 프로그램은 일반적으로이 방법을 구현합니다 (예 : 은행).  
당신은 당신의 필요에 맞는 것을 확인해야합니다.  
취해진 접근 방식에 관계없이 개발자는 TLS 사용과 같이 인증 된 세션 식별자를 보호하는 것과 동일한 방식으로 **CSRF 토큰을 보호**하는 것이 좋습니다.  

#### 기존 동기화 구현
동기화 토큰 방어는 많은 프레임 워크에 내장되어 있으므로 사용할 수 있을 때 먼저 사용하는 것이 좋습니다.  
기존 애플리케이션에 CSRF 방어 기능을 추가하는 외부 구성 요소도 권장됩니다. OWASP는 다음과 같습니다.  
 - For Java: [OWASP CSRF Guard](https://www.owasp.org/index.php/Category:OWASP_CSRFGuard_Project)  
 - For PHP and Apache: [CSRFProtector Project](https://www.owasp.org/index.php/CSRFProtector_Project)  
 












헤더 및 CSRF 토큰에 대한 각 수신 HTTP 요청의 유효성 검사를 담당하는 필터.  
백엔드 목적지에 대한 모든 요청에 대해 호출됩니다.  
우리는 다음과 같은 접근 방식을 사용합니다.  
- 각 유효한 HTTP 교환 후에 CSRF 토큰이 변경됩니다.  
- CSRF 토큰 전송에 대한 사용자 정의 헤더 이름이 수정되었습니다.  
- CSRF 토큰은 동일한 애플리케이션에서 다중 병렬 Ajax 요청을 지원할 수 있도록 백엔드 서비스 URI와 연결된다.  
- CSRF 쿠키 이름은 고정 된 접두사가 접두사로 붙은 백엔드 서비스 이름입니다.  
POC의 경우 응답에서 "액세스 거부"이유를 표시하지만 프로덕션 코드에서는 일반 메시지 만 반환합니다!  


 - STEP 1: 표준 헤더로 동일한 도메인인지 확인  
 - STEP 2: "Double Submit Cookie"접근 방식을 사용하여 CSRF 토큰 확인  
 요청에 CSRF 토큰 쿠키가 없으면 응답으로 응답을 제공하지만 이 단계에서 프로세스를 중단합니다.  
 이 방법을 사용하여 토큰의 첫 번째 제공을 구현합니다.  
   - CSRF 토큰 쿠키 및 헤더 추가  
   - 요청자가 초기 CSRF 토큰을 제공하는 초기 응답을 명확하게 식별 할 수 있도록 응답 상태를 "204 No Content"로 설정합니다.  
   - 쿠키가 존재하면 유효성 검사 단계로 넘어갑니다.  
   - 사용자 정의 HTTP 헤더에서 토큰 가져 오기 (요청자의 제어하에있는 부분)  
   - 비어 있으면 이벤트를 추적하고 요청을 차단합니다.  
    HTTP 헤더를 통해 제공된 토큰이 부재 / 비어 있으므로 요청을 차단합니다!  
    - 헤더의 토큰과 쿠키의 토큰이 같은지 확인하십시오. 여기서는 그렇지 않아 사건을 추적하고 요청을 차단합니다.  
    HTTP 헤더와 쿠키를 통해 제공되는 토큰은 동일하지 않으므로 요청을 차단합니다!  
    - 헤더의 토큰과 쿠키의 토큰이 일치하는지 확인하십시오.  
    이 경우 요청이 대상 구성 요소 (ServiceServlet, jsp ...)에 도달 하도록 하고 버킷을 다시 가져올 때 새 토큰을 추가합니다.  
    CSRF 토큰 쿠키 및 헤더 추가
    
 
 - 구성을 더 쉽게하기 위해 JVM 속성에서 대상 예상 원점을로드합니다.  
 - 재구성에는 일반적으로 허용되는 응용 프로그램 재시작 만 필요합니다.  
 
~~~java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import javax.xml.bind.DatatypeConverter;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.SecureRandom;
import java.util.Arrays;

/**
 * Filter in charge of validating each incoming HTTP request about Headers and CSRF token.
 * It is called for all requests to backend destination.
 *
 * We use the approach in which:
 * - The CSRF token is changed after each valid HTTP exchange
 * - The custom Header name for the CSRF token transmission is fixed
 * - A CSRF token is associated to a backend service URI in order to enable the support for multiple parallel Ajax request from the same application
 * - The CSRF cookie name is the backend service name prefixed with a fixed prefix
 *
 * Here for the POC we show the "access denied" reason in the response but in production code only return a generic message !
 *
 * @see "https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)_Prevention_Cheat_Sheet"
 * @see "https://wiki.mozilla.org/Security/Origin"
 * @see "https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie"
 * @see "https://chloe.re/2016/04/13/goodbye-csrf-samesite-to-the-rescue/"
 */
@WebFilter("/backend/*")
public class CSRFValidationFilter implements Filter {

    /**
     * JVM param name used to define the target origin
     */
    public static final String TARGET_ORIGIN_JVM_PARAM_NAME = "target.origin";

    /**
     * Name of the custom HTTP header used to transmit the CSRF token and also to prefix 
     * the CSRF cookie for the expected backend service
     */
    private static final String CSRF_TOKEN_NAME = "X-TOKEN";

    /**
     * Logger
     */
    private static final Logger LOG = LoggerFactory.getLogger(CSRFValidationFilter.class);

    /**
     * Application expected deployment domain: named "Target Origin" in OWASP CSRF article
     */
    private URL targetOrigin;

    /***
     * Secure generator
     */
    private final SecureRandom secureRandom = new SecureRandom();


    /**
     * {@inheritDoc}
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpServletResponse httpResp = (HttpServletResponse) response;
        String accessDeniedReason;

        /* STEP 1: Verifying Same Origin with Standard Headers */
        //Try to get the source from the "Origin" header
        String source = httpReq.getHeader("Origin");
        if (this.isBlank(source)) {
            //If empty then fallback on "Referer" header
            source = httpReq.getHeader("Referer");
            //If this one is empty too then we trace the event and we block the request (recommendation of the article)...
            if (this.isBlank(source)) {
                accessDeniedReason = "CSRFValidationFilter: ORIGIN and REFERER request headers are both absent/empty so we block the request !";
                LOG.warn(accessDeniedReason);
                httpResp.sendError(HttpServletResponse.SC_FORBIDDEN, accessDeniedReason);
                return;
            }
        }

        //Compare the source against the expected target origin
        URL sourceURL = new URL(source);
        if (!this.targetOrigin.getProtocol().equals(sourceURL.getProtocol()) || !this.targetOrigin.getHost().equals(sourceURL.getHost()) 
		|| this.targetOrigin.getPort() != sourceURL.getPort()) {
            //One the part do not match so we trace the event and we block the request
            accessDeniedReason = String.format("CSRFValidationFilter: Protocol/Host/Port do not fully matches so we block the request! (%s != %s) ", 
				this.targetOrigin, sourceURL);
            LOG.warn(accessDeniedReason);
            httpResp.sendError(HttpServletResponse.SC_FORBIDDEN, accessDeniedReason);
            return;
        }

        /* STEP 2: Verifying CSRF token using "Double Submit Cookie" approach */
        //If CSRF token cookie is absent from the request then we provide one in response but we stop the process at this stage.
        //Using this way we implement the first providing of token
        Cookie tokenCookie = null;
        if (httpReq.getCookies() != null) {
            String csrfCookieExpectedName = this.determineCookieName(httpReq);
            tokenCookie = Arrays.stream(httpReq.getCookies()).filter(c -> c.getName().equals(csrfCookieExpectedName)).findFirst().orElse(null);
        }
        if (tokenCookie == null || this.isBlank(tokenCookie.getValue())) {
            LOG.info("CSRFValidationFilter: CSRF cookie absent or value is null/empty so we provide one and return an HTTP NO_CONTENT response !");
            //Add the CSRF token cookie and header
            this.addTokenCookieAndHeader(httpReq, httpResp);
            //Set response state to "204 No Content" in order to allow the requester to clearly identify an initial response providing the initial CSRF token
            httpResp.setStatus(HttpServletResponse.SC_NO_CONTENT);
        } else {
            //If the cookie is present then we pass to validation phase
            //Get token from the custom HTTP header (part under control of the requester)
            String tokenFromHeader = httpReq.getHeader(CSRF_TOKEN_NAME);
            //If empty then we trace the event and we block the request
            if (this.isBlank(tokenFromHeader)) {
                accessDeniedReason = "CSRFValidationFilter: Token provided via HTTP Header is absent/empty so we block the request !";
                LOG.warn(accessDeniedReason);
                httpResp.sendError(HttpServletResponse.SC_FORBIDDEN, accessDeniedReason);
            } else if (!tokenFromHeader.equals(tokenCookie.getValue())) {
                //Verify that token from header and one from cookie are the same
                //Here is not the case so we trace the event and we block the request
                accessDeniedReason = "CSRFValidationFilter: Token provided via HTTP Header and via Cookie are not equals so we block the request !";
                LOG.warn(accessDeniedReason);
                httpResp.sendError(HttpServletResponse.SC_FORBIDDEN, accessDeniedReason);
            } else {
                //Verify that token from header and one from cookie matches
                //Here is the case so we let the request reach the target component (ServiceServlet, jsp...) and add a new token when we get back the bucket
                HttpServletResponseWrapper httpRespWrapper = new HttpServletResponseWrapper(httpResp);
                chain.doFilter(request, httpRespWrapper);
                //Add the CSRF token cookie and header
                this.addTokenCookieAndHeader(httpReq, httpRespWrapper);
            }
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        //To easier the configuration, we load the target expected origin from an JVM property
        //Reconfiguration only require an application restart that is generally acceptable
        try {
            this.targetOrigin = new URL(System.getProperty(TARGET_ORIGIN_JVM_PARAM_NAME));
        } catch (MalformedURLException e) {
            LOG.error("Cannot init the filter !", e);
            throw new ServletException(e);
        }
        LOG.info("CSRFValidationFilter: Filter init, set expected target origin to '{}'.", this.targetOrigin);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void destroy() {
        LOG.info("CSRFValidationFilter: Filter shutdown");
    }

    /**
     * Check if a string is null or empty (including containing only spaces)
     *
     * @param s Source string
     * @return TRUE if source string is null or empty (including containing only spaces)
     */
    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    /**
     * Generate a new CSRF token
     *
     * @return The token a string
     */
    private String generateToken() {
        byte[] buffer = new byte[50];
        this.secureRandom.nextBytes(buffer);
        return DatatypeConverter.printHexBinary(buffer);
    }

    /**
     * Determine the name of the CSRF cookie for the targeted backend service
     *
     * @param httpRequest Source HTTP request
     * @return The name of the cookie as a string
     */
    private String determineCookieName(HttpServletRequest httpRequest) {
        String backendServiceName = httpRequest.getRequestURI().replaceAll("/", "-");
        return CSRF_TOKEN_NAME + "-" + backendServiceName;
    }

    /**
     * Add the CSRF token cookie and header to the provided HTTP response object
     *
     * @param httpRequest  Source HTTP request
     * @param httpResponse HTTP response object to update
     */
    private void addTokenCookieAndHeader(HttpServletRequest httpRequest, HttpServletResponse httpResponse) {
        //Get new token
        String token = this.generateToken();
        //Add cookie manually because the current Cookie class implementation do not support the "SameSite" attribute
        //We let the adding of the "Secure" cookie attribute to the reverse proxy rewriting...
        //Here we lock the cookie from JS access and we use the SameSite new attribute protection
        String cookieSpec = String.format("%s=%s; Path=%s; HttpOnly; SameSite=Strict", this.determineCookieName(httpRequest), token, httpRequest.getRequestURI());
        httpResponse.addHeader("Set-Cookie", cookieSpec);
        //Add cookie header to give access to the token to the JS code
        httpResponse.setHeader(CSRF_TOKEN_NAME, token);
    }
}
~~~

   
 
