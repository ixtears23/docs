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
 
#### URL에 토큰 공개
동기화 기 토큰의 일부 구현에는 POST 요청뿐만 아니라 GET (URL) 요청의 챌린지 토큰이 포함됩니다.  
이는 페이지 또는 기타 일반 디자인 패턴에 포함 된 링크의 결과로 중요한 서버 측 작업이 호출 된 결과로 종종 구현됩니다.  
이러한 패턴은 종종 CSRF에 대한 지식과 CSRF 방지 설계 전략에 대한 이해없이 구현됩니다.  
이 컨트롤은 CSRF 공격의 위험을 완화하는 데 도움이되지만 고유 한 세션 별 토큰이 GET 요청에 노출되어 있습니다.  
GET 요청의 CSRF 토큰은 브라우저 기록, 로그 파일, HTTP 요청의 첫 번째 줄을 기록하는 지점을 만드는 네트워크 어플라이언스,  
보호 된 사이트가 외부 사이트에 링크되어있는 경우 Referer 헤더 등 여러 위치에서 누출 될 수 있습니다.  
후자의 경우 (링크 된 사이트가 Referer 헤더를 파싱하여 누설 된 CSRF 토큰) 링크 된 사이트가  
보호 된 사이트에서 CSRF 공격을 시작하는 것이 쉽고 공격을 매우 효과적으로 타겟팅 할 수 있습니다.  
Referer 헤더가 CSRF 토큰뿐만 아니라 사이트에 알려주기 때문입니다.  
공격은 JavaScript에서 완전히 실행될 수 있으므로 사이트의 HTML에 스크립트 태그를 간단히 추가하면  
원래의 악의적 인 사이트 또는 해킹 된 사이트에서 공격을 시작할 수 있습니다.  
또한 HTTPS 컨텍스트의 HTTPS 요청은 HTTPS에서 HTTP 요청과 달리 Referer 헤더를 제거하지 않으므로  
Referer를 통한 CSRF 토큰 누출은 여전히 HTTPS 응용 프로그램에서 발생할 수 있습니다.  

이상적인 솔루션은 POST 요청에 CSRF 토큰 만 포함시키고 POST 요청에만 응답하도록 상태를 변경하는 서버 측 작업을 수정하는 것입니다.  
사실 이것은 RFC2616이 GET 요청에 필요한 것입니다.  
민감한 서버 측 작업이 POST 요청에만 응답하도록 보장되면 GET 요청에 토큰을 포함 할 필요가 없습니다.  

그러나 대부분의 JavaEE 웹 응용 프로그램에서는 요청에서 HTTP 매개 변수를 검색 할 때 HTTP 메서드 범위 지정이 거의 사용되지 않습니다.  
"HttpServletRequest.getParameter"를 호출하면 GET 또는 POST인지 여부에 관계없이 매개 변수 값이 반환됩니다.  
그렇다고해서 HTTP 메소드 스코핑을 적용 할 수 없다는 것은 아닙니다.  
개발자가 명시 적으로 HttpServlet 클래스의 doPost()를 재정의하거나 Spring의 AbstractFormController 클래스와 같은  
프레임 워크 특정 기능을 사용하는 경우 구현할 수 있습니다.  

이러한 경우 기존 응용 프로그램에이 패턴을 변경하려고하면 개발 시간과 비용이 많이 들며 임시 조치로 CSRF 토큰을 URL에 전달하는 것이 좋습니다.  
HTTP GET 및 POST 동사에 올바르게 응답하도록 응용 프로그램을 수정하면 GET 요청에 대한 CSRF 토큰을 해제해야합니다.  

#### 암호화 기반 토큰 패턴
암호화 된 토큰 패턴은 토큰 검증의 비교 방법이 아닌 암호화를 이용합니다. 서버 측에서 상태를 유지하고 싶지 않은 응용 프로그램에 가장 적합합니다.  

인증에 성공하면 서버는 서버에서만 사용할 수있는 고유 한 키를 사용하여 사용자의 ID, 타임 스탬프 값 및 난스로 구성된 고유 한 토큰을 생성합니다.  
이 토큰은 AJAX 요청에 대한 요청 헤더/매개 변수에서 클라이언트에 반환되고 양식의 숨김 필드에 포함됩니다.  
이 요청을 받으면 서버는 토큰을 생성하는 데 사용 된 것과 동일한 키를 사용하여 토큰 값을 읽고 해독합니다.  
올바르게 해독 할 수 없다는 것은 침입 시도를 암시합니다.  
일단 해독되면 토큰에 포함 된 UserId와 타임 스탬프가 유효화됩니다.  
UserId는 현재 로그인 한 사용자와 비교되고 타임 스탬프는 현재 시간과 비교됩니다.  

성공적인 토큰 해독시 서버는 구문 분석 된 값에 이상적으로 액세스 할 수 있습니다.  
이러한 클레임은 UserId 클레임을 잠재적으로 저장된 UserId (쿠키 또는 세션 변수에 이미 인증 수단이있는 경우)과 비교하여 처리됩니다.  
타임 스탬프는 현재 시간에 대해 유효성이 검사되어 재생 공격을 방지합니다.  
또는 CSRF 공격의 경우 서버는 독살 된 토큰을 해독 할 수 없으며 공격을 차단하고 기록 할 수 있습니다.  
이 기술은 Cookie에 데이터를 저장하고 Cookie 하위 도메인과 HTTPONLY 문제를 둘러싼 필요성과 같은 다른 상태 비 저장 방법의 단점을 해결합니다.

