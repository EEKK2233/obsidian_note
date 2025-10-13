---
data: 2025-10-13
---
## special symbols
- ~ : HOME_path
- \* : fuzzy matching
- | : use the result of the left command as the input for the right content
- \` : following "echo", *echo \`text\`* the text will be executed as a command
- \> : overwrite the left result to right file
- \>>:appendthe left result to right file
## **ls** \[-a -l -h\] Linux_path

- -a : all,  show all file and directory.(la)
- -l : list, display content in the form of a list(vertically arranged) 
  and show more information.(ll)
- -h : list file sizes in an easily readable format.

## **cd** Linux_path
change directory
cd = cd ~
## **pwd**
Print Work Directory
## **mkdir** \[-p\] Linux_path
create a directory
- -p : automatically create non-existent parent directories, suitable for creating consecutive multi-level directories
## **torch** Linux_path
create a file

## **cat** Linux_path
view all file content
## **more** Linux_path
view part of the file content
## **cp** \[-r\] Linux_path_1 Linux_path_2
copy file or directory
Linux_path_1 : the copied file or directory
Linux_path_2 : the destination for copying
- -r : used to indicate recursion when copying folders
## **mv** Linux_path_1 Linux_path_2
move Linux_path_1 to Linux_path_2
## **rm** \[-r -f\] Linux_path ..
remove files or folders
- -r : used to remove floders
- -f : force remove without prompting for confirmation
## **which** the_command_to_find
find the path of the used command
## **find** starting_path -name "file_name"
## **find**
starting_path -size +|-n[kMG]
> find / -size +100M
## **grep**  \[-n\] "keyword" Linux_path
filter file lines by keyword from file
- -n : display the line numbers for lines
## **wc** \[-c -m -l -w\] Linux_path
count the numbers of lines and other information of the file
- -c : count bytes
- -m : count characters
- -l : count lines
- -w : count words
## echo content_output
print the content_output
## tail \[-f -num\] Linux_path
view the tail file content
- -f : continuously track file changes
- -num : the nums of lines(default is 10)
## chmod \[-R\] premission file/floder
change file or folder permission information
- -R : apply the same change to all file in folder
> chmod u=rwx, g=rx, o=x hello.txt
> chmod 751 hello.txt
## chown \[-R\] \[user\]\[:\]\[group\] file/folder (only root)
> chown root hello.txt
> chown :root hello.txt
> chown root:dbkja hello.txt