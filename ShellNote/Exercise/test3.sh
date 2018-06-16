echo ${var:-"Variable is not set"}
echo "1 - Value of var is ${var}"

echo ${var:="Variable is not set"}
echo "2 - Value of var is ${var}"

unset var
echo ${var:+"This is default value"}
echo "3 - Value of var is $var"

var="Prefix"
echo ${var:+"This is default value"}
echo "4 - Value of var is $var"

echo ${var:?"Print this message"}

var="chongxinfuzhi"
echo "5 - Value of var is ${var}"

#表达式和运算符之间要有空格，完整的表达式要被 ` ` 包含
val0=`expr 2 + 2`  #原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如 awk 和 expr，expr 最常用

a=10
b=20
val=`expr $a + $b`
echo "a + b : $val"
val=`expr $a - $b`
echo "a - b : $val"
val=`expr $a \* $b`  #乘号(*)前边必须加反斜杠(\)才能实现乘法运算；
echo "a * b : $val"
val=`expr $b / $a`
echo "b / a : $val"
val=`expr $b % $a`
echo "b % a : $val"
if [ $a == $b ]
then
	echo "a is equal to b"
fi
if [ $a != $b ]
then
    echo "a is not equal to b"
fi


