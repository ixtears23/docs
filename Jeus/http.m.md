*DOMAIN
jeuservice

##### 필수항목
1)	Node Name = string 31자 이내의 string으로 정의한다.  
31자를 초과하는 이름을 사용 할 경우 에는 컴파일 에러는 나지 않으나 내부적으로 31자까지만 인식한다.  
Node 이름은 실제 등록된 Host의 이름을 말한다. 예를 들어 UNIX의 경우 “uname –n” 명령으로 각 Host의 이름을 확인할 수 있다.   
또한 해당 Node명은 반드시 “/etc/hosts” 파일에 등록되어 있어야 한다.   
하나의 Domain은 하나 이상의 Node로 이루어지므로, NODE절에는 최소한 하나 이상의 Node 이름이 정의되어야 한다.  
2)	WEBTOBDIR = literal  
크기 : 255자 이내.  
3)	SHMKEY = numeric (32768 ~ 262143)  
공유 메모리 세그먼트(Shared Memory Segment)를 가리키는 값이다.  
JEUS Web Server를 이루는 Process들이, 서로 정보를 공유하기 위한 공유 메모리 Key값을 정의할 필요가 있다.  
공유 메모리 Key 값을 정의하기 전에 이 Key 값들이, 다른 프로그램 또는 다른 업무에서 사용되는지 반드시 확인해야 한다.  
그렇지 않으면 JEUS Web Server가 Booting시에 이 프로그램과 충돌을 일으켜서 실행이 되지 않는다.   
현재 JEUS Web Server에서 정의되는 Shared Memory의 Key값은 최소 32768에서 최대 262143까지 이다.  
따라서, 이 범위 내에 있는 값을 이용하면 된다.  

4)	DOCROOT = literal  
JEUS Web Server가 Web을 통해 Service 하는 **모든 문서를 포함하는 루트 디렉토리의 경로**이다.  
즉, JEUS Web Server는 DOCROOT가 지정한 디렉토리를 최상위로 하여 문서를 Service하게 된다.  
Client가 요구한 URL은 DOCROOT의 경로 뒤에 추가되어 실제 경로명을 이루게 된다.   
JEUS Web Server는 이 경로를 가지고 파일에 접근하게 된다.   



~~~
*NODE
newtondev
                        Port = "80",
                        Logging = "log1",
                        Docroot = "/home1/ekriss",
                        Shmkey = 59309,
                        WebtobDir = "/home1/ekriss/webtob",
                        ServiceOrder = "uri,ext",
                        JsvPort = 9900,
                        HTH = 1,
                        ErrorLog = "log2"
*VHOST
ITS             Port = "80",
                NodeName = "newtondev",
                DOCROOT = "/home1/itsupport",
                HOSTNAME= "krisstar-its.kriss.re.kr",
                ServiceOrder = "uri,ext",
                Logging = "itslog",
                ErrorLog = "itserrlog"

tioom           Port = "8081",
                NodeName = "newtondev",
                Logging = "log3",
                Docroot = "/home1/ekriss/tioom",
                Hostname = "203.254.160.13",
                ErrorLog = "log4"

secrc           DOCROOT = "/home1/secrc",
                HOSTNAME = "secrc.kriss.re.kr",
                PORT = "80",
                IndexName = "index.html",
                NodeName = "newtondev"

apmp            DOCROOT = "/home1/apmp",
                HOSTNAME = "apmp.kriss.re.kr",
                PORT = "8889",
                ServiceOrder = "uri,ext",
                IndexName = "index.html",
                NodeName = "newtondev"

bpmdev                  DOCROOT = "/home1/ekriss/uengine",
                HOSTNAME = "bpmdev.kriss.re.kr",
                PORT = "80",
                ServiceOrder = "uri,ext",
                IndexName = "index.jsp",
                NodeName = "newtondev",
                Logging = "bpmdevlog",
                ErrorLog = "bpmdeverrlog"

krisstardev     DOCROOT = "/home1/ekriss/nextKriss",
                HOSTNAME = "krisstardev.kriss.re.kr",
                PORT = "80",
                ServiceOrder = "uri,ext",
                IndexName = "index.jsp",
                NodeName = "newtondev",
                Logging = "krisstardevlog",
                ErrorLog = "krisstardeverrlog"

