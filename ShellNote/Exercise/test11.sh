a=0
until [ ! $a -lt 10 ]  #until ѭ��ִ��һϵ������ֱ������Ϊ true ʱֹͣ
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
            break   #break n ��ʾ�����ڼ���ѭ��������break��ʾ��������ѭ��
        ;;
    esac
done