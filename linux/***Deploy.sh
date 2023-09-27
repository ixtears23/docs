#!/bin/sh

***="/home1/***/***";


echo 'Server Stop Go Go ~~ '

/home1/***/jeus7/bin/stopServer -host localhost:9710 -u administrator -p jeusadmin

echo 'Server Stop Ok ~~ '



echo 'remove *** Directory Go Go ~~ '

cd $krissSource

rm -r /home1/***/***/design
rm -r /home1/***/***/META-INF
rm -r /home1/***/***/WEB-INF

echo 'remove *** Directory Ok !! '



echo 'war unzip Go Go ~~ '

cd $***

jar -xvf $***/web.***-3.5.0.war

echo 'war unzip Ok !! '



echo 'war file remove ... '

cd $***

rm -f web.***-3.5.0.war

echo 'war file remove Ok !! '



echo 'server start Go Go ~~ '

/home1/***/jeus7/bin/jeusadmin -port 9700 -u administrator -p jeusadmin << EOF
start-server server1
exit
EOF

echo 'server start Ok ~~ '


exit 0
