#!/usr/bin/env bash

clear
SYSINFO=`head -n 1 /etc/issue`
IFS=$'\n'
UPTIME=`uptime`
D_UP=${UPTIME:1}
MYGROUPS=`groups`
DATE=`date`
KERNEL=`uname -a`
CPWD=`pwd`
ME=`whoami`
CPU=`arch`

printf "<=== SYSTEM ===>\n"
echo "  Distro info:	"$SYSINFO""
printf "  Kernel:\t"$KERNEL"\n"
printf "  Uptime:\t"$D_UP"\n"
free -mot | awk '
/Mem/{print "  Memory:\tTotal: " $2 "Mb\tUsed: " $3 "Mb\tFree: " $4 "Mb"}
/Swap/{print "  Swap:\t\tTotal: " $2 "Mb\tUsed: " $3 "Mb\tFree: " $4 "Mb"}'
printf "  Architecture:\t"$CPU"\n"
cat /proc/cpuinfo | grep "model name\|processor" | awk '
/processor/{printf "  Processor:\t" $3 " : " }
/model\ name/{
i=4
while(i<=NF){
	printf $i
	if(i<NF){
		printf " "
	}
	i++
}
printf "\n"
}'
printf "  Date:\t\t"$DATE"\n"
printf "\n<=== USER ===>\n"
printf "  User:\t\t"$ME" (uid:"$UID")\n"
printf "  Groups:\t"$MYGROUPS"\n"
printf "  Working dir:\t"$CPWD"\n"
printf "  Home dir:\t"$HOME"\n"
printf "\n<=== NETWORK ===>\n"
printf "  Hostname:\t"$HOSTNAME"\n"
ip -o addr | awk '/inet /{print "  IP (" $2 "):\t" $4}'
/sbin/route -n | awk '/^0.0.0.0/{ printf "  Gateway:\t"$2"\n" }'
cat /etc/resolv.conf | awk '/^nameserver/{ printf "  Name Server:\t" $2 "\n"}'
