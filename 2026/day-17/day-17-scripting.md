### Day 17 – Shell Scripting: Loops, Arguments & Error Handling

## 🎯 Objective

Level up shell scripting skills by practicing:

- Writing **for loops** and **while loops**
- Using **command-line arguments** (`$1`, `$#`, `$@`, `$0`)
- Installing packages via script
- Implementing **basic error handling**

---

# 🧪 Challenge Tasks

## Task 1 – For Loop

### Script: `for_loop.sh`

#### Purpose:

Loop through a list of fruits and print each one.

#### Code

```bash

#!/bin/bash

# Print fruit names using for loop

for fruit in Apple watermelon papaya kiwi orange
do
        echo "Current fruit is: $fruit"
done
```
#### Output

```
Current fruit is: Apple
Current fruit is: watermelon
Current fruit is: papaya
Current fruit is: kiwi
Current fruit is: orange
```

### Script: count.sh

##### Purpose:

Print numbers 1 to 10 using a for loop.

#### Code

```bash
#!/bin/bash

# Print numbers from 1 to 10 using a for loop

for i in {1..10}
do
        echo "$i"
done
```
#### Output

```
1
2
3
4
5
6
7
8
9
10
```

## Task 2 – While Loop

### Script: countdown.sh

#### Purpose:

Take a number from the user and count down to 0 using a while loop.

#### Code

```bash
#!/bin/bash

# Take input from user

 read -p "Enter a number:" num

# Count down to 0 using a while loop

 while [ "$num" -ge 0 ]
 do
         echo "$num"
         ((num--))
 done

 echo "done!"
```

#### Output

```
Enter a number:7
7
6
5
4
3
2
1
0
done!
```

## Task 3 – Command-Line Arguments

### Script: greet.sh

#### Purpose: Accept a name as input and greet the user.

#### Code

```bash
#!/bin/bash

 if [ -z "$1" ]; then
         echo "Usage: $0"
 else
         echo "Hello, $1!"
 fi
```

#### Output

Without argument - ./greet.sh

```
Usage: ./greet.sh
```
with argument - ./greet.sh Vrushali
```
Hello, Vrushali!
```

### Script: args_demo.sh

#### Purpose:
Display argument-related variables.

$# → Number of arguments

$@ → All arguments

$0 → Script name

#### Code

```bash
#!/bin/bash

 echo "The total number of arguments are: $#"
 
 echo "All arguments are: $@"

 echo "Script name is: $0"
```

#### Output

- Command: ./args_demo.sh tokyo delhi pune

```
 The total number of arguments are: 3
All arguments are: tokyo delhi pune
Script name is: ./args_demo.sh
```

## Task 4 – Install Packages via Script

### Script: install_packages.sh

#### Purpose: Automatically check and install required packages.

 Packages checked:

- nginx
- curl
- wget

#### Code

```bash
#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Define a list of packages

 PACKAGES=( "nginx" "curl" "wget" )

 for package in "${PACKAGES[@]}"
 do
         echo "Checking package: $package"
if dpkg -s "$package" &> /dev/null
then  
        echo "Status: $package is already installed. Skipping"
else 
        echo "Status: $package is not installed. Installing..."
         apt install -y "$package" 

         if dpkg -s "$package" &> /dev/null
         then 
                 echo "Status: $package installed successfully."
         else
                 echo "Status: Failed to install $package."
         fi
fi
echo "--------------------------------------------------------"
done
```

#### Output

```
Checking package: nginx
Status: nginx is already installed. Skipping
--------------------------------------------------------
Checking package: curl
Status: curl is already installed. Skipping
--------------------------------------------------------
Checking package: wget
Status: wget is already installed. Skipping
--------------------------------------------------------
```

### Root Permission Check

This script checks if it is being run as root before installing packages.

```bash
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi
```

## Example Output

If run without root: 

Please run this script as root.


If run correctly:

```bash
sudo su
 ./install_packages.sh
```

Then the script continues.

## Task 5 – Error Handling

### Script: safe_script.sh

#### Purpose: Demonstrate safe scripting using:

- `set -e`

- || operator

- directory and file operations

#### Code

```
#!/bin/bash

# Exit immediately if any command fails.

 set -e

 echo "Creating directory..."

 mkdir /tmp/devops-test || echo "Directory already exists"

 echo "Navigating into directory..."

 cd /tmp/devops-test || { echo "Failed to enter directory"; exit 1; }

 echo "Creating file..."

 touch testfile.txt || echo "Failed to create file"

 echo "Script completed successfully"
```
### Output

```
Creating directory...
Navigating into directory...
Creating file...
Script completed successfully
```

📚 Key Learnings

- Loops (for, while) automate repetitive tasks.
- Command-line arguments allow scripts to accept dynamic input.
- Package management automation helps manage dependencies efficiently.
- Error handling (set -e, ||) makes scripts safer and more reliable.

🚀 Conclusion

This exercise strengthened core Bash scripting skills by combining loops, arguments, automation, 

and error handling to build more practical and reliable scripts.
