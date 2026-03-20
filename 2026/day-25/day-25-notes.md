# Day 25 - Git Reset vs Revert & Branching Strategies

## Task 1: Git Reset

### What is the difference between --soft, --mixed, and --hard?

All three reset types move HEAD back to a previous commit but they differ in what happens to your changes:

**--soft** — removes the commit but keeps the changes staged. You can immediately run `git commit` again without doing `git add`.

**--mixed** — removes the commit and unstages the changes. The changes are still in your files but you need to run `git add` before committing again. This is the default reset behavior.

**--hard** — removes the commit AND deletes the changes completely from your files. The changes are gone forever.

### Observed during hands-on:

After `git reset --soft HEAD~1`:
- Commit C was removed from log
- Changes were still staged — `git status` showed changes ready to commit

After `git reset --mixed HEAD~1`:
- Commit C was removed from log
- `git status` showed `modified: reset-test.txt` — changes still there but unstaged
- Terminal showed `Unstaged changes after reset: M reset-test.txt`

After `git reset --hard HEAD~1`:
- Commit C was removed from log
- `git status` showed `nothing to commit, working tree clean`
- `cat reset-test.txt` showed only 2 lines — commit C content was completely gone

### Which one is destructive and why?
`--hard` is destructive because it permanently deletes your changes. Unlike `--soft` and `--mixed` where your work is still recoverable, `--hard` wipes everything with no way to get it back through normal Git commands.

### When would you use each one?
- `--soft` — when you want to undo a commit but keep everything staged. Useful when you committed too early and want to add more changes to the same commit.
- `--mixed` — when you want to undo a commit and reorganize your changes before committing again.
- `--hard` — when you want to completely throw away your recent work and go back to a clean state. Use with caution.

### Should you ever use git reset on commits that are already pushed?
No. Git reset rewrites history by removing commits. If you reset commits that others have already pulled, their local history will conflict with yours when they try to push or pull. Always use `git revert` for commits that are already on GitHub.

---

## Task 2: Git Revert

### Observed during hands-on:
Created 3 commits — Commit X, Commit Y, Commit Z on `revert-test.txt`.

After `git revert <hash of Commit Y>`:

`git log --oneline` showed:
```
aac6c76 Revert "Commit Y"
c469530 Commit Z
ba02728 Commit Y
594edea Commit X
```

`cat revert-test.txt` showed:
```
commit X
commit Z
```

Commit Y's changes were removed from the file but Commit Y is still visible in the log history.

### How is git revert different from git reset?
- `git reset` removes the commit from history — it rewrites the past
- `git revert` keeps the commit in history and adds a new commit on top that undoes the changes — it does not rewrite the past

### Why is revert considered safer than reset for shared branches?
Because revert never changes existing commit history. It only adds a new commit. So anyone who has already pulled your branch will not have any conflicts. Reset on the other hand removes commits from history which causes problems for everyone who has pulled those commits.

### When would you use revert vs reset?
- Use `git reset` — for local mistakes that have NOT been pushed to GitHub yet
- Use `git revert` — for mistakes that have already been pushed and shared with others

---

## Task 3: Reset vs Revert Comparison

| | git reset | git revert |
|---|---|---|
| What it does | Moves HEAD back, removes commits | Creates a new commit that undoes changes |
| Removes commit from history | Yes | No |
| Adds new commit | No | Yes |
| Safe for shared/pushed branches | No | Yes |
| When to use | Local mistakes before pushing | Mistakes already pushed to GitHub |

**One line summary:**
- `git reset` — pretends the commit never happened
- `git revert` — admits the mistake and fixes it with a new commit

---

## Task 4: Branching Strategies

### 1. GitFlow

**How it works:**
GitFlow uses multiple long-lived branches. Development happens on the `develop` branch. Features are built on `feature` branches that branch off from develop and merge back into develop. When ready to release, a `release` branch is created from develop. After release it merges into both `main` and `develop`. Critical bugs in production are fixed on `hotfix` branches that branch off from main.

**Text-based flow:**
```
main
  |
  └── hotfix (for urgent production fixes)
  
develop
  |
  ├── feature/login
  ├── feature/signup
  └── release/v1.0 → merges into main and develop
```

**When/where it's used:**
Large teams with scheduled releases, enterprise software, projects that maintain multiple versions simultaneously.

**Pros:**
- Very organized and structured
- Clear separation between development and production
- Good for versioned releases

**Cons:**
- Complex — many branches to manage
- Slow — lots of merging overhead
- Overkill for small teams or fast moving projects

---

### 2. GitHub Flow

**How it works:**
Simple strategy with just one main branch. Developers create a feature branch from main, work on it, open a pull request, get it reviewed, and merge it back into main. Main is always deployable.

**Text-based flow:**
```
main
  |
  ├── feature/login → pull request → merge to main → deploy
  ├── feature/signup → pull request → merge to main → deploy
  └── fix/bug → pull request → merge to main → deploy
```

**When/where it's used:**
Startups, small teams, projects that deploy continuously. Used by React (facebook/react) — observed on GitHub: single `main` branch with many short lived feature and dependabot branches merged via pull requests.

**Pros:**
- Simple and easy to follow
- Fast — less overhead
- Main is always production ready

**Cons:**
- Not ideal for managing multiple release versions
- Requires good test coverage since main is always deployable

---

### 3. Trunk-Based Development

**How it works:**
All developers commit directly to one branch called `trunk` (usually `main`). If branches are used at all, they are extremely short lived — merged within a day. Relies heavily on feature flags to hide incomplete features in production.

**Text-based flow:**
```
main (trunk)
  |
  ├── short-lived branch → merged same day
  ├── direct commits from developer A
  └── direct commits from developer B
```

**When/where it's used:**
Large tech companies like Google and Facebook for internal projects. Teams with strong automated testing and CI/CD pipelines.

**Pros:**
- Fastest integration — no long running branches
- Reduces merge conflicts
- Forces continuous integration

**Cons:**
- Requires very strong test automation
- Risk of breaking main if discipline is low
- Not suitable for teams without CI/CD

---

### Answers:

**Which strategy would you use for a startup shipping fast?**

GitHub Flow — it is simple, fast, and keeps things moving without overhead. One main branch, feature branches, pull requests, deploy. That's all you need when moving fast.

**Which strategy would you use for a large team with scheduled releases?**

GitFlow — it is structured and organized. The separation between develop, release, and main branches makes it easy to manage scheduled releases and maintain multiple versions.

**Which one does React (facebook/react) use?**

GitHub Flow. Observed on GitHub — React has one `main` branch as default and many short lived feature branches like `devtools/activity-hidden`, `builds/facebook-fbsource`, and automated `dependabot` branches. All contributions come in through pull requests and get merged into main. History shows continuous commits directly to main with no long running parallel branches.

