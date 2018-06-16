echo "\$*=" $*
echo "\"\$*\"=" "$*"
echo "\$@=" $@
echo "\"\$@\"=" "$@"
echo "print each param from \$*"
for var in $*
do
    echo "$var"
done
echo "print each param from \$@"
for var in $@
do
    echo "$var"
done
echo "print each param from \"\$*\""
for var in "$*"
do
    echo "$var"
done
echo "print each param from \"\$@\""
for var in "$@"
do
    echo "$var"
done

:'
$* 和 $@ 都表示传递给函数或脚本的所有参数，不被双引号(" ")包含时，都以"$1" "$2" … "$n" 的形式输出所有参数。

但是当它们被双引号(" ")包含时，"$*" 会将所有的参数作为一个整体，以"$1 $2 … $n"的形式输出所有参数；"$@" 会将各个参数分开，以"$1" "$2" … "$n" 的形式输出所有参数。

fi
'

a=10  #变量定义与等号间不能有空格
echo -e "Value of a is $a \n"  #这里 -e 表示对转义字符进行替换。如果不使用 -e 选项或者使用 -E ,将会原样输出\n


DATE=`date`  # 命令替换是指Shell可以先执行命令，将输出结果暂时保存，在适当的地方输出。

echo "Date is $DATE"


USERS=`who | wc -l`
echo "Logged in user are $USERS"



