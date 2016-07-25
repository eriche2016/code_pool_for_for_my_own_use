# Notes on knowledge on computer stuff
## show package path installed in torch
In order to show the package where you store by using `luarocks install pack_name` command,  using:  
`luarocks show pack_name`

## install command without root priviledge
I donot have superuser priviledge on this sever, but this doesnot put restrictions on installing commandfor my own use.
ex, i want to instatll rar command, but i donnot have permission to use command like apt-get install rar, so
(1)i need to download the command files from website: 
http://www.rarlab.com/download.htm
then i put this file on folder: 
/home/hxw/Public/command_hxw/
then i untar the file:
(2) tar xzf rarlinux-x64-5.3.0.tar.gz

(3) then:
   cd rar 
   modify the makefile as: 

      PREFIX=/home/hxw/Public/command_hxw

      install:
        mkdir -p $(PREFIX)/bin
        mkdir -p $(PREFIX)/lib
        cp rar unrar $(PREFIX)/bin
        cp rarfiles.lst /home/hxw/Public/command_hxw/etc
        cp default.sfx $(PREFIX)/lib
  then make etc folder in /home/hxw/Public/command_hxw/etc
  and redirects to dir which makefile sites. 

(4) then run command:
    make install 

(5) then add  ~/.bashrc with the line: 

    export PATH=/home/hxw/Public/command_hxw/bin:$PATH 

(6) then 
    source .bashrc

now feel free to use your rar command 
