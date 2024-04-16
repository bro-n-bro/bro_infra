#!/bin/bash

########### Keys data and functions ###########
# Announce bro keys
KEYS="#savetheales\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDO6Qj3xtwzwHD1RZQlcwuvnkoTBeo9XbSdgqKHcIMpQHpsmHb/vQnIowMXNddsnAZeVa7vQQKqvZnbVuQwjQsS67KYIuw0hBnWEr4wkIhD2g4P1Fq+g/srq0UEeOXl0vK6Pk2rdZzdgBXJXIfRBcNk5/LAE+tEkWtWy3OaINR1GF68ptjQyztWKpU5VVpG9JyvA4BN4rJ8rqsw+GSkNLSrERWlw+ij13Nf4pQ9c42+NM0c4VdWNyU4CkPONHiWGtoEXHtvay34JKyLdsE8Tz9iDgGHFzsJ6r/1g5DbFgatF8eVlyFbdggjxw9tp2ER2VbkrXHefdTGfSQKJmXz0e1p alpuchilo@Admins-MacBook-Pro.local\n\n#cyberobione\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDP9jEZChtvn3FZ74LXMu64J4pWq3QZyrS07izJVB1k8GGzZTg/rJ81ZUB1EUq8v2DTOmXqodulCQWezF7qBeXJUmlEKL4NZ+RmDRXtDQkh6THDF2z8EIxbPXMfhdeBsp56f2CgcoedgPqsnEJV4wjM8vwVu2s2SGClClrnQ9BW9N6A61JuyGXrXfc3H9Cd5BYOlzDfe42hATAN71H/E7ePWFBiqyG1kMPiIPiYSY7uJLRkvBWo350t6GJDJSxX3fBE/4/w8d9nZLoD0FJoQE1gwOmM5buglYrq4cmWnCB2HIQp4uOBlWMpRkaHBKsAtvpGs8JVWsNMdy1IN1nkLqgAi7wR+rjC0FTHWllGN7v5QWkvbl39hl0GEbPch8mIj83882L6fprskcli+jKCDG7jwHGpChh/Uu0ej+CS3ehQXM8INu+1yN+cgPoWCLP2hTw4fYgvO8LiCPyyWvPzCNwPn8gwh07RLrEsIfA68dmIMJuhx+CMnfrYYYHDoqFzyN8= root@earth\n\n#mrlp4\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4K6mOZ079d3CqH6JXE6y0WbhOxbTLHgDH9FAMvdBOtQJYSPh9yd5BYWnGvFKn6iexj2FuRrS0R7lo9d1zFiKusjLwfa263JFoBCA+yDBHd5qOInRV0HalDAFcQKtUt3UFl5OImU94ABK3f300wTj+smXBjanBfpnpUPzstqBV8op00DmJgcGLC6lkN+hbdftcnbTQs9IYJxIylRtiLExeUe7iBC8QcHnn1QOQFLxhBwkrdm7I9q5nGgZ+nq2rTD1duEx0dsr471aIDB2L41U9j3jqpxH1ncqNtI8O04aAt5aPpaw8QKMSZtdwYnHyliw+Y9TB7BFhK5C7AAXERrqC6IGWPDZV1J1ciw1IEpEKuOkqKVojkGuEt7QxekynuoW5yUaikOOACStyQgx6hrdrTkhbDU6xauPeTvLVhb3R0IEqENYw9OoaJEHnN/sCkXxoyyhVTGJ6XxEX1YBJ8s/QQLBPm6JEIBQGbSJEhOLz1UPb8B8A2f12z8jo692JbYluuonJcHubGZnhMBqPAc075BJ9hExcQLSKOoqjxqhw9mvPN5flhBGCN1YjbwxSIGPlzNmv42sreSX2HPemiTTfCO5rpHxEkquVFui5WkxszrhY10y8JEdA6VpxkN0vr9rF4N1+jgdPAom7ZJ0EEZvP2nnwu2tKK/Kl8hDYzpeWLQ== mrlp4@linuxisbetter\n\n#jimbatan\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDh2HPz3WhUH1ixRV4J1eWRBI/96all7L3hvjaOGNzlBtwP44J1XM4pft7sEexdYkepdIcdSgKJuF1TyU72SET8AgqeeEbxqVu2+R9uhb1iBQdsG4cQUO8TL9hgohuoBtaUqtrxYOuhxR1N3CkZzLzcSBSuztJZ7ud+pmcJOjc2oFrJ7f8bnH3ohucMLUZJyhi7pQwRT5nlMjZNMNy1yxrjIwPG9pMAuSiWR1hrADOPmIikNgYHx1JGr7PfWkE062vLZSm/hBOmXoqAHtbARA5+MXMFfsWAJKNABEvr6P2wnGDw/vjv3YdqRyetQTgwT7kzojY7AIBWwSyFucJH8RNtFy78Xvea9F2nwA+udWAFoDe9Tc6pRVU2TYQIwyiFnYenRdR4DgjkXjQg0EOqbI9G6gbapgjwlCoPm8cyZiS0daJvUJtnZXpxXnH9OBkPlsw7Nt6NXg2tc86wH826ZK3y4NjIlGHQg9C7b/zP5tzO/TfrZpYrFeULjsN+y4vWn0U= alexb@Alexs-MacBook-Pro.local\n\n#duckveider\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiaADrJBodNfh7l27rIa67Ucxww6OXTS5oNzjUIwIBNPrORmvOeZwmMFr7r9edg1UTjtB8RcfPQMtGEgHY0hsN7K6Ac8vKkXVkMBSBRIEldofqC24h94teZKwyrQ5q9axFClXYC4X8iSE2DLBijSFV9vwumjZaiwp+gXY9vXX7rDlvW81ofpR2mkTgY/PWSxsiYTxik/8uQHuNTtOPtXH04jFfm02IWJS2gvDC4a6EXKOvysjXCUA2/U/UFKbjUHvr2JWuDL+mTxYjL7xsSZuQQf+Q0ukcTaVT8mECNZqZihDIwR4qUMNJM5ec3TIysPpqb2GWoDwCcbWOakBNpHZB duckveider\n\n#gateway\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC06K2whbJPM4KQbdY4xCsP8FJs5Au8eiBbJLdy9RV+lTfnvYFTs+CzPUUVNa94yuTE7PQIlcHNo2ek4lWP0RB9Sfytq0aGCnuJicAE8eITBBwy2l1Tn0sqMIDZduwAxlflvxHNVYnag/3A2iNWKIOFT9lalE3w3IK08t0Iy/zm9TeeLI6S3TvBf6EH1U0dvflhDV9JvneaEZIjt1rgl8ZJ+PGcHALvQP5zTkQ7z8ydN9CqfKmjwlmMX9aURfj7HBUbr+GsuENJIpjL+JFFFQ1SjSTA8pW8eSQo5/ChTY++7KcwP8nV+s10QM6cRvzQJnZkKBmA2hbPQzMRJIXYL82VVbCiC8z1QpZ01vyAI+Iz24iGK0fnQo11EgItp5c7pCGGYpHr0jDEvaM1F6pureS73Zg3QnirJf8FGnDeXC1TNn1GWiA8xQpjB9LBA3/GKR3U9z9C3NS4lxQp3lO6yQl5IrJ5s+pGF7GSZpdk1HMAY62A22uHVy8mUioND3GMPeE= bro@gateway"
SSHDAPPEND="\n\n#Skip 2nd factor when access from Bro gateway\nMatch Address 116.203.197.50/32\n  AllowUsers bro\n  AuthenticationMethods publickey\n  PubkeyAuthentication yes\n  PasswordAuthentication no"
#function for manual adding of keys to authorized_keys
keys_manual () {
  printf '\n************************************************\n'
  enough=false
  while [ "$enough" == false ]; do
     echo "Please enter allowed RSA keys"
     read -r  TEAMRSA
     echo $TEAMRSA >> /home/$USR/.ssh/authorized_keys
     echo "Want to add one more? y/n"
     read -r  RPLY
     if [ "$RPLY" = "n" ]; then
       enough=true
       break
     else
       enough=false
     fi ;
  done
}

