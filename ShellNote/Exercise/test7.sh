your_name="qinjx"
greeting="hello, "$your_name" !"
greeting_1="hello, ${your_name} !"
echo $greeting $greeting_1

string1="abcd"
echo ${#string1} #输出字符串长度 4

string2="alibaba is a great company"
echo ${string2:0:9} #输出子字符串 alibaba i ,左边0表示第一个字符开始，9表示字符的总数

string="alibaba is a great company"
echo `expr index "$string" str`  #输出10. 从string中查找str出现的第一个字符s,index从1开始数,若没找到则输出0


array1=(1 3 4 5 6)  #只能用空格分隔
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
array3[10]=30  #下标可以不连续，没定义的则为空


NAME[0]="Zara"
NAME[1]="Qadir"
NAME[2]="Mahnaz"
NAME[3]="Ayan"
NAME[4]="Daisy"
echo "First Index: ${NAME[0]}"
echo "Second Index: ${NAME[1]}"

echo "${array1[3]},${array2[@]},${!array3[@]},${#array2[@]}"  #前两个都是返回数组所有元素，第三个个返回该数组中有元素的所有下标，最后一个返回数组中包含元素的个数
 
echo "${#NAME[2]}"  #获得数组中单个元素的长度
