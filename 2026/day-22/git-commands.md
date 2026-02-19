#Git Commands Reference

## Setup and config

### Install Git

What it does: Installs Git on the system.
Example: 
```bash
sudo apt update
sudo apt install git -y
```
### git config 
What it does: Sets Git username and email.
Example: 
 git config --global user.name "Your name"
 git config --global user.email "you@example.com"

## Basic Workflow

### git init
What it does: Initializes a new Git repository in the current directory.
Example
```bash
git init
```

### git status
What it does: Shows the current state of the working directory and staging area.
Example: 
```bash
git status
```

### git add 
What it does: Stages changes for the next commit.
Example: 
```bash
git add git-commands.md
```

### git commit
What it does: Record staged changes to the repository.
Example:
```bash
git commit -m "Meaningful message"
```

## Viewing Changes 

### git diff
What it does: Shows the difference between working directory and staged files.
Example: 
```bash
git diff
```

### git log
What it does: Shows commit history.
Example:
```bash
git log
```


