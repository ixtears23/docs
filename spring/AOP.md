# Spring AOP

- Aspect: 여러 클래스에 걸쳐 영향을 미치는 모듈화입니다.  
트랜잭션 관리는 엔터프라이즈 Java 애플리케이션에서 교차하는 우려의 좋은 예입니다.  
Spring AOP에서 aspect는 정규 클래스 (스키마 기반 접근법) 또는 @Aspect 주석으로 주석 된 일반 클래스 (@AspectJ 스타일)를 사용하여 구현 됩니다.  
- Join point: 메소드 실행이나 예외 처리와 같은 프로그램 실행 중 포인트.  
Spring AOP에서 조인 포인트는 항상 메소드 실행을 나타낸다.  
- Advice: 특정 조인 포인트에서 aspect에 의해 취해진 액션.  
다양한 유형의 advice에는 "around", "before"및 "after"advice가 포함됩니다.  
Spring을 포함한 많은 AOP 프레임 워크는 인터셉터로서 조언을 모델링하고 조인 포인트 주변의 인터셉터 체인을 유지합니다.  
- Pointcut: join point 와 일치하는 속성. 조언은 pointcut 표현식과 관련이 있으며 pointcut (예 : 특정 이름의 메소드 실행)과 일치하는 모든 join point에서 실행됩니다.  
Pointcut 표현식과 일치하는 조인 포인트의 개념은 AOP의 핵심이며, Spring은 기본적으로 AspectJ pointcut 표현식 언어를 사용한다.  


## Advice 선언
> 스키마 기반 AOP 지원은 @AspectJ 스타일과 동일한 5 가지 유형의 조언을 사용하며 정확히 동일한 의미를 갖는다.  

#### Before Advice
> Before Advice는 일치하는 메소드 실행전에 실행 됩니다.  
> 다음 예제와 같이 <aop : before> 요소를 사용하여 <aop : aspect> 내부에서 선언됩니다.  
~~~xml
<aop:aspect id="beforeExample" ref="aBean">

    <aop:before
        pointcut-ref="dataAccessOperation"
        method="doAccessCheck"/>

    ...

</aop:aspect>
~~~
여기에서 `dataAccessOperation`은 최상위 (`<aop:config>`) 수준에 정의 된 pointcut의 ID입니다.  
`pointcut` 인라인으로 정의하려면, `pointcut-ref` 속성을 `pointcut` 속성으로 바꾸십시오.
~~~xml
<aop:aspect id="beforeExample" ref="aBean">

    <aop:before
        pointcut="execution(* com.xyz.myapp.dao.*.*(..))"
        method="doAccessCheck"/>

    ...

</aop:aspect>
~~~

**@AspectJ 스타일에 대한 설명에서 언급했듯이, 명명 된 pointcuts를 사용하면 코드의 가독성이 크게 향상 될 수 있습니다.**  
method 속성은 조언의 본문을 제공하는 메소드 (doAccessCheck)를 식별합니다.  
이 메소드는 어드바이스가 포함 된 aspect 요소에 의해 참조 된 bean에 대해 정의되어야합니다.  
데이터 액세스 작업 (pointcut 표현식과 일치하는 메소드 실행 조인 포인트)이 실행되기 전에 aspect bean에 대한 doAccessCheck 메소드가 호출됩니다.  

---

#### After Returning Advice
일치하는 메소드 실행이 정상적으로 완료되면 리턴되는 조언이 실행됩니다.  
before advice와 같은 방법으로 <aop : aspect> 내부에 선언 됩니다.  
- 선언 방법
~~~xml
<aop:aspect id="afterReturningExample" ref="aBean">

    <aop:after-returning
        pointcut-ref="dataAccessOperation"
        method="doAccessCheck"/>

    ...

</aop:aspect>
~~~

`@AspectJ` 스타일에서와 마찬가지로, advice body 내에서 리턴 값을 얻을 수 있습니다.  
이를 수행하려면 다음 예제에서와 같이 **리턴 속성**을 사용하여 **리턴 값이 전달되어야하는 매개 변수의 이름을 지정**하십시오.  
~~~xml

<aop:aspect id="afterReturningExample" ref="aBean">

    <aop:after-returning
        pointcut-ref="dataAccessOperation"
        returning="retVal"
        method="doAccessCheck"/>

    ...

