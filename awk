AWK
-F 以XX为分割
df -lh | grep boot | awk '{print $5}' | awk -F '%' '{print $1}'
grep "bash" /etc/passwd | awk -F ':' '{print $1,$7}'

首行尾行添加内容
grep "bash" /etc/passwd | awk -F ":" 'BEGIN {print "name,shell"} {print $1","$7} END {print "bin/bosh"}'
搜索/etc/passwd有root关键字的所有行，并显示对应的shell
awk -F: '/root/{print $7}' /etc/passwd

对count指定变量
awk '{count++;print $0;} END {print "user count is ", count}' /etc/passwd
这里没有初始化count，虽然默认是0，但是妥当的做法还是初始化为0:
awk 'BEGIN {count=0;print "[start]user count is ", count} {count=count+1;print $0;} END{print "[end]user count is ", count}' /etc/passwd
统计某个文件夹下的文件占用的字节数,过滤4096大小的文件(一般都是文件夹):
ls -l |awk 'BEGIN {size=0;print "[start]size is ", size} {if($5!=4096){size=size+$5;}} END{print "[end]size is ", size/1024/1024,"M"}'
----------------------------------------------------
unset 变量名 #取消定义变量
set/env 查看所有的环境变量
•常见的环境变量：
• $USER 、$LOGNAME
• $UID 、 $SHELL 、$HOME
• $PWD、 $PATH
$PS1、



--------------------------------------------------
linux中shell变量$#,$@,$0,$1,$2的含义解释:
变量说明:
$$
Shell本身的PID（ProcessID）
$!
Shell最后运行的后台Process的PID
$?
最后运行的命令的结束代码（返回值）
$-
使用Set命令设定的Flag一览
$*
所有参数列表。如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。
$@
所有参数列表。如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。
$#
添加到Shell的参数个数
$0
Shell本身的文件名
$1～$n
添加到Shell的各参数值。$1是第1参数、$2是第2参数…。

示例：
1 #!/bin/bash
2 #
3 printf "The complete list is %s\n""$$"
4 printf "The complete list is %s\n""$!"
5 printf "The complete list is %s\n""$?"
6 printf "The complete list is %s\n""$*"
7 printf "The complete list is %s\n""$@"
8 printf "The complete list is %s\n""$#"
9 printf "The complete list is %s\n""$0"
10 printf "The complete list is %s\n""$1"
11 printf "The complete list is %s\n""$2
结果：
[Aric@localhost ~]$ bash params.sh 123456 QQ
The complete list is24249
The complete list is
The complete list is0
The complete list is123456 QQ
The complete list is123456
The complete list isQQ
The complete list is2
The complete list isparams.sh
The complete list is123456
The complete list isQQ

