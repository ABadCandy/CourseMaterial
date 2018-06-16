#return an array value

function arraydblr {
  local orignarray
  local newarray
  local elements
  local i
  orignarray=(`echo "$@"`)
  newarray=(`echo "$@"`)
  elements=$[ $#-1 ]
  for ((i=0;i<=$elements;i++))
  {
    newarray[$i]=$[ ${orignarray[$i]} * 2 ]
  }
  echo ${newarray[*]}
}

myarray=(1 2 3 4 5)
echo "The original array is : ${myarray[*]}"
#arg1=`echo ${myarray[*]}`
#result=(`arraydblr $arg1`)
result=`arraydblr ${myarray[*]}`
echo "The new array is : ${result[*]}"


