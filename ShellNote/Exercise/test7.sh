your_name="qinjx"
greeting="hello, "$your_name" !"
greeting_1="hello, ${your_name} !"
echo $greeting $greeting_1

string1="abcd"
echo ${#string1} #����ַ������� 4

string2="alibaba is a great company"
echo ${string2:0:9} #������ַ��� alibaba i ,���0��ʾ��һ���ַ���ʼ��9��ʾ�ַ�������

string="alibaba is a great company"
echo `expr index "$string" str`  #���10. ��string�в���str���ֵĵ�һ���ַ�s,index��1��ʼ��,��û�ҵ������0


array1=(1 3 4 5 6)  #ֻ���ÿո�ָ�
array2=(
4 
7
13
5
7
1
)

array3[0]=9
array3[2]=10
array3[10]=30  #�±���Բ�������û�������Ϊ��


NAME[0]="Zara"
NAME[1]="Qadir"
NAME[2]="Mahnaz"
NAME[3]="Ayan"
NAME[4]="Daisy"
echo "First Index: ${NAME[0]}"
echo "Second Index: ${NAME[1]}"

echo "${array1[3]},${array2[@]},${!array3[@]},${#array2[@]}"  #ǰ�������Ƿ�����������Ԫ�أ������������ظ���������Ԫ�ص������±꣬���һ�����������а���Ԫ�صĸ���
 
echo "${#NAME[2]}"  #��������е���Ԫ�صĳ���
