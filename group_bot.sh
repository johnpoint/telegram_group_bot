#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#=================================================
#	System Required: CentOS 6+/Debian 6+/Ubuntu 14.04+
#	Version: 0.0.0
#	Blog: johnpoint.github.io
#	Author: johnpoint
#	Email: jahanngauss414@gmail.com
#    USE AT YOUR OWN RISK!!!
#    Publish under GNU General Public License v2
#=================================================

sh_ver="0.0.0"
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"
Separator_1="——————————————————————————————"

###############
#		检查权限		#
###############

[[ $EUID != 0 ]] && echo -e "${Error} 当前账号非ROOT(或没有ROOT权限)，无法继续操作，请使用${Green_background_prefix} sudo su ${Font_color_suffix}来获取临时ROOT权限（执行后会提示输入当前账号的密码）。" && exit 1

############
#		检测		#
############

if [ -f /etc/redhat-release ]; then
    release="centos"
    PM='yum'
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
    PM='apt-get'
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
    PM='apt-get'
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    PM='yum'
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
    PM='apt-get'
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
    PM='apt-get'
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    PM='yum'
 else
    echo -e "${Error}无法识别~"
    exit 0
fi

menu(){
echo -e "  telegram group bot ${Red_font_prefix}[v${sh_ver}]${Font_color_suffix}
  ---- johnpoint ----
  ${Green_font_prefix}1.${Font_color_suffix} 安装 lnmp
  ${Green_font_prefix}2.${Font_color_suffix} 安装 wordpress
  ${Green_font_prefix}3.${Font_color_suffix} 安装 DirectoryLister
 "
	echo && stty erase '^H' && read -p "请输入数字 [1-3]：" num
case "$num" in
	1)
	Install_lnmp
	;;
	2)
	Install_wordpress
	;;
	3)
	Install_DirectoryLister
	;;
	*)
	echo -e "${Error} 请输入正确的数字 [1-3]"
	;;
esac
}

action=$1
if [[ ! -z $action ]]; then
	if [[ $action = "start" ]]; then
		Start_bot
	elif [[ $action = "stop" ]]; then
		Stop_bot
	elif [[ $action ="restart" ]]; then
		Stop_bot
		Start_bot
else
	menu
fi

