#!/bin/bash

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

# create new user
adduser $USR
usermod -aG sudo $USR

# setup firewall
echo 'Setup some firewall :-)'
printf '\n************************************************\n'
ufw allow $SSHPORT
ufw allow 26656
ufw allow from $MONITORIP to any port 8090
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
systemctl reload ssh

# setup fail2ban
sed -i 's/.*backend = %(sshd_backend)s*/enabled = true\nbantime = 14400\nfindtime = 3600\nmaxretry = 3/' /etc/fail2ban/jail.conf
service fail2ban restart
fail2ban-client status sshd


#add trusted rsa keys to authorized_keys
printf '\n************************************************\n'
mkdir /home/$USR/.ssh
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


sudo -i -u $USR bash << EOF
echo "execute as $USR"
google-authenticator  -t -D -r 3 -R 30 -w 4 -f
EOF
