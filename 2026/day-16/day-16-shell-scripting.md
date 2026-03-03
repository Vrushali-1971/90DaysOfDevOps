## Day 16 – Shell Scripting Basics

### Goal 
- To learn the fundamentals every script needs.
- To understand shebang (#!/bin/bash) and why it matters.
- Work with variables, echo, and read
- Write basic if-else conditions

### Steps for every script file in the following tasks.

Step 1: create a file using vim editor.

Step 2: Write code inside vim editor.

Step 3: Give executable permissions.

Step 4: Run the executable file.

### Task 1: Your First Script
 
  **Command used to Create, Execute and Run the script file**

```bash
vim hello.sh
chmod +x hello.sh
./hello.sh
```

**Code:**
```
#!/bin/bash
echo "Hello, DevOps!"
```

**What happens if you remove the shebang line?**

 Without shebang, the script may run with the wrong shell or fail when executed directly (./script.sh).

 ### Task 2: Variables

 **Command used to Create, Eexecute and Run the script file**

 ```bash
vim variables.sh
chmod +x variables.sh
./variables.sh
```
**Code:** 
```
#!/bin/bash
NAME='Vrushali'
ROLE='DevOps Engineer'
echo "Hello, I am $NAME and I am a $ROLE"
```

**Single Quotes vs Double Quotes (Difference)**

**Single quotes ' '**

- Variables are NOT expanded

**Example:**

echo 'Hello, I am $NAME'

➜ Output: Hello, I am $NAME

**Double quotes " "**

- Variables ARE expanded

**Example:**

echo "Hello, I am $NAME"

➜ Output: Hello, I am Ajay

### Task 3: User Input with read

**Commands used to Create, execute and run the file.**

```bash
vim greet.sh
chmod +x greet.sh
./greet.sh
```

**Code:**

```
#!/bin/bash
read -p "Enter your name: " name
read -p "Enter your favourite tool: " tool
echo "Hello $name, and your favorite tool is $tool"
```

### Task 4: If-Else Conditions

**Commands used for Task1**

```bash
vim check_number.sh
chmod +x check_number.sh
./check_number.sh
```
**Code:**

```
#!/bin/bash
read -p "Enter the number: " num
if [ "$num" -gt 0 ]; then
    echo "The number is positive"
elif [ "$num" -lt 0 ]; then
    echo "The number is negative"
else
    echo "The number is Zero"
fi
```
 
**Commands used for Task 2**
```bash
vim file_check.sh
chmod +x file_check.sh
./file_check.sh
```
**Code:**
```
#!/bin/bash
read -p "Enter the file name: " file
if [ -f "$file" ]; then
   echo "File exists"
else
   echo "File doesnot exist"
fi
``` 

### Task 5: Combine It All

**Commands used**

```bash
vim server_check.sh
chmod +x server_check.sh
./server_check.sh
```

**Code:**

```
#!/bin/bash

service="nginx"

read -p "Do you want to check the status? (y/n): " answer

if [ "$answer" = "y" ]; then
        systemctl status "$service"
  if systemctl is-active --quiet "$service"; then
        echo "$service is active"
    else
        echo "$service is not active"
    fi
elif [ "$answer" = "n" ]; then
    echo "Skipped."
else
        echo "Invalid Input"
fi
```

### What I Learned

1. Shebang ensures correct interpreter execution.
2. Quotes are important for safe variable handling.
3. If-else logic and file checks are core building blocks of automation.




