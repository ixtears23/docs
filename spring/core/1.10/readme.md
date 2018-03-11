# 1.10. Classpath scanning and managed components (Classpath 검색 및 관리되는 구성 요소) 

이 장의 대부분의 **예제**는 **XML을 사용하여 Spring 컨테이너 내에  
각 BeanDefinition을 생성하는 구성 메타 데이터를 지정**합니다.  

이전 섹션 (annotation 기반 컨테이너 구성)에서는 소스 레벨 annotation을 통해  
많은 구성 메타 데이터를 제공하는 방법을 보여줍니다.  
그러나 이러한 예제에서도 **"base"bean 정의는 XML 파일에 명시 적으로 정의**되지만  
**annotation은 종속성 주입을 유도**합니다.  

이 절에서는 **classpath를 스캔**하여 **후보(Candidate) 구성 요소를 내재적으로 감지하는 옵션**에 대해 설명합니다.  

**후보(Candidate) 컴포넌트**는 **필터 기준과 일치**하고 **해당 bean 정의가 컨테이너에 등록 된 클래스**입니다.  
따라서 **Bean 등록을 수행하기 위해 XML을 사용할 필요가 없습니다.**  

**대신 어노테이션 (예 : @Component), AspectJ 유형 표현식(expressions)** 또는 **사용자 정의 필터 기준을 사용**하여  
**컨테이너에 등록 된 bean 정의를 가질 클래스를 선택할 수 있습니다.**  

---
**Spring 3.0**부터는 **Spring JavaConfig 프로젝트**가 제공하는 많은 기능들이 핵심 Spring 프레임 워크의 일부이다.  
이를 통해 ***전통적인 XML 파일을 사용하는 대신*** **Java를 사용하여 Bean을 정의 할 수 있습니다.**  
이러한 새로운 기능을 *사용하는 방법에 대한 예제는*  
**@Configuration, @Bean, @Import 및 @DependsOn 주석을 살펴보십시오.**  