#### HMAC 기반 토큰 패턴
[HMAC(해시 기반 메시지 인증 코드)](https://en.wikipedia.org/wiki/HMAC)는 메시지의 무결성과 인증을 보장하는 데 도움이되는 암호화 기능입니다.  
CSRF 완화가 서버에서 상태를 유지하지 않고도 달성 할 수있는 또 다른 방법이며 두 가지 주요 차이점이 있는 암호화 토큰 기반 패턴과 유사합니다.  
 - 암호화 함수 대신 강력한 HMAC 함수를 사용하여 토큰 생성  
 - CSRF 토큰을 포함하는 작업의 목적을 나타내는 'operation'이라는 추가 필드를 포함합니다 (form 태그 / ajax 호출 일 수 있음)  
 (Ex: ‘oneclickpurchase’ (or) buy/asin=SDFH&category=2&quantity=3)  
 
note : 암호화 토큰 패턴 (사용자의 ID, 시간 소인 값 및 nonce)에 언급 된 필드가 포함됩니다.  
작업 필드는 해시 함수가 여러 번의 반복과 관계없이 동일한 값을 생성한다는 사실을 완화하는 데 도움이됩니다 
(매번 암호화 될 때 다른 값을 생성하는 강력한 암호화 함수와 달리).  
따라서 응용 프로그램에서 반복되는 토큰 값을 피하는 데 도움이됩니다.  
논스 (Nonce) 필드는 암호화 된 토큰 패턴에서와 동일한 목적을 제공한다
(즉, 약한 암호화 기능으로 인한 드문 충돌을 피하고 심층 방어 수단으로 작용한다).  
이전에 언급 한 네 개의 필드 (사용자 ID, 타임 스탬프 값, nonce 및 작업)를 모두 포함하여 HMAC를 사용하여 토큰을 생성 한 다음  
양식 태그의 숨김 필드, ajax 호출의 헤더 / 매개 변수에이를 포함시킵니다.  
요청에서 클라이언트로부터 HMAC를 받으면 생성하는 데 사용한 것과 동일한 필드를 사용하여 HMAC를 다시 생성 한 다음  
다시 생성 한 HMAC가 클라이언트에서받은 HMAC와 일치하는지 확인합니다.  
그렇다면 합법적 인 사용자 요청이며 그렇지 않은 경우 CSRF 침입으로 신고하고 인시던트 대응 팀에 알립니다.  
공격자는 생성시 사용 된 해시 필드를 생성하는 데 사용 된 키를 볼 수 없기 때문에이를 위조 된 요청에 사용할 수 있도록 다시 생성 할 수 없습니다.  

> 여기아래부터 줄바꿈 안함.

#### 자동 CSRF 완화 기법
토큰을 완화하는 기술이 널리 사용되지만 (싱크로 나이저 토큰 및 상태 / 암호화 / HMAC 토큰으로 상태 유지) 이러한 기술과 관련된 주요 문제점은 때때로 사물을 잊어 버리는 인간의 경향입니다. 개발자가 상태 변경 작업에 토큰을 추가하는 것을 잊어 버리면 응용 프로그램이 CSRF에 취약하게됩니다. 이를 피하기 위해 CSRF 취약한 리소스에 토큰을 추가하는 프로세스를 자동화 할 수 있습니다 (이 문서의 앞 부분에서 언급 함). 다음을 수행하여이를 수행 할 수 있습니다.  

- 기본 양식 태그 / ajax 호출을 중심으로 래퍼 (자동으로 토큰을 추가)를 작성하고 개발자에게 표준 태그 대신 래퍼를 사용하도록 교육하십시오. 이 접근법은 토큰을 추가하는 개발자들에게만 의존하는 것보다 낫지 만, 사물을 잊어 버리는 인간의 문제에 여전히 취약합니다. Spring Security는이 기술을 사용하여 사용자 정의 <form : form> 태그가 사용될 때 기본적으로 CSRF 토큰을 추가합니다. 사용중인 Spring Security 버전에서 사용 가능하고 올바르게 구성되었는지 확인한 후에 사용할 수 있습니다.  
- 조직 웹 렌더링 프레임 워크에서 트래픽을 캡처하고 고객에게 렌더링하기 전에 CSRF 취약한 리소스에 토큰을 추가하는 훅을 작성합니다. 특정 응답이 상태 변경을 수행 할 때 (따라서 토큰이 필요할 때) 분석하기가 어렵 기 때문에 모든 CSRF 취약한 리소스 (예 : 모든 POST 응답의 토큰 포함)에 토큰을 포함 할 수 있습니다. 이는 권장되는 접근 방법 중 하나이지만, 발생할 수있는 성능 비용을 고려해야합니다.  
- 클라이언트 측 스크립트의 도움으로 페이지가 사용자 브라우저에서 렌더링 될 때 클라이언트 측에 자동으로 추가되는 토큰을 가져옵니다 (이 접근법은 CSRF Guard에서 사용됩니다). 자바 스크립트 하이재킹 공격을 고려해야합니다. 사용자 정의 자동 토큰 시스템을 구축하기 전에 기본적으로 CSRF 보호를 달성 할 수있는 옵션이 있는지 확인하는 것이 좋습니다. 예를 들어 .NET에는 CSRF 취약한 리소스에 토큰을 추가하는 내장 된 보호 기능이 있습니다. CSRF 취약한 리소스를 자동으로 토큰으로하는 이러한 내장 된 CSRF 보호를 사용하기 전에 적절한 구성 (예 : 키 관리 및 토큰 관리)을 담당해야합니다.  

#### Login CSRF
대부분의 개발자는 사용자가 그 단계에서 인증되지 않아 CSRF가 로그인 양식에 적용되지 않는다고 가정하기 때문에 로그인 양식의 CSRF 취약점을 무시하는 경향이 있습니다. 그 가정은 거짓입니다. 사용자가 인증되지 않은 로그인 양식에서는 CSRF 취약점이 계속 발생할 수 있지만 영향 / 위험보기는 일반 CSRF 취약성의 영향 / 위험도 (사용자가 인증 된 경우)와 완전히 다릅니다.  

로그인 폼에 대한 CSRF 취약점으로 인해 공격자는 희생자 로그인을하고 검색에서 행동을 학습 할 수 있습니다. 로그인 CSRF 및 기타 위험에 대한 자세한 내용은이 백서의 [3 절](https://seclab.stanford.edu/websec/csrf/csrf.pdf)을 참조하십시오.  

로그인 CSRF는 사전 세션 (사용자가 인증되기 전에 세션)을 만들고 로그인 양식에 토큰을 포함시켜 완화 할 수 있습니다. 위에 언급 된 기술 중 하나를 사용하여 토큰을 생성 할 수 있습니다. 사용자가 인증되면 사전 세션을 실제 세션으로 전환 할 수 있습니다. 이 기술은 교차 사이트 요청 위조 섹션 4.1에 설명되어 있습니다.  

마스터 도메인의 하위 도메인이 위협 모델에서 신뢰할 수없는 것으로 취급되면 로그인 CSRF를 완화하기가 어렵습니다. 엄격한 하위 도메인 및 경로 수준 참조 자 헤더 (대부분의 로그인 페이지가 HTTPS에서 제공되기 때문에 - 참조자를 제외하지 않음 - 또한 홈 페이지에서 연결되어 있음) 유효성 확인 (6.1 절에 자세히 설명 됨)은 이러한 경우 로그인 양식에서 CSRF를 어느 정도 완화하기 위해 사용할 수 있습니다.  

### 심층 방어 기법
#### 표준 헤더로 origin 확인
방어 기술은 Cross-Site Request Forgery의 Robust Defenses 섹션 5.0에서 특별히 제안되었습니다. 이 논문은 Origin 헤더의 첫 번째 생성과 CSRF 방어 메커니즘으로서의 그것의 사용을 제안한다.  

이 완화에는 HTTP 요청 헤더 값을 검사하는 두 가지 단계가 있습니다.  
1. 요청의 출처 (소스 출처) 결정. 원점 및 / 또는 참조 헤더를 통해 수행 할 수 있습니다.  
2. 요청이 발생할 원점을 결정합니다 (대상 원점).

서버 쪽에서 우리는 둘 다 일치하는지 확인합니다. 이 경우 요청은 합법적 인 요청 (동일한 원산지 요청)을 수락하고 요청하지 않으면 요청을 취소합니다 (요청이 교차 도메인에서 비롯됨). 이러한 헤더의 신뢰성은 금지 된 헤더 목록에 해당되므로 프로그래밍 방식으로 (XSS의 JavaScript를 사용하여) 변경할 수 없다는 것에서 비롯됩니다 (즉, 브라우저에서만 설정할 수 있음).  

##### 원본 출처 식별 (원본/Referer header)  
##### 원본(Origin) 헤더 확인  
Origin 헤더가 있으면 해당 값이 대상 원점과 일치하는지 확인합니다. Referer와 달리 Origin 헤더는 HTTPS URL에서 비롯된 HTTP 요청에 표시됩니다.  
##### 참조(Referer) 헤더 확인  
Origin 헤더가 없으면 Referer 헤더의 호스트 이름이 대상 출처와 일치하는지 확인하십시오. 이 CSRF 완화 방법은 동기화 토큰을 추적하는 데 필요한 세션 상태를 설정하기 전에 만들어진 요청과 같이 인증되지 않은 요청에도 일반적으로 사용됩니다.  

두 경우 모두 대상 출처 확인이 강한 지 확인하십시오. 예를 들어, 사이트가 "site.com"인 경우 "site.com.attacker.com"이 원본 확인을 통과하지 못하게하십시오 (예 : 원본의 뒤쪽 / 뒤를 통과하여 전체 원본과 일치하는지 확인하십시오 ).  

이러한 헤더가 없으면 요청을 수락하거나 차단할 수 있습니다. 차단하는 것이 좋습니다. 또는 이러한 모든 인스턴스를 기록하고 유스 케이스 / 동작을 모니터링 한 다음 충분한 신뢰를 얻은 후에야 차단 요청을 시작할 수 있습니다.  

##### Identifying the Target Origin
목표 출처를 쉽게 결정할 수 있다고 생각할 수도 있지만 흔히 그렇지 않습니다. 첫 번째 생각은 요청의 URL에서 대상 출처 (즉, 호스트 이름 및 포트 번호)를 간단히 가져 오는 것입니다. 그러나 애플리케이션 서버는 흔히 하나 이상의 프록시 뒤에 있으며 원래 URL은 애플리케이션 서버가 실제로 수신 한 URL과 다릅니다. 응용 프로그램 서버에 사용자가 직접 액세스하는 경우 URL의 원본을 사용하면 문제가 없으며 모두 설정됩니다.  

프록시를 사용하는 경우 고려해야 할 여러 가지 옵션이 있습니다.  

- **응용 프로그램을 구성하여 대상 출처를 간단히 알 수 있습니다** : 이는 사용자의 응용 프로그램이므로 대상 원점을 찾아 일부 서버 구성 항목에서 해당 값을 설정할 수 있습니다. 이는 정의 된 서버 측에서 가장 안전한 접근 방식이므로 신뢰할 수있는 가치입니다. 그러나 응용 프로그램이 dev, test, QA, 프로덕션 및 여러 프로덕션 인스턴스와 같은 여러 위치에 배포 된 경우 유지 관리하는 것이 문제가 될 수 있습니다. 이러한 각각의 상황에 대한 올바른 값을 설정하는 것은 어려울 수 있지만 중앙 구성을 통해 수행 할 수 있고 인스턴스를 제공하여 값을 확보 할 수 있다면 정말 좋습니다! (참고 : CSRF 방어의 주요 부분이 CSRF에 의존하기 때문에 중앙 집중식 구성 저장소가 안전하게 유지되어야합니다.)  
- **호스트 헤더 값 사용** : 응용 프로그램이 자체 대상을 찾고 배포 된 각 인스턴스에 대해 구성 할 필요가 없도록하려면 호스트의 호스트 패밀리를 사용하는 것이 좋습니다. 호스트 헤더의 용도는 요청의 대상 원점을 포함하는 것입니다. 그러나 앱 서버가 프록시 뒤에있는 경우 Host 헤더 값은 원래 URL과 다른 프록시 뒤에있는 URL의 대상 출처로 프록시에 의해 변경 될 가능성이 큽니다. 이 수정 된 호스트 헤더 원점은 원래 Origin 또는 Referer 헤더의 소스 원점과 일치하지 않습니다.  
- **X-Forwarded-Host 헤더 값 사용** : 프록시가 호스트 헤더를 변경하는 문제를 피하기 위해 X-Forwarded-Host라는 또 다른 헤더가 있습니다.이 헤더의 목적은 프록시가 수신 한 원래의 Host 헤더 값을 포함시키는 것입니다. 대부분의 프록시는 X-Forwarded-Host 헤더의 원래 Host 헤더 값을 전달합니다. 따라서 헤더 값은 Origin 또는 Referer 헤더의 소스 원점과 비교해야하는 대상 원점 값이 될 가능성이 큽니다.  

CSRF 치트 시트의 초기 버전에서의 이러한 완화는 주요 방어 수단으로 취급됩니다. 아래에 언급 된 이유로, 이제는 국방 깊이 섹션으로 이동합니다.  

암시 적이기 때문에 원 래 또는 리퍼러 헤더가 요청에있을 때이 완화가 제대로 작동합니다. 이러한 헤더가 대다수 포함되어 있지만 포함되지 않은 사용 사례는 거의 없습니다 (대부분 사용자의 개인 정보 보호 / 브라우저 생태계 조정에 대한 합법적 인 이유가 대부분입니다). 다음은 몇 가지 유스 케이스를 나열한 것입니다.  

- Internet Explorer 11은 신뢰할 수있는 영역의 사이트를 통해 CORS 요청에 Origin 헤더를 추가하지 않습니다. Referer 헤더는 UI 출처의 유일한 표시로 남습니다. 여기 및 여기에 stackoverflow에있는 다음 참조를 참조하십시오.  
- 302 리디렉션 교차 원점을 따르는 인스턴스에서 원점은 다른 원점으로 전송하면 안되는 민감한 정보로 간주 될 수 있으므로 리디렉션 된 요청에 포함되지 않습니다.  
- Origin이 "null"로 설정된 일부 개인 정보 환경이 있습니다. 예를 들어 여기에서 다음을 참조하십시오.  
- 원본 헤더는 모든 원본 출처 요청에 포함되지만 동일한 출처 요청의 경우 대부분의 브라우저에서 POST / DELETE / PUT에만 포함됩니다. 참고 : 이상적인 것은 아니지만 많은 개발자는 GET 요청을 사용하여 상태 변경 작업을 수행합니다.  
- Referer 헤더도 예외는 아닙니다. 리퍼러 헤더도 생략 된 여러 가지 사용 사례가 있습니다 ([1], [2], [3], [4] 및 [5]). 로드 밸런서, 프록시 및 임베디드 네트워크 장치는 리퍼러 헤더를 기록 할 때 프라이버시 사유로 인해 리퍼러 헤더를 제거하는 것으로 잘 알려져 있습니다.  

소스 및 대상 출처 확인 논리에서 위의 경우에 예외가 기록 될 수 있지만 현재 이러한 모든 사용 사례를 참조하는 중앙 저장소는 없습니다 (심지어 최신 상태로 유지하는 것이 중요합니다). 각 브라우저는 이러한 유스 케이스를 다르게 처리 할 수도 있습니다 (브라우저는 생태계를 고려하여 상황을 다르게 처리하는 것으로 알려져 있습니다. 신뢰할 수있는 영역 내에서 원본 헤더를 보내지 않은 IE 예제가 그러한 예입니다). 출발지 및 / 또는 리퍼러 헤더가 포함되지 않은 요청을 거부하면 좋은 아이디어처럼 들릴 수 있지만 합법적 인 사용자에게 영향을 미칠 수 있습니다. 이 시스템을 모니터링 모드로 유지하고 위에서 언급 한 것과 같은 유스 케이스를 조사하려고 시도한 다음이를 예외 로직에 추가하는 작업은 사용자 환경에서이 방어를보다 안정화시키는 것으로 고려할 수있는 프로세스입니다.  

이 CSRF 방어는 때때로 바뀔 수있는 브라우저 동작에 의존합니다. 예를 들어, 새로운 프라이버시 컨텍스트가 발견 된 경우, 토큰 기반 완화와 같이 CSRF 완화에 대한 전체 제어 권한이있는 곳에서 유효성 검사 논리를 업데이트해야하는 상황에서. 브라우저가 CSRF 토큰을 변경하면 이들은 브라우저 페이지에서 HTML 내용을 문자 그대로 변경합니다 (브라우저에서 수행하지 않을 것임).  

Origin 및 / 또는 Referrer 헤더로 보호되는 응용 프로그램의 페이지에 XSS 취약점이있는 경우 다른 페이지의 상태 변경 작업 (일반적으로 CSRF에 취약)을 악용하는 데 필요한 노력의 수준은 매우 쉽습니다 (매개 변수 및 토큰 기반 완화 (공격자가 대상 페이지를 다운로드하고 토큰에 대한 DOM을 구문 분석하고 단조 요청을 구성하여 서버로 전송해야하는 경우)와 비교할 때보다 브라우저에서 Origin 및 Referrer 헤더가 기본적으로 포함되므로 요청을 위조하십시오. .  

참고 : 본문에서 기원 헤더의 개념이 강력한 CSRF 방어를 참조하고 있지만, 초기 기점 헤더 RFC는 CSRF를 어떤 방식 으로든 완화하기 위해 언급하지 않습니다 (그러나 다른 초안 버전은 그렇습니다).  

#### Double Submit Cookie
서버 측의 CSRF 토큰에 대한 상태를 유지하는 것이 문제가있는 경우 이중 방어 쿠키 기술을 사용하는 것이 좋습니다. 이 기술은 구현하기 쉽고 상태 비 저장입니다. 이 기술에서는 쿠키 값과 요청 값이 일치하는지 서버가 확인하면서 쿠키와 요청 매개 변수 모두에 무작위 값을 보냅니다. 사용자가 (CSRF 로그인을 방지하기 위해 인증하기 전에) 사이트는 (암호 적으로 강한) 의사 난수 값을 생성하고이를 세션 식별자와 별도로 사용자 시스템의 쿠키로 설정해야합니다. 사이트는 모든 트랜잭션 요청이이 의사 난수 값을 숨겨진 양식 값 (또는 다른 요청 매개 변수 / 헤더)으로 포함하도록 요구합니다. 두 항목이 서버 측에서 일치하면 서버는이 요청을 합법적 인 요청으로 수락하고 그렇지 않은 경우 요청을 거부합니다.  

교차 기원 공격자는 서버에서 전송 된 데이터를 읽거나 동일한 출처 정책에 따라 쿠키 값을 수정할 수 없기 때문에이 기술이 작동 할 것이라는 믿음이 있습니다. 즉, 공격자가 피해자가 악의적 인 CSRF 요청으로 값을 전송하도록 유도 할 수는 있지만 공격자는 쿠키에 저장된 값 (서버가 토큰 값을 비교하는 값)을 수정하거나 읽을 수 없습니다.  

여기에 가정 된 것과 관련된 몇 가지 단점이 있습니다. "하위 도메인에 대한 신뢰 및 일반적으로 HTTPS 연결을 수락하기위한 전체 사이트의 적절한 구성"문제 Rich Lundeen의 Blackhat 토크는 이러한 단점을 언급합니다.  

"두 번 제출하면 공격자가 쿠키를 작성할 수있는 경우 분명히 보호 기능을 무력화 할 수 있으며 쿠키를 작성하는 것이 훨씬 쉽습니다. 쿠키를 작성할 수 있다는 사실은 많은 사람들이 이해하기 어렵습니다. 하나의 도메인이 다른 도메인의 쿠키에 액세스 할 수 없도록 지정하는 동일한 원산지 정책은 없지만 도메인 전체에 쿠키를 작성할 수있는 두 가지 일반적인 시나리오가 있습니다.  

a) hellokitty.marketing.example.com은 동일한 출처 정책으로 인해 secure.example.com에서 쿠키를 읽거나 DOM에 액세스 할 수 없지만 hellokitty.marketing.example.com은 상위 도메인에 쿠키를 쓸 수 있습니다 (예 : hellokitty.marketing.example.com). co.kr)에 저장되고 이러한 쿠키는 secure.example.com에 의해 소비됩니다 (secure.example.com은 쿠키를 설정하는 사이트를 구분하는 좋은 방법이 없습니다). 또한 secure.example.com이 항상 쿠키를 먼저 받아 들일 수 있도록하는 방법이 있습니다. 이것이 의미하는 바는 hellokitty.marketing.example.com의 XSS가 secure.example.com의 쿠키를 덮어 쓸 수 있다는 것입니다.  

b) 공격자가 중간에있는 경우 일반적으로 HTTP를 통해 동일한 도메인에 요청할 수 있습니다. 응용 프로그램이 https://secure.example.com에서 호스팅되는 경우 쿠키가 보안 플래그로 설정되어 있어도 중간에있는 사람이 http://secure.example.com에 대한 연결을 강제로 설정하고 (overwrite) 임의의 쿠키 (보안 플래그가 공격자가 해당 쿠키를 읽을 수 없어도). HSTS 헤더가 서버에 설정되어 있고 사이트를 방문하는 브라우저가 HSTS 헤더를 모든 하위 도메인을 포함하는 방식으로 설정하지 않으면 중간에있는 사람이 일반 텍스트 HTTP 요청을하지 못하도록하는 HSTS를 지원하더라도 중간은 단순히 별도의 하위 도메인에 요청을 보내고 1과 비슷한 쿠키를 덮어 쓸 수 있습니다. 즉, http://hellokitty.marketing.example.com이 https를 강제 실행하지 않는 한 공격자는 모든 쿠키에 대해 쿠키를 덮어 쓸 수 있습니다. example.com 하위 도메인. "  

