# Day 11 – File Ownership Challenge (chown & chgrp)

## Goal
Today's goal is to master file and directory ownership in Linux through hands-on tasks.

1. Change file owner using `chown`
2. Change file group using `chgrp`
3. Apply ownership changes recursively

## Files & Directories Created

**Files**
- devops-file.txt
- team-notes.txt
- project-config.yaml
  
**Directories**
- app-logs/
- heist-project/
- bank-heist/

**Files inside directories**

heist-project/
- vault/gold.txt
- plans/strategy.conf

bank-heist/
- access-codes.txt
- blueprints.pdf
- escape-plan.txt


## Ownership Changes

### devops-file.txt

**Before:** 
ubuntu:ubuntu

Changed owner to **tokyo**
```bash
sudo chown tokyo devops-file.txt
```
Then changed owner to berlin

sudo chown berlin devops-file.txt

**Result:**
berlin:ubuntu

### team-notes.txt

Created group: sudo groupadd heist-team

Changed group of the file:
```bash
sudo chgrp heist-team team-notes.txt
```
**Result:**
ubuntu:heist-team

### project-config.yaml
Changed both owner and group in one command:
```bash
sudo chown professor:heist-team project-config.yaml
```
**Result:**
professor:heist-team

### app-logs Directory
Changed owner and group:
```bash
sudo chown berlin:heist-team app-logs
```
**Result:**
berlin:heist-team 

### Recursive Ownership Change
Directory structure created:
```bash
mkdir -p heist-project/vault
mkdir -p heist-project/plans
touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf
```
Created group:
```bash
sudo groupadd planners
```
Changed ownership recursively:
```bash
sudo chown -R professor:planners heist-project/
```
Verification:
```bash
ls -lR heist-project/
```
All files and subdirectories now belong to:

professor:planners

### Bank Heist Directory Ownership
**Created files:**
```bash
mkdir bank-heist
touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt
```
**Set ownership:**
```bash
sudo chown tokyo:vault-team bank-heist/access-codes.txt
sudo chown berlin:tech-team bank-heist/blueprints.pdf
sudo chown nairobi:vault-team bank-heist/escape-plan.txt
```
**Verification:**
```bash
ls -l bank-heist/
```
### Commands Used: 
```bash
ls -l
touch filename
mkdir directory
mkdir -p directory/subdirectory
sudo chown username filename
sudo chgrp groupname filename
sudo chown owner:group filename
sudo chown -R owner:group directory
sudo groupadd groupname
```
### What I Learned:

- Learned the difference between file owner and file group, and how Linux controls file access based on ownership.

- Learned how to change file owner using chown and file group using chgrp.

- Learned how to change both owner and group together and apply ownership changes recursively using -R for directories.



