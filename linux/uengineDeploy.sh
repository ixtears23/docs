
#!/bin/sh

uengineSource="/home1/***/***";
***Name='bpm-4.0.0-BUILD-SNAPSHOT'
 

echo 'Server Stop Go Go ~~ '

/home1/***/jeus7/bin/stopServer -host localhost:9720 -u administrator -p jeusadmin

echo 'Server Stop Ok ~~ '



echo 'war unzip Go Go ~~ '

cd $***

jar -xvf $***/bpm-4.0.0-BUILD-SNAPSHOT.war

echo 'war unzip Ok !! '



echo 'war file remove ... '

cd $***

rm -f bpm-4.0.0-BUILD-SNAPSHOT.war

echo 'war file remove Ok !! '



echo 'rename sso conf ...'

mv $***/WEB-INF/classes/tmaxeamagent.conf.run $uengineSource/WEB-INF/classes/tmaxeamagent.conf
mv $***/WEB-INF/classes/tmaxeamagent.lic.run $uengineSource/WEB-INF/classes/tmaxeamagent.lic
mv $***/WEB-INF/classes/tmaxeamapi.conf.run $uengineSource/WEB-INF/classes/tmaxeamapi.conf

echo 'rename sso conf OK !! '



echo 'server start Go Go ~~ '

/home1/***/jeus7/bin/jeusadmin -port 9700 -u administrator -p jeusadmin << EOF
start-server server2
exit
EOF

echo 'server start Ok ~~ '



exit 0

