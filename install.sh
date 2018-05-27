

gdisk /dev/sda
x to enter expert mode
z to zap the disk
y when promted with warning


cgdisk
/dev/sda

Let’s create our boot partition:

Hit New from the options at the bottom.
Just hit enter to select the default option for the first sector.
Now the partion size - Arch wiki recommends 200-300 MB for the boot size. Let’s make it 500MiB or 1GB in case we need to add more OS to our machine. I’m gonna assign mine with 1024MiB. Hit enter.
Set GUID to EF00. Hit enter.
Set name to boot. Hit enter.
Now you should see the new partition in the partitions list with a partition type of EFI System and a partition name of boot. You will also notice there is 1007KB above the created partition. That is the MBR. Don’t worry about that and just leave it there.

Hit New again.
Hit enter to select the default option for the first sector.
Hit enter again to use the remainder of the disk.
Also hit enter for the GUID to select default.
Then set name of the partition to root.


# mkfs.fat -F32 /dev/sda1
# mkfs.ext4 /dev/sda2

# mkdir /mnt
# mount /dev/sda2 /mnt

# mkdir /mnt/boot
# mount /dev/sda1 /mnt/boot

# pacstrap /mnt base

# genfstab -U /mnt >> /mnt/etc/fstab

# arch-chroot /mnt

# ln -sf /usr/share/zoneinfo/Australia/ACT /etc/localtime
# hwclock --systohc

Uncomment en_US.UTF-8 UTF-8 and other needed localizations in /etc/locale.gen, and generate them with:
en_AU.UTF8 UTF8
# locale-gen

# echo redx > /etc/hostname

#hosts file???
# systemctl enable dhcpcd@eth0.service
#passwd

# mkinitcpio -p linux

# bootctl install

Create a boot entry /boot/loader/entries/arch.conf:
title Arch Linux
linux /vmlinuz-linux
initrd  /initramfs-linux.img
options root=/dev/sda2 rw




To use the multilib repository, uncomment the [multilib] section in /etc/pacman.conf (Please be sure to uncomment both lines):

[multilib]
Include = /etc/pacman.d/mirrorlist
pacman -Syu
nvidia	
nvidia-utils	
lib32-nvidia-utils	




pacman -S i3                                           
pacman -S nvidia
pacman -S dmenu

alsa-utils


useradd -m -G users -s /bin/bash username
passwd username
vim /etc/sudoers
username ALL=(ALL) ALL
