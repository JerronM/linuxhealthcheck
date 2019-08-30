#!/bin/sh
NIXECHO="/bin/echo" 
/bin/uname -a | grep SunOS &> /dev/null
if [ $? = 0 ]; then
end

else

#OS Info Check
echo "OS Info:"
echo "----------------------"
uname -a
echo ""

#Get date/time info
echo "Date/Time Info:"
echo "----------------------"
date
echo ""

#Check the uptime and load avg on the server
echo "Uptime and Load AVG:"
echo "----------------------"
uptime
echo ""

#Get ip info
echo "IP Info:"
echo "----------------------"
ifconfig
echo ""

#Check for the highest consumers of memory and CPU from "top" output
echo "Process/Resource Info:"
echo "----------------------"
top -n 1 b | head -20
echo ""

#Interface and IP details with error counts
echo "Network Info:"
echo "----------------------"
netstat -i
echo ""

#Check for free memory
echo "Memory Stats:"
echo "----------------------"
free -m
echo ""

#Virtual memory stats
echo "Virtual memory stats:"
vmstat
echo ""

#CPU I/O stats since boot up
echo "CPU I/O Stats:"
echo "----------------------"
iostat
echo ""

#Disk/partition usage
echo "Disk/Partition Usage:"
echo "----------------------"
df -h
echo ""

#Mount Check
echo "Mount Check from fstab:"
echo "----------------------"
LINMNTCHK=`/bin/cat /etc/fstab | /bin/grep -v '^#' | awk '{print $2}' | /bin/grep -i "^/" | /bin/egrep -v '/etc/fstab|proc|sys|shm|pts|cdrom'`
for i in $LINMNTCHK; do
/bin/grep $i /proc/mounts > /dev/null

if [ $? = 0 ]; then
    echo $i "is mounted"
else
    echo $i "is not mounted - needs manual intervention"
fi
done
echo ""

#NFS Mount info
echo "NFS Mount Info:"
echo "----------------------"
showmount -e localhost
echo ""
echo "DNS Info:"
echo "----------------------"
/bin/cat /etc/resolv.conf
echo ""

fi
