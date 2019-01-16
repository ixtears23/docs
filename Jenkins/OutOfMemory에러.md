## OutOfMemory

> Maven build 시 FindBug Plugin을 함께 build 하면 OutofMemory 발생하는 문제.


### 문제 확인

- 기존 Maven Build Goals (문제 없음)
![mavenBuild](./img/mavenBuild.gif)

- Maven Goals 에 pmd, findbugs Build 추가 (OutOfMemory 발생)
![withFindBugBuild](./img/withFindBugBuild.gif)

- Build 중인 console 창 확인  
![콘솔](./img/콘솔.gif)

- OutOfMemory 발생  
![findBug에러](./img/findBug에러.GIF)  


### 해결

#### Jenkins 서버를 실행할 때 JVM 옵션의 Memory 할당 값 변경

- start.bat 파일 변경  
![CI서버](./img/CI서버.gif)

- JAVA_OPTS 값 변경  
![start_bat](./img/start_bat.gif)

#### Jenkins 에서 Maven 빌드시 Maven_OPTS 메모리 값 설정

- Jenkins 관리에서 시스템 설정 확인  
![jenkins관리](./img/jenkins관리.GIF)

- 시스템 설정에서 Maven 설정 부분 확인 (Maven Installations... 클릭)
![시스템관리](./img/시스템관리.GIF)

- Global MAVEN_OPTS 에 Maven 빌드 시 메모리 값 설정  
![시스템관리_Maven](./img/시스템관리_Maven.gif)

#### Maven 빌드 중 Findbugs 빌드 시 메모리 값 설정
- 기존 findbugs-maven-plugin 설정  
![기존Pom](./img/기존Pom.gif)

- findbugs-maven-plugin 설정에서 maxHeap 값을 추가해서 메모리 설정  
![Pom메모리추가](./img/Pom메모리추가.gif)




**결론**  
**아래와 같이 메모리 설정해서 OutOfMemory 문제 해결**
- **Jenkins** 서버 메모리 **1024**  
- **Maven Build** 메모리 **512**  
- **Findbugs Plugin** 메모리 **2048**  

**※ 참고 : 해당 서버의 총 메모리는 4G**  
