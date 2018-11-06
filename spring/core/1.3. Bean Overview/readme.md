##### version: 5.1.2.RELEASE
[Spring Reference 1.3. Bean Overview](https://docs.spring.io/spring/docs/5.1.2.RELEASE/spring-framework-reference/core.html#beans-definition)

## 1.3. Bean 개요
> 개요: 간결하게 추려 낸 주요 내용.

**Spring IoC 컨테이너**는 하나 이상의 `Bean`을 관리한다.  
이 `Bean`은 사용자가 컨테이너에 제공하는 **구성 메타 데이터** (예 : XML `<bean/>` 정의의 양식)로 작<U>성</U>됩니다.  


컨테이너 내부에서 이러한 `bean` 정의는 (다른 정보들 사이에서) 다음 메타 데이터를 포함하는 `BeanDefinition` 객체로 표현됩니다.  
- 패키지 수식 클래스 명 : 일반적으로, 정의되고있는 bean의 실제 구현 클래스.  
- `Bean`이 컨테이너에서 작동하는 방법 (범위, 수명주기 콜백 등)을 나타내는 `Bean` 동작 구성 요소.  
- `Bean`이 작업을 수행하는 데 필요한 다른 `Bean`에 대한 참조.  
이러한 참조는 협력자(collaborators) 또는 종속성(dependencies)이라고도 합니다.  
- 새로 생성 된 객체에 설정할 기타 구성 설정: 예를 들어 풀의 크기 제한 또는 연결 풀을 관리하는 `Bean`에서 사용할 연결 수를 지정합니다.  

##### bean 정의
|Property|설명|
|:--------|:--------|
|Class|[Instantiating Beans](https://docs.spring.io/spring/docs/5.1.2.RELEASE/spring-framework-reference/core.html#beans-factory-class)|
|Name|[Naming Beans](https://docs.spring.io/spring/docs/5.1.2.RELEASE/spring-framework-reference/core.html#beans-beanname)|
|Scope|[Bean Scopes](https://docs.spring.io/spring/docs/5.1.2.RELEASE/spring-framework-reference/core.html#beans-factory-scopes)|
|Constructor arguments|[Dependency Injection](https://docs.spring.io/spring/docs/5.1.2.RELEASE/spring-framework-reference/core.html#beans-factory-collaborators)|
|Properties|[Dependency Injection](https://docs.spring.io/spring/docs/5.1.2.RELEASE/spring-framework-reference/core.html#beans-factory-collaborators)|
|Autowiring mode|[Autowiring Collaborators](https://docs.spring.io/spring/docs/5.1.2.RELEASE/spring-framework-reference/core.html#beans-factory-autowire)|
|Lazy initialization mode|[Lazy-initialized Beans](https://docs.spring.io/spring/docs/5.1.2.RELEASE/spring-framework-reference/core.html#beans-factory-lazy-init)|
|Initialization method|[Initialization Callbacks](https://docs.spring.io/spring/docs/5.1.2.RELEASE/spring-framework-reference/core.html#beans-factory-lifecycle-initializingbean)|
|Destruction method|[Destruction Callbacks](https://docs.spring.io/spring/docs/5.1.2.RELEASE/spring-framework-reference/core.html#beans-factory-lifecycle-disposablebean)|


`ApplicationContext` 구현은 컨테이너 외부에서 작성된 기존 객체의 등록을 허용 합니다.
이것은 `BeanFactory` `DefaultListableBeanFactory` 구현을 리턴하는 `getBeanFactory()` 메소드를 통해  `ApplicationContext`의 `BeanFactory`에 액세스함으로써 수행된다.  
`DefaultListableBeanFactory`는 `registerSingleton(..)` 및 `registerBeanDefinition(..)` 메소드를 통해 이 등록을 지원합니다.  
그러나 일반적인 응용 프로그램은 `Bean` 정의 메타 데이터를 통해 정의 된 `Bean`에서만 작동합니다.  


### 중요
**`Bean` 메타 데이터와 수동으로 제공되는 싱글 톤 인스턴스**는  
자동 와이어 링 및 기타 인트로 스펙션 단계에서 컨테이너가 적절히 추론 할 수 있도록 **가능한 빨리 등록**해야합니다.  
기존 메타 데이터와 기존 싱글 톤 인스턴스를 재정의하는 것은 어느 정도 지원되지만  
**런타임에 새로운 빈의 등록 (팩토리에 대한 라이브 액세스와 동시에)은 공식적으로 지원되지 않으며**  
**동시 액세스 예외**, **빈 컨테이너의 일관성없는 상태**가 발생합니다.  




