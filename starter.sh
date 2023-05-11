#! /bin/bash
echo -e 'Create a directory or make use of this directory? (Y/N): \c'
read response
trials=0
response=${response:0:1}
# CHECKS FOR A WRONG INPUT
while [ ${response^^} != "Y" -o ${response^^} != "N" ]
do  echo -e 'Please enter Y or Yes / No or N: \c'
    read response
    response=${response:0:1}
    trials=$((trials + 1))

    if [ $trials -eq 3 ]; then
      echo 'Script stopped'
      break
    fi
done

if [ ${response^^} == "Y" ]
then
  echo -e "Directory name: \c"
  read dirname
  local count=0

  # CHECKS FOR CONFLICTING DIRECTORY NAME
  while [ -e $dirname -a $count -lt 3 ]
  do  echo "Directory exits, use a new file name"
      count=$((count + 1))
      read -p "New directory name: " dirname

      if [ $trials -eq 3 ]; then
        echo -e 'You need to enter a new Directory name\n'
        break
      fi
  done
  
  mkdir $dirname && cd $dirname
  echo -e "Entry point file or use index.js? (Y/N): \c"
  read decide
  decide=${decide:0:1}
  if [ ${decide^^} == "Y" ]
  then
    read -p "Enter file name: " filename
    touch $filename | chmod a+x $filename

    echo -e "Default node project or use [--yes(-y)] flag? (Y/N): \c"
    read decision
    # WITHOUT -Y FLAG
    decision=${decision:0:1}
    if [ ${decision^^} == 'Y']
    then npm init

    # WITH -Y FLAG
    else
      npm init -y
      # --- CREATING A DEFAULT HTTP SERVER ----
      read -p "http server Or Express server Or You are good (H/E/O): " res
      if [ ${res^^} == "H" ]
      then  
        echo -e "const http = require("http");\n\nconst PORT = process.env.PORT || 5000\n\nserver = http.createServer((req, res) => {\n\tif (req.url == '/'){\n\t\tres.writeHead(200)\n\t\tres.end('Hello')\n\t}\n})\n\n\nserver.listen(PORT, () => console.log('server running on port: '+PORT))" >> $filename
      echo "run script"
      elif [ ${res^^} == "H" ]
      then  
        npm i express
        echo -e "const express = require("express");\nconst app = express()\n\nconst PORT = process.env.PORT || 5000\n\napp.get('/', (req, res) => {\n\tres.json({status: true, message: 'Server up and running'})})\n\n\nserver.listen(PORT, () => console.log('server running on port: '+PORT))" >> $filename
        echo "you are good to go"
      else
          echo "console.log('Hello, Welcome')" >> $filename
          echo "DONE"
          exit
      fi
    fi
  else
    touch index.js
    echo -e "Default node project or use [--yes(-y)] flag? (Y/N): \c"
    read decision
  fi
else
  exit
fi