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
$* �� $@ ����ʾ���ݸ�������ű������в���������˫����(" ")����ʱ������"$1" "$2" �� "$n" ����ʽ������в�����

���ǵ����Ǳ�˫����(" ")����ʱ��"$*" �Ὣ���еĲ�����Ϊһ�����壬��"$1 $2 �� $n"����ʽ������в�����"$@" �Ὣ���������ֿ�����"$1" "$2" �� "$n" ����ʽ������в�����

fi
'

a=10  #����������Ⱥż䲻���пո�
echo -e "Value of a is $a \n"  #���� -e ��ʾ��ת���ַ������滻�������ʹ�� -e ѡ�����ʹ�� -E ,����ԭ�����\n


DATE=`date`  # �����滻��ָShell������ִ���������������ʱ���棬���ʵ��ĵط������

echo "Date is $DATE"


USERS=`who | wc -l`
echo "Logged in user are $USERS"



