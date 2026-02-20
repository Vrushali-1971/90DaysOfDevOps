## Day 09 – Linux User & Group Management Challenge

## Goal: Today's goal is to practice user and group management by completing hands-on challenges.

## Users & Groups Created

- Users: tokyo, berlin, professor, nairobi
  
- Groups: developers, admins, project-team

##  Group Assignments 

- tokyo → tokyo, developers, project-team
  
- berlin → berlin, developers, admins
  
- professor → professor, admins
  
- nairobi → nairobi, project-team

## Directories Created

/opt/dev-project → drwxrwxr-x (775), group: developers

/opt/team-workspace → drwxrwxr-x (775), group: project-team

 ## Commands Used
 
 ## User creation and set passwd:
 ```bash
sudo useradd -m username
sudo passwd username
```
## Group creation:
```bash
sudo groupadd groupname
```
## Assign user to group:
```bash
sudo usermod -aG groupname username
```
## Add a user to multiple groups:
```bash
sudo usermod -aG group1,group2,group3 username
```
## create directory:
```bash
sudo mkdir directory-name
```
## Change ownership:
```bash
sudo chown user:group filename
```
## Change permissions:
```bash
sudo chmod 775 filename
```
## change user:
```bash
sudo su - username
```
## make file:
```bash
touch filename.txt
```
## Check permissions:
```bash
ls -ld /path
```
## Check group:
```bash
groups username
```
## What I Learned

1.When a user is created, Linux automatically creates a primary group with the same name.

2.In sudo chown user:group file
: is a separator between user and group.

user:
→ User is specified
→ Group left empty
→ Only user changes

:group
→ User left empty
→ Group specified
→ Only group changes

user:group
→ Both user and group change

3. Importance of -aG, -m, and su - in user management.

 -m (with useradd)
→ Creates a home directory for the user automatically.

-aG (with usermod)
→ Adds user to a supplementary group.
→ -a = append (don’t remove existing groups)
→ -G = specify group list

su - username
→ Switches to user with a login shell.
→ Loads user’s environment and home directory.













