#!/bin/bash

SMARTCTL=/usr/sbin/smartctl
SMARTSCAN=/opt/smartsscan
#DISKS=(`lsblk 2>&1| grep -E  "^nvm|^sd" | grep -v NAME | grep -v $HWRAID| awk '{print $1}'`)
DIR=/var/lib/node_exporter_textfile_collectors
TMPDIR=/opt/smarts
TMPHW=/opt/hwraid
[ -d $TMPHW ] || mkdir $TMPHW

function collect_smart() {
	disks=("$@")
	for disk in ${disks[*]}
		do if [[ "$disk" != "$HWRAID" ]]
		   then	   $SMARTCTL -a /dev/$disk >$TMPDIR/$disk
			   outfile="${DIR}/${disk}.prom"
			   tmpstatus=$(<$TMPDIR/$disk)
			   format=`echo "$tmpstatus" | grep 'SATA'`
			   if [[ -z "$format" ]]
			   then nvme_status
			   else sata_status
			   fi
		  fi
   	done
}

function collect_hwraid() {
        raiddevs=("$@")
	disk=$HWRAID
	for num in ${raiddevs[*]}
                do  $SMARTCTL -a /dev/$disk -d megaraid,$num >$TMPDIR/$disk$num
		    $SMARTCTL -j -a /dev/$disk -d megaraid,$num >$TMPHW/$disk$num
                    outfile="${DIR}/${disk}${num}.prom"
                    tmpstatus=$(<$TMPDIR/$disk$num)
                    format=`echo "$tmpstatus" | grep 'SATA'`
                    if [[ -z "$format" ]]
                    then nvme_status
                    else sata_status
                    fi
        done
#       rm -f /opt/smarts/*
#       rm -f $SMARTSCAN
}

function sata_status () {
                  health=`echo "$tmpstatus" | grep "SMART overall-health self-assessment test result"| cut -d\: -f2`
                  if [ "$health" != " PASSED" ] && [ "$health" != "PASSED" ] && [ "$health" != "SUCCESS" ] && [ "$health" != " SUCCESS" ]
                       then echo "${disk}${num}_failed_state 1" > $outfile
                       else echo "${disk}${num}_failed_state 0" > $outfile
                  fi
                  echo "${disk}${num}_temperature `echo \"$tmpstatus\" | grep "Temperature_Celsius" | awk '{print $10}'`" >> $outfile
                  echo "${disk}${num}_read_errors `echo \"$tmpstatus\" | grep "Raw_Read_Error_Rate" | awk '{print $10}'`" >> $outfile
		  write_errs=`echo \"$tmpstatus\" | grep "Write_Error_Rate" | awk '{print $10}'`
		  [[ -n "$write_errs" ]] && echo "${disk}${num}_write_errors $write_errs" >> $outfile
		  lifetime=`echo "$tmpstatus" | grep "Percent_Lifetime_Remain" | awk '{print $10}'`
		  [[ -z "$lifetime" ]] &&  lifetime=`echo "$tmpstatus" | grep "Remaining_Lifetime_Perc" | awk '{print $10}'`
		  [[ -n "$lifetime" ]] && echo "${disk}${num}_perc_used `echo $(( 100 - $lifetime ))`" >> $outfile
                  chown node_exporter.node_exporter $outfile
	}


function nvme_status () {
	          health=`echo "$tmpstatus" | grep "SMART overall-health self-assessment test result"| cut -d\: -f2`
		  if [ "$health" != " PASSED" ] && [ "$health" != "PASSED" ] && [ "$health" != "SUCCESS" ] && [ "$health" != " SUCCESS" ]
                       then echo "${disk}${num}_failed_state 1" > $outfile
                       else echo "${disk}${num}_failed_state 0" > $outfile
                  fi
                  echo "${disk}${num}_temperature `echo \"$tmpstatus\" | grep "^Temperature:" | awk '{print $2}'`" >> $outfile
                  echo "${disk}${num}_smart_errors `echo \"$tmpstatus\" | grep "^Error Information Log Entries:" | awk '{print $5}'|cut -d\% -f1`" >> $outfile
                  echo "${disk}${num}_perc_used `echo \"$tmpstatus\" | grep "^Percentage Used:" | awk '{print $3}'|cut -d\% -f1`" >> $outfile
                  chown node_exporter.node_exporter $outfile
	}


$SMARTCTL --scan >$SMARTSCAN
HWRAID=`cat $SMARTSCAN| grep megaraid -B1 | grep -v megaraid | awk '{print $1}'| cut -d\/ -f3`
HWRAIDDEVS=(`cat $SMARTSCAN |grep megaraid | cut -d\, -f2 | cut -d\  -f 1`)
#DISKS=(`lsblk 2>&1| grep -E  "^nvm|^sd" | grep -v NAME | grep -v $HWRAID| awk '{print $1}'`)
DISKS=(`lsblk 2>&1| grep -E  "^nvm|^sd" | grep -v NAME | grep -v $HWRAID | awk '{print $1}'`)
collect_smart ${DISKS[*]}
collect_hwraid ${HWRAIDDEVS[*]}
#for run in {1..11} ; do collect_smart ${DISKS[*]}; sleep 5 ; done
