#!/bin/bash

DIR=/var/lib/node_exporter_textfile_collectors
TMPDIR=/opt/rls

COMPLETED=""

DAEMON1=""
CHANNEL1=""
API1=""

DAEMON2=""
CHANNEL2=""
API2=""

function collect_chain1() {
        D1=`echo $DAEMON1 | awk -F '/' '{print $NF}'`
        outfile="${DIR}/${D1}.prom"
        $DAEMON1 q ibc channel client-state transfer $CHANNEL1 --node $API1 >$TMPDIR/$D1
        d1_status=$(<$TMPDIR/$D1)
        echo "${D1}_revision_height `(echo "$d1_status" | grep latest_height -A 2  | grep revision_height) | awk '{print $2}' | cut -d\\" -f 2`" >$outfile
}

function collect_chain2() {
        D2=`echo $DAEMON2 | awk -F '/' '{print $NF}'`
        outfile="${DIR}/${D2}.prom"
        $DAEMON2 q ibc channel client-state transfer $CHANNEL2 --node $API2 > $TMPDIR/$D2
        d2_status=$(<$TMPDIR/$D2)
        echo "${D2}_revision_height `(echo "$d2_status" | grep latest_height -A 2  | grep revision_height) | awk '{print $2}' | cut -d\\" -f 2`" >$outfile
}

function collect_stats {
        collect_chain1
        collect_chain2
}

function setup() {
#Get first executable
	if [ -z $DAEMON1 ]
	then echo -n  "Please, enter global path to Chain 1 executable (default /root/go/bin/) : "
		read DAEMON1
		if [ ! -f "$DAEMON1" ] && [ ! -f "/root/go/bin/$DAEMON1" ]
		then echo "Incorrect path for the first executable!"
			exit 1
		fi
	fi
#Get first channel
	if [ -z $CHANNEL1 ]
        then echo -n  "Please, enter CHANNEL 1 name : "
                read CHANNEL1
        fi
#Get first API url
        if [ -z $API1 ]
        then echo -n  "Please, enter API URL for the first network : "
                read API1
		CODE=`curl -I $API1 2>/dev/null -m 10 | grep HTTP | awk '{print $2}'`
		if [[ $CODE != "200" ]]
		then echo -n "API unavailbalse. Is it correct?  (y/n) : "
		read ans
		while [[ $ans != @("y"|"n") ]]
			do echo -n "Please, type y or n: "
			   read ans
		done

		case $ans in
			"y") exit 0
			;;
			"n") exit 1
		esac
		fi
        fi

#Get second executable
        if [ -z $DAEMON2 ]
        then echo -n  "Please, enter global path to Chain 2 executable (default /root/go/bin/) : "
                read DAEMON2
                if [ ! -f "$DAEMON2" ] && [ ! -f "/root/go/bin/$DAEMON2" ]
                then echo "Incorrect path for the second executable!"
                        exit 1
                fi
        fi
#Get second channel
        if [ -z $CHANNEL2 ]
        then echo -n  "Please, enter CHANNEL 2 name : "
                read CHANNEL2
        fi
#Get second API url
        if [ -z $API2 ]
        then echo -n  "Please, enter API URL for the second network : "
                read API2
                CODE=`curl -I $API2 2>/dev/null -m 10 | grep HTTP | awk '{print $2}'`
                if [[ $CODE != 200 ]]
                then echo -n "API unavailbalse. Is it correct?  (y/n) : "
                read ans
                while [[ $ans != @("y"|"n") ]]
                        do echo -n "Please, type y or n: "
                           read ans
                done

                case $ans in
                        "y") exit 0
                        ;;
                        "n")
                esac
                fi
        fi

	if [[ ! -z $DAEMON1 ]] &&  [[ ! -z $CHANNEL1 ]] && [[ ! -z $API1 ]] && [[ ! -z $DAEMON2 ]] && [[ ! -z $CHANNEL2 ]] && [[ ! -z $API2 ]]
	then
		#Setting up first daemon
		if [[ $DAEMON1 == *"/"* ]]
		then sed -i -e "s|^DAEMON1=\"\"|DAEMON1=\"${DAEMON1}\"|g" /opt/collect_channels.sh
		else sed -i -e "s|^DAEMON1=\"\"|DAEMON1=\"/root/go/bin/$DAEMON1\"|g" /opt/collect_channels.sh
		fi
		#Setting up first channel
	        sed -i -e "s|^CHANNEL1=\"\"|CHANNEL1=\"${CHANNEL1}\"|g" /opt/collect_channels.sh
		#Setting up first channel
                sed -i -e "s|^API1=\"\"|API1=\"${API1}\"|g" /opt/collect_channels.sh
		#Setting up second daemon
		if [[ $DAEMON2 == *"/"* ]]
                then sed -i -e "s|^DAEMON2=\"\"|DAEMON2=\"${DAEMON2}\"|g" /opt/collect_channels.sh
                else sed -i -e "s|^DAEMON2=\"\"|DAEMON2=\"/root/go/bin/$DAEMON2\"|g" /opt/collect_channels.sh
                fi
                #Setting up first channel
                sed -i -e "s|^CHANNEL2=\"\"|CHANNEL2=\"${CHANNEL2}\"|g" /opt/collect_channels.sh
                #Setting up first channel
                sed -i -e "s|^API2=\"\"|API2=\"${API2}\"|g" /opt/collect_channels.sh
		sed -i -e "s|^COMPLETED=\"\"|COMPLETED=\"true\"|g" /opt/collect_channels.sh
	fi

}

if [[ -z $COMPLETED ]]
        then setup
        else collect_stats
fi
