# Links and information for proxmox and truenas

## Some requirements
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install software-properties-common
```
symlink
install gpg
## Samba container discovery
https://ghost.canaletto.fr/partage-smb-sous-proxmox/

https://linuxize.com/post/how-to-list-groups-in-linux/

https://pve.proxmox.com/wiki/Unprivileged_LXC_containers


## Reception sous VM
https://wiki.samba.org/index.php/Mounting_samba_shares_from_a_unix_client for mounting on startup using fstab (requires some options to not lock)

## Automated services using systemd
https://patrakov.blogspot.com/2011/01/writing-systemd-service-files.html

## Automated applications on startup with gui using Desktop files
https://specifications.freedesktop.org/autostart-spec/autostart-spec-latest.html

https://arcolinux.com/how-to-autostart-any-application-on-any-linux-desktop/

#VPN in container and linux
https://wiki.archlinux.org/title/OpenVPN#DNS

https://technotipsy.com/linux/check-for-dns-leaks-on-a-headless-linux-server/

https://developer-old.gnome.org/NetworkManager/stable/nmcli.html

https://www.maketecheasier.com/connect-vpn-automatically-linux/

## Wireguard
https://www.wireguardconfig.com/

https://nixvsevil.com/posts/wireguard-in-proxmox-lxc/

# Synchronization du temps sous ubuntu
https://www.howtogeek.com/tips/how-to-sync-your-linux-server-time-with-network-time-servers-ntp/

## Proxmox Assign Bind Mount To Unprivileged Container
https://pve.proxmox.com/wiki/ZFS:_Tips_and_Tricks#LXC_with_ACL_on_ZFS (may need to set zfs acl)

In order for the LXC container to have full access the proxmox host directory, a subgid is set as owner of a host directory, and an ACL is used to ensure permissions.
### Bind Mount dataset to LXC
Add the following line to /etc/pve/lxc/<CT_ID>.conf
```
mp0:/mount/point/on/host,mp=/mount/point/on/lxc
```

### Create group on host
In the default Proxmox configuration, unpriviliged container subgids will have the prefix "10" followed by the expected 4-digit gid.
``` 
addgroup --gid <GID (ie."101000")> <GroupName (ie."container-data")>
```

### Set ACL for shared dataset
Any members of -GID- will have "rwx", new files from -GID- have "rwx" default
*Note: documentation suggests the "-d" flag should be used to assign default, however I have been able to get the desired result without, so... take that as you will*
```
chgrp -R <GroupName> <Dataset>
chmod -R 2775 <Dataset>
setfacl -Rm g:<GID>:rwx,d:g:<GID>:rwx <Dataset>
```

---
## Inside your LXC container
### Create group
GID needs to match the last 4 digits of the subgid assigned earlier
```
addgroup --gid <GID (ie."1000")> <GroupName (ie."container-data")>
```

### Add users to new permitted group
```
usermod -aG <GroupName> <User>
```

You should now be able to make modifications to the assigned directory on the host system from within the unpriviliged container.




