# [Introduction to the POM](https://maven.apache.org/guides/introduction/introduction-to-the-pom.htm)
* [What is a POM?](https://github.com/ixtears23/docs/blob/master/maven/Introduction%20to%20the%20POM.md#what-is-a-pom)
* [Super POM](https://github.com/ixtears23/docs/blob/master/maven/Introduction%20to%20the%20POM.md#super-pom)
* [Minimal POM](https://github.com/ixtears23/docs/blob/master/maven/Introduction%20to%20the%20POM.md#minimal-pom)
* [Project Inheritance]()
  * [Example 1]()
  * [Example 2]()
* [Project Aggregation]()
  * [Example 3]()
  * [Example 4]()
* [Project Inheritance vs Project Aggregation]()
  * [Example 5]()
* [Project Interpolation and Variables]()
* [Available Variables]()


# [What is a POM?](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html#What_is_a_POM)

**Project Object Model** 또는 POM은 **Maven의 기본 작업 단위**입니다.  
**Maven이 프로젝트를 빌드하는 데 사용**하는 **프로젝트 및 구성 정보에 대한 정보**가 들어있는 **XML 파일**입니다.  
대부분의 프로젝트에 기본값이 들어 있습니다.  
예를 들어,  
* 빌드 디렉토리는 `target`입니다.  
* 소스 디렉토리. `src / main / java`.  
* 테스트 소스 디렉토리 `src / test / java` 등등.  

> 참고 : 여기서 번역된 '목표'는 'goal' 임.


POM은 Maven 1의 project.xml에서 Maven 2의 pom.xml로 이름이 바뀌 었습니다.  
실행될 수있는 목표를 포함하는 maven.xml 파일 대신 이제는 pom.xml에 목표 또는 플러그인이 구성됩니다.  
작업 또는 목표를 실행할 때 Maven은 현재 디렉토리에서 POM을 찾습니다.  
POM을 읽고 필요한 구성 정보를 얻은 다음 목표를 실행합니다.  


POM에서 지정할 수있는 구성 중 일부는 프로젝트 종속성(project dependencies),  
실행 가능한 플러그인 또는 목표, 빌드 프로파일(build profiles) 등 입니다.  
프로젝트 버전(project version), 설명(description), 개발자(developers), 메일 링리스트(mailing lists)  
등과 같은 기타 정보도 지정할 수 있습니다.  

[[top]](https://github.com/ixtears23/docs/blob/master/maven/Introduction%20to%20the%20POM.md#introduction-to-the-pom)

# [Super POM](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html#Super_POM)
`Super POM`은 **Maven의 기본 POM**입니다.  

<U>모든 POM</U>은 명시 적으로 설정하지 않는 한 `Super POM`을 **확장**합니다.  
즉, `Super POM`에 지정된 구성이 프로젝트에 대해 만든 POM에 상속됩니다.

아래 스 니펫은 **Maven 2.0.x 용 Super POM**입니다.  
~~~xml
<project>
  <modelVersion>4.0.0</modelVersion>
  <name>Maven Default Project</name>
 
  <repositories>
    <repository>
      <id>central</id>
      <name>Maven Repository Switchboard</name>
      <layout>default</layout>
      <url>http://repo1.maven.org/maven2</url>
      <snapshots>
        <enabled>false</enabled>
      </snapshots>
    </repository>
  </repositories>
 
  <pluginRepositories>
    <pluginRepository>
      <id>central</id>
      <name>Maven Plugin Repository</name>
      <url>http://repo1.maven.org/maven2</url>
      <layout>default</layout>
      <snapshots>
        <enabled>false</enabled>
      </snapshots>
      <releases>
        <updatePolicy>never</updatePolicy>
      </releases>
    </pluginRepository>
  </pluginRepositories>
 
  <build>
    <directory>target</directory>
    <outputDirectory>target/classes</outputDirectory>
    <finalName>${artifactId}-${version}</finalName>
    <testOutputDirectory>target/test-classes</testOutputDirectory>
    <sourceDirectory>src/main/java</sourceDirectory>
    <scriptSourceDirectory>src/main/scripts</scriptSourceDirectory>
    <testSourceDirectory>src/test/java</testSourceDirectory>
    <resources>
      <resource>
        <directory>src/main/resources</directory>
      </resource>
    </resources>
    <testResources>
      <testResource>
        <directory>src/test/resources</directory>
      </testResource>
    </testResources>
  </build>
 
  <reporting>
    <outputDirectory>target/site</outputDirectory>
  </reporting>
 
  <profiles>
    <profile>
      <id>release-profile</id>
 
      <activation>
        <property>
          <name>performRelease</name>
        </property>
      </activation>
 
      <build>
        <plugins>
          <plugin>
            <inherited>true</inherited>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-source-plugin</artifactId>
 
            <executions>
              <execution>
                <id>attach-sources</id>
                <goals>
                  <goal>jar</goal>
                </goals>
              </execution>
            </executions>
          </plugin>
          <plugin>
            <inherited>true</inherited>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-javadoc-plugin</artifactId>
 
            <executions>
              <execution>
                <id>attach-javadocs</id>
                <goals>
                  <goal>jar</goal>
                </goals>
              </execution>
            </executions>
          </plugin>
          <plugin>
            <inherited>true</inherited>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-deploy-plugin</artifactId>
 
            <configuration>
              <updateReleaseInfo>true</updateReleaseInfo>
            </configuration>
          </plugin>
        </plugins>
      </build>
    </profile>
  </profiles>
 
</project>
~~~

아래 스 니펫은 **Maven 2.1.x 용 Super POM**입니다.  
~~~xml
<project>
  <modelVersion>4.0.0</modelVersion>
  <name>Maven Default Project</name>
 
  <repositories>
    <repository>
      <id>central</id>
      <name>Maven Repository Switchboard</name>
      <layout>default</layout>
      <url>http://repo1.maven.org/maven2</url>
      <snapshots>
        <enabled>false</enabled>
      </snapshots>
    </repository>
  </repositories>
 
  <pluginRepositories>
    <pluginRepository>
      <id>central</id>
      <name>Maven Plugin Repository</name>
      <url>http://repo1.maven.org/maven2</url>
      <layout>default</layout>
      <snapshots>
        <enabled>false</enabled>
      </snapshots>
      <releases>
        <updatePolicy>never</updatePolicy>
      </releases>
    </pluginRepository>
  </pluginRepositories>
 
  <build>
    <directory>${project.basedir}/target</directory>
    <outputDirectory>${project.build.directory}/classes</outputDirectory>
    <finalName>${project.artifactId}-${project.version}</finalName>
    <testOutputDirectory>${project.build.directory}/test-classes</testOutputDirectory>
    <sourceDirectory>${project.basedir}/src/main/java</sourceDirectory>
    <!-- TODO: MNG-3731 maven-plugin-tools-api < 2.4.4 expect this to be relative... -->
    <scriptSourceDirectory>src/main/scripts</scriptSourceDirectory>
    <testSourceDirectory>${project.basedir}/src/test/java</testSourceDirectory>
    <resources>
      <resource>
        <directory>${project.basedir}/src/main/resources</directory>
      </resource>
    </resources>
    <testResources>
      <testResource>
        <directory>${project.basedir}/src/test/resources</directory>
      </testResource>
    </testResources>
   <pluginManagement>
       <plugins>
         <plugin>
           <artifactId>maven-antrun-plugin</artifactId>
           <version>1.3</version>
         </plugin>       
         <plugin>
           <artifactId>maven-assembly-plugin</artifactId>
           <version>2.2-beta-2</version>
         </plugin>         
         <plugin>
           <artifactId>maven-clean-plugin</artifactId>
           <version>2.2</version>
         </plugin>
         <plugin>
           <artifactId>maven-compiler-plugin</artifactId>
           <version>2.0.2</version>
         </plugin>
         <plugin>
           <artifactId>maven-dependency-plugin</artifactId>
           <version>2.0</version>
         </plugin>
         <plugin>
           <artifactId>maven-deploy-plugin</artifactId>
           <version>2.4</version>
         </plugin>
         <plugin>
           <artifactId>maven-ear-plugin</artifactId>
           <version>2.3.1</version>
         </plugin>
         <plugin>
           <artifactId>maven-ejb-plugin</artifactId>
           <version>2.1</version>
         </plugin>
         <plugin>
           <artifactId>maven-install-plugin</artifactId>
           <version>2.2</version>
         </plugin>
         <plugin>
           <artifactId>maven-jar-plugin</artifactId>
           <version>2.2</version>
         </plugin>
         <plugin>
           <artifactId>maven-javadoc-plugin</artifactId>
           <version>2.5</version>
         </plugin>
         <plugin>
           <artifactId>maven-plugin-plugin</artifactId>
           <version>2.4.3</version>
         </plugin>
         <plugin>
           <artifactId>maven-rar-plugin</artifactId>
           <version>2.2</version>
         </plugin>        
         <plugin>                
           <artifactId>maven-release-plugin</artifactId>
           <version>2.0-beta-8</version>
         </plugin>
         <plugin>                
           <artifactId>maven-resources-plugin</artifactId>
           <version>2.3</version>
         </plugin>
         <plugin>
           <artifactId>maven-site-plugin</artifactId>
           <version>2.0-beta-7</version>
         </plugin>
         <plugin>
           <artifactId>maven-source-plugin</artifactId>
           <version>2.0.4</version>
         </plugin>         
         <plugin>
            <artifactId>maven-surefire-plugin</artifactId>
            <version>2.4.3</version>
         </plugin>
         <plugin>
           <artifactId>maven-war-plugin</artifactId>
           <version>2.1-alpha-2</version>
         </plugin>
       </plugins>
     </pluginManagement>
  </build>
 
  <reporting>
    <outputDirectory>${project.build.directory}/site</outputDirectory>
  </reporting>
  <profiles>
    <profile>
      <id>release-profile</id>
 
      <activation>
        <property>
          <name>performRelease</name>
          <value>true</value>
        </property>
      </activation>
 
      <build>
        <plugins>
          <plugin>
            <inherited>true</inherited>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-source-plugin</artifactId>
            <executions>
              <execution>
                <id>attach-sources</id>
                <goals>
                  <goal>jar</goal>
                </goals>
              </execution>
            </executions>
          </plugin>
          <plugin>
            <inherited>true</inherited>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-javadoc-plugin</artifactId>
            <executions>
              <execution>
                <id>attach-javadocs</id>
                <goals>
                  <goal>jar</goal>
                </goals>
              </execution>
            </executions>
          </plugin>
          <plugin>
            <inherited>true</inherited>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-deploy-plugin</artifactId>
            <configuration>
              <updateReleaseInfo>true</updateReleaseInfo>
            </configuration>
          </plugin>
        </plugins>
      </build>
    </profile>
  </profiles>
 
</project>
~~~

[[top]](https://github.com/ixtears23/docs/blob/master/maven/Introduction%20to%20the%20POM.md#introduction-to-the-pom)

# [Minimal POM](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html#Minimal_POM)

POM의 최소 요구 사항은 다음과 같습니다.  
 * project root  
 * modelVersion - 4.0.0으로 설정해야합니다.  
 * groupId - 프로젝트 그룹의 ID입니다.  
 * artifact - 인공물(project)의 ID.  
 * version - 지정된 그룹의 아티팩트 버전.  
 
 예 :  
 ~~~xml
 <project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-app</artifactId>
  <version>1</version>
</project>
~~~

**POM**은 **groupId, artifactId 및 version**을 구성해야합니다.  
이러한 세 가지 값은 **프로젝트의 정규화 된 아티팩트 이름을 구성**합니다.  
이것은 `<groupId>` : `<artifactId>` : `<version>` 형식입니다.  
위의 예에서는 정규화 된 **아티팩트 이름**은 **"com.mycompany.app:my-app:1"**입니다.  

또한, 첫 번째 섹션에서 언급했듯이,  
설정 세부 사항을 지정하지 않으면 Maven은 기본값을 사용하게 됩니다.  
이 기본값 중 하나는 패키징 유형(packaging type)입니다.  
모든 Maven 프로젝트에는 패키징 유형이 있습니다.  
**POM에 지정되지 않은 경우** **기본값 "jar"**가 사용됩니다.  

또한 `minimal POM` 에서는 저장소(repositories)가 지정되지 않았음을 알 수 있습니다.  
`minimal POM`을 사용하여 프로젝트를 빌드하면 `Super POM`의 리포지토리 구성을 상속받습니다.  
따라서 Maven이 `minimal POM`에서 종속성을 인식하면,  
이러한 종속성은 `Super POM`에 지정된 http://repo.maven.apache.org/maven2 에서 다운로드 된다는 것을 알게됩니다.  

[[top]](https://github.com/ixtears23/docs/blob/master/maven/Introduction%20to%20the%20POM.md#introduction-to-the-pom)

# [Project Inheritance](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html#Project_Inheritance)

병합되는 POM의 요소는 다음과 같습니다.  
* dependencies(의존성)
* developers and contributors(개발자와 공헌자)
* plugin lists (including reports) (플러그인 목록 (보고서 포함))
* plugin executions with matching ids(일치하는 ID로 플러그인 실행)
* plugin configuration(플러그인 구성)
* resources(자원)

Super POM은 프로젝트 상속의 한 예이지만  
다음 예제에서와 같이 POM의 부모 요소를 지정하여 부모 POM을 도입 할 수도 있습니다.  

### [Example 1](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html#Example_1)
**The Scenario(시나리오)**  
예를 들어 이전 artifact 인 `com.mycompany.app:my-app:1`을 재사용 하겠습니다.  
그리고 또 다른 artifact 인 `com.mycompany.app:my-module:1`을 소개합시다.  
~~~xml
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-module</artifactId>
  <version>1</version>
</project>
~~~
디렉토리 구조를 다음과 같이 지정하십시오.  
~~~
.
 |-- my-module
 |   `-- pom.xml
 `-- pom.xml
~~~
참고
`my-module/pom.xml`은 `com.mycompany.app:my-module:1`의 `POM`이고  
`pom.xml`은 `com.mycompany.app:my-app:1`의 `POM`입니다.

**The Solution(해결책)**  
이제 `com.mycompany.app:my-app:1`을 `com.mycompany.app:my-module:1`의 부모 아티팩트로 전환 하려면  
`com.mycompany.app:my-module:1`의 POM을 다음 구성으로 수정해야합니다.  

**`com.mycompany.app:my-module:1's POM`**
~~~xml
<project>
  <parent>
    <groupId>com.mycompany.app</groupId>
    <artifactId>my-app</artifactId>
    <version>1</version>
  </parent>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-module</artifactId>
  <version>1</version>
</project>
~~~

**부모섹션이 추가 된 것을 주목하십시오.**  
이 섹션에서는 POM의 부모 인 artifact를 지정할 수 있습니다.  
상위 POM의 정규화 된 artifact이름을 지정하면 됩니다.  
이 설정으로 우리 모듈은 **부모 POM의 속성 중 일부를 상속받을 수 있습니다.**  

또는 groupId 및 / 또는 모듈 버전이 부모와 동일하게 하려면  
POM에서 모듈의 groupId 및 / 또는 버전 ID를 제거 할 수 있습니다.  

~~~xml
<project>
  <parent>
    <groupId>com.mycompany.app</groupId>
    <artifactId>my-app</artifactId>
    <version>1</version>
  </parent>
  <modelVersion>4.0.0</modelVersion>
  <artifactId>my-module</artifactId>
</project>
~~~

이렇게하면 모듈이 groupId 및 / 또는 상위 POM의 버전을 상속 할 수 있습니다.  

### [Example 2](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html#Example_2)

**The Scenario(시나리오)**  
그러나 부모 프로젝트가 이미 로컬 저장소(부모 pom.xml은 pom.xml모듈 보다 한 디렉토리 높다)에 설치되어있는 경우  
또는 특정 디렉토리 구조의 경우, 이것은 작동합니다.  
~~~
.
 |-- my-module
 |   `-- pom.xml
 `-- parent
     `-- pom.xml
~~~

**The Solution(해결책)**  
이 디렉토리 구조 (또는 다른 디렉토리 구조)를 처리하려면  
부모 섹션에 `<relativePath>` 요소를 추가해야합니다.  
~~~xml
<project>
  <parent>
    <groupId>com.mycompany.app</groupId>
    <artifactId>my-app</artifactId>
    <version>1</version>
    <relativePath>../parent/pom.xml</relativePath>
  </parent>
  <modelVersion>4.0.0</modelVersion>
  <artifactId>my-module</artifactId>
</project>
~~~

이름에서 알 수 있듯이 **모듈의 pom.xml에서 부모의 pom.xml까지**의 **상대 경로**입니다.

[[top]](https://github.com/ixtears23/docs/blob/master/maven/Introduction%20to%20the%20POM.md#introduction-to-the-pom)

# [Project Aggregation](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html#Project_Aggregation)
Project Aggregation(프로젝트 집계)

프로젝트 집계는 프로젝트 상속(Project Inheritance)과 유사합니다.  
그러나 *모듈에서 상위 POM을 지정하는 대신* **상위 POM에서 모듈을 지정**합니다.  
이렇게함으로써, 부모 프로젝트는 이제 모듈을 알게되고,  
*Maven 명령이 부모 프로젝트에 대해 호출된다면*, **Maven 명령은 부모 모듈에도 실행될 것입니다.**  
프로젝트 집계를 수행하려면 다음을 수행해야합니다.  
 * 상위 POM 패키징을 값 "pom"으로 변경하십시오.  
 * 부모 POM에 해당 모듈 디렉토리 (하위 POM)을 지정합니다.  
 
 
### [Example 3](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html#Example_3)
**The Scenario(시나리오)**  
이전의 원본 아티팩트 POM 및 디렉토리 구조가 주어지면,  
**`com.mycompany.app:my-app:1's` POM**  
~~~xml
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-app</artifactId>
  <version>1</version>
</project>
~~~
**`com.mycompany.app:my-module:1's POM`**  
~~~xml
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-module</artifactId>
  <version>1</version>
</project>
~~~
**directory structure**  
~~~
.
 |-- my-module
 |   `-- pom.xml
 `-- pom.xml
~~~

**The Solution(해결책)**  
my-module을 my-app에 집계하려면 my-app를 수정하면됩니다.  
~~~xml
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-app</artifactId>
  <version>1</version>
  <packaging>pom</packaging>
 
  <modules>
    <module>my-module</module>
  </modules>
</project>
~~~

개정 된 `com.mycompany.app:my-app:1`에서 패키징 섹션`<packaging>`과 모듈`<module>` 섹션이 추가되었습니다.  
패키징`<packaging>`의 경우 값은 "pom"으로 설정되고 모듈`<module>` 섹션의 경우 `<module> my-module </ module>`이 됩니다.  
<module>의 값은 `com.mycompany.app:my-app:1`에서 `com.mycompany.app:my-module:1`의 POM까지의 상대 경로입니다.  
(연습으로 모듈의 artifactId를 모듈 디렉토리의 이름으로 사용합니다.)  

이제 Maven 명령이 `com.mycompany.app:my-app:1`을 처리 할 때마다  
동일한 Maven 명령이 `com.mycompany.app:my-module:1`에 대해 실행됩니다.  
또한 일부 명령 (목표)은 프로젝트 집계를 다르게 처리합니다.  
### [Example 4](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html#Example_4)
**The Scenario(시나리오)**  
그러나 디렉토리 구조를 다음과 같이 변경하면 어떻게 될까요?  
~~~xml
.
 |-- my-module
 |   `-- pom.xml
 `-- parent
     `-- pom.xml
~~~
부모 폼은 어떻게 모듈을 지정 하시겠습니까?  
**The Solution(해결책)**  
대답? - Example 3과 같은 방식으로 모듈에 대한 경로를 지정합니다.  
~~~xml
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-app</artifactId>
  <version>1</version>
  <packaging>pom</packaging>
 
  <modules>
    <module>../my-module</module>
  </modules>
</project>
~~~

[[top]](https://github.com/ixtears23/docs/blob/master/maven/Introduction%20to%20the%20POM.md#introduction-to-the-pom)

# [Project Inheritance vs Project Aggregation](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html#Project_Inheritance_vs_Project_Aggregation)
##### Project Inheritance vs Project Aggregation(프로젝트 상속 대 프로젝트 집계)
여러 Maven 프로젝트가 있고 모두 비슷한 구성을 가지고 있다면  
유사한 구성을 제거하고 부모 프로젝트를 만들어 프로젝트를 리팩토링 할 수 있습니다.  
따라서 당신이해야 할 것은 당신의 Maven 프로젝트가 상위 프로젝트를 상속 할 수 있도록하는 것뿐입니다.  
이러한 설정은 모든 프로젝트에 적용됩니다.  

함께 구축되거나 처리되는 프로젝트 그룹이있는 경우  
상위 프로젝트를 만들고 해당 상위 프로젝트에서 해당 프로젝트를 모듈로 선언하도록 할 수 있습니다.  
그렇게함으로써, 당신은 단지 부모를 build하면되고 나머지는 뒤따라 올 것입니다.  

물론 Project Inheritance와 Project Aggregation을 둘 다 적용할 수 있습니다.  
즉, **모듈에서 부모 프로젝트를 지정하도록하고** ***동시에*** **해당 부모 프로젝트에서 해당 Maven 프로젝트를 모듈로 지정**하도록 할 수 있습니다.  
**세 가지 규칙**을 모두 적용하면됩니다.  
 * 부모 POM의 모든 하위 POM을 지정합니다.  
 * 상위 POM 패키징을 값 "pom"으로 변경하십시오.  
 * 상위 POM에 모듈의 디렉토리 (하위 POM)를 지정하십시오.  

### [Example 5](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html#Example_5)
**The Scenario(시나리오)**  
이전의 original artifact POM을 다시 감안할 때,  
**`com.mycompany.app:my-app:1`'s POM**  
~~~xml
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-app</artifactId>
  <version>1</version>
</project>
~~~
**`com.mycompany.app:my-module:1`'s POM**  
~~~xml
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-module</artifactId>
  <version>1</version>
</project>
~~~
and this **directory structure(디렉토리 구조)**  
~~~
.
 |-- my-module
 |   `-- pom.xml
 `-- parent
     `-- pom.xml
~~~
**The Solution(해결책)**
**프로젝트 상속과 집계를 모두 수행**하려면 ***세 가지 규칙 만 적용***하면됩니다.  
**`com.mycompany.app:my-app:1'`s POM**  
~~~xml
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.app</groupId>
  <artifactId>my-app</artifactId>
  <version>1</version>
  <packaging>pom</packaging>
 
  <modules>
    <module>../my-module</module>
  </modules>
</project>
~~~
**`com.mycompany.app:my-module:1'`s POM**  
~~~xml
<project>
  <parent>
    <groupId>com.mycompany.app</groupId>
    <artifactId>my-app</artifactId>
    <version>1</version>
    <relativePath>../parent/pom.xml</relativePath>
  </parent>
  <modelVersion>4.0.0</modelVersion>
  <artifactId>my-module</artifactId>
</project>
~~~
> 참고 : 상속은 POM 자체에 사용 된 것과 동일한 상속 전략을 프로파일합니다.  

[[top]](https://github.com/ixtears23/docs/blob/master/maven/Introduction%20to%20the%20POM.md#introduction-to-the-pom)

# [Project Interpolation and Variables](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html#Project_Interpolation)
##### Project Interpolation and Variables(프로젝트 통합 및 변수)
메이븐 (Maven)이 권장하는 관행 중 하나는 반복하지 않는 것입니다.  
그러나 여러 다른 위치에서 동일한 값을 사용해야하는 상황이 있습니다.  
값이 한 번만 지정되도록하는 데 도움을주기 위해  
Maven에서는 POM에서 자신의 변수와 미리 정의 된 변수를 모두 사용할 수 있습니다.  

예를 들어, `project.version` 변수에 액세스하려면 다음과 같이 참조하십시오.  
~~~xml
<version>${project.version}</version>
~~~
주의해야 할 한 가지 요소는 위에 설명 된대로 이러한 변수가 상속 된 후에 처리된다는 것입니다.  
즉, 부모 프로젝트에서 변수를 사용하는 경우  
부모가 아닌 자식의 정의가 결국 사용되는 변수가 됩니다.  

##### Available Variables(사용 가능한 변수)
**Project Model Variables(프로젝트 모델 변수)**  
단일 값 요소 인 모델의 필드는 변수로 참조 될 수 있습니다.  
예를 들어 `${project.groupId}`, `${project.version}`, `${project.build.sourceDirectory}` 등이 있습니다.  
전체 속성 목록을 보려면 POM reference를 참조하십시오.  
이 변수는 모두 "project"라는 접두어로 참조됩니다.  
당신은 또한 pom과 참조를 볼 수 있습니다.  
접두사 또는 접두사가 모두 생략 된 경우 - 이 양식은 현재 사용되지 않으며 사용되어서는 안됩니다.  
**Special Variables(특수 변수)**  

|변수|설명|
|:----|:----|
|project.basedir|현재 프로젝트가 존재하는 디렉토리.|
|project.baseUri|현재 프로젝트가 존재하는 디렉토리이며 URI로 표시됩니다. Maven 2.1.0 이후|
|maven.build.timestamp|빌드의 시작을 나타내는 타임 스탬프. Maven 2.1.0-M1부터|

빌드 타임 스탬프의 형식은 아래 예제와 같이  
`maven.build.timestamp.format` 속성을 선언하여 사용자 정의 할 수 있습니다.  
~~~
<project>
  ...
  <properties>
    <maven.build.timestamp.format>yyyy-MM-dd'T'HH:mm:ss'Z'</maven.build.timestamp.format>
  </properties>
  ...
</project>
~~~
format 패턴은 [SimpleDateFormat](http://java.sun.com/javase/6/docs/api/java/text/SimpleDateFormat.html)의 API 문서에 제공된 규칙을 준수해야합니다.  
속성(Properties)이없는 경우, 형식의 기본값은 예제에 이미 나와 있습니다.  
**Properties(속성)**  
프로젝트에 정의 된 모든 특성을 변수로 참조 할 수도 있습니다. 다음 예제를 고려하십시오.  
~~~xml
<project>
  ...
  <properties>
    <mavenVersion>2.1</mavenVersion>
  </properties>
  <dependencies>
    <dependency>
      <groupId>org.apache.maven</groupId>
      <artifactId>maven-artifact</artifactId>
      <version>${mavenVersion}</version>
    </dependency>
    <dependency>
      <groupId>org.apache.maven</groupId>
      <artifactId>maven-project</artifactId>
      <version>${mavenVersion}</version>
    </dependency>
  </dependencies>
  ...
</project>
~~~

[[top]](https://github.com/ixtears23/docs/blob/master/maven/Introduction%20to%20the%20POM.md#introduction-to-the-pom)
