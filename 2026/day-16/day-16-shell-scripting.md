## Day 16 – Shell Scripting Basics

### Goal 
- To learn the fundamentals every script needs.
- To understand shebang (#!/bin/bash) and why it matters.
- Work with variables, echo, and read
- Write basic if-else conditions

**Command used to Create, Execute and Run the script file**

```bash
vim file.sh        # Create the file with a editor (replace your file's name with file.sh)
chmod +x file.sh   # Give executable permission
./file.sh         # Run the script
```

### Task 1: Your First Script
1. Create a file `hello.sh`
2. Add the shebang line `#!/bin/bash` at the top
3. Print `Hello, DevOps!` using `echo`
4. Make it executable and run it

**Code:**
```
#!/bin/bash
echo "Hello, DevOps!"
```

### Q. What happens if you remove the shebang line?
 Without shebang, the script may run with the wrong shell or fail when executed directly (./script.sh).

### Task 2: Variables
1. Create `variables.sh` with:
   - A variable for your `NAME`
   - A variable for your `ROLE` (e.g., "DevOps Engineer")
   - Print: `Hello, I am <NAME> and I am a <ROLE>`

**Code:** 
```
#!/bin/bash
NAME='Vrushali'
ROLE='DevOps Engineer'
echo "Hello, I am $NAME and I am a $ROLE"
```
#### Observation: Single vs Double Quotes

In my script, I stored the value `Vrush` (and `Aspiring DevOps Engineer`).
I tried both single and double quotes, and got the **same output** in each case.

**Why no difference?**
Because the values contained no `$`, backticks, or escape sequences,
single and double quotes behave identically — both just group the text.
The quotes are only *delimiters*; they are not stored in the variable.

**When quotes DO matter:**
1. **Spaces in the value** — quotes are required, otherwise Bash treats
   the words as separate commands:

### Single Quotes vs Double Quotes in Bash

| Feature | Single Quotes `'...'` | Double Quotes `"..."` |
|---|---|---|
| Variable expansion (`$VAR`) |  Not expanded — literal |  Expanded |
| Command substitution (`$(cmd)` / `` `cmd` ``) |  Not executed — literal |  Executed |
| Arithmetic expansion (`$((...))`) |  Not evaluated — literal | Evaluated |
| Backslash escaping (`\n`, `\$`, `\"`) |  Backslash is literal | Escapes `$`, `` ` ``, `"`, `\` |
| Special characters (`;`, `*`, `?`, `&`, `\|`) | Treated literally |  Treated literally |
| Spaces preserved as one string | Yes |  Yes |
| Can contain the other quote type | Yes (`"` inside) | Yes (`'` inside) |
| Cannot contain | `'` (single quote) | `"` (double quote, unless escaped) |
| Use when | You want **exact literal** text | You want **expansion** + safety |
| Example | `'Hello $USER'` → `Hello $USER` | `"Hello $USER"` → `Hello alice` |

### Quick rule
- **Single quotes** = *"take it literally, don't touch anything"*
- **Double quotes** = *"expand variables/commands, but keep it as one string"*
- **No quotes** = *"expand, then word-split and glob"* (usually a bug — always quote variables when using them)

### Task 3: User Input with read
1. Create `greet.sh` that:
   - Asks the user for their name using `read`
   - Asks for their favourite tool
   - Prints: `Hello <name>, your favourite tool is <tool>`

**Code:**
```
#!/bin/bash
read -p "Enter your name: " name
read -p "Enter your favourite tool: " tool
echo "Hello $name, and your favorite tool is $tool"
```
- read -p command displays a prompt message to the user and captures their typed input into a variable on the same line.

### Task 4: If-Else Conditions
1. Create `check_number.sh` that:
   - Takes a number using `read`
   - Prints whether it is **positive**, **negative**, or **zero**

2. Create `file_check.sh` that:
   - Asks for a filename
   - Checks if the file **exists** using `-f`
   - Prints appropriate message

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
Create `server_check.sh` that:
1. Stores a service name in a variable (e.g., `nginx`, `sshd`)
2. Asks the user: "Do you want to check the status? (y/n)"
3. If `y` — runs `systemctl status <service>` and prints whether it's **active** or **not**
4. If `n` — prints "Skipped."

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
![proof-1](./images/Day-16%20Shell%20script%201.jpg)

![proof-1](./images/Day-16%20Shell%20script%202.jpg)


