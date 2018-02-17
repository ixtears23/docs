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
