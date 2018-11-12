


#### log4j2 의 설정파일 위치



#### log를 사용하기 위한 종속성 추가

> **log4j2**만 사용하는 경우 아래 **2개의 dependency**만 있으면 log를 찍을 수 있습니다.  
> 자세한 내용은 아래 url을 참고 하세요.  
[Maven, Ivy, Gradle, and SBT Artifacts](https://logging.apache.org/log4j/2.x/manual/api.html)  

~~~xml
		<dependency>
			<groupId>org.apache.logging.log4j</groupId>
			<artifactId>log4j-api</artifactId>
			<version>2.11.1</version>
		</dependency>
		<dependency>
			<groupId>org.apache.logging.log4j</groupId>
			<artifactId>log4j-core</artifactId>
			<version>2.11.1</version>
		</dependency>
~~~

- 사용법  
~~~java
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
 
public class HelloWorld {
    private static final Logger logger = LogManager.getLogger("HelloWorld");
    public static void main(String[] args) {
        logger.info("Hello, World!");
    }
}
~~~


**SLF4J Bridge**를 사용하려면 아래 종속성만 추가하면 됩니다.  
~~~xml
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>slf4j-api</artifactId>
			<version>${org.slf4j-version}</version>
		</dependency>
~~~


... 
