echo "What's your name?"
read PERSON
echo "Hello,$PERSON"

for skill in Ada Coffe Action Java
do
    echo "I am good at ${skill}Script"
done

myurl="http1"
echo ${myurl}

myurl="http2"  #变量可以重复定义，但是用readonly声明后则为只读变量
echo ${myurl}

value1="zhidu"

readonly value1

unset myurl    #变量被删除后不能再次使用；unset 命令不能删除只读变量。
echo $myurl    #输出空行

echo $$   #特殊变量$表示当前shell进程的ID即pid

echo "File Name: $0"
echo "First Parameter : $1"
echo "First Parameter : $2"
echo "Quoted Values: $@"
echo "Quoted Values: $*"
echo "Total Number of Parameters : $#"