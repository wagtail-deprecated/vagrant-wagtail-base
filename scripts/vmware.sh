apt-get -y install build-essential
ln -s /usr/src/linux /usr/src/linux-headers-$(uname -r)
mkdir -p /mnt/disk
mount -o loop linux.iso /mnt/disk/
tar xvf /mnt/disk/VMwareTools-9.9.2-2496486.tar.gz -C `pwd`
perl vmware-tools-distrib/vmware-install.pl -default
umount /mnt/disk
rmdir /mnt/disk
rm -rf vmware-tools-distrib
rm linux.iso

apt-get -y purge build-essential

mkdir -p /mnt/hgfs
echo -n ".host:/ /mnt/hgfs vmhgfs rw,ttl=1,uid=my_uid,gid=my_gid,nobootwait 0 0" >> /etc/fstab
