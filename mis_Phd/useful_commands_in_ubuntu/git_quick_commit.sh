# Shell script to directly add current
# folder and files to remote repository
# as initial commit, simply run the script
# and enter the git remote URL when prompt
# Use it, Modify it, Sell it :D
git init
git status
git add .
git commit -m "My first commit" 
git status
echo -n "Enter remote URL"
echo -n
read url
git remote add origin $url
git push -f origin master
