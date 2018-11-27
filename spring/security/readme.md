[SESSION ID로 CSRF 토큰을 사용하지 않는 이유](https://stackoverflow.com/questions/6968074/why-not-use-session-id-as-xsrf-token)  
[CSRF 이해](https://github.com/pillarjs/understanding-csrf)  

[깃 허브](https://github.com/aditzel/spring-security-csrf-filter)  
[스택오버플로우](https://stackoverflow.com/questions/20862299/with-spring-security-3-2-0-release-how-can-i-get-the-csrf-token-in-a-page-that)  
[참고](https://minwan1.github.io/2017/04/22/2017-04-22-spring-security-implement/)  

![csrf토큰](https://github.com/ixtears23/docs/blob/master/spring/security/csrf%20%ED%86%A0%ED%81%B0%20%EC%83%9D%EC%84%B1.PNG?raw=true)
- csrf Token 생성  
- UUID.randomUUID().toString();  

- parameterName: _csrf  
- headerName: X-CSRF-TOKEN  

