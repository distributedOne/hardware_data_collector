#!/bin/bash

#set -e

hostname=`hostname`;

resultfolder="results_"${hostname};

mkdir -p ${resultfolder};
mkdir -p ${resultfolder}/cpu/;
mkdir -p ${resultfolder}/disks/;
mkdir -p ${resultfolder}/memory/;
mkdir -p ${resultfolder}/net/;
mkdir -p ${resultfolder}/ceph/;
mkdir -p ${resultfolder}/dmi/;

echo "------------"
echo "CPU SECTION:"
echo "------------"
grep 'model name' /proc/cpuinfo | uniq > ${resultfolder}/cpu/cpuinfo.txt
echo -n "CPU "; cat ${resultfolder}/cpu/cpuinfo.txt;

cat /sys/bus/pci/devices/*/local_cpulist | uniq > ${resultfolder}/cpu/local_cpulist.txt
echo -n "local_cpulist: "; cat ${resultfolder}/cpu/local_cpulist.txt;

echo;

echo "------------"
echo "DISKS SECTION:"
echo "------------"

cat /proc/mounts > ${resultfolder}/disks/mounts.txt
echo "Mounts: "
echo "--------"
cat ${resultfolder}/disks/mounts.txt;

echo;

for disk in `cat /proc/partitions | grep -w sd[a-z] | awk '{print $4}'`;
do

	curdisk=${disk:0:3};

	cat /sys/block/${curdisk}/device/model > ${resultfolder}/disks/${curdisk}_model.txt;
	echo -n "disk_model: ";
	echo -n "${curdisk}: ";
	cat ${resultfolder}/disks/${curdisk}_model.txt;

	cat /sys/block/${curdisk}/queue/hw_sector_size > ${resultfolder}/disks/${curdisk}_queue_hw_sector_size.txt; 
	echo -n "hw_sector_size: ";
	echo -n "${curdisk}: ";
	cat ${resultfolder}/disks/${curdisk}_queue_hw_sector_size.txt;

	cat /sys/block/${curdisk}/queue/max_hw_sectors_kb > ${resultfolder}/disks/${curdisk}_queue_max_hw_sectors_kb.txt; 
	echo -n "max_hw_sectors_kb: ";
	echo -n "${curdisk}: ";
	cat ${resultfolder}/disks/${curdisk}_queue_max_hw_sectors_kb.txt;

	cat /sys/block/${curdisk}/queue/max_sectors_kb > ${resultfolder}/disks/${curdisk}_queue_max_sectors_kb.txt;
	echo -n "max_sectors_kb: ";
	echo -n "${curdisk}: ";
	cat ${resultfolder}/disks/${curdisk}_queue_max_sectors_kb.txt;

	cat /sys/block/${curdisk}/queue/nomerges > ${resultfolder}/disks/${curdisk}_queue_nomerges.txt;
	echo -n "nomerges: ";
	echo -n "${curdisk}: ";
	cat ${resultfolder}/disks/${curdisk}_queue_nomerges.txt;

	cat /sys/block/${curdisk}/queue/nr_requests > ${resultfolder}/disks/${curdisk}_queue_nr_requests.txt;
	echo -n "nr_requests: ";
	echo -n "${curdisk}: ";
	cat ${resultfolder}/disks/${curdisk}_queue_nr_requests.txt;

	cat /sys/block/${curdisk}/queue/read_ahead_kb > ${resultfolder}/disks/${curdisk}_queue_read_ahead_kb.txt;
	echo -n "read_ahead_kb: ";
	echo -n "${curdisk}: ";
	cat ${resultfolder}/disks/${curdisk}_queue_read_ahead_kb.txt;

	cat /sys/block/${curdisk}/queue/rq_affinity > ${resultfolder}/disks/${curdisk}_queue_rq_affinity.txt;
	echo -n "rq_affinity: ";
	echo -n "${curdisk}: ";
	cat ${resultfolder}/disks/${curdisk}_queue_rq_affinity.txt;

	cat /sys/block/${curdisk}/queue/scheduler > ${resultfolder}/disks/${curdisk}_queue_scheduler.txt;
	echo -n "scheduler: ";
	echo -n "${curdisk}: ";
	cat ${resultfolder}/disks/${curdisk}_queue_scheduler.txt;

	echo;

done;

echo "------------"
echo "MEMORY SECTION:"
echo "------------"

cat /proc/meminfo > ${resultfolder}/memory/meminfo.txt;
echo -n "total_memory: "; grep 'MemTotal' /proc/meminfo | awk {'print $2 " " $3'};

cat /proc/sys/vm/dirty_background_ratio > ${resultfolder}/memory/dirty_background_ratio.txt;
echo -n "dirty_background_ratio: "; cat ${resultfolder}/memory/dirty_background_ratio.txt;

cat /proc/sys/vm/dirty_ratio > ${resultfolder}/memory/dirty_ratio.txt;
echo -n "dirty_ratio: "; cat ${resultfolder}/memory/dirty_ratio.txt;

cat /proc/sys/vm/vfs_cache_pressure > ${resultfolder}/memory/vfs_cache_pressure.txt;
echo -n "vfs_cache_pressure: "; cat ${resultfolder}/memory/vfs_cache_pressure.txt;

cat /proc/sys/vm/min_free_kbytes > ${resultfolder}/memory/min_free_kbytes.txt;
echo -n "min_free_kbytes: "; cat ${resultfolder}/memory/min_free_kbytes.txt;

echo;

echo "------------"
echo "NET SECTION:"
echo "------------"

cat /proc/sys/net/core/rmem_max > ${resultfolder}/net/rmem_max.txt;
echo -n "rmem_max: "; cat ${resultfolder}/net/rmem_max.txt;

cat /proc/sys/net/core/wmem_max > ${resultfolder}/net/wmem_max.txt;
echo -n "wmem_max: "; cat ${resultfolder}/net/wmem_max.txt;

cat /proc/sys/net/ipv4/tcp_rmem > ${resultfolder}/net/tcp_rmem.txt;
echo -n "tcp_rmem: "; cat ${resultfolder}/net/tcp_rmem.txt;

cat /proc/sys/net/ipv4/tcp_wmem > ${resultfolder}/net/tcp_wmem.txt;
echo -n "rcp_wmem: "; cat ${resultfolder}/net/tcp_wmem.txt;

cat /proc/sys/net/core/netdev_max_backlog > ${resultfolder}/net/netdev_max_backlog.txt;
echo -n "netdev_max_backlog: "; cat ${resultfolder}/net/netdev_max_backlog.txt;

cat /proc/sys/net/ipv4/tcp_timestamps > ${resultfolder}/net/tcp_timestamps.txt;
echo -n "tcp_timestamps: "; cat ${resultfolder}/net/tcp_timestamps.txt;

cat /proc/sys/net/ipv4/tcp_sack > ${resultfolder}/net/tcp_sack.txt;
echo -n "tcp_sack: "; cat ${resultfolder}/net/tcp_sack.txt;

cat /proc/sys/net/ipv4/tcp_available_congestion_control > ${resultfolder}/net/tcp_available_congestion_control.txt;
echo -n "tcp_available_congestion_control: "; cat ${resultfolder}/net/tcp_available_congestion_control.txt;

cat /proc/version > ${resultfolder}/os_version.txt;
echo -n "os_version: "; cat ${resultfolder}/os_version.txt;

echo;

echo "------------"
echo "CEPH SECTION:"
echo "------------"

ceph -v > ${resultfolder}/ceph/version.txt
cat ${resultfolder}/ceph/version.txt;

for i in /var/run/ceph/ceph-mon.*.asok;
do
        ceph --admin-daemon=$i config show * > ${resultfolder}/ceph/config_show.txt;
done;

cat /etc/ceph/ceph.conf > ${resultfolder}/ceph/ceph.conf;
ceph osd getmap > $resultfolder/ceph/osd.map;
ceph osd getcrushmap -o /tmp/crushmap;
crushtool -d /tmp/crushmap > $resultfolder/ceph/crushmap.txt;
ceph osd tree > $resultfolder/ceph/osd_tree.txt;
ceph pg dump > ${resultfolder}/ceph/pg_dump.txt;
ceph osd dump > ${resultfolder}/ceph/osd_dump.txt;
ceph mon dump > ${resultfolder}/ceph/mon_dump.txt;

echo;

echo "------------"
echo "DMI SECTION:"
echo "------------"

cat /sys/devices/virtual/dmi/id/product_name > ${resultfolder}/dmi/product_name;
echo -n "dmi_product_name: "; cat ${resultfolder}/dmi/product_name.txt;

cat /sys/devices/virtual/dmi/id/product_version > ${resultfolder}/dmi/product_version;
echo -n "dmi_product_version: "; cat ${resultfolder}/dmi/product_version.txt;

echo;

echo "------------"
echo "Compressing data:"
echo "------------"

tar zcvf hw_data_results_$hostname.tar.gz ${resultfolder}/;

echo;

echo "hw_data_results_$hostname.tar.gz has been created in the local folder."

exit 0;