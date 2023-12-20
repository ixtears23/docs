## 세션관리 - Redisson
세션 클러스터링을 위해서 Redisson 세션 사용.
여러 서버에서 동일 사용자에 대해 동일 세션 공유

### Tomcat Redis 설정 - context.xml
**파일 위치**
- /var/lib/tomcat8/conf
- /etc/tomcat8
**context.xml**
```xml
<?xml version='1.0' encoding='utf-8'?>
<Context>
    <WatchedResource>WEB-INF/web.xml</WatchedResource>
    <WatchedResource>${catalina.base}/conf/web.xml</WatchedResource>
<Manager className="org.redisson.tomcat.RedissonSessionManager"
       configPath="${catalina.base}/redisson.conf"
       readMode="REDIS" updateMode="DEFAULT" broadcastSessionEvents="false"/>
</Context>
```
- configPath
	- Redis 설정 파일 경로 지정
- readMode : 세션 데이터의 읽기 방식 설정
	- MEMORY : 세션 데이터를 Redis와 Tomcat의 로컬 세션에 모두 저장
	- REDIS : 모든 세션 데이터를 오직 Redis에만 저장
- updateMode : 세션 데이터의 업데이트 방식 설정
	- DEFAULT : Session.setAttribute 메서드 호출시마다 Redis에 세션 데이터를 업데이트
	- AFTER_REQUEST : HTTP 요청이 완료된 후에만 Redis에 세션 데이터를 업데이트

### Redisson을 사용하기 위한 파일
**redisson jar 파일 위치**
- /usr/share/tomcat8/lib

**파일명**
- redisson-all-3.11.2.jar
- redisson-tomcat-8-3.11.2.jar

### Tomcat Redis 설정 - Redis 설정 파일
**catalina base 경로**
- /var/lib/tomcat8

**${catalina.base}/redisson.conf 경로** 
- /var/lib/tomcat8/redisson.conf

**redisson.conf**
```json
{
  "singleServerConfig": {
    "idleConnectionTimeout": 10000,
    "pingTimeout": 1000,
    "connectTimeout": 10000,
    "timeout": 3000,
    "retryAttempts": 3,
    "retryInterval": 1500,
    "password": null,
    "subscriptionsPerConnection": 5,
    "clientName": null,
    "address": "redis://prod-crm.kvgibg.ng.0001.apn2.cache.amazonaws.com:6379",
    "subscriptionConnectionMinimumIdleSize": 1,
    "subscriptionConnectionPoolSize": 50,
    "connectionMinimumIdleSize": 32,
    "connectionPoolSize": 64,
    "database": 0,
    "dnsMonitoringInterval": 5000
  },
  "threads": 0,
  "nettyThreads": 0,
  "codec": {
    "class": "org.redisson.codec.JsonJacksonCodec"
  },
  "transportMode": "NIO"
}
```

- singleServerConfig : 단일 Redis 서버 설정
	- address : redis 서버 주소
	- connectionMinimumIdleSize : 연결 풀 유휴 크기
	- connectionPoolSize : 연결 풀 총 크기
	- timeout : 네트워크 타임아웃
	- retryAttempts : 네트워크 연결 재시도
- codec : 객체 직렬화에 사용할 코덱 정의
- transportMode : 네트워크 통신 모드
	- NIO
	- EPOLL

### Redisson 으로 만들어진 세션 정보
~~~shell
$ hgetall redisson:tomcat_session:A3C07A1CCB2DEBD6248A2AB6171DB29E
 1) "session:thisAccessedTime"
 2) "[\"java.lang.Long\",1703012912165]"
 3) "session:isNew"
 4) "false"
 5) "session:lastAccessedTime"
 6) "[\"java.lang.Long\",1703012912163]"
 7) "session:maxInactiveInterval"
 8) "600000"
 9) "session:isValid"
10) "true"
11) "session:creationTime"
12) "[\"java.lang.Long\",1703012912163]"
~~~

- session:thisAccessedTime : 마지막으로 세션에 접근한 시간
- session:isNew : 세션이 새로 생성된 것인지 여부
- session:lastAccessedTime  : 이전 요청이 처리된 시간(현재 요청이 처리되기 바로 전 요청 시간)
- session:maxInactiveInterval  : 세션이 비활성 상태로 유지될 수 있는 최대 시간
- session:isValid  : 세션이 유효한지 여부
- session:creationTime : 세션이 생성된 시간

---

**redis에서 세션 조회 방법**
쿠키에 있는 JSESSIONID 로 조회 가능
- JSESSIONID=924F6D60F386B74E45760D4D01AF416C
```shell
$ hgetall redisson:tomcat_session:924F6D60F386B74E45760D4D01AF416C
```
