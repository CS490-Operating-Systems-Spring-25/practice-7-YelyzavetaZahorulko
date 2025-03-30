## Task 1

**To compile assmbly code:**

`aarch64-linux-gnu-as -o task1.o task1.S`

`aarch64-linux-gnu-ld -o task1 task1.o`

**Run:**
`./task1`

**Expected Result:**

print current directory - home/ubuntu

If run `echo $?` it should return `1`

**Check the correctness of work with files:**
Check if the file exists: 
`ls -l testfile.txt`

Check the content of the file:
`cat testfile.txt`

Check permissions:
`ls -l testfile.txt`

Expected:
`-rwxr-xr-x 1 user user 26 Mar  5 12:34 testfile.txt`
