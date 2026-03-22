# Day 26 - GitHub CLI: Manage GitHub from Your Terminal

## What is GitHub CLI?

GitHub CLI is a command line tool made by GitHub that lets you interact with GitHub directly from your terminal without opening a browser. The command name is `gh`.

Normal way — push code from terminal, switch to browser to create PR, check issues, manage repo, then switch back to terminal. With GitHub CLI everything stays in the terminal. It can also be used in scripts and automation pipelines.

---

## Task 1: Install and Authenticate

### Installation
```bash
sudo apt update
sudo apt install gh -y
```

### Authentication
```bash
gh auth login
```

Answered the prompts:
- Account: GitHub.com
- Protocol: SSH
- SSH key: selected existing `/home/ubuntu/.ssh/id_ed25519.pub`
- Authentication method: Login with a web browser
- Got a one time code, went to `github.com/login/device`, pasted code and authorized

### Verify login
```bash
gh auth status
```

**Observed output:**
```
✓ Logged in to github.com account Vrushali-1971
- Active account: true
- Git operations protocol: ssh
- Token scopes: 'admin:public_key', 'gist', 'read:org', 'repo'
```

### What authentication methods does gh support?
- **Login with a web browser** — generates a one time code, authorize on github.com/login/device
- **Login with an authentication token** — paste a Personal Access Token (PAT) directly

---

## Task 2: Working with Repositories

### Commands practiced:

**Create a new repo from terminal:**
```bash
gh repo create gh-cli-test --public --add-readme
```
Created a public repo with README directly on GitHub without opening browser.

**Clone a repo using gh:**
```bash
gh repo clone Vrushali-1971/gh-cli-test
```

**View repo details:**
```bash
gh repo view Vrushali-1971/gh-cli-test
```

**List all repositories:**
```bash
gh repo list
```
Showed all 6 public repos with name, description, visibility and last updated time.

**Open repo in browser:**
```bash
gh repo view Vrushali-1971/gh-cli-test --web
```
On EC2 this shows the URL but cannot open browser automatically since no GUI is installed.

**Delete a repo:**
```bash
gh repo delete Vrushali-1971/gh-cli-test --yes
```
Required adding `delete_repo` scope first with `gh auth refresh -h github.com -s delete_repo`.

---

## Task 3: Issues

### Commands practiced:

**Create an issue:**
```bash
gh issue create --repo Vrushali-1971/devops-git-practice --title "Test issue from terminal" --body "This issue was created using GitHub CLI" --label "bug"
```

**List open issues:**
```bash
gh issue list --repo Vrushali-1971/devops-git-practice
```

**View a specific issue:**
```bash
gh issue view 1 --repo Vrushali-1971/devops-git-practice
```

**Close an issue:**
```bash
gh issue close 1 --repo Vrushali-1971/devops-git-practice
```

**Observed:** After closing, `gh issue list` showed `no open issues` confirming the issue was closed successfully.

### How could you use gh issue in a script or automation?
- Automatically create an issue when a deployment fails in a CI/CD pipeline
- Close issues automatically when a fix is merged
- Generate a daily report of all open bugs by listing issues with `--json` flag
- Label and assign issues automatically based on keywords

---

## Task 4: Pull Requests

### Commands practiced:

**Create branch, commit and push:**
```bash
git switch -c feature-gh-cli
echo "testing gh cli pr" >> gh-cli-test.txt
git add . && git commit -m "Add gh cli test file"
git push origin feature-gh-cli
```

**Create a PR from terminal:**
```bash
gh pr create --repo Vrushali-1971/devops-git-practice --title "Test PR from terminal" --body "This PR was created using GitHub CLI" --base master --head feature-gh-cli
```

**List open PRs:**
```bash
gh pr list --repo Vrushali-1971/devops-git-practice
```

**View PR details:**
```bash
gh pr view 2 --repo Vrushali-1971/devops-git-practice
```

**Merge PR:**
```bash
gh pr merge 2 --repo Vrushali-1971/devops-git-practice --merge
```

### What merge methods does gh pr merge support?
- `--merge` — creates a merge commit (default)
- `--squash` — squashes all commits into one before merging
- `--rebase` — rebases commits onto base branch before merging

### How would you review someone else's PR using gh?
```bash
gh pr review <number> --approve
gh pr review <number> --request-changes --body "Please fix the tests"
gh pr review <number> --comment --body "Looks good, just one question"
```

---

## Task 5: GitHub Actions & Workflows Preview

### Commands practiced:

**List workflow runs:**
```bash
gh run list --repo facebook/react
```

**Observed:** Showed 20 recent workflow runs with status (✓ passed, X failed), workflow name, branch, event type, run ID, elapsed time and age. React has workflows like Fuzz tests, Lint, Build and Test, Manage stale issues running on schedules and pull requests.

**View specific run:**
```bash
gh run view 23383489934 --repo facebook/react
```

**Observed output:**
```
✓ main (Runtime) Fuzz tests · 23383489934
Triggered via schedule about 46 minutes ago
JOBS
✓ test_fuzz in 1m10s (ID 68026582852)
```

### How could gh run and gh workflow be useful in a CI/CD pipeline?
- Check if a deployment workflow passed before proceeding to next step in a pipeline
- Trigger a workflow run automatically after an event
- Send alerts if a workflow run fails
- Monitor workflow status from scripts without opening GitHub browser
- Get workflow run results in JSON format for further processing with `--json` flag

---

## Task 6: Useful gh Tricks

### gh api — raw GitHub API calls
```bash
gh api user
```
Returns full GitHub profile in JSON format including login, repos count, followers, following, created date etc.

```bash
gh api user --jq '.public_repos'
```
**Observed:** Returned `6` — total public repos count.

### gh gist — create and manage Gists
```bash
echo "This is my first gist from terminal" > gist-test.txt
gh gist create gist-test.txt --public --desc "Test gist from terminal"
```
**Observed:** Created public gist at `https://gist.github.com/Vrushali-1971/5e5d5161a32a33a4019c101641de3c93`

```bash
gh gist list
```
Listed the gist with ID, description, file count, visibility and last updated time.

### gh release — create releases
```bash
gh release create v1.0 --title "Version 1.0" --notes "First release of devops-git-practice"
```
**Observed:** Created release at `https://github.com/Vrushali-1971/devops-git-practice/releases/tag/v1.0`

### gh alias — create shortcuts
```bash
gh alias set prl 'pr list'
gh prl
```
**Observed:** `gh prl` worked as a shortcut for `gh pr list`. Showed `no open pull requests`.

### gh search repos — search GitHub
```bash
gh search repos devops --limit 5
```
**Observed:** Found 714613 devops repositories. Showed top 5 with name, description, visibility and last updated.

---

## Key Takeaways

- GitHub CLI removes the need to switch between terminal and browser
- All `gh` commands work with `--repo owner/repo` to target any repo
- Use `--json` flag with most commands to get machine readable output for scripting
- `gh pr create --fill` auto fills PR title and body from commit messages
- GitHub CLI is essential for DevOps automation — creating PRs, managing issues, monitoring workflows all from scripts
- `gh help` and `gh <command> --help` are the best way to explore available options

