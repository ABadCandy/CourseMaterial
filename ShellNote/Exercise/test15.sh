funWithParam(){
    echo "The value of the first parameter is $1 !"
    echo "The value of the second parameter is $2 !"
    echo "The value of the tenth parameter is $10 !"  #��ʱ��ȡ�Ĳ���Ϊi${1}0,��220
    echo "The value of the tenth parameter is ${10} !"  #$10 ���ܻ�ȡ��ʮ����������ȡ��ʮ��������Ҫ${10}����n>=10ʱ����Ҫʹ��${n}����ȡ������
    echo "The value of the eleventh parameter is ${11} !"
    echo "The amount of the parameters is $# !"  # ��������
    echo "The string of the parameters is $* !"  # ���ݸ����������в���
}
funWithParam 22 2 3 4 5 6 7 8 9 34 73