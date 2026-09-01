git config --global user.name "cs242-test"
git config --global user.email "cs242@iitg.ac.in"
mkdir myproject
cd myproject
git init
git status
echo "int main(){printf("helloworld"); return 0;}" > hello.c
git add hello.c
git commit -m "First release of Hello World!"
git status -short
git commit -a -m "Updated hello.c with a new line"
mkdir ~/NewProjCopy
cp ~/NewProjCopy
GIT_WORK_TREE=
git chekout mypoject


