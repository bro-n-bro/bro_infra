#!/bin/bash

SMARTCTL=/usr/sbin/smartctl
DISKS=(`lsblk 2>&1| grep -E  "^nvm|^sd" | grep -v NAME | awk '{print $1}'`)
DIR=/var/lib/node_exporter_text_collectors
TMPDIR=/opt/smarts

function collect_smart() {
	disks=("$@")
	for disk in ${disks[*]}
		do $SMARTCTL -a /dev/$disk >$TMPDIR/$disk
		   outfile="${DIR}/${disk}.prom"
		   tmpstatus=$(<$TMPDIR/$disk)
		   format=`echo "$tmpstatus" | grep 'SATA'`
		   if [[ -z "$format" ]]
		   then nvme_status
		   else sata_status
		   fi
   	done
}


function sata_status () {
                  health=`echo "$tmpstatus" | grep "SMART overall-health self-assessment test result"| cut -d\: -f2`
                  if [ "$health" != " PASSED" ] && [ "$health" != "PASSED" ] && [ "$health" != "SUCCESS" ] && [ "$health" != " SUCCESS" ]
                       then echo "${disk}_failed_state 1" > $outfile
                       else echo "${disk}_failed_state 0" > $outfile
                  fi
                  echo "${disk}_temperature `echo \"$tmpstatus\" | grep "Temperature_Celsius" | awk '{print $10}'`" >> $outfile
                  echo "${disk}_read_errors `echo \"$tmpstatus\" | grep "Raw_Read_Error_Rate" | awk '{print $10}'`" >> $outfile
		  echo "${disk}_write_errors `echo \"$tmpstatus\" | grep "Write_Error_Rate" | awk '{print $10}'`" >> $outfile
		  lifetime=`echo "$tmpstatus" | grep "Percent_Lifetime_Remain" | awk '{print $10}'`
		  echo "${disk}_perc_used `echo $(( 100 - $lifetime ))`" >> $outfile
                  chown node_exporter.node_exporter $outfile
	}


function nvme_status () {
	          health=`echo "$tmpstatus" | grep "SMART overall-health self-assessment test result"| cut -d\: -f2`
		  if [ "$health" != " PASSED" ] && [ "$health" != "PASSED" ] && [ "$health" != "SUCCESS" ] && [ "$health" != " SUCCESS" ]
                       then echo "${disk}_failed_state 1" > $outfile
                       else echo "${disk}_failed_state 0" > $outfile
                  fi
                  echo "${disk}_temperature `echo \"$tmpstatus\" | grep "^Temperature:" | awk '{print $2}'`" >> $outfile
                  echo "${disk}_smart_errors `echo \"$tmpstatus\" | grep "^Error Information Log Entries:" | awk '{print $5}'|cut -d\% -f1`" >> $outfile
                  echo "${disk}_perc_used `echo \"$tmpstatus\" | grep "^Percentage Used:" | awk '{print $3}'|cut -d\% -f1`" >> $outfile
                  chown node_exporter.node_exporter $outfile
	}


collect_smart ${DISKS[*]}
#for run in {1..11} ; do collect_smart ${DISKS[*]}; sleep 5 ; done
