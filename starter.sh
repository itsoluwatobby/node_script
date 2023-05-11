#! /bin/bash
echo -e 'Create a directory or make use of this directory? (Y/N): \c'
read response

if [ ${response^^} == "Y" ]
then
  echo -e "Give your directory a name: \c"
  read dirname
  mkdir $dirname && cd $dirname
  echo -e "Entry point file or use index.js? (Y/N): \c"
  read dic
  if [ ${dic^^} == "Y" ]
  then
    read -p "Enter file name: " filename
    touch $filename | chmod a+x $filename
    cat "console.log('Hello, Welcome')" >> $filename
    echo "DONE"
  else
    touch index.js
    echo -e "Default node project or use [--yes(-y)] flag? (Y/N): \c"
    read decision
  fi

else
  npm init -y
fi