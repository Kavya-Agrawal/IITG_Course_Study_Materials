mkdir sccs_test
cd sccs_test
echo ’hello’ > quit.c
mkdir SCCS
sccs create quit.c
sccs edit quit.c
echo ’bye’ >> quit.c
sccs delta quit.c
