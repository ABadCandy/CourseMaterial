for str in This is a string  #ע�ⲻҪ������������,�������Ϊ��һ������ѭ��һ�ξ������
do
    echo $str
	echo -e "\n"
done

for loop in 1 2 3 4 5
do
    echo "The value is: $loop"
done

for FILE in $HOME/.bash*  #��ʾ��Ŀ¼����.bash��ͷ���ļ�
do
   echo $FILE
done


array=(1,a,2,c,d)

for a in ${array[*]}
do
	echo $a
done


declare -i COUNTER=0  #�������ͱ���
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