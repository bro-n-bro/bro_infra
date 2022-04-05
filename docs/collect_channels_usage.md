# bro_infra
Use this instruction for setting up channel monitoring with node_exporter using textfile collectors.

First of all create directory for temporary files and download script.

``` 
mkdir /opt/rls
wget -O /opt/collect_channels.sh https://github.com/bro-n-bro/bro_infra/blob/main/scripts/smart_monitor.sh && chmod +x /opt/collect_channels.sh
```

After that run script and add correct values:
```
/opt/collect_channels.sh
```

Then decide how frequently script should run and add appropriate cron task with *crontab -e* command. 
For example, to run script every 10 minutest line should look like: 
```
*/10 * * * * /opt/collect_channels.sh
```

Latest height will be collected into textfile collectors directory (/var/lib/node_exporter_textfile_collectors) and prefixed with chain name.
For example, for Osmosis file name will be /var/lib/node_exporter_textfile_collectors/osmosisd.prom and its content - osmosisd_revision_height 2222222
