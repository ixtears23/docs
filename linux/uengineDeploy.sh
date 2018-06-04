
#!/bin/sh

uengineSource="/home1/ekriss/uengine";
krissName='bpm-4.0.0-BUILD-SNAPSHOT'
 

echo 'Server Stop Go Go ~~ '

/home1/ekriss/jeus7/bin/stopServer -host localhost:9720 -u administrator -p jeusadmin

echo 'Server Stop Ok ~~ '



echo 'war unzip Go Go ~~ '

cd $uengineSource

jar -xvf $uengineSource/bpm-4.0.0-BUILD-SNAPSHOT.war

echo 'war unzip Ok !! '



echo 'war file remove ... '

cd $uengineSource

rm -f bpm-4.0.0-BUILD-SNAPSHOT.war

echo 'war file remove Ok !! '



echo 'rename sso conf ...'

mv $uengineSource/WEB-INF/classes/tmaxeamagent.conf.run $uengineSource/WEB-INF/classes/tmaxeamagent.conf
mv $uengineSource/WEB-INF/classes/tmaxeamagent.lic.run $uengineSource/WEB-INF/classes/tmaxeamagent.lic
mv $uengineSource/WEB-INF/classes/tmaxeamapi.conf.run $uengineSource/WEB-INF/classes/tmaxeamapi.conf

echo 'rename sso conf OK !! '



echo 'server start Go Go ~~ '

/home1/ekriss/jeus7/bin/jeusadmin -port 9700 -u administrator -p jeusadmin << EOF
start-server server2
exit
EOF

echo 'server start Ok ~~ '



exit 0

