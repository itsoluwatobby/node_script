#! /bin/bash
echo -e 'Create a directory or make use of this directory? (Y/N): \c'
read response

if [ ${response^^} == "Y" ]
then
  echo -e "Directory name: \c"
  read dirname
  count=0

  # CHECKS FOR CONFLICTING DIRECTORY NAME
  while [ -e $dirname -a $count -lt 3 ]
  do  echo "Directory exits, use a new file name"
      count=$((count + 1))
      read -p "New directory name: " dirname
  done
  if [ $count -eq 3 ]
  then echo -e 'You need to enter a new Directory name\n'
  else
    mkdir $dirname && cd $dirname
    echo -e "Entry point file or use index.js? (Y/N): \c"
    read decide
    if [ ${decide^^} == "Y" ]
    then
      read -p "Enter file name: " filename
      touch $filename | chmod a+x $filename

      # --- CREATING A DEFAULT HTTP SERVER ----
      read -p "httpserver boiler plate or You are good (Y/N): " res
      if [ ${res^^} == "Y" ]
      then  echo -e "const http = require("http");\n\nconst PORT = process.env.PORT || 5000\n\nserver = http.createServer((req, res) => {\n\tif (req.url == '/'){\n\t\tres.writeHead(200)\n\t\tres.end('Hello')\n\t}\n})\n\n\nserver.listen(PORT, () => console.log('server running on port: '+PORT))" >> $filename
      echo "run script"
      else
          echo "console.log('Hello, Welcome')" >> $filename
          echo "DONE"
      fi
    else
      touch index.js
      echo -e "Default node project or use [--yes(-y)] flag? (Y/N): \c"
      read decision
    fi
  fi
else
  exit
fi