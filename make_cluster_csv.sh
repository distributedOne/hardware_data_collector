#!/bin/bash

machines=`ls -1 ceph_cluster_hardware_results/ | grep hw_data_results | awk -F'hw_data_results_' {'print $2'}`

echo "MACHINE, TEST, VALUE";

for machine in ${machines};
do
	rootfolder="ceph_cluster_hardware_results/hw_data_results_${machine}/results_${machine}"
	disks=`ls -1 ${rootfolder}/disks/*_model.txt`


	echo -n "${machine},"
	echo -n "cpu_model,"
	echo -n "\""; cat ${rootfolder}/cpu/cpuinfo.txt | awk -F':' {'print $2'} | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "local_cpulist,"
	echo -n "\""; cat ${rootfolder}/cpu/local_cpulist.txt | tr -d "\n"; echo -n "\"";
	echo;

	for disk in ${disks};
	do
		curdisk=`basename $disk | awk -F'_model.txt' {'print $1'}`;

		echo -n "${machine},"
		echo -n "${curdisk}_model,"
		echo -n "\""; cat ${rootfolder}/disks/${curdisk}_model.txt | tr -d "\n"; echo -n "\"";
		echo;

		echo -n "${machine},"
		echo -n "${curdisk}_queue_hw_sector_size,"
		echo -n "\""; cat ${rootfolder}/disks/${curdisk}_queue_hw_sector_size.txt | tr -d "\n"; echo -n "\"";
		echo;

		echo -n "${machine},"
		echo -n "${curdisk}_queue_max_hw_sectors_kb,"
		echo -n "\""; cat ${rootfolder}/disks/${curdisk}_queue_max_hw_sectors_kb.txt | tr -d "\n"; echo -n "\"";
		echo;

		echo -n "${machine},"
		echo -n "${curdisk}_queue_max_sectors_kb,"
		echo -n "\""; cat ${rootfolder}/disks/${curdisk}_queue_max_sectors_kb.txt | tr -d "\n"; echo -n "\"";
		echo;

		echo -n "${machine},"
		echo -n "${curdisk}_queue_nomerges,"
		echo -n "\""; cat ${rootfolder}/disks/${curdisk}_queue_nomerges.txt | tr -d "\n"; echo -n "\"";
		echo;

		echo -n "${machine},"
		echo -n "${curdisk}_queue_nr_requests,"
		echo -n "\""; cat ${rootfolder}/disks/${curdisk}_queue_nr_requests.txt | tr -d "\n"; echo -n "\"";
		echo;

		echo -n "${machine},"
		echo -n "${curdisk}_queue_read_ahead_kb,"
		echo -n "\""; cat ${rootfolder}/disks/${curdisk}_queue_read_ahead_kb.txt | tr -d "\n"; echo -n "\"";
		echo;

		echo -n "${machine},"
		echo -n "${curdisk}_queue_rq_affinity,"
		echo -n "\""; cat ${rootfolder}/disks/${curdisk}_queue_rq_affinity.txt | tr -d "\n"; echo -n "\"";
		echo;

		echo -n "${machine},"
		echo -n "${curdisk}_queue_scheduler,"
		echo -n "\""; cat ${rootfolder}/disks/${curdisk}_queue_scheduler.txt | tr -d "\n"; echo -n "\"";
		echo;

	done;

	echo -n "${machine},"
	echo -n "total_memory,"
	echo -n "\""; grep 'MemTotal' ${rootfolder}/memory/meminfo.txt | awk {'print $2 " " $3'} | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "dirty_background_ratio,"
	echo -n "\""; cat ${rootfolder}/memory/dirty_background_ratio.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "dirty_ratio,"
	echo -n "\""; cat ${rootfolder}/memory/dirty_ratio.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "vfs_cache_pressure,"
	echo -n "\""; cat ${rootfolder}/memory/vfs_cache_pressure.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "min_free_kbytes,"
	echo -n "\""; cat ${rootfolder}/memory/min_free_kbytes.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "rmem_max,"
	echo -n "\""; cat ${rootfolder}/net/rmem_max.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "wmem_max,"
	echo -n "\""; cat ${rootfolder}/net/wmem_max.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "tcp_rmem,"
	echo -n "\""; cat ${rootfolder}/net/tcp_rmem.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "tcp_wmem,"
	echo -n "\""; cat ${rootfolder}/net/tcp_wmem.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "netdev_max_backlog,"
	echo -n "\""; cat ${rootfolder}/net/netdev_max_backlog.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "tcp_timestamps,"
	echo -n "\""; cat ${rootfolder}/net/tcp_timestamps.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "tcp_sack,"
	echo -n "\""; cat ${rootfolder}/net/tcp_sack.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "tcp_available_congestion_control,"
	echo -n "\""; cat ${rootfolder}/net/tcp_available_congestion_control.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "os_version,"
	echo -n "\""; cat ${rootfolder}/os_version.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "ceph_version,"
	echo -n "\""; cat ${rootfolder}/ceph/version.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "dmi_product_name,"
	echo -n "\""; cat ${rootfolder}/dmi/product_name.txt | tr -d "\n"; echo -n "\"";
	echo;

	echo -n "${machine},"
	echo -n "dmi_product_version,"
	echo -n "\""; cat ${rootfolder}/dmi/product_version.txt | tr -d "\n"; echo -n "\"";
	echo;

done;