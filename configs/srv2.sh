rc-update add staticroute
cat >/etc/route.conf<< EOF
net 10.10.10.0 netmask 255.255.255.0 gw 10.20.20.1
EOF
/etc/init.d/staticroute start
