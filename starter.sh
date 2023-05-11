#! /bin/bash

## Author: OLUWATOBI AKINOLA SAMUEL
## Codename: itsoluwatobby
## Description: 
## Email: itsoluwatobby@gmail.com

echo -e 'Create a directory or make use of this directory? (Y/N): \c'
read response

checksWrongInput(){
  # CHECKS FOR A WRONG INPUT
  local userArg=$1

  while [ ${userArg} != "Y" -a ${userArg} != "N" ] || [ -z $userArg ]
  do  
      if [ $trials -eq 3 ]; then
        echo 'Script stopped'
        exit
      fi

      echo -e 'Please enter Y or Yes / No or N: \c'
      read userArg
      userArg=${userArg:0:1}
      userArg=${userArg^^}
      trials=$((trials + 1))
  done
}

## install dependencies
installDependencies(){
  local dependencies=$@
  npm i ${dependencies[@]}
}

trials=0
response=${response:0:1}
response=${response^^}

  # CHECKS FOR WRONG INPUT
  checksWrongInput $response

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

      if [ $trials -eq 3 ]; then
        echo -e 'You need to enter a new Directory name\n'
        break
      fi
  done
  
  mkdir $dirname && cd $dirname
  echo -e "Entry point file or use index.js? (Y/N): \c"
  # TODO: COMPLETE DEFAULT index.js
  read decide
  decide=${decide:0:1}
  decide=${decide^^}

  # CHECKS FOR WRONG INPUT
  checksWrongInput $decide

  if [ ${decide^^} == "Y" ]
  then
    read -p "Enter file name: " filename
    touch $filename | chmod a+x $filename

    echo -e "Default node project or use [--yes(-y)] flag? (Y/N): \c"
    read decision
    # WITHOUT -Y FLAG
    decision=${decision:0:1}
    decision=${decision^^}

    # CHECKS FOR WRONG INPUT
    checksWrongInput $decision

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