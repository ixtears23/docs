# Spring IoC 컨테이너와 빈에 대한 소개

이 장에서는 IoC (Inversion of Control) [1] 원리의 Spring Framework 구현에 대해 다룹니다.  
IoC는 종속성 주입 (DI)이라고도합니다.  
이것은 객체가 생성자 인수, 팩토리 메소드에 대한 인수 또는 팩토리 메소드에서 생성되거나 리턴 된 객체 인스턴스에 설정된 특성을 통해서만  
종속성, 즉 작업하는 다른 객체를 정의하는 프로세스입니다.  
그런 다음 컨테이너는 Bean을 작성할 때 이러한 종속성을 주입합니다.  
이 프로세스는 근본적으로 반비례하므로 클래스 직접 작성 또는 Service Locator 패턴과 같은  
메커니즘을 사용하여 종속성의 인스턴스 또는 위치를 제어하는 Bean 자체의 Inversion of Control (IoC)입니다.  


org.springframework.beans와 org.springframework.context 패키지는 Spring Framework의 IoC 컨테이너의 기초

ApplicationContext 는 Bean factory의 완전한 수퍼셋

Bean factory
BeanFactory 인터페이스는 모든 유형의 객체를 관리 할 수있는 고급 구성 메커니즘을 제공합니다. 
BeanFactory는 구성 프레임 워크와 기본 기능을 제공


ApplicationContext
ApplicationContext는 BeanFactory의 하위 인터페이스입니다.
ApplicationContext는 더 많은 엔터프라이즈 별 기능을 추가합니다.


Spring에서는 애플리케이션의 백본을 형성하고  
**Spring IoC 컨테이너에 의해 관리되는 객체**를 **Bean**이라고 부른다.

Bean은 Spring IoC 컨테이너에 의해 인스턴스화, 어셈블 링 및 관리되는 객체이다.  
위의 말처럼 관리되지 않는다면 빈은 응용 프로그램의 많은 객체 중 하나 일뿐입니다.  

빈들과 그 사이의 의존성은 컨테이너가 사용하는 컨피규레이션 메타 데이터에 반영됩니다.  

### Container overview
`org.springframework.context.ApplicationContext` 인터페이스는  
Spring IoC 컨테이너를 나타내며  
앞서 언급 한 bean을 인스턴스화, 구성 및 어셈블 할 책임이있다.  

컨테이너는 구성 메타 데이터를 읽음으로써 인스턴스화, 구성 및 어셈블 할 객체에 대한 지침을 가져옵니다.  
구성 메타 데이터는 XML, Java 어노테이션 또는 Java 코드로 표시됩니다.  
이 도구를 사용하면 응용 프로그램을 구성하는 개체와 그러한 개체 간의 풍부한 상호 종속성을 표현할 수 있습니다.  

ApplicationContext 인터페이스의 여러 구현은 Spring과 함께 즉시 제공됩니다.  
독립 실행 형 응용 프로그램에서는  
`ClassPathXmlApplicationContext` 또는 `FileSystemXmlApplicationContext`의 인스턴스를 만드는 것이 일반적입니다.  

XML은 컨피규레이션 메타 데이터를 정의하기위한 전통적인 형식 이었지만  
컨테이너에 Java 주석이나 코드를 메타 데이터 형식으로 사용하도록 지시 할 수 있습니다.  
...

### 1.2.1. Configuration metadata
Spring IoC 컨테이너는 구성 메타 데이터의 형태를 사용한다.  
이 구성 메타 데이터는 애플리케이션 개발자가 Spring 컨테이너에게  
애플리케이션의 객체를 인스턴스화, 구성 및 어셈블하도록 지시하는 방법을 나타냅니다.  

컨피규레이션 메타 데이터는 전통적으로 간단하고 직관적 인 XML 형식으로 제공되며,  
이 장의 대부분은 Spring IoC 컨테이너의 주요 개념과 기능을 전달하는 데 사용된다.  

> XML 기반 메타 데이터는 구성 메타 데이터의 유일한 허용 형식이 아닙니다.  
> Spring IoC 컨테이너 자체는이 구성 메타 데이터가 실제로 작성된 형식과 완전히 분리되어있다.  
> 요즘 많은 개발자들이 Spring 애플리케이션을위한 Java 기반의 구성을 선택합니다.  

