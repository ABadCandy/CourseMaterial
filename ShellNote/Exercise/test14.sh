# Calling one function from another
number_one () {
   echo "Url_1 is http://see.xidian.edu.cn/cpp/shell/"
   number_two
}
number_two () {
   echo "Url_2 is http://see.xidian.edu.cn/cpp/u/xitong/"
}
number_one

unset -f number_one  #跟删除变量一样可以删除函数

number_one  #再次调用则找不到该函数报错