#!/bin/bash

case $1 in
 "--new")
 	if test "$2"; then
 		echo 您输入的订阅地址是：$2
		wget $2 -O firststep.txt
		bash decode1.sh
		bash decode2.sh
		echo ========================================
		echo "    ip地址        耗费时间"
		cat result.txt
	else
		echo 请输入最新的订阅地址！！！
	fi
 ;;
 "")
	bash decode2.sh
	echo ========================================
	echo "    ip地址        耗费时间"
	cat result.txt
 ;;
 *)
 	echo 参数错误
 ;;
esac

exit 0
