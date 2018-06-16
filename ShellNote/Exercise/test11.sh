a=0
until [ ! $a -lt 10 ]  #until 循环执行一系列命令直至条件为 true 时停止
do
   echo $a
   a=`expr $a + 1`
done

while :
do
    echo -n "Input a number between 1 to 5: "
    read aNum
    case $aNum in
        1|2|3|4|5) echo "Your number is $aNum!"
        ;;
        *) echo "You do not select a number between 1 to 5, game is over!"
            break   #break n 表示跳出第几层循环，单独break表示跳出本层循环
        ;;
    esac
done