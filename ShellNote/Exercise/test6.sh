a="abc"
b="efg"
if [ $a = $b ]
then
   echo "$a = $b : a is equal to b"
else
   echo "$a = $b: a is not equal to b"
fi
if [ $a != $b ]
then
   echo "$a != $b : a is not equal to b"
else
   echo "$a != $b: a is equal to b"
fi
if [ -z $a ]  #-z �ַ�������Ϊ0����true
then
   echo "-z $a : string length is zero"
else
   echo "-z $a : string length is not zero"
fi
if [ -n $a ]  #-n �ַ�������Ϊ0����true
then
   echo "-n $a : string length is not zero"
else
   echo "-n $a : string length is zero"
fi
if [ $a ]  #����ַ����Ƿ�Ϊ�գ���Ϊ�շ��� true��
then
   echo "$a : string is not empty"
else
   echo "$a : string is empty"
fi