따라서 하위 도메인이 완전히 보안되고 HTTPS 연결 만 수락한다는 확신이없는 한 (우리는 대기업에서 보증하기가 어렵다고 생각합니다), CSRF에 대한 기본 완화 방법으로 쿠키 제출 방법에 의존해서는 안됩니다.  

#### Samesite 쿠키 속성
SameSite는 CSRF 공격을 완화하기 위해 Google에서 도입 한 쿠키 속성 (HTTPOnly, Secure 등과 유사)입니다. 이 인터넷 초안에 정의되어 있습니다. 이 특성은 브라우저가 사이트 간 요청과 함께 쿠키를 보내지 못하게합니다. 이 속성에 가능한 값은 lax 또는 strict입니다.  

엄격한 값은 일반적인 링크를 따라 갔을 때조차도 브라우저가 모든 사이트 간 탐색 컨텍스트에서 대상 사이트로 쿠키를 보내지 못하게합니다. 예를 들어, GitHub와 같은 웹 사이트의 경우 로그인 한 사용자가 회사 토론 포럼이나 이메일에 게시 된 비공개 GitHub 프로젝트에 대한 링크를 따라 가면 GitHub는 세션 쿠키를받지 못해 사용자가 프로젝트에 액세스 할 수 있습니다. 그러나 은행 웹 사이트는 거래 페이지가 외부 사이트와 연결되도록 허용하지 않으므로 엄격한 플래그가 가장 적절합니다.  

