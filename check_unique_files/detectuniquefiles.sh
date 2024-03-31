#!/bin/bash
#clean final report
#If you see this alerts:
#-------------------------ls: cannot access 'my_dir_1': No such file or directory----------------------------------
#-------------------------ls: cannot access 'my_dir_2': No such file or directory----------------------------------
# maybe you haven't catalogs and files for testing, you can uncomment next string! After that test catalogs and files will be created!
mkdir -p my_dir_1 my_dir_2 && cd my_dir_1 && touch file1.txt  file2.txt  file3.txt && cd .. && cd my_dir_2 && touch  file2.txt  file4.txt && cd ..
echo "" > compare.txt
# add filenames from catalog *my_dir_1* to file compare.txt
ls my_dir_1 >> compare.txt
# add filenames from catalog *my_dir_2* to file compare.txt
ls my_dir_2 >> compare.txt
#sort \ drop double \ output
echo | sort compare.txt | uniq | sed '/^$/d' > list.txt
#cat list.txt # uncomment if need first symbol string '#' for debug
for list in $(cat list.txt)
do
echo $list
echo ""
done
rm list.txt
rm compare.txt