*ALIAS
alias1          uri = "/kriss/ext/image/", RealPath = "/home1/ekriss/kriss/web/ext/image/"
alias2          uri = "/kriss/ext/script/", RealPath = "/home1/ekriss/kriss/web/ext/script/"
alias3          uri = "/kriss/ext/style/", RealPath = "/home1/ekriss/kriss/web/ext/style/"
alias4          uri = "/kriss/ext/xrw/images/", RealPath = "/home1/ekriss/kriss/web/ext/xrw/images/"
alias5          uri = "/workplace/images/", RealPath = "/home1/ekriss/kriss/workplace/images/"
alias6          uri = "/software/",  RealPath = "/home1/itsupport/software/"
alias7          uri = "/workplace/", RealPath = "/home1/ekriss/kriss/workplace/"
alias8          uri = "/its_assets/", RealPath = "/home1/itsupport/assets/"
alias9          uri = "/assets/",  RealPath = "/home1/ekriss/kriss/web/assets/"
alias10          uri = "/cms/cms_assets/", RealPath = "/home1/itsupport/cms/assets/"
alias11          uri = "/upload/", RealPath = "/home1/itsupport/upload/"
alias12          uri = "/kriss/assets/",  RealPath = "/home1/ekriss/kriss/web/assets/"

*SVRGROUP
htmlg           NodeName = "newtondev", SvrType = "HTML"
cgig            NodeName = "newtondev", SvrType = "CGI"
ssig            NodeName = "newtondev", SvrType = "SSI"
jsvg            NodeName = "newtondev", SvrType = "JSV"
jsvg2           NodeName = "newtondev", SvrType = "JSV"
jsvg3           NodeName = "newtondev", SvrType = "JSV", VhostName = "tioom"
jsvg4           NodeName = "newtondev", SvrType = "JSV", VhostName = "ITS"
jsvg5           NodeName = "newtondev", SvrType = "JSV", VhostName = "bpmdev"
jsvg6           NodeName = "newtondev", SvrType = "JSV", VhostName = "krisstardev"


*SERVER
html            SvgName = "htmlg", MinProc = 30, MaxProc = 50
cgi             SvgName = "cgig", MinProc = 1, MaxProc = 2
ssi             SvgName = "ssig", MinProc = 1, MaxProc = 2
MyGroup         SvgName = "jsvg", MinProc = 80, MaxProc = 80
tioomGroup      SvgName = "jsvg3", MinProc = 10, MaxProc = 20
ITSGroup        SvgName = "jsvg4", MinProc = 80, MaxProc = 80
BPMDEVGroup     SvgName = "jsvg5", MinProc = 80, MaxProc = 80
KRISSDEVGroup   SvgName = "jsvg6", MinProc = 80, MaxProc = 80

*URI
uri20            uri = "/", SvrType = "JSV", VhostName = "krisstardev"
uri21            uri = "/", SvrType = "JSV", VhostName = "bpmdev"
uri2            uri = "/assets/", SvrType = "HTML"
uri15           uri = "/kriss/assets/", SvrType = "HTML"
uri6            uri = "/its_assets/", SvrType = "HTML", VhostName = "ITS"
uri12           uri = "/cms/cms_assets/", SvrType = "HTML", VhostName = "ITS"
uri13           uri = "/upload/", SvrType = "HTML", VhostName = "ITS"
uri14           uri = "/software/" , SvrType = "HTML", VhostName = "ITS"
uri3            uri = "/tioom/", SvrType = "JSV", VhostName = "tioom"
uri4            uri = "/examples/", SvrType = "JSV"
uri5            uri = "/cgi-bin/", SvrType = "CGI"
uri7            uri = "/kriss/ext/image/", SvrType = "HTML"
uri8            uri = "/kriss/ext/script/", SvrType = "HTML"
uri9            uri = "/kriss/ext/style/", SvrType = "HTML"
uri10           uri = "/kriss/ext/xrw/images/", SvrType = "HTML"
uri11           uri = "/workplace/images/", SvrType = "HTML"
uri1            uri = "/", SvrType = "JSV"


*LOGGING
log1
                        FileName = "/home1/ekriss/webtob/log/access_%Y%%M%%D%.log",
                        Format = "DEFAULT",
                        Option = "sync"
log2
                        FileName = "/home1/ekriss/webtob/log/error_%Y%%M%%D%.log",
                        Format = "ERROR",
                        Option = "sync"
log3
                        FileName = "/home1/ekriss/webtob/log/access_tioom_%Y%%M%%D%.log",
                        Format = "DEFAULT",
                        Option = "sync"
log4
                        FileName = "/home1/ekriss/webtob/log/error_tioom_%Y%%M%%D%.log",
                        Format = "ERROR",
                        Option = "sync"
itslog          Format = "DEFAULT", FileName = "/home1/ekriss/webtob/log/access_its__%Y%%M%%D%.log",
                Option = "sync"
