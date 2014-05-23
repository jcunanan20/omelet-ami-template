#!/bin/bash
  

#
# register newrelic repository
#
sudo tee /etc/apt/sources.list.d/newrelic.list << "EOF1" > /dev/null
deb http://apt.newrelic.com/debian/ newrelic non-free
EOF1

sudo sh -c 'wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -'


#
# install newrelic agent
#
sudo apt-get -y update
sudo apt-get -y install newrelic-sysmond
sudo nrsysmond-config --set license_key=bc601ba34e286544df84d72865e2023b9f425b5c
sudo /etc/init.d/newrelic-sysmond start


#
# send all syslog to loggly receiver
#
sudo tee /etc/rsyslog.d/22-loggly.conf << "EOF2" > /dev/null
$template LogglyFormat,"<%pri%>%protocol-version% %timestamp:::date-rfc3339% %HOSTNAME% %app-name% %procid% %msgid% [4e7f64f8-474e-46e3-87c4-eb39de7916fa@41058] %msg%"
 
 
*.*             @@logs-01.loggly.com:514;LogglyFormat
 
 
EOF2
 
sudo /etc/init.d/rsyslog restart
exit 0
