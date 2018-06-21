## classpath*


### wildcard 란?

**와일드카드 문자**는 컴퓨터에서 특정 명령어로 명령을 내릴 때,  
**여러 파일을 한꺼번에 지정할 목적으로 사용하는 기호**를 가리킨다.  
이 문자는 어느 곳에서 사용하느냐에 따라 약간의 차이를 보인다.  
*주로 특정한 패턴이 있는 문자열 혹은 파일을 찾거나, 긴 이름을 생략할 때 쓰인다.*  


- `ls *a*` 중간에 a가 들어간 파일을 모두 출력
- `ls *` 모든 파일 출력
- `ls f*` 맨 처음 문자가 f인 파일을 모두 출력
- `ls *ff` 끝 문자가 ff로 끝나는 파일을 모두 출력
- `ls *f*` 중간에 f가 들어간 파일을 모두 출력
- `ls s*f` 시작 문자가 s, 끝 문자가 f로 끝나는 파일을 모두 출력


### AntPathMatcher

##### Spring 5.0.7 Class AntPathMatcher
- `?` 한 문자와 일치합니다.  
- `*`는 0 개 이상의 문자와 일치합니다.  
- `**` 경로의 0 개 이상의 디렉토리와 일치합니다.  
- `{spring : [a-z] +}`는 `regexp [a-z] +`를 "spring"이라는 경로 변수와 일치시킵니다.  

**example**  

- `com/t?st.jsp` — `com/test.jsp`뿐만 아니라 `com/tast.jsp` 또는 `com/txst.jsp`와 일치합니다.  
- `com/*.jsp` — `com` 디렉토리의 모든 `.jsp` 파일을 일치시킵니다.  
- `com/**/test.jsp` — `com` 경로 아래의 모든 test.jsp 파일을 일치시킵니다.  
- `org/springframework/**/*.jsp` — `org/springframework` 경로 아래의 모든 `.jsp` 파일을 일치시킵니다.  
- `org/**/servlet/bla.jsp` — `org/springframework/servlet/bla.jsp`와 일치하지만  
`org/springframework/testing/servlet/bla.jsp` 및 `org/servlet/bla.jsp`와 일치합니다.  
- `com/{filename:\\w+}.jsp` `com/test.jsp`와 일치하고 파일 이름 변수에 값 `test`를 할당합니다.  
