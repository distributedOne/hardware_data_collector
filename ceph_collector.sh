#!/bin/bash

mkdir ceph_cluster_hardware_results/

hosts=`grep 'host = ' /etc/ceph/ceph.conf | awk {'print $3'} | sort | uniq`

echo "Transferring hardware data collection script to all nodes..."
for host in ${hosts};
do
	echo "Transferring script to $host."
	scp collect_hardware_data.sh root@$host:/root/collect_hardware_data.sh &
done;
wait;
echo "All transfers completed."

echo "Starting hardware data collection on all nodes..."
for host in ${hosts};
do
	echo "Starting data collection on $host."
	ssh root@$host "chmod +x /root/collect_hardware_data.sh && /bin/bash /root/collect_hardware_data.sh > /root/collect_hw_data_$host.txt && mv /root/collect_hw_data_$host.txt /root/results_$host/collect_hw_data_$host.txt" &
done;
wait;
echo "Collection completed."

echo "Gathering results from all nodes..."
for host in ${hosts};
do
	scp root@$host:/root/hw_data_results_$host.tar.gz ceph_cluster_hardware_results/hw_data_results_$host.tar.gz &
done;
wait;
echo "Result gathering completed."

echo "Starting cleanup on all nodes..."
for host in ${hosts};
do
	echo "Cleanup starting on $host."
	ssh root@$host rm /root/hw_data_results_$host.tar.gz &
	ssh root@$host rm -rf /root/results_$host/ &
	ssh root@$host rm /root/collect_hardware_data.sh &
done;
wait;
echo "Cleanup completed."

tar zcvf ceph_cluster_hardware_results.tar.gz ceph_cluster_hardware_results/

echo "Hardware data collection has been archived in ceph_cluster_hardware_results.tar.gz."

rm -rf ceph_cluster_hardware_results/

exit 0;