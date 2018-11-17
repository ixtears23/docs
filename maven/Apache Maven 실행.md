### Apache Maven 실행

[Running Apache Maven](https://maven.apache.org/run.html)


Maven을 실행하는 구문은 다음과 같습니다.  
~~~console
mvn [options] [<goal(s)>] [<phase(s)>]
~~~

사용 가능한 모든 옵션은 사용자가 액세스 할 수있는 기본 제공 도움말에 설명되어 있습니다.  
~~~console
mvn -h
~~~

Maven 프로젝트를 **빌드**하기 위한 일반적인 호출은 Maven **라이프 사이클 단계**를 사용합니다.  
예)  
~~~console
mvn package
~~~

내장 된 라이프사이클 및 phase는 다음과 같습니다.  

- clean > pre-clean, clean, post-clean  
- default > validate, initialize, generate-sources, process-sources, generate-resources, 
process-resources, compile, process-classes, generate-test-sources, process-test-sources, 
generate-test-resources, process-test-resources, test-compile, process-test-classes, test, 
prepare-package, package, pre-integration-test, integration-test, post-integration-test, verify, install, deploy  
- site > pre-site, site, post-site, site-deploy  


모든 패키지 출력물과 문서화 사이트를 생성하고 저장소 관리자에게 배포하는 프로젝트의 새로운 빌드는  
~~~console
mvn clean deploy site-deploy
~~~
패키지를 만들고 다른 프로젝트의 재사용을 위해 로컬 저장소에 설치하면됩니다.  
~~~console
mvn verify
~~~
이것은 Maven 프로젝트에 대한 가장 일반적인 빌드 호출입니다.  
프로젝트 작업을하지 않을 때, 그리고 다른 유스 케이스에서 Maven의 일부로 구현 된 특정 작업을 호출 할 수 있습니다.  
이를 플러그인의 목표라고합니다.  
~~~console
mvn archetype:generate
~~~
or  
~~~console
mvn checkstyle:check
~~~


