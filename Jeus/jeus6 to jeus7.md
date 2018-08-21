

### 2.3. 서버 설정 이전

서버 설정 이전이란 서버의 설정을 구성하는 XML 파일 등을 변환하여 이전하는 동작을 말하며,  
JEUSMain.xml, EJBMain.xml, WEBMain.xml, JMSMain.xml, accounts.xml, policies.xml와 같은 설정 파일을 포함한다.  

JEUS 7에서는 JEUSMain.xml, EJBMain.xml, WEBMain.xml, JMSMain.xml로 나누어져 있던 설정이  
domain.xml로 합쳐졌기 때문에 이를 종합하여 **domain.xml**에 설정을 해야 한다.  

#### 2.3.1. 서버 설정 이전 대상
서버 설정 이전의 경우 변환이 필요한 파일들과 대상은 다음과 같다.  

- JEUS6_HOME/config/NODE_NAME/**JEUSMain.xml**  
→ JEUS7_HOME/domains/DOMAIN_NAME/config/domain.xml  

- JEUS6_HOME/config/NODE_NAME/EJB_ENGINE_NAME/**EJBMain.xml**  
→ JEUS7_HOME}/domains/DOMAIN_NAME/config/domain.xml  

- JEUS6_HOME/config/NODE_NAME/JMS_ENGINE_NAME/**JMSMain.xml**  
→ JEUS7_HOME/domains/DOMAIN_NAME/config/domain.xml  

- JEUS6_HOME/config/NODE_NAME/SERVLET_ENGINE_NAME/**WEBMain.xml**  
→ JEUS7_HOME/domains/DOMAIN_NAME/config/domain.xml  

다음 파일들은 변환할 필요는 없지만 해당 디렉터리로 복사되어야 한다.

- JEUS6_HOME/config/NODE_NAME/SERVLET_ENGINE_NAME/web.xml  
→ JEUS7_HOME/domains/DOMAIN_NAME/config/servlet/SERVER_NAME/web.xml  

JEUS6_HOME/config/NODE_NAME/SERVLET_ENGINE_NAME/webcommon.xml  
→ JEUS7_HOME/domains/DOMAIN_NAME/config/servlet/SERVER_NAME/webcommon.xml  