itserrlog       Format = "ERROR", FileName = "/home1/ekriss/webtob/log/error_its__%Y%%M%%D%.log",
                Option = "sync"
bpmdevlog       Format = "DEFAULT", FileName = "/home1/ekriss/webtob/log/access_bpmdev__%Y%%M%%D%.log",
                Option = "sync"
bpmdeverrlog    Format = "ERROR", FileName = "/home1/ekriss/webtob/log/error_bpmdev__%Y%%M%%D%.log",
                Option = "sync"
krisstardevlog          Format = "DEFAULT", FileName = "/home1/ekriss/webtob/log/access_krisstardev__%Y%%M%%D%.log",
                Option = "sync"
krisstardeverrlog       Format = "ERROR", FileName = "/home1/ekriss/webtob/log/error_krisstardev__%Y%%M%%D%.log",
                Option = "sync"

*EXT
htm            MimeType = "text/html", SvrType = HTML
html           MimeType = "text/html", SvrType = HTML
jsp             MimeType = "application/jsp", SvrType = JSV
swf             MimeType = "application/x-shockwave-flash", SvrType = HTML
flv             MimeType = "video/flv", SVRTYPE = HTML
avi             MimeType = "video/msvideo", SvrType = HTML
wma             MimeType = "video/msvideo", SvrType = HTML
wmv             MimeType = "video/msvideo", SvrType = HTML
asf             MimeType = "video/msvideo", SvrType = HTML
stm             MimeType = "application/street-stream", SvrType = HTML
str             MimeType = "application/street-stream", SvrType = HTML
st7             MimeType = "application/street-stream", SvrType = HTML
gdb             MimeType = "x-lml/x-gdb", SvrType = HTML
pps             MimeType = "application/vnd.ms-powerpoint", SvrType = JSV
pot             MimeType = "application/vnd.ms-powerpoint", SvrType = HTML
hwp             MimeType = "application/x-hwp", SvrType = HTML
do              MimeType = "application/do", SVRTYPE = JSV
bin             MimeType = "application/octet-stream", SVRTYPE = HTML
zip             MimeType = "application/octet-stream", SVRTYPE = HTML
cab             MimeType = "application/octet-stream", SVRTYPE = HTML
bat             MimeType = "application/octet-stream", SVRTYPE = HTML
exe             MimeType = "application/octet-stream", SVRTYPE = HTML
js              MimeType = "application/x-javascript", SVRTYPE = HTML
png             MimeType = "image/png", SVRTYPE = HTML
jpeg            MimeType = "image/jpeg", SVRTYPE = HTML
jpg             MimeType = "image/jpeg", SVRTYPE = HTML
jpe             MimeType = "image/jpeg", SVRTYPE = HTML
jfif            MimeType = "image/jpeg", SVRTYPE = HTML
pjpeg           MimeType = "image/jpeg", SVRTYPE = HTML
pjp             MimeType = "image/jpeg", SVRTYPE = HTML
bmp             MimeType = "image/bmp",  SVRTYPE = HTML
mpeg            MimeType = "video/mpeg", SVRTYPE = HTML
mpg             MimeType = "video/mpeg", SVRTYPE = HTML
mpe             MimeType = "video/mpeg", SVRTYPE = HTML
mpv             MimeType = "video/mpeg", SVRTYPE = HTML
vbs             MimeType = "video/mpeg", SVRTYPE = HTML
mpegv           MimeType = "video/mpeg", SVRTYPE = HTML
shtml           MimeType = "magnus-internal/parsed-html",   SVRTYPE = HTML
gif             MimeType = "image/gif",                     SVRTYPE = HTML
ppt             MimeType = "application/vnd.ms-powerpoint", SVRTYPE = HTML
doc             MimeType = "application/msword", SVRTYPE = HTML
pdf             MimeType = "application/pdf",               SVRTYPE = HTML
ocx             MimeType = "application/x-pe-win32-x86",    SVRTYPE = HTML
xml             MimeType = "text/html", SVRTYPE = HTML
css             MimeType = "text/css", SVRTYPE = HTML
woff             MimeType = "application/x-font-woff", SVRTYPE = HTML
eot              MimeType = "application/vnd.ms-fontobject", SVRTYPE = HTML
ttf              MimeType = "application/font-ttf", SVRTYPE = HTML
jsf             Mimetype ="application/jsp",  Svrtype=JSV,  SvrName=ITSGroup
mp4             Mimetype ="video/mp4",  SVRTYPE = HTML
~~~
