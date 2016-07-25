#choice 1
# list how many files in current dir(including files in subdir)
find . -type f | wc -l

#choice 2
# list how many files in each subdir in current dir
for i in $(find . -maxdepth 1 -type d) ; do 
    echo -n $i": " ; 
    ( find $i -type f | wc -l ) ; 
done
