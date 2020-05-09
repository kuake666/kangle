clear

echo -e "
+--------------------------------------------------------------------+
|         \033[32m           阿拉丁建站系统KANGLE一键安装脚本 \033[0m  |
+--------------------------------------------------------------------+
|                          www.autoaladdin.cn                        |         
+--------------------------------------------------------------------+
|         本脚本是可以一键安装Kangle+Easypanel+Mysql集合脚本。          |
+--------------------------------------------------------------------+
|         脚本集成：PHP5.2/5.3/5.4/5.5/5.6/7.0/7.1/7.2、MYSQL5.6      |
+--------------------------------------------------------------------+
|         支持前台用户任意切换PHP5.2-7.2以适应网站程序                  |
+--------------------------------------------------------------------+
|                        BY 夸克 & 小樱 提供脚本                      |
+--------------------------------------------------------------------+
|                     \033[32m      夸克-QQ 79517721\033[0m           |
+--------------------------------------------------------------------+

\033[32m本脚本仅支持CentOS 6 64位版本\033[0m"
mysql_root_password=""
	read -p "请输入您需要设置的MySQL密码:" mysql_root_password
	if [ "$mysql_root_password" = "" ]; then
	mysql_root_password="autoaladdin"
	fi
	echo '[OK] Your MySQL password is:';echo $mysql_root_password;

yum -y install epel-release
chkconfig nscd off;service nscd stop;yum -y install dnsmasq;sed -i 's/#listen-address.*/listen-address=127.0.0.1/g' /etc/dnsmasq.conf;echo -e 'nameserver 127.0.0.1\nnameserver 208.67.222.222\nnameserver 8.8.8.8\nnameserver 114.114.114.114\nnameserver 119.29.29.29\noptions timeout:1 attempts:1 rotate' > /etc/resolv.conf;chkconfig dnsmasq on;service dnsmasq start
rm -rf /etc/yum.repos.d/CentOS-Base.repo
wget http://github.itzmx.com/1265578519/mirrors/master/CentOS/CentOS6-Base-itzmx.repo -O /etc/yum.repos.d/CentOS6-Base-itzmx.repo
rm -rf /etc/yum.repos.d/*pel.repo
rm -rf /etc/yum.repos.d/epel-testing.repo
wget http://github.itzmx.com/1265578519/mirrors/master/EPEL/epel.repo -O /etc/yum.repos.d/epel.repo
wget http://github.itzmx.com/1265578519/mirrors/master/EPEL/epel-testing.repo -O /etc/yum.repos.d/epel-testing.repo
rpm -ivh http://github.itzmx.com/1265578519/repo/master/CentOS/mysql-community-release-el6-5.noarch.rpm
rm -rf /etc/yum.repos.d/mysql-community.repo
rm -rf /etc/yum.repos.d/mysql-community-source.repo
wget http://github.itzmx.com/1265578519/repo/master/CentOS/mysql-community.repo -O /etc/yum.repos.d/mysql-community.repo
wget http://github.itzmx.com/1265578519/repo/master/CentOS/mysql-community-source.repo -O /etc/yum.repos.d/mysql-community-source.repo
yum -y install which file wget make automake gcc gcc-c++ pcre-devel zlib-devel openssl-devel sqlite-devel quota unzip bzip2 libaio-devel
ulimit -n 1048576
echo "* soft nofile 1048576" >> /etc/security/limits.conf
echo "* hard nofile 1048576" >> /etc/security/limits.conf
wget http://github.itzmx.com/1265578519/kangle/master/ent/e.sh -O e.sh;sh e.sh /vhs/kangle
wget http://github.itzmx.com/1265578519/kangle/master/kangle/easypanel/ep.sh -O ep.sh;sh ep.sh
wget http://github.itzmx.com/1265578519/transmission/master/2.84/libevent-2.0.21-stable.tar.gz
tar zxf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure
make -s -j 4
make -s install
ln -s /usr/local/lib/libevent-2.0.so.5 /usr/lib/libevent-2.0.so.5
ln -s /usr/local/lib/libevent-2.0.so.5.1.9 /usr/lib/libevent-2.0.so.5.1.9
ln -s /usr/lib/libevent-2.0.so.5 /usr/local/lib/libevent-2.0.so.5
ln -s /usr/lib/libevent-2.0.so.5.1.9 /usr/local/lib/libevent-2.0.so.5.1.9
cd ..
yum -y install memcached php-pecl-memcache
yum -y install php-pecl-apc
rm -rf /etc/sysconfig/memcached
wget http://github.itzmx.com/1265578519/kangle/master/memcached/memcached -O /etc/sysconfig/memcached
service memcached start
chkconfig --level 2345 memcached on
echo "127.0.0.1 download.safedog.cn" >> /etc/hosts
setenforce 0 && sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
wget http://github.itzmx.com/1265578519/safedog/master/2.4/safedog_linux64.tar.gz
cd ..
yum -y install mysql mysql-server
rm -rf /etc/my.cnf
wget http://github.itzmx.com/1265578519/kangle/master/mysql/5.6/my.cnf -O /etc/my.cnf
service mysqld restart
cd
#设置服务器密码
mysqladmin -u root password $mysql_root_password
cd
wget http://github.itzmx.com/1265578519/kangle/master/php/5.5/5538/completed/tpl_php5538.sh -O tpl_php5538.sh;sh tpl_php5538.sh
cd
wget http://github.itzmx.com/1265578519/kangle/master/php/5.6/5633/completed/tpl_php5633.sh -O tpl_php5633.sh;sh tpl_php5633.sh
cd
wget http://github.itzmx.com/1265578519/kangle/master/php/7.0/7027/completed/tpl_php7027.sh -O tpl_php7027.sh;sh tpl_php7027.sh
cd
wget http://github.itzmx.com/1265578519/kangle/master/php/7.1/7113/completed/tpl_php7113.sh -O tpl_php7113.sh;sh tpl_php7113.sh
cd
wget http://github.itzmx.com/1265578519/kangle/master/php/7.2/721/completed/tpl_php721.sh -O tpl_php721.sh;sh tpl_php721.sh
rm -rf /vhs/kangle/etc/config.xml
cd /vhs/kangle/etc
#配置config.xml
wget https://dev.tencent.com/u/kuakeyun/p/autoaladdin/git/raw/master/config.tar.gz -O config.tar.gz
tar zxf config.tar.gz
rm -rf config.tar.gz
cd
echo ""  > /vhs/kangle/nodewww/webftp/admin/cnzz.html
echo ""  > /vhs/kangle/nodewww/webftp/vhost/cnzz.html
cd /vhs/kangle
#安装错误页面
wget https://dev.tencent.com/u/kuakeyun/p/autoaladdin/git/raw/master/error.tar.gz -O error.tar.gz
tar zxf error.tar.gz
rm -rf error.tar.gz
cd
cd /vhs/kangle/www
wget https://dev.tencent.com/u/kuakeyun/p/autoaladdin/git/raw/master/index.tar.gz -O index.tar.gz
tar zxf index.tar.gz
rm -rf index.tar.gz
cd
cd /home
wget https://dev.tencent.com/u/kuakeyun/p/autoaladdin/git/raw/master/program1.tar.gz -O program1.tar.gz
tar zxvf program1.tar.gz
rm -rf program1.tar.gz
wget https://dev.tencent.com/u/kuakeyun/p/autoaladdin/git/raw/master/program2.tar.gz -O program2.tar.gz
tar zxvf program2.tar.gz
rm -rf program2.tar.gz
wget https://dev.tencent.com/u/kuakeyun/p/autoaladdin/git/raw/master/program3.tar.gz -O program3.tar.gz
tar zxvf program3.tar.gz
rm -rf program3.tar.gz
wget https://dev.tencent.com/u/kuakeyun/p/autoaladdin/git/raw/master/program4.tar.gz -O program4.tar.gz
tar zxvf program4.tar.gz
rm -rf program4.tar.gz
wget https://dev.tencent.com/u/kuakeyun/p/autoaladdin/git/raw/master/index.tar.gz -O index.tar.gz
tar zxf index.tar.gz
rm -rf index.tar.gz
cd  
cd /vhs/kangle/nodewww/webftp/vhost/control
wget https://dev.tencent.com/u/kuakeyun/p/autoaladdin/git/raw/master/domain.tar.gz -O domain.tar.gz
tar zxvf domain.tar.gz
rm -rf domain.tar.gz
cd
rm -rf /vhs/kangle/nodewww/webftp/vhost/control/sso.ctl.php
rm -rf /vhs/kangle/nodewww/webftp/admin/control/sso.ctl.php
clear
rm -rf start.sh
echo -e "
———————————————————————————
	     \033[1mＫＡＮＧＬＥＳＯＦＴ\033[0m

	\033[32m阿拉丁自助建站系统KANGLE安装完毕\033[0m

    \033[32m阿拉丁建站系统官网 www.autoaladdin.cn\033[0m
———————————————————————————
Easypanel 账号: admin 	Mysql 账号: root

Easypanel 密码: kangle	Mysql 密码: "$mysql_root_password




