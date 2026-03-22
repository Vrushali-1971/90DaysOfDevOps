#Git Commands Reference

## Setup and config

### Install Git 

What it does:  Installs Git on the system. Example:

```bash
sudo apt update
sudo apt install git -y
```

### git config

What it does: Sets Git username and email. 

Example: git config --global user.name "Your name" 

git config --global user.email "you@example.com"


## Basic Workflow

### git init

What it does: Initializes a new Git repository in the current directory. 

Example:

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
git log --oneline
```

## Branching 


```bash
git branch
```

What it does: List all local branches in the current repository.


```bash
git branch <name>
```

What it does: Creates a new branch at the current commit.


```bash
git switch <name>
```

What it does: Switches from the current branch to the specified branch


```bash
git switch -c <name>
```

What it does: Creates a new branch and switches to it in one step.


```bash
git branch -d <name>
```

What it does: Deletes a branch that has already been merged.


## Remotes


```bash
git remote add origin <url>
```
What it does: Connect local repo to GitHub


```bash
git remote add upstream <url>
```  

What it does: Add original repo as upstream (after forking)


```bash
git remote -v
``` 
   
What it does: List all configured remotes


## Push & Pull


```bash
git push -u origin <branch>
```
   
What it does: Push branch and set upstream tracking


```bash
git push
```

What it does: Push to tracked remote (after -u is set)


```bash
git pull origin <branch>
```       

What it does: Fetch + merge remote changes


## Clone & Fork

```bash
git clone <url>
```              

What it does: Clone a repository to local machine. 


## Merge

```bash
git merge <branch>
```                    

What it does: Merge branch into current branch


```bash
git merge --squash <branch>
```           

What it does:  Squash all commits into one before merging


## Rebase

```bash
git rebase <branch>                   
```
 
What it does: Rebase current branch onto target branch


## Stash

```bash
git stash push -m "description" 
```

What it does: Stash with a message


```bash
git stash list                        
```
 
What it does: List all stashes


```bash
git stash pop 
```                        

What it does: Apply and remove top stash


```bash
git stash apply stash@{n}
```         

What it does: Apply specific stash, keeps it in list


```bash
git stash drop stash@{n}            
```
 
What it does: Delete a specific stash


## Cherry-pick

```bash
git cherry-pick <hash>                
```

What it does: Apply a specific commit onto current branch


```bash
git cherry-pick --abort               
```

What it does: Abort cherry-pick in case of conflict


```bash
git cherry-pick --continue            
```

What it does: Continue after resolving conflict


## Useful log


```bash
git log --oneline --graph --all       
```

What it does: Visualize full branch history


```bash
git log --oneline -5                  
```

What it does: Show last 5 commits 


## Reset

```bash
git reset --soft HEAD~1
```

What it does: Removes the last commit but keeps changes staged


```bash
git reset --mixed HEAD~1
```

What it does: Removes the last commit and unstages the changes (default reset)


```bash
git reset --hard HEAD~1
```

What it does: Removes the last commit and deletes changes completely


## Revert


```bash
git revert <hash>
```

What it does: Creates a new commit that undoes the changes of a specific commit


```bash
git revert --continue
```

What it does: Continue revert after resolving a conflict


```bash
git revert --abort
```
 
What it does: Abort the revert and go back to state before git revert


## Safety net

```bash
git reflog
```
 
What it does: Shows all Git actions including commits, resets, and checkouts even after hard reset


## GitHub CLI - Authentication

```bash
gh auth login
```

What it does: Authenticate with your GitHub account


```bash
gh auth status
```

 What it does: Check which GitHub account is active and token scopes


```bash
gh api user --jq '.login’
```


 What it does: Shows your GitHub username


## GitHub CLI - Repository


```bash
gh repo create <name> --public --add-readme
```


 What it does: Create a new public GitHub repo with README from terminal


```bash
gh repo clone <owner/repo>
```


What it does: Clone a GitHub repo using gh instead of git clone


```bash
gh repo view <owner/repo>
```

 What it does: View details of a repo from terminal


```bash
gh repo list
```

 What it does: List all your GitHub repositories


```bash
gh repo view <owner/repo> --web
```

 What it does: Open a repo in browser from terminal


```bash
gh repo delete <owner/repo> --yes
```

 What it does: Delete a GitHub repo from terminal


## GitHub CLI - Issues


```bash
gh issue create --repo <owner/repo> --title "title" --body "body" --label "bug"
```

 What it does: Create a new issue on a repo from terminal


```bash
gh issue list --repo <owner/repo>
```

What it does: List all open issues on a repo


```bash
gh issue view <number> --repo <owner/repo>
```

What it does: View a specific issue by its number


```bash
gh issue close <number> --repo <owner/repo>
```

What it does: Close an issue from terminal


## GitHub CLI - Pull Requests


```bash
gh pr create --repo <owner/repo> --title "title" --body "body" --base master --head <branch>
```

What it does: Create a pull request from terminal


```bash
gh pr list --repo <owner/repo>
```

What it does: List all open pull requests on a repo


```bash
gh pr view <number> --repo <owner/repo>
```

What it does: View details of a specific PR


```bash
gh pr merge <number> --repo <owner/repo> --merge
```

What it does: Merge a pull request from terminal


## GitHub CLI - Workflow Runs


```bash
gh run list --repo <owner/repo>
```

What it does: List all workflow runs on a repo


```bash
gh run view <run-id> --repo <owner/repo>
```

What it does: View details of a specific workflow run


## GitHub CLI - Useful Tricks


```bash
gh api user
```
 
What it does: Get your full GitHub profile in JSON format


```bash
gh api user --jq '.public_repos'
``` 

What it does: Get just your public repo count


```bash
gh gist create <file> --public --desc "description"
```

What it does: Create a public GitHub Gist from terminal


```bash
gh gist list
```

What it does: List all your gists


```bash
gh release create <tag> --title "title" --notes "notes"
```

What it does: Create a new release on a repo from terminal


```bash
gh alias set <shortcut> '<command>'
```

What it does: Create a shortcut for a gh command


```bash
gh search repos <keyword> --limit 5
```

What it does: Search GitHub repos from terminal


