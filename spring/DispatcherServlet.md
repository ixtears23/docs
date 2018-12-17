# DispatcherServlet 소스 분석


## dispatcherServlet 요청 순서
1. doService  
2. **doDispatch** : 핸들러에 실제 디스패치를 처리합니다. 아래는 doDispatch 분석 내용  

1. WebAsyncUtils  
비동기 웹 요청 처리와 관련된 유틸리티 메소드입니다.  
현재 요청에 대해 WebAsyncManager를 가져 오거나 찾지 못한 경우 요청과 함께 만들어서 연결합니다.  
asyncManager를 가져온다. servletRequest의 getAttribute 이름은 WEB_ASYNC_MANAGER 가져온다.  
없으면 인스턴스화 해서 setAttribute 이름 WEB_ASYNC_MANAGER 한다.  

2. **Multipart인지 검사**한다.  
DispatcherServlet의 multipartResolver 가 null 이 아니고 multipart 요청이 맞는지 확인..


3. 현재 요청에 대한 **handler** 결정  
4. 현재 요청에 대한 **handler adapter** 결정  
5. Handler 에서 지원하는 경우 마지막으로 수정된 haeder를 처리한다.  
6. **Interceptor.preHandle** 실행  
7. **실제 handler 호출**  
8. **Interceptor.postHandle** 호출  
9. **Exception 검사**하고 **mav 렌더링** -> **locale 설정** header 정보의 accept-language 를 가져옴. (ko_kr, ko, en-US, en)  
dispatcherServlet 에 등록한 viewResolver 에 viewName과 local을 던져서 **view**를 가져옴. (jstlView) 없으면 다음 viewResolver 검색 반복.  
10. **interceptor.afterCompletion** 실행  
