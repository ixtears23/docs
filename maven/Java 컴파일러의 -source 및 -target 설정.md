## Setting the `-source` and `-target` of the Java Compiler


때로는 특정 프로젝트를 현재 사용중인 것과 다른 버전으로 컴파일해야하는 경우가 있습니다.  
`javac`는 `-source` 및 `-target`을 사용하여 이러한 명령을 허용 할 수 있습니다.  
컴파일하는 동안 이러한 옵션을 제공하도록 컴파일러 플러그인을 구성 할 수도 있습니다.  

예를 들어 Java 8 언어 기능 (-source 1.8)을 사용하고 컴파일 된 클래스가 JVM 1.8 (-target 1.8)과 호환되기를 원하면  
기본 등록 정보 인 다음 두 등록 정보를 사용하십시오.

~~~xml
<project>
  [...]
  <properties>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
  </properties>
  [...]
</project>
~~~

또는 플러그인을 직접 구성하십시오.
~~~xml
<project>
  [...]
  <build>
    [...]
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.7.0</version>
        <configuration>
          <source>1.8</source>
          <target>1.8</target>
        </configuration>
      </plugin>
    </plugins>
    [...]
  </build>
  [...]
</project>
~~~

### Note
단순히 대상 옵션을 설정해도 코드가 실제로 지정된 버전의 JRE에서 실행되는 것은 아닙니다.  
이 함정은 이후 JRE에서만 존재하는 API의 의도되지 않은 사용으로 연결 오류가 발생하여 런타임에 코드가 실패하게됩니다.  
이 문제를 피하려면 컴파일러의 부트 클래스 경로를 대상 JRE와 일치하도록 구성하거나  
Animal Sniffer Maven Plugin을 사용하여 코드가 의도하지 않은 API를 사용하지 않는지 확인하십시오.  
같은 방법으로 소스 옵션을 설정해도 코드가 실제로 지정된 버전의 JDK에서 컴파일되는 것은 아닙니다.  
Maven을 시작하는 데 사용 된 것과 다른 특정 JDK 버전으로 코드를 컴파일하려면 다른 JDK 예제를 사용하여 컴파일 예제를 참조하십시오.  

## Compiling Sources Using A Different JDK(다른 JDK를 사용하여 소스 컴파일하기)
### Using Maven Toolchains(Maven 툴체인 사용하기)
다른 JDK를 사용하는 좋은 방법은 툴체인 메커니즘을 사용하는 것입니다.  
프로젝트를 빌드하는 동안 툴 체인이 없는 Maven은 JDK를 사용하여 Java 소스 컴파일, Javadoc 생성, 유닛 테스트 실행  
또는 JAR 서명과 같은 다양한 단계를 수행합니다.  
각 플러그인에는 javac, javadoc, jarsigner 등 JDK 도구가 필요합니다.  
툴체인은 Maven 자체를 실행하는 플러그인과는 독립적 인 중앙 집중식으로 모든 플러그인에 사용할 JDK 경로를 지정하는 방법입니다.  

### Cofiguring the Compiler Plugin(컴파일러 플러그인 구성)
툴체인 밖에서 컴파일하는 동안 사용할 특정 JDK를 컴파일러 플러그인에 알릴 수도 있습니다.  
이러한 구성은이 플러그인에만 적용되며 다른 플러그인에는 영향을주지 않습니다.  
compilerVersion 매개 변수는 플러그인에서 사용할 컴파일러 버전을 지정하는 데 사용할 수 있습니다.  
그러나이 작업을 수행하려면 fork를 true로 설정해야합니다.  
~~~xml
<project>
  [...]
  <build>
    [...]
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.7.0</version>
        <configuration>
          <verbose>true</verbose>
          <fork>true</fork>
          <executable><!-- path-to-javac --></executable>
          <compilerVersion>1.3</compilerVersion>
        </configuration>
      </plugin>
    </plugins>
    [...]
  </build>
  [...]
</project>
~~~
실행 파일의 파일 시스템 경로를 하드 코딩하지 않으려면 속성을 사용할 수 있습니다.  
~~~xml
<executable>${JAVA_1_4_HOME}/bin/javac</executable>
~~~
그런 다음 각 개발자는 `settings.xml`에서 이 속성을 정의하거나 환경 변수를 설정하여 빌드가 이식성을 유지하도록합니다.  
~~~xml
<settings>
  [...]
  <profiles>
    [...]
    <profile>
      <id>compiler</id>
        <properties>
          <JAVA_1_4_HOME>C:\Program Files\Java\j2sdk1.4.2_09</JAVA_1_4_HOME>
        </properties>
    </profile>
  </profiles>
  [...]
  <activeProfiles>
    <activeProfile>compiler</activeProfile>
  </activeProfiles>
</settings>
~~~
다른 JDK로 빌드하는 경우 jar 파일 매니페스트를 사용자 정의 할 수 있습니다.  








