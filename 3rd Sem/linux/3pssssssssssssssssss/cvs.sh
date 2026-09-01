#https://www.geeksforgeeks.org/cvs-command-in-linux-with-examples/


mkdir ~/cvs_root
export CVSROOT='/home/asahu/cvs_root'
mkdir cvs_test ; 
cd cvs_test
cvs -d /home/asahu/cvs_root init
echo 'myfile dummy contents'> myfile
cvs import -m "CVS START" cvs_file myfile start
cvs checkout cvs_file
cd cvs_file
mkdir cvs_file_1
cvs add cvs_file_1
cvs commit myfile
cvs update
cvs remove myfile
