install
text
cdrom
skipx
lang en_US.UTF-8
keyboard us
timezone UTC
network --onboot yes --device eth0 --bootproto dhcp --hostname centos7-2-puppet4-vagrant.local
rootpw vagrant
user --name=vagrant --groups=wheel --password=vagrant
auth --enableshadow --passalgo=sha512 --kickstart
firewall --enable --ssh
selinux --permissive
zerombr
bootloader --location=mbr
clearpart --all --initlabel
autopart
firstboot --disable
reboot
 
%packages --nobase
@core
coreutils
yum
rpm
e2fsprogs
lvm2
openssh-server
openssh-clients
dhclient
yum-presto
curl
iputils
man
info
sudo
# do not install these:
-postfix
-linux-firmware
-b43-openfwwf
-atmel-firmware
-xorg-x11-drv-ati-firmware
-ipw2100-firmware
-ipw2200-firmware
-ivtv-firmware
-iwl1000-firmware
-iwl3945-firmware
-iwl4965-firmware
-iwl5000-firmware
-iwl5150-firmware
-iwl6000-firmware
-iwl6050-firmware
-libertas-usb8388-firmware
-rt61pci-firmware
-rt73usb-firmware
-zd1211-firmware
-iwl6000g2a-firmware
-iwl6000g2b-firmware
-iwl7260-firmware
-iwl2030-firmware
-iwl105-firmware
-iwl2000-firmware
-iwl100-firmware
-iwl135-firmware
-iwl3160-firmware
-aic94xx-firmware
-alsa-firmware
%end
 
 
%post --log=/root/ks.log
echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
echo "Defaults:vagrant !requiretty" >> /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant
mkdir -pm 700 /home/vagrant/.ssh
# see: https://github.com/mitchellh/vagrant/tree/master/keys
# (this key will be replaced by vagrant automatically)
cat <<EOK >/home/vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8Y\
Vr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdO\
KLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7Pt\
ixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmC\
P3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcW\
yLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
EOK
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh
# disable reverse lookups (slow)
echo 'UseDNS no' >> /etc/ssh/sshd_config
%end
