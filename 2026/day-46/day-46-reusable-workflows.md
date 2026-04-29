# Day 46 – Reusable Workflows & Composite Actions

## Objective

* Learn reusable workflows using `workflow_call`
* Pass inputs, secrets, and outputs
* Build a custom composite action
* Understand real CI/CD modular design

---

# Task 1: Understanding Concepts

###  What I learned:

* Reusable workflow = workflow that can be called like a function
* `workflow_call` enables reuse across workflows
* Reusable workflows run **jobs**, actions run **steps**
* Must be stored in:

```
.github/workflows/
```

---

# Task 2: Reusable Workflow

### Workflow File

[reusable-build.yml](./workflows/reusable-build.yml)

### Screenshot

![Reusable workflow run](./images/task-2-build.jpg)

---

# Task 3: Caller Workflow

### Workflow File

[call-build.yml](./workflows/call-build.yml)

### 📸 Screenshot

![Caller workflow execution](./images/task-3.jpg)

---

# Task 4: Outputs (Reusable → Caller)

### Workflow Files

* [reusable-build.yml](./workflows/reusable-build.yml)
* [call-build.yml](./workflows/call-build.yml)

### Screenshots

![Generate version output](./images/task-4-1.jpg)
![Read output in next job](./images/task-4-2.jpg)

---

# Task 5: Composite Action

### Action File

[setup-and-greet](./actions/setup-and-greet/action.yml)

### Screenshot

![Composite action output](./images/task-5.jpg)

---

# Task 6: Reusable Workflow vs Composite Action

| Feature         | Reusable Workflow    | Composite Action    |
| --------------- | -------------------- | ------------------- |
| Triggered by    | `workflow_call`      | `uses:`             |
| Contains jobs   |  Yes                 |  No                 |
| Contains steps  |  Yes                 |  Yes                |
| Location        | `.github/workflows/` | `.github/actions/`  |
| Accepts secrets |  Yes                 |  No                 |
| Best for        | Full CI/CD pipelines | Reusable step logic |

---

# Key Learnings

* Reusable workflows reduce duplication
* `workflow_call` makes pipelines modular
* Outputs enable data sharing between jobs
* Composite actions simplify repeated steps
* Difference between:

  * `jobs`
  * `steps`
  * `needs`
  * `outputs`

---

# Final Outcome

* Built reusable workflow
* Created caller workflow
* Passed inputs, secrets, outputs
* Implemented composite action
* Understood real-world CI/CD design

---

# Summary

This task helped me understand how DevOps teams design scalable and reusable CI/CD pipelines using workflows and custom actions.

---
