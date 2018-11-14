# maven 저장소

### sonatype - nexus


[[Central Repository]](https://search.maven.org/)

### maven 명령어

- sample
`mvn --projects my-project --also-make install`  

- `--also-make`는 my-project가 의존하는 모든 프로젝트를 빌드합니다.  
- `--also-make-dependents`는 my-project에 의존하는 모든 프로젝트를 빌드합니다.  

프로젝트 간의 종속성에 대한 DAG (Directed Acyclic Graph)를 상상한다면 (A -> B는 B가 A에 종속됨을 의미합니다),  

`--also-make`는 프로젝트 my-project의 모든 프로젝트를 "루트"프로젝트로 만들고,  
`--also make-dependents`는 프로젝트 my-project에서 "leaf"프로젝트로 모든 프로젝트를 빌드합니다.   

다음과 같은 프로젝트가 있다고 가정 해 보겠습니다.  
~~~
 dao     util
   \     /
  services
     | 
   webapp
~~~

`mvn --projects services  --also-make`  
DAO, 유틸리티 및 서비스를 build합니다.  
그리고,  
`mvn --projects services  --also-make-dependents`  
서비스와 웹 애플리케이션을 build 할 것입니다.



