#du command will sumarize disk usage of each file, and recursively for directories:
        du -hs /path/to/directory 
        #-h means human readable, -s means summary 

# command will produce a list of all the folders in /path/to/folder:
        du -h --max-depth=1 /path/to/folder 

#~/.local or more precisely ~/.local/share is the place will store use data. the ~/.local also contains share/Trash, which is the trash bin, and they will be likely consumes a big margin of disk space. you can check the usage of it by the following command:
#    du -hs ~/.local/share/Trash
#if you donnot need to keep items in the trash , delete everything in share/Trash with:
#    rm -rf ~/.local/share/Trash


