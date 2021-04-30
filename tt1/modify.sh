#!/bin/bash
OIFS="$IFS"
IFS=$'\n'
for i in `ldapsearch -x -D 'cn=root,dc=tt1,dc=pri' -w 'pc1234' | grep cn=| cut -d : -f 2 | sed 's/^\ //g'`
do
echo "DN: $i"
ldapmodify -x -D 'cn=root,dc=tt1,dc=pri' -w 'pc1234' << EOF
dn: $i
changetype: modify
add: objectClass
objectClass: radiusprofile

EOF

echo "$i added radiusProfile"

ldapmodify -x -D 'cn=root,dc=tt1,dc=pri' -w 'pc1234' << EOF
dn: $i
changetype: modify
replace: radiusIdleTimeout
radiusIdleTimeout: 60
#-
#replace: patata
#patata: cuak
#-
EOF

echo "$i set idletime"

done
IFS="$OIFS"
