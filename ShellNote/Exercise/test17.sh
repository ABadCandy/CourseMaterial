var1=10
while [ $var1 -gt 0 ]
do
    echo $var1
    # math expr
    var1=$[$var1 - 1]
done
