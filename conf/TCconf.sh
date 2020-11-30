
#  TINY CORE LINUX Config
#  http://tinycorelinux.net/
#
#  date:  30/11/2020
#



# ------ INPUT ------
# Password that will be set to tc and root accounts



# ------ PRE REQUIS -----
# A executer sous le console (pas terminal). 
# Pour y acceder 'clic droit' + 'exit' + 'exit to prompt':



cd /tmp


# config Keyboard FR
# ------------------
sudo loadkmap < /usr/share/kmap/azerty/fr-latin9.kmap
# make it persistent
sed -i '/box/a \loadkmap < /usr/share/kmap/azerty/fr-latin9.kmap\' /opt/bootsynch.sh



# set password for tc and root
# ----------------------------
echo -e "$1\$1" | passwd tc
echo -e "$1\$1" | passwd root

sudo echo '/etc/shadow' >> /opt/.filetool.lst



# sshd config for root access
# ---------------------------
tce-load -wi openssh
cd /usr/local/etc/ssh/
sudo cp sshd_config.orig sshd_config
sudo chmod 777 sshd_config
echo "#ALEX CONF" >> sshd_config
echo "PermitRootLogin yes" >> sshd_config
sudo /usr/local/etc/init.d/openssh start
sudo echo '/usr/local/etc/ssh' >> /opt/.filetool.lst 
sudo echo '/usr/local/etc/init.d/openssh start &' >> /opt/bootlocal.sh






filetool.sh -b    # pour sauvegarder


sudo reboot
