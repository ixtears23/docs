- eclipse 검색 한 파일을 여는경우 계속 새 탭으로 열기

Windows -> Preferences -> General -> Search -> Reuse editors to show matches 체크 해제

- eclipse open 파일 갯수에 상관없이 계속 파일 열기

Windows -> Preferences -> General -> Editors -> Close editors automatically 체크 

---

### [jadclipse](http://jadclipse.sourceforge.net/wiki/index.php/Main_Page)

`net.sf.jadclipse_3.3.0.jar` 파일을 다운로드 해서  
eclipse경로\plugins 경로에 붙여 넣는다.  
- 이클립스 설정 
Windows -> Java -> JadClipse -> Path to decompiler:  
입력 값 : 예) `C:\eclipse\jad.exe`  

Windows -> General -> Editors -> File Associations  
- \*.class  
- \*.class without source  
위의 두 File Type 의 `Associated editors:`에  
JadClipse Class File Viewer (default) 로 설정 한다.

---
