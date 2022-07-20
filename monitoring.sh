#!/bin/bash
archi=$(uname -a)

physic_cpu=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)

virtual_cpu=$(grep "processor" /proc/cpuinfo | wc -l)

total_ram=$(free --mega | grep "Mem:" | awk '{ print $2 }')
used_ram=$(free --mega | grep "Mem:" | awk '{print $3 }')
percentage_ram=$(echo "scale=2; ($used_ram/$total_ram)*100" | bc)

total_disk=$(df -Bm | grep "/dev/" | awk '{ print $2 }' | awk '{ SUM += $1 } END { print SUM}')
total_disk_gb=$(echo "scale=2; ($total_disk/1024)" | bc)
used_disk=$(df -Bm | grep "/dev/" | awk '{ print $3 }' | awk '{ SUM += $1 } END { print SUM }')
used_disk_gb=$(echo "scale=2; $used_disk/1024" | bc)
percentage_disk=$(echo "scale=2; ($used_disk_gb/$total_disk_gb) * 100" | bc)

cpu_usage=$(top -bn 1 | grep '^%Cpu')

echo "	#Architecture : ${archi}
	#CPU Physical : ${physic_cpu}
	#vCPU : ${virtual_cpu}
	#Memory usage : ${used_ram}/${total_ram}MB (${percentage_ram}%)
	#Disk usage : ${total_disk_gb}Go/${used_disk_gb}Go (${percentage_disk}%)
	#CPU load : ${cpu_usage}%"
