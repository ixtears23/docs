powher shell 에서 다음과 같이 pem 파일 권한 설정

~~~shell
$ icacls.exe pem-key.pem /reset
$ icacls.exe pem-key.pem /grant:r %username%:(R)
$ icacls.exe pem-key.pem /inheritance:r
~~~

mobaxterm이라는 터미널 도구를 사용해서 터널링
~~~shell
$ ssh- i pem.key 서버주소
~~~
