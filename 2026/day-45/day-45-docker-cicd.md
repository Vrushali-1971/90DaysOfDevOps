# Day 45 – Docker Build & Push with GitHub Actions

## Objective
Build a complete CI/CD pipeline where:
- Code push → Docker image build → Push to Docker Hub → Run container

---

## Task 1: Prepare

###  What I did:
- Used my Day 36 project (`todo-flask-app`)
- Added:
  - Dockerfile
  - app.py
  - requirements.txt
- Configured GitHub secrets:
  - DOCKER_USERNAME
  - DOCKER_TOKEN

### 📸 Screenshot
![Task 1 - Initial Build](./images/task-1-build.jpg)

---

## Task 2: Build Docker Image in CI

### What I did:
- Created GitHub Actions workflow
- Built Docker image using docker/build-push-action

### Workflow Snippet:
```yaml
- name: Build Docker Image
  uses: docker/build-push-action@v5
  with:
    context: ./todo-flask-app
    push: false
    tags: |
      vrushalicloud/todo-flask-app:latest
```
### Screenshot
![Build step success](./images/task-2-build.jpg)

---

## Task 3: Push to Docker Hub
### What I did:
- Logged into Docker Hub using secrets
- Added tagging:
  - latest
  - sha-<short_commit_hash>

### SHA Extraction:
```yaml
- name: Get short SHA
  run: echo "SHORT_SHA=${GITHUB_SHA::7}" >> $GITHUB_ENV
```
### Push Step:
```yaml
- name: Push Docker Image
  if: github.ref == 'refs/heads/main'
  uses: docker/build-push-action@v5
  with:
    context: ./todo-flask-app
    push: true
    tags: |
      vrushalicloud/todo-flask-app:latest
      vrushalicloud/todo-flask-app:sha-${{ env.SHORT_SHA }}
```
### Screenshot (Push on Main)
![](./images/task-3-build-push-main.jpg)

### Docker Hub Tags
![](./images/docker-hub-tags.jpg)

---

## Task 4: Push Only on Main Branch
### What I did:
Added condition:
```yaml
if: github.ref == 'refs/heads/main'
```
### Tested:
- Pushed to feature branch
- Image built but NOT pushed 

 ### Screenshot
 ![Workflow run on feature1, Push step skipped](./images/task-4-push-feature1.jpg)

 ---

## Task 5: Add Status Badge
### What I did:
- Added GitHub Actions badge to README.md

 ### Badge Syntax:
![Build and Push Docker Image](https://github.com/Vrushali-1971/github-actions-practice/actions/workflows/docker-publish.yml/badge.svg)]

### docker-publish Workflow file 
[docker-publish.yml workflow file](./docker-publish.yml)

### Screenshot
![README with green badge](./images/task-5-status-badge.jpg)

---

## Task 6: Pull & Run Docker Image
### What I did:
- Pulled image from Docker Hub
- Ran container on EC2

### Commands:
```bash
docker pull vrushalicloud/todo-flask-app:latest
docker run -d -p 5000:5000 vrushalicloud/todo-flask-app:latest
```

### EC2 Terminal Output
![Docker pull and run command](./images/day-45-pull-build.jpg)

### Browser Output
![Browser output (public IP)](./images/day-45-app-browser-accessed.jpg)

### Curl Output (Server Side)
![curl output from server](./images/day-45-app-accessed-EC2server.jpg)

# Important Fix (Real Learning)
 ### Problem:
App was stuck in infinite loop:
```python
while True:
```
### Fix:
Handled DB failure gracefully
```python
def get_db_connection():
    try:
        return mysql.connector.connect(...)
    except:
        return None
```

### Result:
- App runs even without DB 
- No blocking startup 
- Real production behavior 

##  Full CI/CD Flow
```
Code Push → GitHub Actions Trigger
→ Build Docker Image
→ Tag (latest + sha)
→ Push to Docker Hub
→ Pull on EC2
→ Run Container
→ Access via Browser
```

### Key Learnings
- CI/CD automates build and deployment
- SHA tagging helps in version control & rollback
- Never block app startup due to dependencies
- Always handle service failures gracefully
- Difference between:
   - Build vs Push
   - Local vs Production behavior
- Feature branch testing is critical in CI/CD

### Final Output
- Automated Docker CI/CD pipeline
- Image available on Docker Hub
- App deployed and accessible via browser
- Status badge in README




