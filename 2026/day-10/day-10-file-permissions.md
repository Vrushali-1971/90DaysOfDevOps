# Day 10 – File Permissions & File Operations Challenge

## Goal:  Today's goal is to learn file permissions and perform hands-on tasks.

---

## Files Created

** Files **
- devops.txt
- notes.txt

** Directories **
- project

** Shell script **
- script.sh

---

## Permission Changes

### devops.txt: 

** Before **

-rw-rw-r--

- Owner – read and write permissions
- Group – read and write permissions
- Others – read-only permission

** After **

To make the file read-only, the command used was:

```bash
chmod 444 devops.txt
```
Result: -r--r--r--

Owner, group, and others now only have read-only permission.

### notes.txt

** Before **

The file had: -rw-rw-r--

- Owner – read and write permissions
- Group – read and write permissions
- Others – read-only permission

** After **

After running:

```bash
chmod 640 notes.txt
```
Result: -rw-r-----

- Owner – read and write permissions
- Group – only read permission
- Others – no permissions

### script.sh

** Before **

The file had: -rw-rw-r--

- Owner – read and write permissions
- Group – read and write permissions
- Others – read-only permission

** After **

To make the file executable without changing existing permissions, the command used was:

```bash
chmod +x script.sh
```
Result: -rwxrwxr-x

Owner and group received read, write, and execute permissions, while others received read and execute permissions.

### project Directory

** Before **

The directory had default permissions (depending on system umask).

** After **

After running:

```bash
chmod 755 project
```
Result: drwxr-xr-x

Owner has read, write, and execute permissions, while group and others have read and execute permissions.

---

## Test Permissions

Tried:
```bash
echo "text" >> devops.txt
```
The result was Permission denied because the file was set to read-only.

Also tried to execute script.sh after running: chmod 666 script.sh

As expected, the result was Permission denied because the execute permission was removed.

---

## Commands Used
```bash
touch devops.txt

echo "text" > notes.txt

vim script.sh

ls -l

cat notes.txt

vim -R script.sh

head -n 5 /etc/passwd

tail -n 5 /etc/passwd

chmod +x script.sh

./script.sh

chmod 444 devops.txt

chmod 640 notes.txt

mkdir project

chmod 755 project

chmod 666 script.sh
```
---

## What I Learned

- Learned how file permissions work in Linux using read (r), write (w), and execute (x) for user, group, and others.

- Learned how to view file permissions using ls -l and interpret permission formats like rwxr-xr-x.

- Learned how to modify permissions using chmod, such as making a file executable, read-only, or restricting access using numeric permissions like 755, 640, and 444.









