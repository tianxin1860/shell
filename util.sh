#!/bin/bash
##! @TODO: 通用工具脚本
##! @VERSION:	1.0
##! @AUTHOR: tianxin
##! @FILEIN: NONE
##! @FILEOUT: NONE

##! @TODO:	检查shell返回值，支持管道内所有返回值统一检查
##!       	需要注意使用方法：	check_retval "${PIPESTATUS[*]}" "FUNC_NAME"
##! @AUTHOR: tianxin
##! @VERSION: 1.0
##! @IN: $1 => "${PIPESTATUS[*]}"
##! @IN: $2 => shell函数名/过程名
##! @OUT: 0 => success; 255 => failure; 1 => argc error
function check_retval()
{
	if [ 2 -ne ${#} ];
	then
		echo "[WARNING]: Invalid paramters of check_retval!" 1>&2
		return 1
	fi

	awk \
	-v ret_value="$1" \
	-v func_name="$2" \
	'BEGIN {
		split(ret_value, ret_arr, " ");
		for(i in ret_arr) {
			if(ret_arr[i] != 0) {
				printf("[WARNING]: Failure at %s, pipestatus: %s\n", func_name, ret_value) > "/dev/stderr"
				exit 1
			}
		}
	}'

	if [ 0 -ne $? ];
	then
		return 255
	fi

	return 0
}