</aop:aspect>
~~~
doAccessCheck 메소드는 retVal이라는 매개 변수를 선언해야합니다.  
이 매개 변수의 유형은 @AfterReturning에 대해 설명한 것과 같은 방식으로 일치를 제한합니다.  
예를 들어, 다음과 같이 메소드 서명을 해제 할 수 있습니다.  
~~~java
public void doAccessCheck(Object retVal) {...
~~~

---

#### After Throwing Advice
예외를 throw하여 일치하는 메서드 실행이 종료 될 때 advice를 throw 한 후 실행합니다.  
다음 예제와 같이 after-throwing 요소를 사용하여 <aop : aspect> 내부에서 선언됩니다.  
~~~xml
<aop:aspect id="afterThrowingExample" ref="aBean">

    <aop:after-throwing
        pointcut-ref="dataAccessOperation"
        method="doRecoveryActions"/>

    ...

</aop:aspect>
~~~
@AspectJ 스타일에서와 마찬가지로, advice body 내에서 던져진 예외를 얻을 수 있습니다.  
이렇게하려면 throwing 속성을 사용하여 다음 예제와 같이 예외를 전달해야하는 매개 변수의 이름을 지정합니다.  

~~~xml
<aop:aspect id="afterThrowingExample" ref="aBean">

    <aop:after-throwing
        pointcut-ref="dataAccessOperation"
        throwing="dataAccessEx"
        method="doRecoveryActions"/>

    ...

</aop:aspect>
~~~

doRecoveryActions 메소드는 dataAccessEx라는 매개 변수를 선언해야합니다.  
이 매개 변수의 유형은 @AfterThrowing에 대해 설명한 것과 같은 방식으로 일치를 제한합니다.  
예를 들어, 메소드 서명은 다음과 같이 선언 될 수 있습니다.  


#### After (Finally) Advice
일치하는 메소드 실행이 종료되는 방법과 상관없이 조언이 실행됩니다.  
다음 예제와 같이 after 요소를 사용하여 선언 할 수 있습니다.  
~~~xml
<aop:aspect id="afterFinallyExample" ref="aBean">

    <aop:after
        pointcut-ref="dataAccessOperation"
        method="doReleaseLock"/>

    ...

</aop:aspect>
~~~

#### Around Advice
마지막 조언은 Around Advice입니다. around advice는 매치 메소드 실행을 "around" 에서 실행한다.  
메소드가 실행되기 전과 후에 모두 작업을 수행 할 수 있는 기회를 가지며 메소드가 언제, 실제로 어떻게 실행 되는지를 결정합니다.  
around advice는 thread-safe 방식으로 메서드 실행 전후에 상태를 공유하는 데 자주 사용됩니다(예 : 타이머 시작 및 중지).  
항상 귀하의 요구 사항을 충족시키는 가장 강력한 형태의 조언을 사용하십시오.  
before advice가 그 일을 할 수 있다면 around advice를 사용하지 마십시오.  

aop : around 요소를 사용하여 around advice를 선언 할 수 있습니다.  
advice 메소드의 첫 번째 매개 변수는 ProceedingJoinPoint 유형이어야합니다.  
조언 본문 내에서 ProceedingJoinPoint에서 proceed()를 호출하면 기본 메서드가 실행됩니다.  
proceed 메서드는 Object []를 사용하여 호출 할 수도 있습니다.  
배열의 값은 진행될 때 메서드 실행에 대한 인수로 사용됩니다.  
다음 예는 XML에서 around advice를 선언하는 방법을 보여줍니다.

~~~xml
<aop:aspect id="aroundExample" ref="aBean">

    <aop:around
        pointcut-ref="businessService"
        method="doBasicProfiling"/>

    ...

</aop:aspect>
~~~
doBasicProfiling advice의 구현은 다음 예제처럼 @AspectJ 예제와 똑같을 수있다 (물론 annotation은 제외하다).  
~~~java
public Object doBasicProfiling(ProceedingJoinPoint pjp) throws Throwable {
    // start stopwatch
    Object retVal = pjp.proceed();
    // stop stopwatch
    return retVal;
}
~~~

#### Advice Parameters
스키마 기반 선언 스타일은 @AspectJ 지원에 대해 설명한 것과 같은 방식으로 완전히 입력 된 조언을 지원합니다.  
즉, pointcut 매개 변수를 advice 메소드 매개 변수와 이름을 매칭시킵니다.   
advice 메소드에 대한 인수 이름을 명시 적으로 지정하려면 advice 요소의 arg-names 속성을 사용하면됩니다.  
이 메소드는 advice 주석의 argNames 속성과 동일한 방식으로 처리됩니다.  
다음 예에서는 XML에서 인수 이름을 지정하는 방법을 보여줍니다.  
~~~xml
<aop:before
    pointcut="com.xyz.lib.Pointcuts.anyPublicMethod() and @annotation(auditable)"
    method="audit"
    arg-names="auditable"/>
~~~

arg-names 속성은 매개 변수 이름의 쉼표로 구분 된 목록을 허용합니다.  
XSD 기반 접근 방식의 약간 더 관여 된 예는 강력한 입력 매개 변수와 함께 사용되는 몇 가지 주변 조언을 보여줍니다.  
~~~java
package x.y.service;

public interface PersonService {

    Person getPerson(String personName, int age);
}

public class DefaultFooService implements FooService {

    public Person getPerson(String name, int age) {
        return new Person(name, age);
    }
}
~~~
다음은 aspect 입니다. profile (..) 메소드가 많은 유형의 강력한 매개 변수를 허용한다는 사실에 유의하십시오.  
그 중 첫 번째는 메소드 호출을 진행하는 데 사용되는 조인 포인트입니다.  
이 매개 변수가 있으면 다음 예제와 같이 프로필 (..)이 주위의 조언으로 사용된다는 표시입니다.  
~~~java
ackage x.y;

import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.util.StopWatch;

public class SimpleProfiler {

    public Object profile(ProceedingJoinPoint call, String name, int age) throws Throwable {
        StopWatch clock = new StopWatch("Profiling for '" + name + "' and '" + age + "'");
        try {
            clock.start(call.toShortString());
            return call.proceed();
        } finally {
            clock.stop();
            System.out.println(clock.prettyPrint());
        }
    }
}
~~~

마지막으로, 다음 예제 XML 구성은 특정 조인 포인트에 대한 선행 조언의 실행에 영향을줍니다.  
~~~xml
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:aop="http://www.springframework.org/schema/aop"
    xsi:schemaLocation="
        http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd">

    <!-- this is the object that will be proxied by Spring's AOP infrastructure -->
    <bean id="personService" class="x.y.service.DefaultPersonService"/>

    <!-- this is the actual advice itself -->
    <bean id="profiler" class="x.y.SimpleProfiler"/>

    <aop:config>
        <aop:aspect ref="profiler">

            <aop:pointcut id="theExecutionOfSomePersonServiceMethod"
                expression="execution(* x.y.service.PersonService.getPerson(String,int))
                and args(name, age)"/>

            <aop:around pointcut-ref="theExecutionOfSomePersonServiceMethod"
                method="profile"/>

        </aop:aspect>
    </aop:config>

</beans>
~~~

다음 드라이버 스크립트를 고려하십시오.  
~~~java
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import x.y.service.PersonService;

public final class Boot {

    public static void main(final String[] args) throws Exception {
        BeanFactory ctx = new ClassPathXmlApplicationContext("x/y/plain.xml");
        PersonService person = (PersonService) ctx.getBean("personService");
        person.getPerson("Pengo", 12);
    }
}
~~~
이러한 Boot 클래스를 사용하면 표준 출력에 다음과 비슷한 출력을 얻을 수 있습니다.  
~~~log
StopWatch 'Profiling for 'Pengo' and '12'': running time (millis) = 0
-----------------------------------------
ms     %     Task name
-----------------------------------------
00000  ?  execution(getFoo)
~~~

#### Advice Ordering
여러 조언이 동일한 조인 포인트 (실행 메소드)에서 실행되어야 할 때 순서 규칙은 Advice Ordering에 설명 된 것과 같습니다.  
aspect 간의 우선 순위는 aspect를 뒷받침하는 bean에 Order 주석을 추가하거나 bean이 Ordered 인터페이스를 구현하도록함으로써 결정 됩니다.  