기본 lax 값은 사용자가 외부 링크를 통해 도착한 후에 사용자의 로그인 세션을 유지하려는 웹 사이트의 보안과 유용성간에 적절한 균형을 제공합니다. 위의 GitHub 시나리오에서 외부 웹 사이트의 일반 링크를 따라 가면서 POST와 같은 CSRF가 발생하기 쉬운 요청 방법으로 차단할 때 세션 쿠키가 허용됩니다. 느슨한 모드에서 허용되는 교차 사이트 요청은 최상위 수준의 탐색 기능을 제공하며 안전한 "HTTP"방법입니다 (자세한 내용은 여기 참조).

이 속성을 사용하는 쿠키의 예 :
~~~javascript
Set-Cookie: JSESSIONID=xxxxx; SameSite=Strict
Set-Cookie: JSESSIONID=xxxxx; SameSite=Lax
~~~
여러 브라우저에서이 속성에 대한 지원이 늘어나고 있지만 여전히이를 채택해야하는 브라우저가 있습니다. 2018 년 8 월 현재 SameSite 속성은 인터넷 사용자의 68.92 %가 사용하는 브라우저에 있습니다 (자세한 통계는 여기에 있음).  

이 기술은 CSRF 공격을 완화하는 데 효율적으로 보이지만 초반 단계 (초안)에 있으며 위에서 언급 한대로 전체 브라우저를 지원하지 않습니다. Google의 초안에는 공격자가 동일한 사이트 요청으로 단조 요청을 시뮬레이션 할 수있는 SameSite 쿠키를 보낼 수있는 몇 가지 사례가 나와 있습니다.  

