#! /bin/bash

## Author: OLUWATOBI AKINOLA SAMUEL
## Version: 1.0.0
## Codename: itsoluwatobby
## Description: A short project to help you get started with your node. js project
## Email: itsoluwatobby@gmail.com

# ------------- COLORS ---------------------
GREEN='\033[0;32m'  # green color
YELLOW='\033[0;33m'  # yellow color
RED='\033[0;31m' # red color
NC='\033[0m' # no color(nc)

checksWrongInput(){
  # CHECKS FOR A WRONG INPUT
  userArg=$1
  local trials=0

  while [[ "$userArg" != "Y" && "$userArg" != "N" || -z "$userArg" ]]
  do  
      if [ $trials -eq 3 ]; then
        echo 'Script stopped'
        exit
      fi

      echo -e 'Please enter Yes(Y) / No(N): \c'
      read userArg
      userArg="${userArg:0:1}"
      userArg="${userArg^^}"
      trials=$((trials + 1))
  done

  return 0
}

## CLEAR SHELL
clearShell(){
  read -p "Clear terminal? (Y/N): " isCleared
  isCleared=${isCleared:0:1}
  isCleared=${isCleared^^}
  [[ ${isCleared^^} == "Y" ]] && clear
}

## install dependencies
installDependencies(){
  read -p "Install dependencies? (Y/N): " installDecision
  installDecision=${installDecision:0:1}
  installDecision=${installDecision^^}

  checksWrongInput "$installDecision"
  installDecision="$userArg"
  # ////////////////////////////////////////
  if [ "${installDecision^^}" == 'Y' ]; then
    echo -e "Enter dependency names (separated by space)?: \c"
    read -r -a dependencies

    echo "Installing dependencies..."
    npm i ${dependenciesArray[@]}
    # wait
    
    clearShell
  fi
  echo -e "Installation completed"
}

## CREATE PROJECT
createProject(){
  echo -e "Creating project..."
  local filename=$1

  npm init -y &
  wait
  echo -e "Project initiated\n"
  
  # --- CREATING A DEFAULT HTTP SERVER ----
  echo -e "\nServer boiler plate option"
  echo -e "--------------------------\n"
  echo -e "http server (H)\nExpress server (E)\nYou are good (O)\nResponse (H | E | O): \c"
  read res
  if [ ${res^^} == "H" ]
  then
    echo -e "const http = require("http");\n\nconst PORT = process.env.PORT || 5000\n\nserver = http.createServer((req, res) => {\n\tif (req.url == '/'){\n\t\tres.writeHead(200)\n\t\tres.end('Hello')\n\t}\n\n\telse{\n\t\tres.writeHead(404)\n\t\tres.end('Resource not found')\n\t}\n})\n\n\nserver.listen(PORT, () => console.log('server running on port: ' + PORT))" >> $filename
    
    installDependencies &
    wait

    echo "Happy coding :)!!"
  elif [ ${res^^} == "E" ]
  then
    echo -e "const express = require("express");\nconst app = express()\n\nconst PORT = process.env.PORT || 5000\n\napp.get('/', (req, res) => {\n\tres.status(200).json({status: true, message: 'Server up and running'})\n})\n\n\napp.all('*', (req, res) => {\n\tres.status(200).json({status: true, message: 'Resource not found'})\n})\n\n\nserver.listen(PORT, () => console.log('server running on port: ' + PORT))" >> $filename
    
    installDependencies &
    wait

    echo "Happy coding :)!!"
  else
      echo "console.log('Hello, Welcome')" >> $filename
      echo "DONE"
      exit
  fi
}

fileNameChecker(){
  dirname=$1
  local count=0
  while [[ -e $dirname && $count -le 3 ]] || [ -z "$dirname" ]
  do
    if [ $count -eq 3 ]; then
      echo -e 'You need to enter a new File name\n'
      exit
    fi

    if [ -z "$dirname" ]; then
        echo "Name cannot be empty"
    else
      echo "Conflicting file name"
    fi

    count=$((count + 1))
    
    read -p "File name: " dirname

  done
}

fileCreation(){

  echo -e "Entry point file name or use index.js? (Y/N): \c"
  read decide

  decide=${decide:0:1}
  decide=${decide^^}

  # ------------------ CHECKS FOR WRONG INPUT -----------------
  checksWrongInput "$decide"
  decide="$userArg"

  if [ ${decide^^} == "Y" ]
  then
    read -p "Enter file name: " filename

    # ----------- CHECK FOR VALID FILENAME -----------------
    fileNameChecker "$filename"
    filename="$dirname"

    touch $filename .gitignore .env ; chmod a+x $filename
    echo -e "node_modules\n.env" >> .gitignore

    #------------------ CREATE PROJECT------------------
    createProject "$filename"
    
  else
    touch index.js .gitignore .env ; chmod a+x index.js
    echo -e "node_modules\n.env" >> .gitignore

    createProject "index.js"
  fi
}

createProjectDirectories(){
  clearShell
  read -p "Would you like to create extra directories? (Y/N):" extraDecision
  extraDecision=${extraDecision:0:1}
  extraDecision=${extraDecision^^}

  checksWrongInput "$extraDecision"
  extraDecision="$userArg"

  if [ "$extraDecision" == "Y" ]; then
    echo -e "Enter directory names (separated by space)?: \c"
    read -r -a directories
    mkdir "${directories[@]}"
    echo "${#directories[@]} folders: [${directories[@]}] successfully created"
    echo "Happy coding :)!!"
  else
    echo "Happy coding :)!!"
  fi
}

option() {
  echo -e 'Create a directory or make use of this directory? (Y/N): \c'
  read response

  response=${response:0:1}
  response=${response^^}

    # CHECKS FOR WRONG INPUT
    checksWrongInput "$response"
    response="$userArg"

  if [ ${response^^} == "Y" ]
  then
    echo -e "Directory name: \c"
    read dirname

    fileNameChecker "$dirname"
    
    mkdir $dirname && cd $dirname

    fileCreation
    createProjectDirectories
    exit
  else
    fileCreation
    createProjectDirectories
    exit
  fi

  return 0
}

formatChecker(){
  lang=$1
  local langOption=("javascript" "typescript")
  lang="${lang:0:1}"
  if [ "${lang,,}" == "${langOption[0]:0:1}" ];then
    echo -e "${YELLOW}Setup $entry node.js project...${NC}"
    option
  elif [ "${lang,,}" == "${langOption[1]:0:1}" ];then
      echo -e "${YELLOW}Setup $entry node.js project...${NC}"
    echo -e "${GREEN}Feature coming soon...${NC}"
    sleep 3
    exit
  fi
  return 0
}

# ------------- MAIN ENTRY POINT -----------------
main(){
  count=$1
  entry=$2
  [[ "$count" -gt 0 ]] && formatChecker "$entry" || option
}

main "$#" "$1"

# TODO: 1) O flag not taken care of. 
#       2) dependency installment not done
#       3) handle the file extension (if ext .js is missing, add it to it)
#       4) Add typescript project option


## Author: OLUWATOBI AKINOLA SAMUEL
## Version: 1.0.0
## Codename: itsoluwatobby
## Description: A short project to help you get started with your node.js project
## Email: itsoluwatobby@gmail.com
