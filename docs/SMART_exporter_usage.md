# bro_infra
Use this instruction for setting up S.M.A.R.T. status monitoring with node_exporter using textfile collectors.

There are few simple steps to set up monitoring on nodes with already existing node_exporter.

First of all, define the directory where collector files will be stored (don't worry about disk space, text files with some short lines will be overwritten).

``` 
mkdir /var/lib/node_exporter_textfile_collectors
mkdir /opt/smarts
```

```
chown node_exporter.node_exporter /var/lib/node_exporter_textfile_collectors
```

Then modify **ExecStart** line in **node_exporter.service** file and add directory as below: 

```
ExecStart=/usr/local/bin/node_exporter --collector.textfile.directory=/var/lib/node_exporter_textfile_collectors
```

Re-read service file and restart node_exporter: 

```
systemctl daemon-reload && systemctl restart node_exporter
```

After these operations node_exporter will be looking for files in **/var/lib/node_exporter_textfile_collectors** and try to parse content and report it to prometheus every time files are changed.

Now add the monitoring script into directory you want (we will use **/opt/**):

```
curl -o /opt/smart_monitor.sh  https://raw.githubusercontent.com/bro-n-bro/bro_infra/main/scripts/smart_monitor.sh 2>/dev/null
```

And make it executable:

```
chmod +x /opt/smart_monitor.sh
```

By default script defines **TMPDIR** as **/tmp**, but it could be re-defined.

So the last thing we need to do - define a cron job. Set it up like the following:

```
* * * * * /opt/smart_monitor.sh
```

If you want more frequent stats just change two latest linse of the script into this:
```
 #collect_smart ${DISKS[\*]}</code>
 for run in {1..11} ; do collect_smart ${DISKS[*]}; sleep 5 ; done </code>
 ```

Once everything is done go to your prometheus URL and check if S.M.A.R.T. status is collected. 
Just type **{your_drive}\_failed** (where your drive is sda or nvme) in search string to check if metrics are collected properly.

