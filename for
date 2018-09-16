
for循环“池理解”
[root@localhost ~]# vi showday.sh
#!/bin/bash
for TM in "Morning" "Noon" "Evening"
do
  echo "The $TM of the day."
done

删除指定的软件
#!/bin/bash
#
read -p "Please enter your sofeware: " SOFT
SFDIR=`rpm -qa | grep $SOFT`
for A in $SFDIR
do
  read -p "Do you want Delete $A ?(yes/no) " ACK
  if [ $ACK = "yes" ]
  then
  rpm -e --nodeps $A
  echo "-----Delete $A Success------"
  fi
done

–对于使用“/bin/bash”作为登录Shell的系统用户，检查他们在“/opt”目录中拥有的子目录或文件数量，如果超过100个，则列出具
体个数及对应的用户帐号

#!/bin/bash
DIR="/opt"
LMT=100
ValidUsers=`grep "/bin/bash" /etc/passwd | cut -d ":" -f 1`
forUserName in $ValidUsers
do
  Num=`find $DIR -user $UserName | wc -l`
  if [ $Num -gt $LMT ] ; then
    echo "$UserName have $Num files."
  fi
done

-------------------------------------------------------------------------
删除20个用户
#!/bin/bash
i=1
while [ $i -le 20 ]
do
  userdel -r stu$i
  i=`expr $i + 1`
done

-------------------------------------------------------------------------
创建30个用户并且加入class组
#!/bin/bash
i=1
groupadd class
while [ $i -le 30 ]
do
  if [ $i -le 9 ] ;then
  USERNAME=stu0${i}
  else
  USERNAME=stu${i}
  fi
useradd $USERNAME
usermod -G class $USERNAME
i=$(($i+1))
done
-------------------------------------------------------------------------
–编写脚本文件 mydb.sh，用于控制系统服务mysqld
–当执行 ./mydb.sh start 时，启动mysqld服务
–当执行 ./mydb.sh stop 时，关闭mysqld服务
–如果输入其他脚本参数，则显示帮助信息

#!/bin/bash
case $1 in
  start)
    echo "Start MySQL service."
    ;;
  stop)
   echo "Stop MySQL service."
   ;;
  *)
   echo "Usage：$0 start|stop"
   ;;
esac
–提示用户从键盘输入一个字符，判断该字符是否为字母、数字或者其它字符，并输出相应的提示信息

#!/bin/bash
read -p "Press some key, then press Return:“ KEY
case "$KEY“ in
  [a-z]|[A-Z])
    echo "It's a letter."
    ;;
  [0-9])
    echo "It's a digit."
    ;;
  *)
    echo "It's function keys、Spacebar or other keys. "
esac
-------------------------------------------------------------------------
增加：
–在脚本中定义一个加法函数，用于计算2个整数的和
–调用该函数计算（12+34）、（56+789）的和

#!/bin/bash
adder() {
  echo `expr $1 + $2`
}
adder 12 34
adder 56 789

跟踪用户命令输入，判断命令使用是否正确
get_ps1()
{
if [ "$?" = "0" ]
then
#we're on the system console or maybe telnetting in
export PS1="[^_^] \W\\$ "
else
#we're not on the console, assume an xterm
export PS1="[T_T] \W\\$ "
fi
}
PROMPT_COMMAND=get_ps1
-------------------------------------------------------------------------
增加
//break是结束整个循环体，continue是结束单次循环
比方说：
#!/bin/bash
# test break
i=1
while [ $i -lt 10 ]
do
if [ $i = 5 ]
then
i=`expr $i + 1`
break;
fi
echo $i
i=`expr $i + 1`
done
结果是输出 1 2 3 4 就退出了整个while循环
但是如果使用continue
#!/bin/bash
# test break
i=1
while [ $i -lt 10 ]
do
if [ $i = 5 ]
then
i=`expr $i + 1`
continue;
fi
echo $i
i=`expr $i + 1`
done
结果是：1 2 3 4 6 7 8 9 10 可见他仅仅是不输出5，因为他结束了本次循环
