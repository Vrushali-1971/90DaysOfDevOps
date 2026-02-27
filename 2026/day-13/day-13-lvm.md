## Day 13 – Linux Volume Management (LVM)

### Goal 
To learn LVM to manage storage flexibly, and to create, extend, and mount volumes.

### Step 1: 
Before we start our task first switch to root user
```bash
sudo su
```
###  Step 2: Create a virtual disk of 1GB
```bash
dd if=/dev/zero of=/tmp/disk1.img bs=1M count=1024
```
### Step 3:  Attach it as a loop device
```bash
losetup -fP /tmp/disk1.img
```
### Step 4:  Check device name
```bash
losetup -a
```
Output - /dev/loop5

### Step 5: Check Current Storage

`lsblk` - Displays information about block storage devices like disks and partitions.

`pvs`   - Displays information about physical volumes (PVs) used in LVM (Logical Volume Manager).

`vgs`   - Displays information about volume groups (VGs) in LVM.

`lvs`   - Displays information about logical volumes (LVs) in LVM.

`df -h` - Shows disk space usage of mounted filesystems in human-readable format (KB, MB, GB)

### Step 6: Create Physical Volume and Verify
```bash
pvcreate /dev/loop5   # or your loop device
pvs
```
### Step 7: Create Volume Group and Verify
```bash
vgcreate devops-vg /dev/loop5
vgs
```
### Step 8: Create Logical Volume and Verify
```bash
lvcreate -L 500M -n app-data devops-vg
lvs
```
### Step 9: Format the volume
```bash
mkfs.ext4 /dev/devops-vg/app-data
```
### Step 10: Create mount directory
```bash
mkdir -p /mnt/app-data
```
### Step 11: Mount the volume
```bash
mount /dev/devops-vg/app-data /mnt/app-data
```
### Step 12: Verify
```bash
df -h /mnt/app-data
```
### Step 13: Extend the volume (Increase by 200MB)
```bash
lvextend -L +200M /dev/devops-vg/app-data
```
### Step 14: Resize filesystem and Verify
```bash
resize2fs /dev/devops-vg/app-data
df -h /mnt/app-data
```
### What I learned 
1. Understanding LVM structure – Learned how LVM works with Physical Volumes (PV), Volume Groups (VG), and Logical Volumes (LV)
  to manage storage flexibly.

3. Creating and managing logical storage – Practiced creating physical volumes, volume groups, and logical volumes using commands like pvcreate, vgcreate, and lvcreate.

4. Extending storage without data loss – Learned how to increase logical volume size using lvextend and resize the filesystem using resize2fs.








