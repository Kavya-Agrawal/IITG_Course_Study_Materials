que 1: ls -r
que 2: rm *.txt *.doc
que 3: cat example*.txt
que 4: grep -l "hello" * | xargs cp -t iitg/   //-t stands for target
que 5: ls *[b-y] , another approach :  find . -type f -name "*[b-y]" but this works recursively gives all files
que 6: du -sb .  => du stands for "disk usage."
                    -s summarizes the total size of the directory.
                    -b displays the size in bytes.
                    . specifies the current directory.
que 7: wc -l *.c or cat *.c | wc -l =>>>> wc = word count and -l means for line
--------------------------------------------------------------------------------
que 8: 

part:1) create new user: useradd -m Abhishek
                sudo passwd Abhishek
                su - Abhishek
part:2) home directory: ==>>> grep Abhishek /etc/passwd | cut -d: -f6
    {
       cut -d: -f6:
       cut is used to extract specific fields from the input.
       -d: sets the delimiter to :, which is the field separator in /etc/passwd.
        -f6 specifies that we want the 6th field, which is the home directory path.
    }

==>>> id -u Abhishek
==>>> id -un Abhishek
    
    {
        id -un Abhishek:
        id is used again to fetch user information.
        -un requests the user name (-u for user ID and -n for the name) of the user Abhishek.
    }


# Switch to Abhishek's shell
su - Abhishek

# Inside Abhishek's shell
mkdir second_user_home
cd second_user_home
touch file1.txt
exit

part 3:)

# Find the group ID of Abhishek
id -g Abhishek

# Create the user Rishi with the same group as Abhishek and specific home directory
useradd -m -g $(id -g Abhishek) -d /home/second_user_home Rishi

# Set the password for Rishi
sudo passwd Rishi

continue.....

# As root
su - Abhishek
cd second_user_home
touch file2.txt
su - Rishi

# As Rishi
touch file3.txt
exit


part 4:)

# Check Ownership and Group of Each File:

ls -l /home/Abhishek/second_user_home/file1.txt
ls -l /home/Abhishek/second_user_home/file2.txt
ls -l /home/second_user_home/file3.txt


------------------------------------------------------


# que 9:

usermod -l Sakshi Abhishek
groupmod -n Sakshi Abhishek
usermod -d /home/oman -m Sakshi
usermod -d /home/Rishi -m Rishi

usermod -s /sbin/nologin Sakshi or chsh -s /sbin/nologin Sakshi
  --->>>> change the shell to nologin shell

-->>> msg >>>> This account is currently not available.

# que 10:

# delete user : 
userdel Sakshi
    # If you also want to delete the user’s home directory, use the -r option: 
userdel -r Sakshi 

# delete group : 
sudo groupdel Sakshi

---------------------------------------------------

# que 11:

sudo grep sshd /var/log/auth.log > ssh_log_entries.txt

# install ssh:

You can install it using the package manager:
    sudo apt-get update
    sudo apt-get install openssh-server

# Start the SSH service:
    sudo systemctl start ssh

# Create a New User:
sudo adduser testuser
ssh testuser@localhost

sudo grep 'sshd' /var/log/auth.log > ssh_log_entries.txt


# que 12:
# part1)

tar -cvf ../archive.tar *

{
    tar: The command to create and manipulate tar archives.
    -c: Creates a new tar archive.
    -v: Verbosely lists files processed (optional, for display purposes).
    -f ../archive.tar: Specifies the path to the tar file (../archive.tar). The ../ indicates that the tar file should be   created in the parent directory of my_directory.
    *: A wildcard that matches all files in the current directory (my_directory), so only the files (not the directory itself)  are included in the tar file.
}

cd ..
tar -tf archive.tar


# part2)

Understanding the - in split Command
When you use the tar command with split, the - signifies that tar should write the archive data to standard output. Here's how it works:

# tar -cvf - huge_folder | split -b 100M - archive.tar.part
{
    tar -cvf - huge_folder: This command creates a tar archive of huge_folder and writes it to standard output (denoted by -).

    split -b 100M - archive.tar.part: This command reads from standard input (denoted by -) and splits the input into chunks of 100 MB each. The chunks are named archive.tar.partaa, archive.tar.partab, and so on.
}
{
    you can also make first a .tar file and then split it,
    for ex i have a tar file named as archive.tar, then
    split -b 100M archive.tar archive.tar.part
}

# ls -lh archive.tar.part* | grep archive.tar.part | wc -l ==>> no of files created

cat archive.tar.part* > combined_archive.tar

# Join the Parts and Extract the Archive

/home/dhruv-pansuriya/dhruv/extract

<!-- create a directory extract -->
# tar -xvf combined_archive.tar -C /home/extract
{
    tar -xvf combined_archive.tar: Extracts the files from combined_archive.tar.
    -x stands for extract.
    -v stands for verbose, which means tar will list the files being extracted.
    -f specifies the file to operate on.
    -C /home/extract: Specifies the directory to extract the files into.
}

<!-- after doing this that dhruv/extract folder will contain the same text.abc file which we used!!!!!!!!!!!  -->


# que 13:

List All Drives: 
df or lsblk

<!-- Before formatting, you need to unmount any mounted partitions: -->

