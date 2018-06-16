NUMS="1 2 3 4 5 6 7"
for NUM in $NUMS
do
   Q=`expr $NUM % 2`
   if [ $Q -eq 0 ]
   then
      echo "Number is an even number!!"
      continue  #如果不加continue则下面一条 echo语句也会同时输出
   fi
   echo "Found odd number"
done


string=
for str in This is a test!
do
	echo $str
done


# Define your function here
function Hello () {  #function可加可不加
   echo "Url is http://see.xidian.edu.cn/cpp/shell/"
}
# Invoke your function
Hello

funWithReturn(){
    echo "The function is to get the sum of two numbers..."
    echo -n "Input first number: "
    read aNum
    echo -n "Input another number: "
    read anotherNum
    echo "The two numbers are $aNum and $anotherNum !"
    return `expr $aNum + $anotherNum`
}
funWithReturn
# Capture value returnd by last command
ret=$?
echo "The sum of two numbers is $ret !"