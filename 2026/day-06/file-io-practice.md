##Day 06 – Linux Fundamentals: Read and Write Text Files

### Goal 
Practice basic file creation, writing, appending, and reading using Linux commands.

### Commands Practiced 
1. 'touch  notes.txt'
   created and empty file named notes.txt.
   
3. 'echo "Today is Day-6 of 90 days of Devops challenge" > notes.txt'
     Wrote text to the file using '>' (Overwrites existing content).
   
5. 'echo "This task is to practice basic file read/write using fundamental commands" >> notes.txt'
    Appended a new line to the file using '>>'.
   
7. 'echo "Let's do this task" | tee -a notes.txt'
    Appended text to the file and displayed it on the terminal at the same time.
   
9. 'cat notes.txt'
    Displayed the full content of the file.
   
11. 'head -n 2 notes.txt'
    Displayed the first 2 lines of the file.
    
13. 'tail -n 2 notes.txt'
    Displayed the last 2 lines of the file.

 ### Observation
 
 - '>' overwrites the file content.
 - '>>' appends new content to the file.
 - 'tee -a' appends and also shows output on the screen.
 - 'cat' 'head', and 'tail' are used to read file content.

 ### Learning

    Linux treats configuration files, logs, and scripts as text files, Understanding how to read and write
    files is essential for debugging and automation in Devops.