위의 요소를 고려하여 기본 방어로 사용하는 것은 좋지 않습니다. Google은 이러한 입장에 동의하며 개발자가 CSRF를보다 완벽하게 완화하기 위해 토큰과 같은 서버 측 방어 수단을 배포 할 것을 강력히 권장합니다.  


#### 사용자 지정 요청 헤더 사용
CSRF 토큰, 이중 제출 쿠키 및 값, 암호화 된 토큰 또는 UI 변경과 관련된 다른 방어를 추가하는 것은 종종 복잡하거나 문제가 될 수 있습니다. 특히 AJAX / XHR 엔드 포인트에 적합한 대체 방안은 사용자 정의 요청 헤더를 사용하는 것입니다. 이 방어는 JavaScript 만 사용하여 사용자 지정 헤더를 추가하고 해당 원본 내에서만 사용할 수있는 SOP (same-origin policy) 제한을 사용합니다. 기본적으로 브라우저는 JavaScript가 교차 원점 요청을 할 수 없도록합니다.  

특히 매력적인 맞춤 헤더와 값은 "X-Requested-With : XMLHttpRequest"입니다. 대부분의 자바 스크립트 라이브러리는 기본적으로이 헤더를 기본적으로 생성하는 요청에 추가하기 때문입니다. 그러나 일부는 그렇지 않습니다. 예를 들어, AngularJS는 사용되었지만 더 이상 사용되지 않습니다. 더 많은 정보를 원한다면 그들의 이론적 근거와 그것을 다시 추가하는 방법을보십시오.  

