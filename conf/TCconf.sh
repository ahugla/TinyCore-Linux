
#  TINY CORE LINUX Config
#  http://tinycorelinux.net/
#
#  date:  30/11/2020
#
#

# ------USAGE -----
# Depuis la console :  'clic droit' + 'exit' + 'exit to prompt':
#   sudo loadkmap < /usr/share/kmap/azerty/fr-latin9.kmap 
#   cd /tmp
#   tce-load -wi git
#   rm -rf /tmp/TinyCore-Linux
#   git clone https://github.com/ahugla/TinyCore-Linux.git
#   sudo chmod 755 /tmp/TinyCore-Linux/conf/TCconf.sh
# 
#   sudo /tmp/TinyCore-Linux/conf/TCconf.sh  [Password]     #  SUDO indispensable pour changer le password root



# ------ INPUT ------
# Password that will be set to tc and root accounts



# ------ PRE REQUIS -----
# A executer sous le console (pas terminal). 
# Pour y acceder 'clic droit' + 'exit' + 'exit to prompt':



echo "parametre : $1"

cd /tmp


# config Keyboard FR
# ------------------
sudo loadkmap < /usr/share/kmap/azerty/fr-latin9.kmap
# make it persistent
sed -i '/box/a \loadkmap < /usr/share/kmap/azerty/fr-latin9.kmap\' /opt/bootsync.sh





# set password for tc and root
# ----------------------------
echo -e "$1\n$1" | passwd tc
echo -e "$1\n$1" | passwd root
echo '/etc/shadow' >> /opt/.filetool.lst         # pour etre backupé




# sshd config for root access
# ---------------------------
sudo -u tc tce-load -wi openssh
cd /usr/local/etc/ssh/
cp sshd_config.orig sshd_config

chmod 777 sshd_config
echo "#ALEX CONF" >> sshd_config
echo "PermitRootLogin yes" >> sshd_config
chmod 644 sshd_config

/usr/local/etc/init.d/openssh start

chmod 777 /opt/bootlocal.sh
echo '/usr/local/etc/init.d/openssh start &' >> /opt/bootlocal.sh  # demarrer SSH au boot
chmod 755 /opt/bootlocal.sh

echo '/opt/bootlocal.sh'  >> /opt/.filetool.lst    # pour etre backupé
echo '/usr/local/etc/ssh' >> /opt/.filetool.lst    # pour etre backupé






filetool.sh -b    # pour sauvegarder les elements listés ici:  /opt/.filetool.lst


#sudo reboot