#function for automatic adding of Bro Team keys to authorized_keys
add_keys () {

echo -n "Do you want to add Bro team and GW keys? (y/n, default y): "
    read ans
    ans="${ans:-y}"
    while [[ $ans != @("y"|"n") ]]
      do echo -n "Please, type y or n (Enter for y): "
         read ans
         ans="${ans:-y}"
    done

    case $ans in
      "y") echo -e $KEYS >> /home/$USR/.ssh/authorized_keys ;;
      "n") keys_manual
    esac
}

add_gw () {
echo -n "Do you want to allow access from Bro gateway withou 2nd factor? (y/n, default y): "
    read ans
    ans="${ans:-y}"
    while [[ $ans != @("y"|"n") ]]
      do echo -n "Please, type y or n (Enter for y): "
         read ans
         ans="${ans:-y}"
    done

    case $ans in
      "y") echo -e $SSHDAPPEND >> /etc/ssh/sshd_config ;;
      "n") ;;
    esac
}

# function for API access
add_front () {
echo -n "Do you want to allow access from Bro FE node (suitable for API nodes)? (y/n, default y): "
    read ans
    ans="${ans:-y}"
    while [[ $ans != @("y"|"n") ]]
      do echo -n "Please, type y or n (Enter for y): "
         read ans
         ans="${ans:-y}"
    done

    case $ans in
      "y") ufw allow from $API_IP to any port 26657
           ufw allow from $API_IP to any port 1317 ;;
      "n") ;;
    esac
}