이것이 시스템의 경우 CSRF 공격으로부터 보호하기 위해 모든 서버 측 AJAX 엔드 포인트에서이 헤더와 값의 존재를 간단히 확인할 수 있습니다. 이 접근법은 일반적으로 UI 변경을 요구하지 않고 REST 서비스에 특히 매력적인 서버 측 상태를 도입하지 않는 두 가지 장점이 있습니다. 원하는 경우 사용자 지정 헤더와 값을 항상 추가 할 수 있습니다.  

이 방어 기술은 교차 사이트 요청 위조에 대한 강력한 방어 섹션 4.3에서 구체적으로 논의됩니다. 그러나 플래시를 사용한이 방어의 우회는 Vimeo의 CSRF 결함을 악용하기 위해 Mathias Karlsson에 의해 2008 년 초와 2015 년에 최근에 문서화되었습니다. 플래시 공격은 Origin 또는 Referer 헤더를 스푸핑 할 수 없으므로이 두 가지를 모두 검사하여 Flash bypass CSRF 공격 (미래에 발생할 경우)을 방지해야합니다.  

플래시와 같은 가능한 우회 외에, 정적 헤더를 사용하면 응용 프로그램에서 다른 상태 변경 작업을 쉽게 활용할 수 있습니다 (토큰 기반 완화보다 원본 / 참조 헤더 확인이 쉬운 이유에 대한 이전 설명과 유사) . 정적 헤더 값 대신 임의의 토큰을 포함시키는 것은 기본 방어 섹션에 설명 된 토큰 기반 방식과 거의 동일합니다. 개발자는 또한 Ajax 호출과 양식 태그가 모두있는 응용 프로그램에서이 접근법을 사용하는 경우 Ajax 호출이 CSRF로부터 보호하는 데 도움이되며이 문서에 설명 된 접근 방식으로 <form> 태그를 보호해야한다고 생각할 필요가 있습니다 토큰과 같은 양식 태그에 맞춤 헤더를 설정하는 것은 직접 불가능합니다. 또한 CORS 구성은이 솔루션이 효과적으로 작동하도록 강력해야합니다 (다른 도메인의 요청에 대한 사용자 지정 헤더가 CORS 사전 점검을 트리거 함).  
	
