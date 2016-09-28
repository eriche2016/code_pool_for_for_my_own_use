## example: keep my nn package up to date with nn original package
# if you get a copy, ignore the line below
# clone your foked nn
git clone https://github.com/eriche2016/nn

cd nn 
git remote add upstream
git remote add upstream https://github.com/torch/nn
git fetch upstream
git pull upstream master
# now you have update your local repository nn, then push it into your forked directory
git push origin master
