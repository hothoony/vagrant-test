# ssh password authentiation yes
sed -i -e 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

# test
mkdir program
mkdir cc
mkdir dd