#### 사용자 상호 작용 기반 CSRF 방어  
여기에 언급 된 모든 기술은 사용자 상호 작용을 필요로하지 않지만 인증되지 않은 작업 (CSRF 또는 기타를 통해 위조 됨)을 방지하기 위해 트랜잭션에 사용자를 참여시키는 것이 더 쉽거나 적절할 때도 있습니다. 다음은 올바르게 구현 될 때 강력한 CSRF 방어 역할을 할 수있는 기술의 몇 가지 예입니다.  
 - 재 인증(password or stronger)  
 - 일회성 토큰  
 - CAPTCHA 보안문자  

CSRF의 방어는 매우 강력하지만 사용자 경험에 커다란 영향을줍니다. 일부 작업 (암호 변경, 송금 등)에 대해 높은 보안이 필요한 응용 프로그램의 경우 이러한 기술을 토큰 기반 완화와 함께 사용해야합니다. 토큰 자체만으로 CSRF를 완화 할 수 있으므로 개발자는 이러한 기술을 사용하여 민감도가 높은 작업에 대한 추가 보안을 달성해야합니다.  

## CSRF의 대중적인 완화 방법이 아닙니다.

### Triple Submit Cookie
이러한 완화는 2012 년 OWASP Appsec Research의 John Wilander에 의해 제안되었습니다. 이 기술은 요청에 동일한 이름을 가진 두 개의 쿠키가 포함되어 있는지 확인하여 추가 제출 방법을 추가합니다 (중복 제출 쿠키 완화를 우회하기 위해 공격자가 추가 쿠키를 작성해야 함). 이중 제출 쿠키의 우회에서 논의 된 문제를 완화하지만 쿠키 항아리 오버플로 (자세한 내용 및 여기 및 여기에 더 많은 세부 사항 세부 정보)와 같은 새로운 문제를 소개합니다. 지금까지이 완화에 대한 실시간 구현을 찾을 수 없었습니다.  

