# find common between two files
comm -12 <(sort file1.txt)  <(sort file2.txt)
## below is the other commands we may need 
comm -3 file1.txt file2.txt         # show all of the lines that are unique in file1.txt and file2.txt
comm -1 file1.txt file2.txt         # show all of the lines that are unique in f2 or common to both
comm -23 <(sort file1.txt)  <(sort file2.txt)        # show all of the lines that are only present in file1.txt
