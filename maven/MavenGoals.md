## MavenGoals


### Maven 빌드 수명주기

- default: 프로젝트 배포를 담당하는 주요 수명주기  
- clean: 프로젝트를 지우고 이전 빌드에서 생성 된 모든 파일을 제거합니다.  
- site: 프로젝트의 사이트 문서를 만드는 방법  


### Maven Phase

Maven 단계는 Maven 빌드 수명주기 의 단계를 나타냅니다.  
다음은 기본 빌드 수명주기 에서 가장 중요한 단계 중 일부입니다 .  

- validate : 빌드에 필요한 모든 정보가 사용 가능한지 확인하십시오.  
- compile : 소스 코드 컴파일  
- test-compile : 테스트 소스 코드 컴파일  
- test : 단위 테스트 실행  
- package : 컴파일 된 소스 코드를 배포 가능한 형식 (jar, war, ...)으로 패키지화 합니다.  
- integration-test : 통합 테스트를 실행하는 데 필요한 경우 패키지 처리 및 배포  
- install : 패키지를 로컬 저장소에 설치합니다.  
- deploy : 패키지를 원격 저장소에 복사합니다.  

단계는 특정 순서로 실행됩니다. 즉, 다음 명령을 사용하여 특정 단계를 실행하면 :  
~~~console
mvn <PHASE>
~~~
이렇게하면 지정된 단계가 실행될뿐만 아니라 모든 이전 단계가 실행됩니다.  


배포 단계(deploy Phase)를 실행하는 경우 : 기본 빌드 수명주기의 마지막 단계  
배포 단계 이전의 모든 단계가 실행됩니다.... 
~~~console
mvn deploy
~~~

### Maven Goal
각 단계는 일련의 목표이며 각 목표는 특정 작업을 담당합니다.  
우리가 단계(Phase)를 실행할 때 : 이 단계(Phase)에 속한 모든 목표(goals)는 순서대로 실행됩니다.  

다음은 몇 가지 단계와 기본 목표입니다.  

 - compiler:compile – 컴파일러 플러그인의 컴파일 목표는 컴파일 단계에 바인딩됩니다.    
 - compiler:testCompile - 테스트 컴파일 단계에 바인딩된다.  
 - surefire:test 테스트 단계에 바인딩된다.  
 - install:install is - 설치 단계에 바인딩된다.  
 - jar:jar and war:war - 패키지 단계에 바인딩 됨.  

우리는 다음 명령을 사용하여 특정 단계와 그 플러그인에 묶여있는 모든 목표를 나열 할 수 있습니다.
~~~console
mvn help:describe -Dcmd=PHASENAME
~~~

예를 들어, 컴파일 단계에 속한 모든 목표를 나열하려면 다음을 실행할 수 있습니다.
~~~console
mvn help:describe -Dcmd=compile
~~~

### 메이븐 플러그인 

다음 명령을 사용하여 특정 플러그인의 모든 목표 를 나열 할 수 있습니다 .
~~~console
mvn <PLUGIN>:help
~~~

예를 들어, Failsafe 플러그인의 모든 목표를 나열하려면 다음을 입력하십시오.
~~~console
mvn failsafe:help
~~~

예를 들어 Failsafe 플러그인에서 통합 테스트 목표를 실행하려면 다음을 실행해야합니다.
~~~console
mvn failsafe:integration-test
~~~

### Maven 프로젝트 빌드하기

Maven 프로젝트를 빌드하려면 다음 단계 중 하나를 실행하여 라이프 사이클 중 하나를 실행해야합니다.  

~~~console
mvn deploy
~~~
그러면 전체 기본 수명주기 가 실행됩니다 . 또는 설치 단계 에서 멈출 수 있습니다 .  
~~~console
mvn install
~~~
하지만 대개 다음 명령을 사용합니다.
~~~console
mvn clean install
~~~
새 빌드 전에 깨끗한 라이프 사이클 을 실행하여 프로젝트를 먼저 정리합니다 .  


플러그인의 특정 목표 만 실행할 수도 있습니다.
~~~console
mvn compiler:compile
~~~


단계 또는 목표를 지정하지 않고 Maven 프로젝트를 빌드하려고하면 오류가 발생합니다.
~~~console
[ERROR] No goals have been specified for this build. You must specify a valid lifecycle phase or a goal
~~~







[출처](https://www.baeldung.com/maven-goals-phases)
