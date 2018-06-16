#create group if not exists  
group=DLtest
egrep "^$group" /etc/group >& /dev/null
if [ $? -ne 0 ]
then
    sudo groupadd $group
fi

##添加用户，并且在大硬盘下为用户生成用户目录和分组
for ((i=1;i<=40;i++))
do
    sudo useradd -d /home/test$i -m test$i -s /bin/bash -g $group
done
#cat < pi_yonghu.txt | xargs -n 1 sudo useradd -m -s /bin/bash -g $group
##批处理模式下更新密码
sudo chpasswd < pi_yonghu_mm.txt
##将上述的密码转换到密码文件和组文件
sudo pwconv
##结束验证信息
echo "OK 新建完成"
