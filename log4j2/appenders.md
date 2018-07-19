# appenders

## RollingFileAppender

**RollingFileAppender**는 *fileName 매개 변수에 명명 된 File에 쓰고*  
TriggeringPolicy 및 RolloverPolicy에 따라 *파일을 롤오버*하는 **OutputStreamAppender**입니다.  

RollingFileAppender는 OutputStreamManager를 확장 한 RollingFileManager를 사용하여  
실제로 파일 I/O를 수행하고 롤오버를 수행합니다.  

다른 구성의 RolloverFileAppenders는 공유 할 수 없지만  
관리자가 액세스 할 수있는 경우 RollingFileManagers가 될 수 있습니다.  

예를 들어 서블릿 컨테이너에있는 두 개의 웹 응용 프로그램은 Log4j가 둘 다 공통 인 ClassLoader에 있으면  
자체 구성을 가지며 동일한 파일에 안전하게 쓸 수 있습니다.  

**RollingFileAppender**에는 *TriggeringPolicy* 및 *RolloverStrategy*가 필요합니다.  
트리거링 정책은 롤오버 전략이 롤오버의 수행 방법을 정의하는 동안 롤오버를 수행해야하는지 결정합니다.  
RolloverStrategy가 구성되어 있지 않으면 RollingFileAppender는 DefaultRolloStrategy를 사용합니다.  

og4j-2.5부터 롤오버에서 실행되도록 DefaultRolloStrategy에서 사용자 정의 삭제 작업을 구성 할 수 있습니다.  
파일명이 설정되어 있지 않은 경우는 2.8이므로, DefaultRolloStrategy 대신에 DirectWriteRolloverStrategy가 사용됩니다.  

log4j-2.9부터 롤오버에서 실행되도록 DefaultRolloverStrategy에서 사용자 정의 POSIX 파일 속성보기 조치를 구성 할 수 있습니다.  
정의되지 않은 경우 RollingFileAppender의 상속 된 POSIX 파일 속성보기가 적용됩니다.  

파일 잠금은 RollingFileAppender에서 지원하지 않습니다.  