# Function for setting app monitoring
setup_monitoring () {
echo -n "Do you want to setup default bro monitoring? (y/n, default y): "
    read ans
    ans="${ans:-y}"
    while [[ $ans != @("y"|"n") ]]
      do echo -n "Please, type y or n (Enter for y): "
         read ans
         ans="${ans:-y}"
    done

    case $ans in
      "y") git clone https://github.com/mrlp4/node_monitoring.git /tmp/monitor
           cd /tmp/monitor
           bash install_prom.sh
           systemctl restart prometheus
           bash install_node_exp.sh
           mkdir -p /var/lib/node_exporter_textfile_collectors
           chown node_exporter.node_exporter /var/lib/node_exporter_textfile_collectors
           sed -i -e 's|ExecStart=/usr/local/bin/node_exporter|ExecStart=/usr/local/bin/node_exporter --collector.textfile.directory=/var/lib/node_exporter_textfile_collectors|g' /etc/systemd/system/node_exporter.service
	   systemctl daemon-reload
           systemctl restart node_exporter
      
       # Restart prometheus as it fails to start when running from setup script
	   systemctl restart prometheus

           curl -o /opt/smart_monitor.sh https://raw.githubusercontent.com/bro-n-bro/bro_infra/main/scripts/smart_monitor.sh
           chmod +x /opt/smart_monitor.sh
           mkdir /opt/smarts
           echo '*/10   *   *   *   *   /opt/smart_monitor.sh' >> /var/spool/cron/crontabs/root
           /opt/smart_monitor.sh ;;
      "n") ;;
    esac
}

###############################################

# Install required soft & upgrades
apt update
apt upgrade -y
apt install wget ufw make build-essential screen git libpam-google-authenticator fail2ban tree jq smartmontools htop -y

# install go

curl -sSL https://git.io/g-install | sh -s
source ~/.bashrc

# get info from user
echo "Please enter new username and hit Enter?"
read -r  USR
echo

echo "Please enter new ssh port Enter?"
read -r  SSHPORT
echo

echo "Please enter grafana monitor address?"
read -r  MONITORHOST
echo

MONITORIP=$(getent ahostsv4 $MONITORHOST  | awk '{print $1}' | head -1)
API_IP=$(dig +short rpc.bronbro.io)

# create new user
adduser $USR
usermod -aG sudo $USR

# Allow API access


# setup firewall
echo 'Setup some firewall :-)'
printf '\n************************************************\n'
ufw allow $SSHPORT
ufw allow 26656
ufw allow from $MONITORIP to any port 8090

add_front

printf '\n************************************************\n'
echo 'We are about to reload firewall!'
printf '\n************************************************\n'
ufw enable
ufw default deny incoming
ufw default allow outgoing
ufw reload

# backup sshd config and reate new one
mv /etc/ssh/sshd_config /etc/ssh/default.sshd_config
echo -e "Port $SSHPORT \nHostKey /etc/ssh/ssh_host_rsa_key \nHostKey /etc/ssh/ssh_host_ed25519_key \nKexAlgorithms curve25519-sha256@libssh.org \nCiphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr \nMACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com \nPermitRootLogin no \nAllowUsers $USR \nPubkeyAuthentication yes \nPasswordAuthentication no \nChallengeResponseAuthentication yes \nUsePAM yes \nAuthenticationMethods publickey,keyboard-interactive \nX11Forwarding no \nPrintMotd no \nClientAliveInterval 300 \nClientAliveCountMax 2 \nAcceptEnv LANG LC_* \nSubsystem	sftp	/usr/lib/openssh/sftp-server" >> /etc/ssh/sshd_config
sed -i 's/.*@include common-auth*/#@include common-auth/' /etc/pam.d/sshd
echo 'auth required pam_google_authenticator.so' >> /etc/pam.d/sshd

# setup fail2ban
sed -i 's/.*backend = %(sshd_backend)s*/enabled = true\nbantime = 14400\nfindtime = 3600\nmaxretry = 3/' /etc/fail2ban/jail.conf
service fail2ban restart
fail2ban-client status sshd

# add keys directory and keys
mkdir /home/$USR/.ssh

add_keys

# Add access from gateway.bronbro.io without 2nd factor
add_gw
systemctl reload ssh

# Setup default bro monitoring
setup_monitoring

# Generate google 2FA
sudo -i -u $USR bash << EOF
echo "execute as $USR"
google-authenticator  -t -D -r 3 -R 30 -w 4 -f -C
EOF

