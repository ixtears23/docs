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
