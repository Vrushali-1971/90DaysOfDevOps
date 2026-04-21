# Day 41: Advanced GitHub Actions - Triggers & Matrix Builds

## Task Overview
Today's task was to learn every way to trigger a workflow and how to run jobs across multiple environments at once.

---

## Task 1: Trigger on Pull Request
I created a workflow that acts as a gatekeeper for the `main` branch. It only triggers when a Pull Request is opened or updated.

[pr-check yaml file](./workflows/pr-check.yml)

#### Screenshots:
Checked pull request on GitHub and confirmed pr-check workflow is running 
![PR check on the Pull Request page](./images/day-41-pr-check)


### Task 2: Scheduled Trigger (Cron)
I implemented a scheduled workflow using Cron syntax.File: .github/workflows/scheduled.ymlYAMLname: Daily Midnight Sync

[Scheduled Trigger yaml file](./workflows/scheduled.yml)

![Daily Midnight sync](./images/day-41-daily-midnight-sync)

#### Cron Challenge:Question: 
#### What is the cron expression for every Monday at 9 AM?
Answer: `0 9 * * 1`

### Task 3: Manual Trigger (workflow_dispatch)
I added a manual trigger that allows users to trigger the workflow from the GitHub UI with specific inputs.File: .github/workflows/manual.ymlYAMLname: Manual Workflow

[Manual Trigger yaml file](./workflows/manual.yml)

![Manual "Run workflow" with environment selection](./images/day-41-manual-trigger-workflow-1)
![Manual-trigger-workflow](./images/day-41-manual-trigger-workflow)


### Task 4: Matrix Builds
I Used a matrix Strategy to run the same job across python versions: `3.10`, `3.11`, `3.12` and ensure that each job installs python and prints the version, watched them run inparallel and extended the matrix to include two operating sytems.

#### Basic Matrix (Python versions)
```yaml
name: Matrix Build task

on: 
  push:

jobs:
  build:
    runs-on: ubuntu-latest
    
    strategy:
      matrix:
        python-version: ["3.10", "3.11", "3.12"]
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}
      
      - name: Show Python versions
        run: python --version
```

#### Extended matrix (Add OS)
 
```yaml
name: Matrix Build task

on:
  push:

jobs:
  build:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest]
        python-version: ["3.10", "3.11", "3.12"]
    
    runs-on: ${{ matrix.os }}

    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}

      - name: Show Python versions
        run: python --version
```


![Matrix Build Showing 3 Paralled jobs in the Actions tab](./images/day-41-matrix-workflow)

![Matrix Build showing 6 parallel jobs in the Actions tab](./images/day-41-extended-matrix-workflow)


### Task 5: Exclude & Fail-Fast
Updated matrix YAML configuration to exclude python 3.10 version on windows and set `fail-fast: false` to observe how all jobs continue execution even when one job fails.

[Matrix Build yaml file](.workflows/matrix.yml)

![Matrix Build fail-fast output](./images/day-41-matrix-forced-failure)


### Key Learnings:Total Jobs: Without exclusion, 6 jobs run ($3 \times 2$). With the exclusion, 5 jobs ran in parallel.Fail-Fast: * fail-fast: true (Default): If one job in the matrix fails, GitHub cancels all other running jobs.fail-fast: false: Allows all jobs to complete their execution even if one fails. 
