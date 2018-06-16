for str in This is a string  #注意不要用引号括起来,否则会认为是一个整体循环一次就输出了
do
    echo $str
	echo -e "\n"
done

for loop in 1 2 3 4 5
do
    echo "The value is: $loop"
done

for FILE in $HOME/.bash*  #显示主目录下以.bash开头的文件
do
   echo $FILE
done


array=(1,a,2,c,d)

for a in ${array[*]}
do
	echo $a
done


declare -i COUNTER=0  #声明整型变量
while [ $COUNTER -lt 5 ]
do
    COUNTER=`expr $COUNTER + 1`
    echo $COUNTER
done

echo 'type <CTRL-D> to terminate'
echo -n 'enter your most liked film: '
while read FILM
do
    echo "Yeah! great film the $FILM"
done