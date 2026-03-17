# Day 23 – Git Branching & Working with GitHub

## Task 1: Understanding Branches

### 1. What is a branch in Git?

A branch in Git is a separate line of development. It allows developers to work on new features, bug fixes, or experiments without affecting the main codebase.

Many repositories use master or main as the default branch. In my repository, the default branch is master.

Branches allow developers to create features independently and merge them later.

---

### 2. Why do we use branches instead of committing everything to master?

Branches are used because:

- They keep the master branch stable
- Developers can work on multiple features simultaneously
- Experimental code won’t break production code
- Makes team collaboration easier
- Features can be tested before merging into master

Example workflow:

- master → stable production code
- feature-1 → new feature development
- bugfix → fixing bugs

---

### 3. What is HEAD in Git?

HEAD is a pointer that refers to the current branch and the latest commit you are working on.

Example:

If you are on the master branch:

HEAD → master → latest commit

If you switch to another branch:

HEAD → feature-1 → latest commit

HEAD always tells Git your current position in the repository.

---

### 4. What happens to your files when you switch branches?

When switching branches:

- Git updates the working directory to match the selected branch
- Files present in that branch appear
- Files not present in that branch disappear

Example:

If "feature-1" contains a file called "feature.txt" but "master" does not:

- On feature-1 → file exists
- On master → file disappears

Each branch represents a different snapshot of the repository.

---

## Task 2 – Branching Commands

#### List all branches

`git branch`

Shows all local branches in the repository.

---

#### Create a new branch

`git branch feature-1`

Creates a branch but does not switch to it.

---

#### Switch to a branch


`git checkout feature-1`

or using the modern command:

`git switch feature-1`

---

#### Create and switch branch in one command

`git checkout -b feature-2`

or

`git switch -c feature-2`

---

### Difference between git switch and git checkout

| Command      | Purpose                                                       |
|--------------|---------------------------------------------------------------|
| git checkout | Older command used for switching branches and restoring files | 
| git switch   | Modern command designed specifically for switching branches   |

---

#### Make a commit on feature branch

**Example:**

```
git switch feature-1
echo "Feature work" >> feature.txt
git add .
git commit -m "Added feature work"
```

This commit exists only on feature-1 branch.

---

Verify commit is not in master

`git switch master`

The commit from "feature-1" will not appear in the master branch.

---

#### Delete a branch

`git branch -d feature-2`

---

## Task 3 – Push to GitHub

#### Add remote repository

`git remote add origin git@github.com:YOUR_USERNAME/devops-git-practice.git`

---

#### Push master branch

`git push -u origin master`

"-u" sets the upstream branch.

---

#### Push feature branch

`git push -u origin feature-1`

Both branches will now appear on GitHub.

---

### Difference between origin and upstream

| Term     | Meaning                                                   |
|----------|-----------------------------------------------------------|
| origin   | Default remote repository linked to your local repository |
| upstream | Original repository from which a fork was created         |

Example:

Your fork → origin
Original repo → upstream

---

## Task 4 – Pull from GitHub

#### Pull changes

`git pull origin master`

This downloads and merges changes from GitHub to the local repository.

---

### Difference between git fetch and git pull

| Command   | Function                                        |
|-----------|-------------------------------------------------|
| git fetch | Downloads changes but does not merge them       |
| git pull  | Downloads changes and automatically merges them |

Example:

```
git fetch origin
git merge origin/master
```

---

## Task 5 – Clone vs Fork

#### Clone a repository

`git clone git@github.com:USERNAME/repository-name.git`

This creates a local copy of a GitHub repository.

---

#### Fork a repository

Forking creates your own copy of someone else's repository on GitHub.

Steps:

1. Click Fork on GitHub
2. Clone your fork

`git clone git@github.com:USERNAME/repository-name.git`

---

### Difference between Clone and Fork

| Clone                    | Fork                                 |
|--------------------------|--------------------------------------|
| Local copy of repository | Personal copy on GitHub              |
| Git command              | GitHub feature                       |
| Used to download code    | Used for contributing to open source |

---

#### When to use Clone vs Fork

Use Clone when:

- Working on your own repository
- You have write access

Use Fork when:

- Contributing to open-source projects
- You do not have direct write access

---

#### Keep fork updated with original repository

Add upstream remote:

`git remote add upstream git@github.com:ORIGINAL_OWNER/repository.git`

Fetch updates:

`git fetch upstream`

Merge updates:

`git merge upstream/master`

---

### Summary

#### Today I learned:

- How Git branches work
- HEAD points to the current commit and branch
- How to create and switch branches
- How to push branches to GitHub
- The difference between origin and upstream
- The difference between clone and fork
- How to keep a fork updated with the original repository 

