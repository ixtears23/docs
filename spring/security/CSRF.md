# Cross-Site Request Forgery (CSRF)


## 개요
사이트간 요청 위조(CSRF)는 최종 사용자가 현재 인증 된 웹 응용 프로그램에서 원치 않는 작업을 강제로 수행하는 공격입니다.  
CSRF 공격은 공격자가 위조 된 요청에 대한 응답을 볼 방법이 없기 때문에 데이터 도난이 아니라 상태 변경 요청을 대상으로합니다.  
소셜 엔지니어링 (이메일 또는 채팅을 통한 링크 보내기와 같은)의 도움으로 공격자는 웹 응용 프로그램의 사용자를 속여 공격자가 선택한 작업을 실행하게 할 수 있습니다.  
피해자가 일반 사용자 인 경우 CSRF 공격이 성공하면 자금 이동, 전자 메일 주소 변경 등과 같은 상태 변경 요청을 수행해야합니다.  
피해자가 관리 계정 인 경우 CSRF는 전체 웹 응용 프로그램을 손상시킬 수 있습니다.  

## 관련 보안 활동

- CSRF 취약성 코드 검토 방법  
CSRF [취약점 코드를 검토](https://www.owasp.org/index.php/Reviewing_code_for_Cross-Site_Request_Forgery_issues)하는 방법에 대한 
[OWASP 코드 검토 가이드](https://www.owasp.org/index.php/Category:OWASP_Code_Review_Project) 기사를 참조하십시오.  

- CSRF 취약성 테스트 방법  
[CSRF 취약점을 테스트](https://www.owasp.org/index.php/Testing_for_CSRF_(OTG-SESS-005))하는 방법에 대한 
[OWASP 테스트 가이드](https://www.owasp.org/index.php/OWASP_Testing_Project) 기사를 참조하십시오.  

- CSRF 취약성을 방지하는 방법  
예방 대책에 대해서는 [CSRF 예방 치트 시트](https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)_Prevention_Cheat_Sheet)를 참조하십시오.  
[OWASP Top 10 CSRF Podcast](https://www.owasp.org/download/jmanico/owasp_podcast_69.mp3)를 들어보십시오.  
대부분의 프레임 워크(Joomla, Spring, Struts, Ruby on Rails, .NET 및 기타)에는 CSRF 지원 기능이 내장되어 있습니다.  
[OWASP CSRF Guard](https://www.owasp.org/index.php/Category:OWASP_CSRFGuard_Project)를 사용하여 CSRF 보호를 Java 응용 프로그램에 추가하십시오.  
[CSRFProtector Project](https://www.owasp.org/index.php/CSRFProtector_Project)를 사용하여 PHP 응용 프로그램이나 Apache Server를 사용하여 
배포 한 모든 프로젝트를 보호 할 수 있습니다.  
OWASP에도 .Net CSRF Guard가 있지만 오래 되었고 완전하게 구현되지 않았습니다.  

John Melton은 [OWASP ESAPI](https://www.owasp.org/index.php/Category:OWASP_Enterprise_Security_API)의 기본 anti-CSRF 기능을 
사용하는 방법을 설명하는 훌륭한 [블로그](http://www.jtmelton.com/2010/05/16/the-owasp-top-ten-and-esapi-part-6-cross-site-request-forgery-csrf/) 게시물을 보유하고 있습니다.  



## 설명
CSRF는 피해자가 악의적인 요청을 제출하도록 유도하는 공격입니다.  
피해자의 신분과 특권을 상속하여 피해자를 대신하여 바람직하지 않은 기능을 수행합니다.  
대부분의 사이트에서 브라우저 요청은 사용자의 세션 쿠키, IP 주소, Windows 도메인 자격 증명 등과 같이 사이트와 관련된 자격 증명을 자동으로 포함합니다.  
따라서 사용자가 현재 사이트에 대해 인증을받은 경우 사이트는 피해자가 보낸 위조 요청과 피해자가 보낸 합법적인 요청을 구별 할 방법이 없습니다.  

CSRF는 피해자의 전자 메일 주소 나 암호를 변경하거나 물건을 구매하는 것과 같이 서버의 상태가 변경되는 대상 기능을 공격합니다.  
피해자가 데이터를 검색하도록 강요하면 공격자가 응답을받지 못하기 때문에 공격자에게 이익이되지 않습니다.  
이와 같이 CSRF 공격은 상태 변경을 요청 합니다.  

때때로 취약한 사이트 자체에 CSRF 공격을 저장할 수 있습니다. 이러한 취약점을 "저장된 CSRF 결함"이라고합니다.  
HTML을 허용하는 필드에 IMG 또는 IFRAME 태그를 저장하거나 더 복잡한 교차 사이트 스크립팅 공격을 수행하면됩니다.  
공격이 사이트에서 CSRF 공격을 저장할 수 있으면 공격의 심각도가 증폭됩니다.  
특히, 희생자가 인터넷에 있는 임의의 페이지보다 공격이 포함 된 페이지를 볼 가능성이 높기 때문에 가능성이 증가합니다.  
피해자가 사이트에서 이미 인증을 받았기 때문에 가능성이 높아집니다.  

### Synonyms
CSRF 공격은 XSRF, "Sea Surf", Session Riding, Cross-Site Reference Forgery 및 Hostile Linking를 비롯한 여러 다른 이름으로도 알려져 있습니다.  
Microsoft는 이러한 유형의 공격을 위협 모델링 프로세스 및 온라인 설명서의 여러 곳에서 원 클릭 공격으로 지칭합니다.  

---

# 작동하지 않는 예방 조치

## secret cookie 사용  
모든 쿠키, 심지어 secret cookie는 모든 요청과 함께 제출된다는 점을 기억하십시오.  
모든 인증 토큰은 최종 사용자가 속여서 요청을 제출했는지 여부에 관계없이 제출됩니다.  
또한 세션 식별자는 응용 프로그램 컨테이너에서 특정 세션 개체와 요청을 연결하는 데 사용됩니다.  
세션 식별자는 최종 사용자가 요청을 제출할 의도가 있는지 확인하지 않습니다.  

## POST 요청만 수락합니다.
응용 프로그램은 비즈니스 로직 실행을위한 POST 요청 만 수락하도록 개발할 수 있습니다.  
공격자가 악성 링크를 만들 수 없으므로 CSRF 공격을 실행할 수 없다는 논리는 올바르지 않습니다.  
공격자가 숨겨진 값으로 공격자의 웹 사이트에서 호스팅되는 단순한 양식과 같이 위조 된 POST 요청을 제출하도록 
피해자를 속일 수있는 다양한 방법이 있습니다.  
이 양식은 JavaScript에 의해 자동으로 트리거 될 수 있거나 양식이 다른 작업을한다고 생각하는 피해자에 의해 트리거 될 수 있습니다.  

CSRF 공격을 방어하기 위한 여러 가지 결함있는 아이디어가 시간이 지남에 따라 개발되었습니다. 다음은 피하는 것이 좋습니다.  

## 다중 단계 트랜잭션
Multi-Step 트랜잭션은 CSRF를 적절히 예방하지 못합니다. 공격자가 완료된 트랜잭션의 각 단계를 예측하거나 추론 할 수 있는 한 CSRF가 가능합니다.  

## URL 다시 쓰기
이것은 공격자가 희생자의 세션 ID를 추측 할 수 없기 때문에 유용한 CSRF 예방 기법으로 볼 수 있습니다.  
그러나 사용자의 세션 ID는 URL에 표시됩니다. 다른 보안 결함을 도입하여 하나의 보안 결함을 수정하는 것은 권장되지 않습니다.  

## HTTPS
HTTPS 자체만으로 CSRF를 방어하지 않습니다.  
그러나 HTTPS는 모든 예방 조치가 신뢰할 수 있는 전제 조건으로 간주 되어야 합니다.

---

## Examples

### 공격은 어떻게 이루어 집니까?
최종 사용자가 웹 응용 프로그램에서 정보를 로드 하거나 정보를 웹 응용 프로그램에 전송하는 방법에는 여러 가지가 있습니다.  
공격을 실행하려면 피해자가 실행될 수 있는 유효한 악의적인 요청을 생성하는 방법을 먼저 이해해야합니다.  
다음 예제를 생각해 보겠습니다.  
Alice는 CSRF에 취약한 bank.com 웹 응용 프로그램을 사용하여 Bob에게 $ 100을 이체하려고합니다.  
공격자인 마리아 (Maria)는 앨리스에게 대신 돈을 보내는 트릭을 원합니다. 공격은 다음 단계로 구성됩니다.  
1. 악용 URL 또는 스크립트 작성
2. 앨리스가 [social engineering](https://www.owasp.org/index.php/Social_Engineering) action을 하도록 한다.  

#### GET scenario
응용 프로그램이 매개 변수를 전송하고 작업을 실행하기 위해 주로 GET 요청을 사용하도록 설계된 경우  
송금 작업이 다음과 같은 요청으로 축소 될 수 있습니다.  
~~~javascript
GET http://bank.com/transfer.do?acct=BOB&amount=100 HTTP/1.1
~~~
마리아는 앨리스를 희생자로 사용하여 이 웹 애플리케이션 취약점을 악용하기로 결정했습니다.  
Maria는 먼저 Alice의 계정에서 그녀의 계정으로 $100,000을 이전하는 다음 악용 URL을 구성합니다.  
그녀는 원래의 명령 URL을 취하여 수혜자 이름을 자신의 것으로 바꿔 동시에 양도 금액을 크게 상향 조정합니다.  
~~~javascript
http://bank.com/transfer.do?acct=MARIA&amount=100000
~~~

공격의 social engineering 관점은 Alice가 은행 응용 프로그램에 로그인 할 때 이 URL을 로드하는 것을 속입니다.  
이것은 대개 다음 기술 중 하나를 사용하여 수행됩니다.  
- HTML 콘텐츠가있는 원치 않는 전자 메일 보내기  
- 희생자가 온라인 뱅킹을 수행하는 동안 방문 할 가능성이 있는 페이지에 악용 URL 또는 스크립트 심기  

악용 URL은 피해자가 클릭하는 것을 권장하는 일반적인 링크로 위장 할 수 있습니다.  
~~~html
<a href="http://bank.com/transfer.do?acct=MARIA&amount=100000">View my Pictures!</a>
~~~
또는 0x0 가짜 이미지로 :
~~~html
<img src="http://bank.com/transfer.do?acct=MARIA&amount=100000" width="0" height="0" border="0">
~~~
이 이미지 태그가 이메일에 포함되어 있어도 Alice는 아무 것도 볼 수 없습니다.  
그러나 브라우저는 전송이 완료되었음을 시각적으로 표시하지 않고 bank.com에 요청을 제출합니다.    
GET을 사용하는 애플리케이션에 대한 CSRF 공격의 실제 사례는 악성 코드를 다운로드 하기 위해  
대규모로 사용 된 2008 년의 [uTorrent 악용](https://www.ghacks.net/2008/01/17/dos-vulnerability-in-utorrent-and-bittorrent/)이었습니다.  


#### POST scenario
GET 공격과 POST 공격의 유일한 차이점은 공격이 희생자에 의해 어떻게 실행되고 있는지입니다.  
이제 은행에서 POST를 사용한다고 가정하고 취약한 요청은 다음과 같습니다.  
~~~javascript
POST http://bank.com/transfer.do HTTP/1.1

acct=BOB&amount=100
~~~
이러한 요청은 표준 `A` 또는 `IMG` 태그를 사용하여 전달할 수 없지만 `FORM` 태그를 사용하여 전달할 수 있습니다.  
~~~html
<form action="<nowiki>http://bank.com/transfer.do</nowiki>" method="POST">
<input type="hidden" name="acct" value="MARIA"/>
<input type="hidden" name="amount" value="100000"/>
<input type="submit" value="View my pictures"/>
</form>
~~~
이 양식을 사용하려면 사용자가 제출 버튼을 클릭해야하지만 JavaScript를 사용하여 자동으로 실행할 수도 있습니다.  
~~~html
<body onload="document.forms[0].submit()">
<form...
~~~

#### Other HTTP methods
최신 웹 응용 프로그램 API는 PUT 또는 DELETE와 같은 다른 HTTP 메소드를 자주 사용합니다.  
취약한 은행이 JSON 블록을 인수로 사용하는 PUT을 사용한다고 가정 해 보겠습니다.  
~~~javascript
PUT http://bank.com/transfer.do HTTP/1.1

{ "acct":"BOB", "amount":100 }
~~~
이러한 요청은 악성 페이지에 삽입 된 JavaScript로 실행될 수 있습니다.
~~~html
<script>
function put() {
	var x = new XMLHttpRequest();
	x.open("PUT","http://bank.com/transfer.do",true);
	x.setRequestHeader("Content-Type", "application/json"); 
	x.send(JSON.stringify({"acct":"BOB", "amount":100})); 
}
</script>
<body onload="put()">
~~~

다행히도, 이 요청은 [동일한 출처 정책](https://www.owasp.org/index.php/Same-Origin_Policy) 제한으로 현대 웹 브라우저에서 실행되지 않습니다.  
이 제한은 기본적으로 대상 웹 사이트가 다음 헤더와 함께 CORS를 사용하여 공격자 (또는 모든 사람)의 출처와  
교차 출처 요청을 열지 않는 한 활성화 됩니다.
~~~javascript
Access-Control-Allow-Origin: *
~~~

## 관련공격
- [Cross-site Scripting(XSS)](https://www.owasp.org/index.php/Cross-site_Scripting_(XSS))  
- [Cross Site History Manipulation(XSHM)](https://www.owasp.org/index.php/Cross_Site_History_Manipulation_(XSHM))  

## 관련 컨트롤
- 표준 세션 외에 URL 및 모든 양식에 요청 별로 추가하십시오.  
이것은 "form keys"라고도합니다.  
많은 프레임 워크 (예:Drupal.org 4.7.4 이상)는 모든 유형에 "내장"된 보호 유형을 포함하거나 시작하기 때문에  
프로그래머는이 보호 기능을 수동으로 코딩 할 필요가 없습니다.  
- 모든 양식(forms)에 해시 (세션 ID, 함수 이름, 서버 측 비밀)를 추가하십시오.  
- .NET의 경우, MAC을 사용하여 ViewState에 세션 식별자를 추가하십시오 (CSRF 예방 치트 시트에 자세히 설명되어 있음).  
- 클라이언트의 HTTP 요청에서 리퍼러 헤더를 확인하면 CSRF 공격을 막을 수 있습니다.  
HTTP 요청이 원래 사이트에서 왔는지 확인하면 다른 사이트의 공격이 작동하지 않는다는 것을 의미합니다.  
메모리 제한으로 인해 임베디드 네트워크 하드웨어에서 사용되는 리퍼러 헤더 검사를 보는 것은 매우 일반적입니다.  
  - XSS를 사용하여 참조 자와 토큰 기반 검사를 동시에 무시할 수 있습니다.  
  예를 들어, Samy 웜은 요청 위조에 사용하기 위한 CSRF 토큰을 얻기 위해 XHR을 사용했습니다.  
- CSRF는 근본적으로 사용자가 아닌 웹 응용 프로그램의 문제이지만 사용자는 다른 사이트를 방문하기 전에 사이트에서 로그 오프하거나  
각 브라우저 세션이 끝날 때 브라우저의 쿠키를 지워서 제대로 설계되지 않은 사이트에서 자신의 계정을 보호 할 수 있습니다.  
- [토큰화하기](https://www.owasp.org/index.php/Tokenizing)  