Spring 컨테이너에서 다른 형식의 메타 데이터를 사용하는 방법에 대한 정보는 다음을 참조하십시오.  
[어노테이션 기반 설정](https://docs.spring.io/spring/docs/5.0.4.BUILD-SNAPSHOT/spring-framework-reference/core.html#beans-annotation-config)
: 스프링 2.5는 어노테이션 기반 설정 메타 데이터에 대한 지원을 도입했다.  
[Java 기반 구성](https://docs.spring.io/spring/docs/5.0.4.BUILD-SNAPSHOT/spring-framework-reference/core.html#beans-java)  
: Spring 3.0부터는 Spring JavaConfig 프로젝트가 제공하는 많은 기능들이 핵심 Spring 프레임 워크의 일부가되었다.  
따라서 XML 파일이 아닌 Java를 사용하여 응용 프로그램 클래스 외부의 Bean을 정의 할 수 있습니다.  
이러한 새로운 기능을 사용하려면 @Configuration, @Bean, @Import 및 @DependsOn 주석을 참조하십시오.  

Spring 설정은 컨테이너가 관리해야하는 하나 이상의 빈 정의로 구성된다.  
XML 기반 구성 메타 데이터는 최상위 레벨 `<beans />` 요소 내에 `<bean />` 요소로 구성된 이러한 bean을 표시합니다.  
Java 구성은 일반적으로 `@Configuration` 클래스 내에서 `@Bean` 주석이있는 메소드를 사용합니다.  

이 bean 정의는 응용 프로그램을 구성하는 실제 객체에 해당합니다.  

??
일반적으로 서비스 계층 개체, 데이터 액세스 개체 (DAO), Struts Action 인스턴스와 같은 프레젠테이션 개체,  
Hibernate SessionFactories, JMS Queue와 같은 인프라 개체 등을 정의합니다.  
일반적으로 도메인 객체를 만들고로드하는 것은 DAO와 비즈니스 로직의 책임이기 때문에  
일반적으로 컨테이너에 Fine-grained 도메인 객체를 구성하지 않습니다.  
??

그러나 AspectJ와 Spring의 통합을 사용하여 IoC 컨테이너의 제어 범위 밖에서 생성 된 객체를 구성 할 수있다.  
[AspectJ를 사용하여 Spring에 의존성 삽입 도메인 객체를 참조하십시오.](https://docs.spring.io/spring/docs/5.0.4.BUILD-SNAPSHOT/spring-framework-reference/core.html#aop-atconfigurable)  

다음 예제는 XML 기반 구성 메타 데이터의 기본 구조를 보여줍니다.  

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="..." class="...">
        <!-- collaborators and configuration for this bean go here -->
    </bean>

    <bean id="..." class="...">
        <!-- collaborators and configuration for this bean go here -->
    </bean>

    <!-- more bean definitions go here(더 많은 bean 정의가 여기에있다.) -->

</beans>
~~~

id 속성은 개별 bean 정의를 식별하는 데 사용하는 문자열입니다.  
class 속성은 빈의 유형을 정의하고 완전한 클래스 이름을 사용합니다.  
id 속성 값은 협업하는 객체를 참조합니다.  
협업 오브젝트를 참조하기위한 XML은이 예제에 표시되지 않습니다.  
[자세한 정보는 종속성을 참조하십시오.](https://docs.spring.io/spring/docs/5.0.4.BUILD-SNAPSHOT/spring-framework-reference/core.html#beans-dependencies)  

### 1.2.2. Instantiating a container
Spring IoC 컨테이너를 인스턴스화하는 것은 간단하다.  
ApplicationContext 생성자에 제공된 위치 경로는 실제로 컨테이너가  
Java CLASSPATH 등의 로컬 파일 시스템과 같은  
다양한 외부 리소스의 구성 메타 데이터를로드 할 수있게하는 리소스 문자열입니다.  
~~~java
ApplicationContext context = new ClassPathXmlApplicationContext("services.xml", "daos.xml");
~~~
??
Spring의 IoC 컨테이너에 대해 알게 된 후에는 Resources에서 설명한 것처럼  
Spring의 Resource 추상화에 대해 더 알고 싶을 것이다.  
URI 구문에서 정의 된 위치에서 InputStream을 읽는 편리한 메커니즘을 제공한다.  
특히 리소스 경로는 응용 프로그램 컨텍스트 및 리소스 경로에서 설명한대로 응용 프로그램 컨텍스트를 구성하는 데 사용됩니다.  
??
다음 예제에서는 서비스 계층 객체 (services.xml) 구성 파일을 보여줍니다.  
~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd">

    <!-- services -->

    <bean id="petStore" class="org.springframework.samples.jpetstore.services.PetStoreServiceImpl">
        <property name="accountDao" ref="accountDao"/>
        <property name="itemDao" ref="itemDao"/>
        <!-- additional collaborators and configuration for this bean go here -->
    </bean>

    <!-- more bean definitions for services go here -->

</beans>
~~~
다음 예제는 데이터 액세스 객체 daos.xml 파일을 보여줍니다.  
~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="accountDao"
        class="org.springframework.samples.jpetstore.dao.jpa.JpaAccountDao">
        <!-- additional collaborators and configuration for this bean go here -->
    </bean>

    <bean id="itemDao" class="org.springframework.samples.jpetstore.dao.jpa.JpaItemDao">
        <!-- additional collaborators and configuration for this bean go here -->
    </bean>

    <!-- more bean definitions for data access objects go here -->

</beans>
~~~
앞의 예에서 서비스 계층은 PetStoreServiceImpl 클래스와 JpaAccountDao 및 JpaItemDao 유형의  
두 데이터 액세스 객체 (JPA 객체 / 관계 매핑 표준을 기반으로 함)로 구성됩니다.  
property name 요소는 JavaBean 속성의 이름을 참조하고 ref 요소는 다른 bean 정의의 이름을 참조합니다.  
id와 ref 요소 사이의이 연결은 공동 작업 객체 간의 종속성을 나타냅니다.  
[객체의 종속성 구성에 대한 자세한 내용은 종속성을 참조하십시오.](https://docs.spring.io/spring/docs/5.0.4.BUILD-SNAPSHOT/spring-framework-reference/core.html#beans-dependencies)  

##### XML 기반 구성 메타 데이터 작성(Composing XML-based configuration metadata)
빈 정의가 여러 XML 파일에 걸쳐있는 것이 유용 할 수 있습니다.  
각 개별 XML 구성 파일은 종종 아키텍처의 논리 계층 또는 모듈을 나타냅니다.  

응용 프로그램 컨텍스트 생성자를 사용하여 모든 XML 조각에서 bean 정의를로드 할 수 있습니다.  
이 생성자는 이전 섹션에서 설명한 것처럼 여러 Resource 위치를 사용합니다.  
또는 하나 이상의 `<import />` 요소를 사용하여 다른 파일의 bean 정의를로드하십시오.  
예 : 
~~~xml
<beans>
    <import resource="services.xml"/>
    <import resource="resources/messageSource.xml"/>
    <import resource="/resources/themeSource.xml"/>

    <bean id="bean1" class="..."/>
    <bean id="bean2" class="..."/>
</beans>
~~~
앞의 예제에서 외부 bean 정의는 세 파일에서로드됩니다.  
services.xml, messageSource.xml 및 themeSource.xml  
services.xml은 import를 수행하는 파일과 동일한 디렉토리 또는 클래스 경로 위치에 있어야하며,  
messageSource.xml 및 themeSource.xml은 resource/ 위치에 있어야합니다.  
보시다시피, 선행 슬래시는 무시되지만,  
이 경로는 상대 경로이므로 슬래시를 전혀 사용하지 않는 것이 더 좋습니다.  
최상위 수준 인 `<beans />` 요소를 포함하여 가져올 파일의 내용은  
Spring 스키마에 따라 유효한 XML bean 정의 여야합니다.  ?

> 상대적 "../"경로를 사용하여 상위 디렉토리의 파일을 참조하는 것은 가능하지만 권장하지는 않습니다.  
> 이렇게하면 현재 응용 프로그램 외부에있는 파일에 대한 종속성이 만들어집니다.  
> 특히,이 참조는 "classpath :"URL (예 : "classpath : ../ services.xml")에는 권장되지 않습니다.  
> 여기서 런타임 확인 프로세스는 "가장 가까운"클래스 경로 루트를 선택하고 상위 디렉토리를 조사합니다.  
> 클래스 경로 구성 변경으로 인해 다른 디렉토리가 잘못 선택 될 수 있습니다.  
> 
> 상대 경로 대신 정규화 된 리소스 위치를 항상 사용할 수 있습니다 
> 예:"file:C:/config/services.xml" or "classpath:/config/services.xml"  
> 그러나 응용 프로그램의 구성을 특정 절대 위치에 연결한다는 점에 유의하십시오.  
> 일반적으로 런타임시 JVM 시스템 속성에 대해 확인되는 "$ {...}"자리 표시자를 통해  
> 절대 위치에 대한 간접 참조를 유지하는 것이 바람직합니다.  

import 지시문은 bean 네임 스페이스 자체에서 제공하는 기능입니다.  
일반 Bean 정의를 뛰어 넘는 추가 구성 기능은 Spring에서 제공하는 XML 네임 스페이스 중에서 선택할 수 있습니다.  
"context"및 "util"네임 스페이스.  

### 1.2.3. Using the container
ApplicationContext는 다른 Bean과 그 의존성의 레지스트리를 유지 보수 할 수있는 고급 팩토리의 인터페이스입니다.  
`T getBean (String name, Class <T> requiredType)` 메소드를 사용하여 bean의 인스턴스를 검색 할 수 있습니다.  

`ApplicationContext`를 사용하면 Bean 정의를 읽고 다음과 같이 액세스 할 수 있습니다.  
~~~java
// create and configure beans
ApplicationContext context = new ClassPathXmlApplicationContext("services.xml", "daos.xml");

// retrieve configured instance(구성된 인스턴스 검색)
PetStoreService service = context.getBean("petStore", PetStoreService.class);

// use configured instance(구성된 인스턴스 사용)
List<String> userList = service.getUsernameList();
~~~

가장 유연한 변형은 `GenericApplicationContext`이며 리더 위임자와 함께 사용됩니다.  
XML 파일 용 XmlBeanDefinitionReader 사용 :  
~~~java
GenericApplicationContext context = new GenericApplicationContext();
new XmlBeanDefinitionReader(context).loadBeanDefinitions("services.xml", "daos.xml");
context.refresh();
~~~
이러한 리더 위임자는 동일한 ApplicationContext에서 혼합되고 매치되어 원할 경우 다양한 구성 소스의 Bean 정의를 읽을 수 있습니다.  

그런 다음 `getBean`을 사용하여 빈의 인스턴스를 검색 할 수 있습니다.  
ApplicationContext 인터페이스에는 Bean을 검색하는 몇 가지 다른 메소드가 있지만  
이상적으로 애플리케이션 코드는 이를 사용하지 않아야합니다.  
실제로 애플리케이션 코드에는 getBean () 메소드에 대한 호출이 전혀 없어야하므로 Spring API에 전혀 의존하지 않는다.  
예를 들어 Spring의 웹 프레임 워크와의 통합은  
컨트롤러 및 JSF 관리 빈과 같은 다양한 웹 프레임 워크 구성 요소에 대한 종속성 주입을 제공하므로  
메타 데이터 (예 : 자동 와이어 링 주석)를 통해 특정 빈에 대한 종속성을 선언 할 수 있습니다.  
??

### 1.3. Bean overview

Spring IoC 컨테이너는 하나 이상의 빈을 관리한다.  
이 bean은 컨테이너에 제공하는 구성 메타 데이터 (예 : XML <bean /> 정의의 양식)로 작성됩니다.  
컨테이너 내부에서 이러한 bean 정의는 (다른 정보들 사이에서) 다음 메타 데이터를 포함하는 BeanDefinition 객체로 표현됩니다.  

- (A package-qualified class name:)패키지 수식 클래스 명 : 일반적으로, 정의되고있는 bean의 실제의 구현 클래스.  
- Bean이 컨테이너에서 작동하는 방법 (범위, 수명주기 콜백 등)을 나타내는 Bean 비헤이비어 구성 요소. ?
- Bean이 작업을 수행하는 데 필요한 다른 bean에 대한 참조. 이러한 참조는 공동 작업자(called collaborators) 또는 종속성이라고도합니다.  
- 새로 생성 된 객체에 설정할 기타 구성 설정 (예 : 연결 풀을 관리하는 Bean에서 사용할 연결 수 또는 풀의 크기 제한).  

이 메타 데이터는 각 bean 정의를 구성하는 속성 세트로 변환됩니다.  
bean 정의

| Property 	    | Explained in…  | 
| :----------- | :-------------: | 
| class     | Instantiating beans  |
| name    | Naming beans |
| scope | Bean scopes |
| constructor arguments    | Dependency Injection  |
| properties    | Dependency Injection  |
| autowiring mode   | Autowiring collaborators |
| lazy-initialization mode | Lazy-initialized beans |
| initialization method | Initialization callbacks |
| destruction method | Destruction callbacks |

특정 bean을 작성하는 방법에 대한 정보가 들어있는 bean 정의 외에,  
ApplicationContext 구현은 사용자가 컨테이너 외부에서 생성 된 기존 객체의 등록도 허용합니다.  
이것은 BeanFactory 구현 DefaultListableBeanFactory를 리턴하는 getBeanFactory () 메소드를 통해  
ApplicationContext의 BeanFactory에 액세스함으로써 이루어진다.  
DefaultListableBeanFactory는 registerSingleton (..) 및 registerBeanDefinition (..) 메소드를 통해이 등록을 지원합니다.  
그러나 일반적인 응용 프로그램은 메타 데이터 bean 정의를 통해 정의 된 bean에서만 작동합니다.  

> Bean 메타 데이터와 수동으로 제공되는 싱글 톤 인스턴스는 자동 와이어 링 및 기타 인트로 스펙 션 단계에서  
> 컨테이너가 컨테이너에 대해 적절히 추론 할 수 있도록 가능한 빨리 등록해야합니다.  
> 기존 메타 데이터와 기존 싱글 톤 인스턴스의 오버라이드는 어느 정도 지원되지만,  
> 런타임시 새 bean의 등록 (팩토리에 대한 라이브 액세스와 동시에)은 공식적으로 지원되지 않으며  
> 콩 컨테이너에서 동시 액세스 예외 및 / 또는 불일치 상태를 유발할 수 있습니다. ?  

### 1.3.1. Naming beans
[Naming beans](https://docs.spring.io/spring/docs/5.0.4.BUILD-SNAPSHOT/spring-framework-reference/core.html#beans-beanname)
모든 빈에는 하나 이상의 식별자가 있습니다.  
이러한 식별자는 Bean을 호스팅하는 컨테이너 내에서 고유해야합니다.  
bean은 대개 단 하나의 식별자를 가지고 있지만, 하나 이상의 식별자가 필요한 경우 여분의 식별자는 별칭으로 간주 될 수 있습니다.  
XML 기반 구성 메타 데이터에서 id 및 / 또는 name 속성을 사용하여 bean 식별자를 지정합니다.  
id 속성을 사용하면 정확히 하나의 id를 지정할 수 있습니다.  
일반적으로 이러한 이름은 영숫자 ( 'myBean', 'fooService'등)이지만 특수 문자도 포함 할 수 있습니다.  
Bean에 다른 별명을 도입하려는 경우, 이름 속성에 쉼표 (,), 세미콜론 (;) 또는 공백으로 구분하여 지정할 수 있습니다.  
Spring 3.1 이전의 버전에서 역사적 기록으로 id 속성은 가능한 문자를 제한하는 xsd : ID 유형으로 정의되었습니다.  
3.1부터는 xsd : string 유형으로 정의됩니다.  
bean id 고유성은 여전히 컨테이너에 의해 시행되지만 XML 파서는 더 이상 필요하지 않습니다.  

빈에 대한 이름이나 ID를 제공 할 필요는 없습니다.  
이름이나 ID가 명시 적으로 제공되지 않으면 컨테이너는 해당 bean에 대해 고유 한 이름을 생성합니다.  
그러나 ref 요소 나 Service Locator 스타일 조회를 사용하여 이름으로 빈을 참조하려는 경우 이름을 제공해야합니다.  
이름을 제공하지 않는 동기화는 내부 빈을 사용하고 공동 작업자를 autowiring하는 것과 관련됩니다.  

##### 빈 명명 규칙
> 관례는 빈을 명명 할 때 인스턴스 이름과 같은 표준 Java 규칙을 사용하는 것입니다.  
> 즉, 빈 이름은 소문자로 시작하고 이후로 camel-cased를 사용합니다.  
> 이러한 이름의 예는 (따옴표 제외) 'accountManager', 'accountService', 'userDao', 'loginController'등입니다.  


> Bean의 이름을 계속 지정하면 구성을보다 쉽게 읽고 이해할 수 있으며  
> Spring AOP를 사용하는 경우 이름과 관련된 콩 세트에 조언을 적용 할 때 많은 도움이됩니다.  

##### (Aliasing a bean outside the bean definition)[https://docs.spring.io/spring/docs/5.0.4.BUILD-SNAPSHOT/spring-framework-reference/core.html#beans-beanname-alias]















