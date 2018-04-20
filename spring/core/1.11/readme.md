## 1.11. Using JSR 330 Standard Annotations(JSR 330 표준 주석 사용)

Spring 3.0부터 Spring은 **JSR-330 표준 주석 (Dependency Injection)을 지원**한다.  
이러한 주석은 **Spring 주석과 동일한 방식으로 스캔**됩니다. 클래스 패스에 관련 항아리(jar)가 있어야합니다.  

---
Maven을 사용하는 경우,  
`javax.inject` 이슈는 표준 Maven 저장소 (http://repo1.maven.org/maven2/javax/inject/javax.inject/1/)  
에서 사용할 수 있습니다. pom.xml 파일에 다음 종속성을 추가 할 수 있습니다.  

~~~xml
<dependency>
    <groupId>javax.inject</groupId>
    <artifactId>javax.inject</artifactId>
    <version>1</version>
</dependency>
~~~
---
