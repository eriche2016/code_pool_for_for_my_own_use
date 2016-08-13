# list files in a directories and store them in a new dir
# suppose i am in dir coco_dataset/, and there are folders test2014/, val2014/, train2014/
# and i want to list all the jpg file name in the directory test2014/, val2014/, train2014/ to .txt files
# to avoid the generated txt files contains itself, we just stay in its direct parent directroy, her, just stay in /coco_dataset 
ls ./val2014/*.jpg > val2014.txt
# in val2014.txt:
# ./val2014/COCO_val2014_000000000042.jpg
# ./val2014/COCO_val2014_000000000073.jpg
# ...

ls ./test2014/*.jpg > test2014.txt

# however, when do the operations on train2014, will get the error message:
#   -bash: /bin/ls: Argument list too long
# one alternative is to use find below:
find ./train2014 -maxdepth 1 -name "*.jpg"  > train2014.txt

# Notes: 
# note that we sometimes we donot want the leading base path, using command below
find ./train2014 -maxdepth 1 -name "*.jpg"  -exec basename {} > train2014.txt \;
# thus, the files
# in train2014.txt:
# COCO_train2014_000000526810.jpg
# COCO_train2014_000000569433.jpg
# ...
