

## Windows 용 Docker CE

##### Docker CE for Windows
 - Windows 10에서 실행되도록 설계된 Docker입니다.  

##### Docker
 - 도킹 된 응용 프로그램을 작성, 운송 및 실행하기 위해서  
 사용하기 쉬운 개발 환경을 제공하는 기본 Windows 응용 프로그램입니다.  

##### Windows 용 Docker CE
 - Windows 기반의 Hyper-V 가상화 및 네트워킹을 사용합니다.  
 - Windows에서 Docker 응용 프로그램을 개발하는 가장 빠르고 안정적인 방법 입니다.  
 - Linux 및 Windows Docker 컨테이너 실행을 지원합니다.  
 
##### Stable channel
신뢰할 수있는 플랫폼을 사용하려면 안정적인 채널(Stable channel)을 사용하는 것이 가장 좋습니다.  
안정적인 릴리스는 Docker 플랫폼 안정 릴리스(Stable releases)를 추적합니다.  
사용 통계 및 기타 데이터를 보낼지 여부를 선택할 수 있습니다.  
안정적인 릴리스는 **분기**마다 한 번 발생합니다.  

##### Edge channel
실험 기능을 더 빨리 사용하려면 Edge 채널을 사용하십시오.  
약간의 불안정성과 버그를 피할 수 있습니다.  
우리는 Edge 릴리스에서 사용 데이터를 수집합니다.  
엣지 빌드는 **월 1 회** 릴리스됩니다.  

[[Docker CE for Windows download Link]](https://store.docker.com/editions/community/docker-ce-desktop-windows)  

##### Install
 - 다운로드 받은 **Docker for Windows Installer**를 더블 클릭하여 설치 프로그램을 실행합니다.  
 - 설치가 완료되면 Docker가 자동으로 시작됩니다.  
 - 알림 영역의 ![whale](./img/whale-x-win.png) 고래는 **Docker가 실행 중**이며 **터미널에서 액세스 할 수 있음**을 나타냅니다.  
 
##### Run
 - PowerShell과 같은 명령 줄 터미널을 열고 일부 Docker 명령을 시험해보십시오!  
 - `docker version` 을 실행하여 Docker Version 을 확인 합니다.  
 - `docker run hello-world` 를 실행하여 Docker가 이미지를 가져 와서 실행할 수 있는지 확인합니다.  



