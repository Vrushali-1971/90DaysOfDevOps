## Day 22 – Introduction to Git

## Today's task is to understand what is git, why it matters and to create a repository from scratch and to build a living document of git commands.

## What I Did Today

 Installed and Configured Git. 

 Created a new repository.

 Explored the .git folder.

 Practiced staging and committing changes.
 
 Built multiple commits to understand history.

## Basic questions for understanding git commands

## 1. What is the difference between git add and git commit?

git add moves changes from the working directory to the staging area.
git commit saves the staged changes permanently into the Git repository with a message.

In short:
git add = prepare changes
git commit = save changes permanently

## 2. What does the staging area do? Why doesn't Git just commit directly?

The staging area allows us to choose which changes we want to include in the next commit.
Git does not commit directly because sometimes we modify many files but only want to commit specific changes.
The staging area gives control before saving.

## 3. What information does git log show you?

git log shows:
Commit ID (hash)
Author name
Date of commit
Commit message

It helps track the history of changes.

## 4. What is the .git/ folder and what happens if you delete it?

The .git folder is the hidden folder that stores all Git history, commits, branches, and configuration. 
If we delete the .git folder, the project will no longer be a Git repository and all version history will permanently lost.

## 5. What is the difference between working directory, staging area, and repository?

Working Directory: This is where we edit files normally. 
Staging Area: This is where we prepare changes before committing. 
Repository: This is where Git permanently saves committed changes.