sudo umount /dev/sdX1

sudo mkfs.vfat -n 'DHRUV' -I /dev/sdb1

{
    sudo: Runs the command with superuser privileges, necessary for formatting drives.
    mkfs.vfat: Formats the specified partition with the VFAT (FAT32) file system.
    -n 'KREATOR': Sets the volume label (name) of the file system to KREATOR. You can replace 'KREATOR' with any name you'd like (up to 11 characters for      FAT32).
    -I: Forces the command to work even if the specified partition is not the first on the disk. It's often used when working with the entire disk, but in     your case, it's targeting a specific partition (/dev/sdb1).
    /dev/sdb1: The partition you're formatting. Make sure to replace sdb1 with the correct partition identifier for your USB drive.
}



# que 14:

<!-- You need to have root access to the machine while using the parted command.  -->


sudo su 
sudo parted /dev/sda
print


// first we will erase all partitions

(parted) mklabel msdos

//after this command there is no partition in this pendrive

# Part 1: Create a Single Primary Partition in USB Using parted

(parted) mkpart primary fat32 0% 100%

{
    mkpart: Creates a partition.
    primary: Specifies a primary partition (for MBR).
    fat32: Filesystem type (can be fat32, ntfs, etc.).
    0%: Start of the partition.
    100%: End of the partition (uses all available space).
}

quit
mkfs.ext4 /dev/sda1 ===>>> it sets the file system for sda1 to ext4  


# Part 2: Create Multiple Partitions in USB Using fdisk

1. Identify the USB Drive:
lsblk or sudo fdisk -l

Start fdisk with the USB Drive: 
# sudo fdisk /dev/sdX

{
If needed, create a new partition table. For MBR (default for fdisk): 

Command (m for help): o
}

Command (m for help): d ==> delete partition

Command (m for help): n ==> create partition

quit

and unmount first using umount /dev/sda

then

# sudo mkfs.ext4 /dev/sda1

Command (m for help): d


Create the First Partition:

Command (m for help): n
Partition number (1-4, default 1): 1
First sector (2048-..., default 2048): <press Enter>
Last sector (2048-..., default ...): +500M

Create the Second Partition:

Command (m for help): n
Partition number (1-4, default 2): 2
First sector (next available sector, default ...): <press Enter>
Last sector (next available sector, default ...): +1G

Write Changes and Exit:

Command (m for help): w

# Part 3: Resize Partitions

# Using parted:
sudo parted /dev/sdX
(parted) resizepart 1 100%
{
    resizepart: Command to resize a partition.
    1: Partition number.
    100%: New end of the partition.
}

# Part 4: delete Partitions

# Using parted:
(parted) rm PART_NUMBER


# Using fdisk:
Delete the Existing Partition:
Command (m for help): d
Partition number (1-4): 1



# que 15:


# part 1:)

# Unmount the USB Drive:
sudo umount /dev/sdX1

# Write the ISO to the USB Drive Using dd:
sudo dd if=/path/to/your.iso of=/dev/sdX bs=4M status=progress

# Sync and Eject:
sudo sync
You can then safely remove the USB drive.

Assuming you have a file ubuntu.iso and your USB drive is /dev/sdb, the command would look like:
# sudo dd if=ubuntu.iso of=/dev/sdb bs=4M status=progress

# part 2:)

Unmount the USB Drive: sudo umount /dev/sdX*
# Create the ISO Image Using dd:

sudo dd if=/dev/sdX of=/path/to/your_image.iso bs=4M status=progress

sudo sync
 
# Example: sudo dd if=/dev/sdb of=~/backup.iso bs=4M status=progress

# part 3:)

# Mounting an ISO File

1)Create a Mount Point: You need a directory where you will mount the ISO file. Create a directory if you don’t have one:

sudo mkdir /mnt/iso

2)  Mount the ISO File: Use the mount command to mount the ISO file to the directory:

sudo mount -o loop /path/to/your_image.iso /mnt/iso

# Unmounting the ISO File

When you’re done, unmount the ISO file using the umount command:


sudo umount /mnt/iso

Remove the Mount Point (Optional):
sudo rmdir /mnt/iso

# que 16)
To manage multiple versions of a programming language compiler like GCC (GNU Compiler Collection) using soft links (symbolic links) on Ubuntu, you can follow these steps:

1) Install Multiple GCC Versions

sudo apt-get update
sudo apt-get install gcc-8 g++-8
sudo apt-get install gcc-9 g++-9


2) Create Symbolic Links
Find the Installed Versions: ls /usr/bin/gcc-*
Remove Existing Symbolic Links: If there are existing symbolic links (e.g., gcc), you might need to remove them first:

sudo rm /usr/bin/gcc
sudo rm /usr/bin/g++

Create New Symbolic Links:

sudo ln -s /usr/bin/gcc-8 /usr/bin/gcc
sudo ln -s /usr/bin/g++-8 /usr/bin/g++


# Switch Versions Using Symbolic Links
sudo ln -sf /usr/bin/gcc-9 /usr/bin/gcc
sudo ln -sf /usr/bin/g++-9 /usr/bin/g++

Verify the Version:
gcc --version
g++ --version
