#!/bin/bash
################
#file_name:autodep.sh
#description：auto get psb.war from jenkins and replace old tomcat app
#last_edit: luyuexin 2018-7-4:
################


tomcathome='/usr/tomcat/apache-tomcat-8.5.24'
url='http://devint-jenkins.xxxx.com/jenkins/job/psb2.0-monitor/ws/trunk/com.xxxx.psb.webapp/target/psb-mmc.war'
oldmd5=''
mailaddrs='xxxx@xxxx.com xxxx@xxxx.com xxxx@xxxx.com xxxx@xxxx.com'

if [ -f "/root/psb-mmc/psb-old.war" ]; then
oldmd5=`md5sum /root/psb-mmc/psb-old.war`	
fi

## download psb.mmc.war
echo "start to download project war "
wget -O /root/psb-mmc/psb-new.war $url || { echo -e "\033[31m download project.war failed \033[0m";exit 1; }

## diff new.war old.war if same stop replace and exit
newmd5=`md5sum /root/psb-mmc/psb-new.war`
#if [ "${newmd5%% *}" == "${oldmd5%% *}" ];then echo -e " \033[31m the new.war has nothing changed, please check  \033[0m";exit 1 ; fi

## start to replace new war
echo -e "\033[43m stop tomcat service \033[0m"
pid=`ps -ef | grep -v 'grep '| grep tomcat | awk '{print $2}'` 
kill -9 $pid
##sh $tomcathome/bin/shutdown.sh
##sleep 2
pid2=`ps -ef | grep -v 'grep '| grep tomcat | awk '{print $2}'`
echo $pid2
if test -z $pid2 
then
  echo "tomcat process has killed" ;
else
  kill -9 $pid2    
fi

echo -e  " \033[43m remove old project and replace \033[0m"
echo ">>>>"
rm -rf $tomcathome/webapps/ROOT
unzip /root/psb-mmc/psb-new.war -d $tomcathome/webapps/ROOT >> /dev/null
if [ "$?" -ne 0 ]; then echo -e " \033[31m unzip .war failed \033[0m";exit 1 ; fi 
\cp -rf /root/psb-mmc/jdbc.properties /root/apps/ROOT

rm -rf /root/psb-mmc/psb-old.war
mv /root/psb-mmc/psb-new.war /root/psb-mmc/psb-old.war

echo -e "\033[43m start tomcat service>> \033[0m "
#$tomcathome/bin/startup.sh
service tomcat start
newpid=`ps -ef | grep -v 'grep '| grep tomcat | awk '{print $2}'`
echo "tomcat new pid is $newpid"
echo "Auto Deploy PSB end please CHECK: DeployTime：`date '+%Y-%m-%d %H:%M:%S'`"| 
echo -e "\033[42m ----------deploy end ,please check -----------\033[0m "

mail -s "Auto Deploy PSB end ! Please CHECK.  DeployTime：`date '+%Y-%m-%d %H:%M:%S'`" $mailaddrs < /root/test/mailtext.txt


