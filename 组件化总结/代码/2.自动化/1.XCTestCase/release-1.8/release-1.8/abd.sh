#!/bin/bash


#参数列表
#默认打测试包
#注意兼容性和通用性处理
urlType='1'
#默认描述
describe='自动编译打包'
#是否发送邮件
sendEmail='1'
#项目名称
projectName='CYTEasyPass'
#导出方法
emethod='ad-hoc'


#获取shell脚本绝对路径
shellHome=$(cd "$(dirname "$0")";pwd)
#ipa包路径信息存放位置
ipa_path=$shellHome/ipa_path
#ipa打包信息保存位置
ipaInfo_path=$shellHome/ipaInfo_path
#ipa备份路径
ipaBackups_path='/Users/xujunquan/ipaHistory'

#firtoken
firtoken='66fad55f5b9e48ce12c409dead5299f4'
#fir short link
firShortLink='chexiaotong'

#默认邮件接收人员
mailReceiver='xujq@cig.com.cn'
#邮件标题
mailSubject='车销通ios安装包更新'



#更新svn环境
echo '---------->将执行 svn upgrade<----------'
svn upgrade

#更新代码
echo '---------->将执行 svn update<----------'
svn update


#从命令行获取参数
while getopts "t:d:m:e:" opt; do
  case $opt in  
    t)  
		#如果不是0、1、2 则无效
		if [[ $OPTARG -eq 0 || $OPTARG -eq 1 || $OPTARG -eq 2 ]]; then
			urlType=$OPTARG
		else
			echo 'urlType 错误 urlType 0->dev , 1->test , 2->production'
		fi
      	;;  
    d)
		describe=$OPTARG
		;;
	m)
		if [[ $OPTARG -eq 0 || $OPTARG -eq 1 ]]; then
            echo '设置是否发送电子邮件'
			sendEmail=#OPTARG
		else
			echo 'sendEmail 错误 sendEmail 0->不发送 ， 1->发送'
		fi
		;;
    e)
        if [[ $OPTARG -eq 0 || $OPTARG -eq 1 ]]; then
            echo '设置ipa导出方法'
            if [[ $OPTARG -eq 1 ]]; then
                emethod='app-store'
            fi
        else
            echo 'ipa导出方法错误 0->ad-hoc , 1->appstore'
        fi
        ;;
    \?)
		echo 'invalid parameters'
      	;;  
  esac  
done  


#使用fastlane进行打包操作
echo "---------->将执行 fastlane abd pname:$projectName type:$urlType emethod:$emethod des:$describe ipaInfo_path:$ipaInfo_path backups_path:$ipaBackups_path ipa_path:$ipa_path<----------"
#type          urltype设置
#des           打包描述
#ipaInfo_path  ipa打包信息存放位置
#backups_path  ipa和dsym保存路径
#ipa_path      ipa安装包路径信息存放位置
fastlane abd pname:$projectName type:$urlType emethod:$emethod des:$describe ipaInfo_path:$ipaInfo_path backups_path:$ipaBackups_path ipa_path:$ipa_path


#$? 0->执行成功，否则失败
fastlane_state=$?
#如果打包成功则上传到fir
if [[ $fastlane_state -eq 0 ]]; then
echo '---------->将执行 fir publish $(cat "$ipa_path") -c $(cat "$ipaInfo_path") -s $firShortLink -t $firtoken<----------'
echo $(cat "$ipa_path")
echo $(cat "$ipaInfo_path")
    fir publish $(cat "$ipa_path") -c $(cat "$ipaInfo_path") -s $firShortLink -t $firtoken
    fir_state=$?
fi


#如果上传fir成功，则提交变更到svn
if [[ $fastlane_state -eq 0 || $fir_state -eq 0 ]]; then
echo "---------->将执行 svn ci -m $(cat "$ipaInfo_path")<----------"
    svn ci -m $(cat "$ipaInfo_path")
fi


#如果上传fir成功，则发送邮件给相关人员
if [[ $fastlane_state -eq 0 || $fir_state -eq 0 ]]; then
echo "---------->将执行 邮件发送脚本<----------"
	#浏览器打开二维码地址
    open 'https://fir.im/chexiaotong'
	#邮件处理
	# if [[ $sendEmail -eq 1 ]]; then
	# 	#statements
		
	# fi
fi









