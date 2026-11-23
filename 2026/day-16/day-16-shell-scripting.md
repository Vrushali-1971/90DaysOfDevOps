## Day 16 – Shell Scripting Basics

### Goal 
- To learn the fundamentals every script needs.
- To understand shebang (#!/bin/bash) and why it matters.
- Work with variables, echo, and read
- Write basic if-else conditions

### Task 1: Your First Script
 
**Command used to Create, Execute and Run the script file**

```bash
vim file.sh        # Create the file with a editor (replace your file's name with file.sh)
chmod +x file.sh   # Give executable permission
./file.sh         # Run the script
```

**Code:**
```
#!/bin/bash
echo "Hello, DevOps!"
```

### Q. What happens if you remove the shebang line?
 Without shebang, the script may run with the wrong shell or fail when executed directly (./script.sh).

### Task 2: Variables

**Code:** 
```
#!/bin/bash
NAME='Vrushali'
ROLE='DevOps Engineer'
echo "Hello, I am $NAME and I am a $ROLE"
```

### Single Quotes vs Double Quotes (Difference)
- **Single Quotes** - When we use single quotes the shell treats it as a literal text and does not expand it.

**Example:** - `echo 'Hello, I am $NAME'`

➜ **Output:** `Hello, I am $NAME` (Here it didn't expand Name variable's given value)

- **Double quotes** - Use double quotes to expand the variable's value while preventing unexpected word splitting and wildcard expansion

**Example:** - `echo "Hello, I am $NAME"`

➜ **Output:** `Hello, I am Vrushali` (Here it expanded the variable as we put the double quotes) 

### Task 3: User Input with read

**Code:**
```
#!/bin/bash
read -p "Enter your name: " name
read -p "Enter your favourite tool: " tool
echo "Hello $name, and your favorite tool is $tool"
```
- read -p command displays a prompt message to the user and captures their typed input into a variable on the same line.

### Task 4: If-Else Conditions
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

### Proof of work: 
![proof-1](./Day-16%20Shell%20script%201.jpg)

![proof-1](./Day-16%20Shell%20script%202.jpg)


