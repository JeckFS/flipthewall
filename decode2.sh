#!/bin/bash

pingTimes=10
test -e result.txt && rm result.txt
cat thirdstep.txt | while read line
do
	decode=$(echo $line | base64 -d 2>&1)
	ok=$(echo $decode | grep -v '输入无效')
	ok=${ok:=noset}
	# 到此ok已经是有用的ssr地址了
	if test $ok != "noset"; then
		# 获取ip及端口号
		ip=$(echo $ok | cut -d ':' -f 1)
		sum=0
		totalSpend=0
		caledTimes=$pingTimes
		writeOrNot=true
		for j in $(seq $pingTimes); do
			t=$(ping -i 0.2 -c 1 -w 1 $ip)
			spend=$(echo $t | grep -o 'rtt min\/avg\/max\/mdev = .*')
			if test -z "$spend"; then
				echo "$ip--->ping不同"
				caledTimes=`expr $caledTimes - 1`
				#continue
				# ping不同的认为这个ip已经废弃，不考虑时断时续的情况
				writeOrNot=false
				break
			fi
			echo ping通的=$t
			spend=${spend#* = }
			spend=${spend%%.*}
			totalSpend=`expr $totalSpend + $spend`
		done
		echo -e "total spend=$totalSpend\n"
		if [ writeOrNot -a $totalSpend -ne 0 -a $caledTimes -ne 0 ];then
			echo "$ip `expr $totalSpend / $caledTimes`" >> result.txt
		fi
	fi
done