### Content-Type Header Validation
이 기술은 트리플 제출 쿠키 완화보다 잘 알려져 있습니다. 우선,이 헤더는 보안을 위해 설계된 것이 아니라 (초기 RFC는이 RFC에서 잘 정의되어 있음) 수신 에이전트가 처리 할 데이터의 유형을 알 수 있도록하여 해당 파서를 호출 할 수 있도록합니다. 이 헤더의 사전 비행 행동 (헤더가 application / x-www-form-urlencoded, multipart / form-data 또는 text / plain 이외의 값을 갖는 경우 사전 비행)은 CSRF 완화로 간주되어 모든 (예 : 애플리케이션 / json. 서버 측은이 사전 비행 중에 CORS / SOP로 교차 출처 요청을 거부 할 수 있음).  

이 접근법에는 두 가지 주요한 문제가 있습니다. 하나는 모든 요청에 실제 사용 사례에도 불구하고 사전 비행을 강요하는 헤더 값을 요구하고 다른 하나는이 기술이 보안을 위해 설계되지 않은 기능에 의존하여 보안 취약성을 완화시키는 것입니다. Chrome API에서 버그가 발견되면 브라우저 설계자는이 비행 전 행동을 제거하는 데 고려조차 고려했습니다. 이 머리글은 보안 컨트롤로 설계되지 않았으므로 건축가는 주 목적을보다 잘 충족시킬 수 있도록 다시 디자인 할 수 있습니다. 앞으로는 다양한 유형의 헤더 유형을 포함하여 다양한 유스 케이스를 지원할 수있는 가능성이 있습니다. CSRF 완화를 위해이 헤더를 사용하는 시스템을 문제로 만들 수 있습니다. 자세한 내용은 일반적인 CSRF 예방 오해를 참조하십시오.  

## CSRF 완화 신화
다음은 CSRF 완화로 간주되는 기술을 보여 주지만 그 중 어느 것도 CSRF 취약성을 완전히 / 실제로 완화하지 못합니다.  
- CORS : CORS는 사이트 간 교차 원어 통신이 필요할 때 동일 출처 정책을 완화하기 위해 고안된 헤더입니다. 이것은 설계되지 않았으며 CSRF 공격을 예방하지도 않습니다.  
- HTTPS 사용 : HTTPS를 사용하면 CSRF 공격으로부터 보호 할 수 없습니다. 위에 설명 된 적절한 CSRF 완화가 포함되지 않은 경우 HTTPS 아래에있는 리소스는 CSRF에 여전히 취약합니다.  
- 더 많은 신화가 [여기](https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF))에서 발견 될 수있다.  

## 개인 안전 CSRF 사용자를위한 팁
CSRF 취약점이 널리 퍼져있는 것으로 알려져 있으므로 위험을 줄이려면 다음 모범 사례를 사용하는 것이 좋습니다.  
1. 웹 응용 프로그램을 사용한 직후 로그 오프하십시오.  
2. 브라우저가 사용자 이름 / 암호를 저장하도록 허용하지 말고, 사이트가 로그인을 "기억"하도록 허용하지 마십시오.  
3. 민감한 응용 프로그램에 액세스하고 인터넷을 자유롭게 탐색하기 위해 동일한 브라우저를 사용하지 마십시오 (탭 브라우징).  
4. No-Script와 같은 플러그인을 사용하면 POST 기반의 CSRF 취약점을 악용하기가 어렵습니다. 익스플로잇이로드 될 때 JavaScript가 자동으로 양식을 제출하는 데 사용되기 때문입니다. JavaScript가 없으면 공격자는 사용자가 속임수를 사용하여 양식을 수동으로 제출해야합니다.  

통합 된 HTML 사용 가능 메일 / 브라우저 및 뉴스 리더 / 브라우저 환경은 메일 메시지 또는 뉴스 메시지를 보는 것만으로도 공격을 실행할 수 있으므로 추가 위험이 따릅니다.  

## 구현 참조 예
다음 JEE 웹 필터는이 치트 시트에 설명 된 몇 가지 개념에 대한 예제 참조를 제공합니다. 이 프로그램은 다음과 같은 무 상태 완화를 구현합니다 (OWASP CSRFGuard, stateful 접근 방법 포함).  
- 표준 헤더를 사용하여 동일한 출처 확인
- Double submit cookie  
- SameSite 쿠키 속성  

참조 샘플 만 수행하고 완료되지는 않습니다 (예 : 출발지와 참조 자 헤더 확인에 성공하지도 않았고 참조 헤더에 대한 포트 / 호스트 / 프로토콜 수준 확인이없는 경우와 같이 제어 흐름을 지시하는 블록이없는 경우) ). 개발자는이 참조 샘플 위에 완전한 완화를 구축하는 것이 좋습니다. 개발자는 CSRF를 확인하기 전에 표준 인증 또는 권한 부여 검사를 구현해야합니다.  

소스도 여기에 있으며 실행 가능한 POC를 제공합니다.  

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

소스코드 주석 설명

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
 
