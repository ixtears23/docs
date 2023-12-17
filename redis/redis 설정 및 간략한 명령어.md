### windows에서 redis 설치를 위한 준비
일단 windows에서는 바로 redis-cli에 접근이 불가하므로,  
redis 문서를 통해 redis를 설치한다.  

**참고**
- https://learn.microsoft.com/en-us/windows/wsl/install-manual
- https://redis.io/docs/install/install-redis/install-redis-on-windows/

1. 파워셀을 관리자 권한으로 열고 아래 순서대로 실행  
`$ dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart`  
`$ dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`  
2. 해당 링크를 찾아서 설치  
`WSL2 Linux kernel update package for x64 machines`
3. 아래 명령어 실행
`$ systeminfo | find "System Type"`
4. 아래 명령어 실행  
`$ wsl --set-default-version 2`
5. ubuntu 설치. 이건 인터넷 브라우저에서 Microsoft store 를 검색해 들어가서 ubuntu를 설치해 주면 된다.

이상 끝났으면, 설치된 ubuntu 를 실행한다.

### Redis 설치
ubuntu를 실행해서 아래 명령어 들을 실행한다.
```
$ curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

$ echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list

$ sudo apt-get update
$ sudo apt-get install redis
```
### redis 실행
```
$ sudo service redis-server start
$ redis-cli

$ 127.0.0.1:6379> ping
PONG
```

이렇게 redis 가 정상적으로 설치된 것을 확인했으면, redis-cli를 사용할 수 있는 상태가 된다.
이제 redis-cli를 사용해서 실제 aws elastic cache redis에 연결해 보자.


### redis 연결
aws elastic cache redis에 직접 접근하는 것이 아니라,  
배스천 호스트를 통해서 접근한다.(보안상의 이유)  

우선 pem 파일이 필요하다. 배스천 호스트에 접근하기 위해서  

#### 1. ubuntu에 pem파일 복사
```
$ cp /mnt/d/pem/cmsdev.pem .
```
/mnt/d 는 d드라이브를 말한다. d드라이브의 pem폴더 안의 dev-secure.pem 파일을 현재 경로에 복사한다는 의미.  

#### 2. pem 파일 권한 설정
```
$ chmod 600 dev-secure.pem
```
#### 3. 배스천 호스트로 포트포워딩
- redis 엔드포인트 : redis-001.kvgibg.0001.apn2.cache.amazonaws.com:6379
- 클라이언트 포트 : 16379
- 배스천 호스트 username : ubuntu
- 배스천 호스트 ip : 43.202.53.238
- PEM 파일 : dev-secure.pem
```
ssh -i dev-secure.pem -L 16379:redis-001.kvgibg.0001.apn2.cache.amazonaws.com:6379 ubuntu@43.202.53.238
```
#### 4. Redis 연결
```
$ redis-cli -p 16379
```

이렇게 하면 연결이 완료 된다.  
참고로, Windows에서 배스천호스트로 터널이 해둔 뒤에,  
WSL 에서 redis-cli -p 16379를 하게 되면, 커넥션 refuse가 뜨면서 연결되지 않는다.  

이유는 WSL은 별도의 네트워크 스택을 사용하기 때문에,    
윈도우에서 열린 터널을 직접 사용할 수 없다.  

**참고로 WSL이란**  
WSL - Windows Subsystem for Linux  
Windows 10과 Windows 11에서 Linux 운영 체제를 실행할 수 있게 해주는 기능이다.  

### 몇가지 실습

현재 Redis 서버에 저장된 key를 한번 살펴보자.  

```
$ KEYS *
...
15217) "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjI0MTM4NS00QTAxODM3Ri04QzhELTRENUMtOEY5Ni1BNkM3Rjk4RkI3MzgiLCJpYXQiOjE2MzE1MTg4MzcsImV4cCI6MTYzMjcyODgzN30.SHgMqzLKsZpy33ykg-HaeeZiISI-rMU0HelqCvUDmdI"
15218) "redisson:tomcat_session:1B99F7533CACE9E95C8D085CF30ADD04"
...
```
#### 타입 확인
```
$ TYPE "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjI0MTM4NS00QTAxODM3Ri04QzhELTRENUMtOEY5Ni1BNkM3Rjk4RkI3MzgiLCJpYXQiOjE2MzE1MTg4MzcsImV4cCI6MTYzMjcyODgzN30.SHgMqzLKsZpy33ykg-HaeeZiISI-rMU0HelqCvUDmdI"
string
$ TYPE "redisson:tomcat_session:1B99F7533CACE9E95C8D085CF30ADD04"
hash
```
#### String 데이터 확인
```
$ GET "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjI0MTM4NS00QTAxODM3Ri04QzhELTRENUMtOEY5Ni1BNkM3Rjk4RkI3MzgiLCJpYXQiOjE2MzE1MTg4MzcsImV4cCI6MTYzMjcyODgzN30.SHgMqzLKsZpy33ykg-HaeeZiISI-rMU0HelqCvUDmdI"
"241385-4A01837F-8C8D-4D5C-8F96-A6C7F98FB738"
```
#### hash 데이터 확인
```
$ HGETALL "redisson:tomcat_session:1B99F7533CACE9E95C8D085CF30ADD04"

 1) "session:thisAccessedTime"
 2) "[\"java.lang.Long\",1702397095607]"
 3) "session:isNew"
 4) "false"
 5) "session:lastAccessedTime"
 6) "[\"java.lang.Long\",1702397095605]"
 7) "session:maxInactiveInterval"
 8) "600000"
 9) "session:isValid"
10) "true"
11) "session:creationTime"
12) "[\"java.lang.Long\",1702397095605]"
```
- 1),3),5)... : 필드명
- 2),4),6)... : 필드에 저장된 값

#### 데이터 유효기간 확인
```
$ TTL "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IjI0MTM4NS00QTAxODM3Ri04QzhELTRENUMtOEY5Ni1BNkM3Rjk4RkI3MzgiLCJpYXQiOjE2MzE1MTg4MzcsImV4cCI6MTYzMjcyODgzN30.SHgMqzLKsZpy33ykg-HaeeZiISI-rMU0HelqCvUDmdI"
(integer) 1138698280
$ TTL "redisson:tomcat_session:1B99F7533CACE9E95C8D085CF30ADD04"
(integer) 176556
```
TTL 로 조회된 값은 초를 의미합니다.  
- 1138698280 초  
- 176556 초

이상 짧게 마무리 하겠습니다.
