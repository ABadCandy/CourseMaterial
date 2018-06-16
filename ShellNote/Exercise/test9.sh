option="${1}"  #第一个参数
case ${option} in
   -f) FILE="${2}"
      echo "File name is $FILE"
      ;;
   -d) DIR="${2}"
      echo "Dir name is $DIR"
      ;;
   *) 
      echo "`basename ${0}`:usage: [-f file] | [-d directory]"  basename表示取出路径名中最后一个路径名称
      exit 1 # Command to come out of the program with status 1 ，非0数字表示不成功退出
      ;;
esac