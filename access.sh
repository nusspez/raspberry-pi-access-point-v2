#!/bin/bash
#ejecutable para acccess point raspbian stretch
clear
echo "-----------------------------------------------------------------------------"
echo "x x   x x   x x   x x x x x    x x x x x    x x x x x x x     x x   x x   x x"
echo "x x   x x   x x   x x x x x    x x x x x    x x x x x x x     x x   x x   x x"
echo "x x   x x   x x   x x   x x    x x                  x x       x x   x x   x x"
echo "x x   x x   x x   x x x x x    x x x x x          x x         x x   x x   x x"
echo "x x   x x   x x   x x x x x    x x x x x        x x           x x   x x   x x"
echo "                  x x          x x            x x"
echo "x x   x x   x x   x x          x x x x x    x x x x x x x     x x   x x   x x"
echo "x x   x x   x x   x x          x x x x x    x x x x x x x     x x   x x   x x"
echo "-----------------------------------------------------------------------------"
echo "esto es un ejecutable para crear automaticamente un access point en la raspberry pi 3"
echo
echo
echo "===menu del instalador==="
PS3='sleccione que quiere hacer:'
opciones=("opcion1 instalar access point." "opcion2 desinstalar access point." "opcion 3 acerca de." "opcion 4 salir.")
select pez in "${opciones[@]}"
do
    case $pez in
    "opcion1 instalar access point." )
      echo "elegiste la opcion 1"
      sudo apt-get -y update #hacemos un update a nuestra raspberry verificando que todo este actualizado
      sudo apt-get -y upgrade #hacemos un upgrade para actulizar los paquetes que nececiten actualizacion
      sudo apt-get -y install dnsmasq hostapd
      sudo systemctl stop dnsmasq
      sudo systemctl stop hostapd
      sudo echo "" /etc/dhcpcd.conf
      sudo echo "interface wlan0">>/etc/dhcpcd.conf
      sudo echo "    static ip_address=172.24.1.1/12">>/etc/dhcpcd.conf
      sudo service dhcpcd restart
      sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
      sudo echo "interface=wlan0      # Use the require wireless interface - usually wlan0">>/etc/dnsmasq.conf
      sudo echo "dhcp-range=172.24.1.50,172.24.1.150,12h">>/etc/dnsmasq.conf
      sudo echo "interface=wlan0
bridge=br0
driver=nl80211
ssid=PI
hw_mode=g
channel=7
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=raspberry
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP">>/etc/hostapd/hostapd.conf
      cat /dev/null > /etc/default/hostapd
      echo '
# Defaults for hostapd initscript
#
# See /usr/share/doc/hostapd/README.Debian for information about alternative
# methods of managing hostapd.
#
# Uncomment and set DAEMON_CONF to the absolute path of a hostapd configuration
# file and hostapd will be started during system boot. An example configuration
# file can be found at /usr/share/doc/hostapd/examples/hostapd.conf.gz
#
DAEMON_CONF="/etc/hostapd/hostapd.conf"

# Additional daemon options to be appended to hostapd command:-
#       -d   show more debug messages (-dd for even more)
#       -K   include key data in debug messages
#       -t   include timestamps in some debug messages
#
# Note that -B (daemon mode) and -P (pidfile) options are automatically
# configured by the init.d script and must not be added to DAEMON_OPTS.
#
#DAEMON_OPTS=""" '>>/etc/default/hostapd
      sudo service hostapd start
      sudo service dnsmasq start
      cat /dev/null > /etc/sysctl.conf
      echo "#
# /etc/sysctl.conf - Configuration file for setting system variables
# See /etc/sysctl.d/ for additional system variables.
# See sysctl.conf (5) for information.
#

#kernel.domainname = example.com

# Uncomment the following to stop low-level messages on console
#kernel.printk = 3 4 1 3

##############################################################3
# Functions previously found in netbase
#

# Uncomment the next two lines to enable Spoof protection (reverse-path filter)
# Turn on Source Address Verification in all interfaces to
# prevent some spoofing attacks
#net.ipv4.conf.default.rp_filter=1
#net.ipv4.conf.all.rp_filter=1

# Uncomment the next line to enable TCP/IP SYN cookies
# See http://lwn.net/Articles/277146/
# Note: This may impact IPv6 TCP sessions too
#net.ipv4.tcp_syncookies=1

# Uncomment the next line to enable packet forwarding for IPv4
net.ipv4.ip_forward=1

# Uncomment the next line to enable packet forwarding for IPv6
#  Enabling this option disables Stateless Address Autoconfiguration
#  based on Router Advertisements for this host
#net.ipv6.conf.all.forwarding=1


###################################################################
# Additional settings - these settings can improve the network
# security of the host and prevent against some network attacks
# including spoofing attacks and man in the middle attacks through
# redirection. Some network environments, however, require that these
# settings are disabled so review and enable them as needed.
#
# Do not accept ICMP redirects (prevent MITM attacks)
#net.ipv4.conf.all.accept_redirects = 0
#net.ipv6.conf.all.accept_redirects = 0
# _or_
# Accept ICMP redirects only for gateways listed in our default
# gateway list (enabled by default)
# net.ipv4.conf.all.secure_redirects = 1
#
# Do not send ICMP redirects (we are not a router)
#net.ipv4.conf.all.send_redirects = 0
#
# Do not accept IP source route packets (we are not a router)
#net.ipv4.conf.all.accept_source_route = 0
#net.ipv6.conf.all.accept_source_route = 0
#
# Log Martian Packets
#net.ipv4.conf.all.log_martians = 1
#

###################################################################
# Magic system request Key
# 0=disable, 1=enable all
# Debian kernels have this set to 0 (disable the key)
# See https://www.kernel.org/doc/Documentation/sysrq.txt
# for what other values do
#kernel.sysrq=1

###################################################################
# Protected links
#
# Protects against creating or following links under certain conditions
# Debian kernels have both set to 1 (restricted)
# See https://www.kernel.org/doc/Documentation/sysctl/fs.txt
#fs.protected_hardlinks=0
#fs.protected_symlinks=0">>/etc/sysctl.conf
      sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
      cat /dev/null > /etc/rc.local
      echo "#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

# Print the IP address
_IP=$(hostname -I) || true
if [ "$_IP" ]; then
  printf "My IP address is %s\n" "$_IP"
fi

iptables-restore < /etc/iptables.ipv4.nat

exit 0

">>/etc/rc.local
      sudo apt-get install hostapd bridge-utils
      sudo systemctl stop hostapd
      echo "denyinterfaces wlan0">>/etc/dhcpcd.conf
      echo "denyinterfaces eth0">>/etc/dhcpcd.conf
      sudo brctl addbr br0
      sudo brctl addif br0 eth0
      echo "# Bridge setup
auto br0
iface br0 inet manual
bridge_ports eth0 wlan0">>/etc/network/interfaces

      sudo reboot
      ;;
    "opcion2 desinstalar access point." )
    echo "elegiste la opcion 2"
    ;;
    "opcion 3 acerca de." )
    echo "elegiste la opcion 3"
    echo "Copyright (C) 2017  pez"
    ;;
    "opcion 4 salir." )
    echo "elegiste la opcion 4"
    break
    ;;
    *) echo opcion invalida;;
  esac
done
