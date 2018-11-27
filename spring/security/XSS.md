# Cross-site Scripting (XSS)

## 개요
XSS(Cross-Site Scripting) 공격은 악의적인 스크립트를 다른 웹 사이트에 주입하는 일종의 주사입니다.  
XSS 공격은 공격자가 웹 응용 프로그램을 사용하여 일반적으로 브라우저 측 스크립트의 형태로 악의적인 코드를  
다른 최종 사용자에게 전송할 때 발생합니다. 이러한 공격을 성공으로 이끌어 낼 수 있는 결함은 매우 널리 퍼져 있으며  
웹 응용 프로그램이 사용자가 입력 한 내용을 유효성을 검사하거나 인코딩하지 않고 생성 된 출력에서 사용하는 곳이라면 어디에서나 발생할 수 있습니다.  

공격자는 XSS를 사용하여 의심하지 않는 사용자에게 악성 스크립트를 보낼 수 있습니다.  
최종 사용자의 브라우저는 스크립트가 신뢰 되어서는 안된다는 것을 알 수 없으며 스크립트를 실행할 것입니다.  
스크립트가 신뢰할 수있는 출처에서 왔다고 생각하기 때문에 악의적 인 스크립트는  
브라우저가 보유한 쿠키, 세션 토큰 또는 기타 중요한 정보에 액세스하여 해당 사이트에서 사용할 수 있습니다.  
이 스크립트는 HTML 페이지의 내용을 다시 작성할 수도 있습니다.  
다양한 유형의 XSS 결함에 대한 자세한 내용은 다음을 참조하십시오. [Types of Cross-Site Scripting](https://www.owasp.org/index.php/Types_of_Cross-Site_Scripting).  

## 관련 보안 활동

### Cross-site scripting 취약점을 피하는 방법
[XSS(Cross-site scripting)방지 치트 시트](https://www.owasp.org/index.php/XSS_(Cross_Site_Scripting)_Prevention_Cheat_Sheet)  
[DOM 기반 XSS 예방 치트 시트](https://www.owasp.org/index.php/DOM_based_XSS_Prevention_Cheat_Sheet)  
[피싱](https://www.owasp.org/index.php/Phishing)에 대한 [OWASP 개발 가이드 문서](https://www.owasp.org/index.php/OWASP_Guide_Project)를 참조하십시오.  
OWASP 개발 가이드 [데이터 유효성 검사](https://www.owasp.org/index.php/Data_Validation)에 관한 기사를 참조하십시오.  


.. 중략.. 나중에.. 시간없음..
