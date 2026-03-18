# Day 24 - Git Merging, Rebasing, Squash, Stash & Cherry-Pick

## Task 1: Git Merge

### What is a fast-forward merge?

A fast-forward merge happens when the branch being merged has not diverged from the base branch. Since **master** had no new commits after **feature-login** was created, Git simply moves the **master** pointer forward to match feature-login. No new merge commit is created — the history stays linear.

#### Observed: When merging **feature-login** into master, Git output said **Fast-forward**.

### When does Git create a merge commit instead?

Git creates a merge commit when both branches have moved independently after the point they diverged. When a commit was added to **master** before merging **feature-signup**, both branches had their own history. Git had to create a new commit with two parents to combine them. This is called a 3-way merge.

#### Observed: When merging **feature-signup** into master after adding a commit to master, Git opened the editor for a merge commit message and the log showed a diamond shape in `git log --oneline --graph --all`.

### What is a merge conflict?

A merge conflict happens when two branches edit the same line of the same file differently. Git cannot decide which version to keep, so it marks the conflict in the file and asks the developer to resolve it manually.

#### Observed: After editing **style.css** with **color: blue** on master and **color: red** on **feature-conflict** (using > to overwrite the same line), running `git merge feature-conflict` produced:

```
CONFLICT (content): Merge conflict in style.css
Automatic merge failed; fix conflicts and then commit the result.
```

The file showed conflict markers:

```
<<<<<<< HEAD
color: blue
=======
color: red
>>>>>>> feature-conflict
```

After manually keeping **color: blue** and removing the markers, the conflict was resolved with `git add` and `git commit`.

#### Key learning: Using **>>** appends new lines so Git sees no conflict. Using **>** overwrites the same line, which causes a conflict.

## Task 2: Git Rebase

### What does rebase actually do to your commits?

Rebase takes the commits from your branch, temporarily removes them, sets the branch to match the latest state of the target branch (master), and then replays your commits one by one on top of it. The commit hashes change because they are technically new commits with a new base.

### How is the history different from a merge?

Merge preserves the true history — you can see where branches diverged and came back together (diamond shapes in the graph). Rebase rewrites history to look linear — it appears as if the branch was always built on top of the latest master with no branching at all.

#### Observed: After rebasing **feature-dashboard** onto master, `git log --oneline --graph --all` showed completely linear history at the top with no |\ or |/ symbols, unlike the merge commits lower in the log.

### Why should you never rebase commits that have been pushed and shared with others?

Rebase rewrites commit hashes. If someone else has already pulled your original commits and you rebase and force push, their local history will conflict with the new rewritten history. This causes serious problems for the team and can lead to lost work.

### When would you use rebase vs merge?

- Use rebase when working on a local feature branch and want to keep a clean linear history before merging into main.
- Use merge when working in a team on shared branches, or when you want to preserve the true history of how and when branches were integrated.


## Task 3: Squash Merge vs Regular Merge

### What does squash merging do?

`git merge --squash` takes all the commits from the feature branch and combines them into a single set of changes, stages them, and lets you commit them as one single commit on the target branch. The individual commits from the branch do not appear in the main branch history.

#### Observed: **feature-profile** had 4 commits (Profile draft, Typo fix, Formatting, Minor tweak). After `git merge --squash feature-profile` and committing, only one commit **Add profile page (squashed)** appeared in master's log.

### When would you use squash merge vs regular merge?

- Use squash merge when a feature branch has many small messy commits (typo fixes, WIP commits) and you want to keep the main branch history clean with one meaningful commit per feature.
- Use regular merge when you want to preserve the full commit history of a feature for traceability and debugging.

### What is the trade-off of squashing?

You lose the individual commit history. If a bug is introduced, it's harder to pinpoint exactly which small change caused it. The detailed story of how the feature was built is gone from the main branch.

## Task 4: Git Stash

### What is the difference between git stash pop and git stash apply?

- `git stash pop`— applies the stash and removes it from the stash list.
- `git stash apply` — applies the stash but keeps it in the stash list. You can apply it again later or on another branch.

#### Observed: After `git stash pop`, the stash was dropped from the list `(Dropped refs/stash@{0})`. After `git stash apply stash@{0}`, the stash remained visible in `git stash list`.

### When would you use stash in a real-world workflow?

- When you are mid-way through a feature and an urgent bug report comes in. You stash your WIP, switch to the hotfix branch, fix the bug, then come back and pop your stash.
- When you want to quickly test something on a clean working directory without committing half-done work.
- When switching between multiple tasks without losing progress on any of them.

Useful stash commands practiced:

```bash
git stash push -m "description"   # stash with a message
git stash list                     # see all stashes
git stash pop                      # apply and remove top stash
git stash apply stash@{1}          # apply a specific stash
git stash drop stash@{0}           # delete a specific stash
```

## Task 5: Cherry-Pick

### What does cherry-pick do?

`git cherry-pick <hash>` takes a specific commit from any branch and applies it onto the current branch as a new commit. Only that one commit's changes are applied — not the entire branch.

#### Observed: **feature-hotfix** had 3 commits (Fix A, Fix B, Fix C). After cherry-picking only Fix A and Fix B onto master, `git log --oneline` showed only those two commits on master. Fix C was not present.

### When would you use cherry-pick in a real project?

- A critical bug fix was made on a feature branch and needs to go to production (main) immediately without merging the entire feature.
- You accidentally made a commit on the wrong branch and want to move just that commit to the correct branch.
- Backporting a fix from a newer release branch to an older stable branch.

### What can go wrong with cherry-picking?

- If the cherry-picked commit depends on changes from earlier commits that are not present on the target branch, Git will conflict — exactly what happened when trying to cherry-pick Fix B without Fix A first.
- Cherry-picking creates a new commit with a different hash, so the same change exists twice in history (once on the original branch, once on master). This can cause confusion during future merges.
- Overusing cherry-pick instead of proper branching strategies leads to messy, hard-to-track history.



### Key Takeaways
| Concept             | What it does                                   |     When to use                       |
|---------------------|------------------------------------------------|---------------------------------------|
| Fast-forward merge  | Moves pointer forward, no new commit           |  Branch hasn't diverged from base     |
| Merge commit        | Creates new commit with two parents            |  Branches have diverged               |
| Rebase              | Replays commits on new base, linear history    |  Local cleanup before merging         |
| Squash merge        | Collapses all branch commits into one          |  Messy WIP commits on feature branch  |
| Stash               | Saves uncommitted work temporarily             |  Context switching without committing |
| Cherry-pick         | Applies one specific commit to current branch  |  Hotfixes, wrong branch commits       |

#### Biggest insight: Merge is honest about history. Rebase makes history look clean but rewrites the past. Neither is universally
better — teams pick one convention and stick to it.
