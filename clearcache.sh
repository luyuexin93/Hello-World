#!/bin/bash
# curl调用清除缓存接口，清理客户端缓存
addrs=" 10.10.40.10 10.10.10.189"
for addr in ${addrs[@]}
  do
    echo "正在清除${addr}缓存..."
    url="http://${addr}:8080/psc110/cache/clear"
    status=`curl -w %{http_code} ${url} -s -o /dev/null`
   if [ "$status" == "200" ];
      then echo "ok"
   else echo "error"
   fi
 done
