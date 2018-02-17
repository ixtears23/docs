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

<U>밑줄</U>
 
 
 


