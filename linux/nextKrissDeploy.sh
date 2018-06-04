#!/bin/sh

krissSource="/home1/ekriss/nextKriss";


echo 'Server Stop Go Go ~~ '

/home1/ekriss/jeus7/bin/stopServer -host localhost:9710 -u administrator -p jeusadmin

echo 'Server Stop Ok ~~ '



echo 'remove nextKriss Directory Go Go ~~ '

cd $krissSource

rm -r /home1/ekriss/nextKriss/design
rm -r /home1/ekriss/nextKriss/META-INF
rm -r /home1/ekriss/nextKriss/WEB-INF

echo 'remove nextKriss Directory Ok !! '



echo 'war unzip Go Go ~~ '

cd $krissSource

jar -xvf $krissSource/web.krisstar-3.5.0.war

echo 'war unzip Ok !! '



echo 'war file remove ... '

cd $krissSource

rm -f web.krisstar-3.5.0.war

echo 'war file remove Ok !! '



echo 'server start Go Go ~~ '

/home1/ekriss/jeus7/bin/jeusadmin -port 9700 -u administrator -p jeusadmin << EOF
start-server server1
exit
EOF

echo 'server start Ok ~~ '


exit 0
