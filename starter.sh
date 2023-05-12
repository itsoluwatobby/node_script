#! /bin/bash

## Author: OLUWATOBI AKINOLA SAMUEL
## Version: 1.0.0
## Codename: itsoluwatobby
## Description: A short project to help you get started with your node. js project
## Email: itsoluwatobby@gmail.com

# ------------- COLORS ---------------------
RED='\033[0;31m' # red color
GREEN='\033[0;32m'  # green color
YELLOW='\033[0;33m'  # yellow color
BLUE='\033[0;34m'   # blue color
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # no color(nc)


checksWrongInput(){
  # CHECKS FOR A WRONG INPUT
  userArg=$1
  local trials=0

  while [[ "$userArg" != "Y" && "$userArg" != "N" || -z "$userArg" ]]
  do  
      if [ $trials -eq 3 ]; then
        echo -e "${RED}Script stopped${NC}"
        exit
      fi
      if [ $trials -eq 2 ];then
        echo -e "${RED}Please enter Yes(Y) / No(N): ${NC}\c"
      else
        echo -e 'Please enter Yes(Y) / No(N): \c'
      fi
      read userArg
      userArg="${userArg:0:1}"
      userArg="${userArg^^}"
      trials=$((trials + 1))
  done

  return 0
}

## CLEAR SHELL
clearShell(){
  echo -e "${RED}Clear terminal? (Y/N): ${NC}\c" 
  read isCleared
  isCleared=${isCleared:0:1}
  isCleared=${isCleared^^}
  [[ ${isCleared^^} == "Y" ]] && clear
}

## install dependencies
installDependencies(){
  clearShell
  local typescript=$1
  
  echo -e "\n${CYAN}Install dependencies? (Y/N): ${NC}\c"
  read installDecision
  installDecision=${installDecision:0:1}
  installDecision=${installDecision^^}

  checksWrongInput "$installDecision"
  installDecision="$userArg"
  # ////////////////////////////////////////
  if [ "${installDecision^^}" == 'Y' ]; then
    echo -e "Enter dependency names (separated by space)?: \c"
    read -r -a dependencies

    echo -e "${CYAN}\nInstalling dependencies...${NC}"
    if [[ "${#dependencies[@]}" -gt 0 ]];then
      
      if [ -z "$typescript" ];then
        for (( i=0; i < "${#dependencies[@]}"; i++ ));do
            npm i "${dependencies[i]}" &
            wait
        done
      else
        for (( i=0; i < "${#dependencies[@]}"; i++ ));do
            npm i "${dependencies[i]}" &
            wait
        done
        clear
        echo -e "${CYAN}\nInstalling types for dependencies...${NC}\n"
        for (( i=0; i < "${#dependencies[@]}"; i++ ));do
            npm i -D "@types/${dependencies[i]}" &
            wait
        done

        npm i --save-dev @types/node
      fi
    fi
    
    #clearShell
  fi
  [[ "${installDecision^^}" == "Y" ]] && echo -e "Installation completed"
}

serverJsTemplate(){
  local res=$1
  local filename=$2

  if [ ${res^^} == "H" ]
  then
    echo -e "const http = require("http");\n\nconst PORT = process.env.PORT || 5000\n\nserver = http.createServer((req, res) => {\n\tif (req.url == '/'){\n\t\tres.writeHead(200)\n\t\tres.end('Hello')\n\t}\n\n\telse{\n\t\tres.writeHead(404)\n\t\tres.end('Resource not found')\n\t}\n})\n\n\nserver.listen(PORT, () => console.log('server running on port: ' + PORT))" >> $filename
    
    installDependencies
  
    #echo -e "${GREEN}Happy coding :)!!${NC}"
  elif [ ${res^^} == "E" ]
  then
    echo -e "const express = require("express");\nconst app = express()\n\nconst PORT = process.env.PORT || 5000\n\napp.get('/', (req, res) => {\n\tres.status(200).json({status: true, message: 'Server up and running'})\n})\n\n\napp.all('*', (req, res) => {\n\tres.status(200).json({status: true, message: 'Resource not found'})\n})\n\n\nserver.listen(PORT, () => console.log('server running on port: ' + PORT))" >> $filename
    
    installDependencies

    #echo -e "${GREEN}Happy coding :)!!${NC}"
  else
      echo "console.log('Your Javascript Node.js Project is Ready')" >> $filename
      echo -e "${GREEN}Happy coding :)!!${NC}"
      exit
  fi
}

serverTsTemplate(){
  local res=$1
  local filename=$2

  if [ ${res^^} == "E" ];then
    echo -e "import express, { Request, Response } from \"express\";\nimport http from \"http\";\nconst app = express()\n\nconst PORT = process.env.PORT || 5000\n\nconst server = http.createServer(app)\n\napp.get('/', (req: Request, res: Response) => {\n\tres.status(200).json({status: true, message: 'Server up and running'})\n})\n\n\napp.all('*', (req: Request, res: Response) => {\n\tres.status(200).json({status: true, message: 'Resource not found'})\n})\n\n\nserver.listen(PORT, () => console.log('server running on port: ' + PORT))" >> src/$filename
    
    installDependencies "typescript"

    #echo -e "${GREEN}Happy coding :)!!${NC}"
  else
      echo "console.log('Your Typescript Node.js Project is Ready')" >> src/$filename
      echo -e "${GREEN}Happy coding :)!!${NC}"
      exit
  fi
}

## CREATE PROJECT
createProject(){
  echo "---------------------------------------------------------"
  echo -e "Creating project..."
  local filename=$1
  local typescript=$2

  if [ -z "$typescript" ];then
    npm init -y &
    wait
  else
    touch package.json
    echo -e "{\n   \"name\": \"dirname\",\n   \"version\": \"1.0.0\",\n   \"description\": \"\",\n   \"main\": \"filename\",\n   \"type\": \"module\",\n   \"scripts\": {\n     \"start\": \"tsc && node dist/filename\",\n     \"dev\": \"tsc && nodemon dist/filename\"\n   },\n   \"keywords\": [],\n   \"author\": \"\",\n   \"license\": \"ISC\"\n}" >> package.json
  fi
  echo -e "Project initiated\n"
  
  # --- CREATING A DEFAULT HTTP SERVER ----
  echo -e "${GREEN}Server boiler plate option${NC}"
  echo -e "--------------------------\n"
  if [ -z "$typescript" ];then
    echo -e "http server ----------------- (H)\nExpress server -------------- (E)\nYou are good ---------------- (O)\nResponse (H | E | O): \c"
    read res
  else
    echo -e "Express server -------------- (E)\nYou are good ---------------- (O)\nResponse (E | O): \c"
    read res
  fi

  if [ -z "$typescript" ];then
    serverJsTemplate "$res" "$filename"
  else
    serverTsTemplate "$res" "$filename"
  fi
}

fileNameChecker(){
  dirname=$1
  local count=0
  while [[ -e $dirname && $count -le 3 ]] || [ -z "$dirname" ]
  do
    if [ $count -eq 3 ]; then
      echo -e "${RED}You need to enter a new File name${NC}"
      exit
    fi

    if [ -z "$dirname" ]; then
        echo -e "${RED}Name cannot be blank${NC}"
    else
      echo -e "${RED}Conflicting file name${NC}"
    fi

    count=$((count + 1))
    
    read -p "File name: " dirname

  done
}

tsConfigFile(){
  echo -e "{\n   \"compilerOptions\": {\n     \"target\": \"ES6\",\n     \"module\": \"NodeNext\",\n     \"sourceMap\": true,\n     \"outDir\": \"dist\",\n     // \"strict\": true,\n     \"skipLibCheck\": true,\n     \"esModuleInterop\": true\n   },\n   \"include\": [\n     \"types.d.ts\",\n     \"src/**/*\"\n   ],\n   \"exclude\": [\"node_modules\"]\n}" >> tsconfig.json

  return 0
}

fileCreation(){
  local typescript=$1

  if [ -z "$typescript" ];then
    echo -e "Entry point file name or use index.js? (Y/N): \c"
    read decide
  else
    mkdir src dist

    echo -e "Entry point file name or use index.ts? (Y/N): \c"
    read decide
  fi

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

    # ------------- CHECK FOR (.js) EXTENSION -----------------
    if [[ -n "$typescript" && "${filename: -3}" == ".ts" ]];then
      filename=${filename}
    elif [ "${filename: -3}" == ".js" ];then
      filename=${filename}
    else
      [[ -z "$typescript" ]] && filename="${filename}.js" || filename="${filename}.ts"
    fi

    if [ -z "$typescript" ];then
      touch $filename .gitignore .env README.md
      echo -e "node_modules\n.env" >> .gitignore
      createProject "$filename"
    else
      touch src/$filename .gitignore .env README.md tsconfig.json
      echo -e "node_modules\n.env" >> .gitignore
      tsConfigFile
      createProject "$filename" "ts"
    fi

  else
    if [ -z "$typescript" ];then
      touch index.js .gitignore .env
      echo -e "node_modules\n.env" >> .gitignore
      createProject "index.js"
    else
      touch src/index.ts .gitignore .env README.md tsconfig.json
      echo -e "node_modules\n.env" >> .gitignore
      tsConfigFile
      createProject "index.ts" "ts"
    fi

  fi
}

createProjectDirectories(){
  clearShell
  local typescript=$1
  local defaultDirectories=("controller" "middleware" "routes" "helpers" "models")

  read -p "Would you like to create extra directories? (Y/N):" extraDecision
  extraDecision=${extraDecision:0:1}
  extraDecision=${extraDecision^^}

  checksWrongInput "$extraDecision"
  extraDecision="$userArg"

  if [[ "$extraDecision" == "Y" && -z "$typescript" ]]; then
    echo -e "Enter directory names (separated by space)?: \c"
    read -r -a directories
    mkdir "${directories[@]}"
    echo "${#directories[@]} folders: [${directories[@]}] successfully created"
    echo -e "${GREEN}Happy coding :)!!${NC}"

  elif [ "$extraDecision" == "N" ];then
    echo -e "${GREEN}Happy coding :)!!${NC}"
  
  elif [[ "$extraDecision" == "Y" && -n "$typescript" ]]; then
    echo -e "Enter directory names (separated by space)?: \c"
    read -r -a directories
    cd src
    mkdir "${directories[@]}"
    echo "${#directories[@]} folders: [${directories[@]}] successfully created"
    echo -e "${GREEN}Happy coding :)!!${NC}"

  elif [ -n "$typescript" ]; then
    cd src
    mkdir "${defaultDirectories[@]}"
    echo "${#defaultDirectories[@]} folders: [${defaultDirectories[@]}] successfully created"
    echo -e "${GREEN}Happy coding :)!!${NC}"

  elif [[ -z "$typescript" || "$extraDecision" != "Y" ]]; then
    mkdir "${defaultDirectories[@]}"
    echo "${#defaultDirectories[@]} folders: [${defaultDirectories[@]}] successfully created"
    echo -e "${GREEN}Happy coding :)!!${NC}"
  
  #------------ HANDLE THIS LATER --------------------------
  elif [ "$default" == "D" ]; then
    if [ -n "typescript" ]; then
      cd src
      mkdir "${defaultDirectories[@]}"
      echo "${#defaultDirectories[@]} folders: [${defaultDirectories[@]}] successfully created"
      echo -e "${GREEN}Happy coding :)!!${NC}"
      exit
    fi
    mkdir "${defaultDirectories[@]}"
    echo "${#defaultDirectories[@]} folders: [${defaultDirectories[@]}] successfully created"
    echo -e "${GREEN}Happy coding :)!!${NC}"

  fi
}

mainProgram() {
  local typescript=$1
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

    fileCreation "$typescript"
    createProjectDirectories "$typescript"
    exit
  else
    fileCreation "$typescript"
    createProjectDirectories "$typescript"
    exit
  fi

  return 0
}

optionChecks(){
  lang=$1
  local default=$2
  local langOption=("javascript" "typescript" "default")
  lang="${lang:0:1}"

  #--------------------- JS ------------------------
  if [[ "${lang,,}" == "${langOption[0]:0:1}" && -z $default ]];then
    echo -e "${YELLOW}Setting up ${langOption[0]} node.js project...${NC}"
    mainProgram

  #--------------------- TS ------------------------
  elif [[ "${lang,,}" == "${langOption[1]:0:1}" && -z $default ]];then
      echo -e "${YELLOW}Setting up ${langOption[1]} node.js project...${NC}"
      mainProgram "ts"
    echo -e "${GREEN}Feature coming soon...${NC}"
    sleep 3
    exit

  #--------------------- DEFAULT JS ------------------------
  elif [[ "${default,,}" == "${langOption[2]:0:1}" && "${lang,,}" == "${langOption[0]:0:1}" ]];then
      echo -e "${YELLOW}Setting up a default ${langOption[0]} node.js project...${NC}"
    echo -e "${GREEN}Feature coming soon...2${NC}"
    sleep 3
    exit

  #--------------------- DEFAULT TS ------------------------
  elif [[ "${default,,}" == "${langOption[2]:0:1}" && "${lang,,}" == "${langOption[1]:0:1}" ]];then
      echo -e "${YELLOW}Setting up a default ${langOption[1]} node.js project...${NC}"
    echo -e "${GREEN}Feature coming soon...1${NC}"
    sleep 3
    exit

  #--------------------- DEFAULT JS ------------------------
  elif [[ "${default,,}" == "${langOption[2]:0:1}" && -z "${lang}" ]] || [ "${lang,,}" != "${langOption[0]:0:1}" ] || [ "${lang,,}" != "${langOption[1]:0:1}" ];then
      echo -e "${YELLOW}Setting up a default ${langOption[0]} node.js project...${NC}"
    echo -e "${GREEN}Feature coming soon...3${NC}"
    sleep 3
    exit

  fi
  return 0
}

noEntry(){
  entry=""
  echo -e "Please what node.js project do you want \n${GREEN}Javascript ---- (J)${NC}\n${BLUE}Typescript ---- (T)${NC}"
  read -p "Option: " langType
  entry="$langType"
}

default=$1
entry=$2
default="${default:0:1}"
default="${default^^}"

# ------------- MAIN ENTRY POINT -----------------
main(){
  local count=$1
  local entry=$2
  local default=$3
  if [ "$count" == 2 ];then
    optionChecks "$default" "$entry"
  elif [[ "$count" -gt 0 ]];then 
    optionChecks "$entry"
  else
    noEntry
    optionChecks "$entry"
    mainProgram
  fi
}

  #----------- CREATES A JAVASCRIPT/TYPESCRIPT PROJECT ----------------
if [ -z "$default" ];then
  main "$#" "$default"

  #----------- CREATES A DEFAULT PROJECT ----------------
  #&& "$default" == "D" 
elif [[ "$#" -eq 2 ]];then
  main "$#" "$entry" "$default"

  #----------- CREATES A DEFAULT PROJECT ----------------
elif [[ "$#" -eq 1 && "$default" == "D" ]];then
  main "$#" "$default"

  #----------- CREATES A JAVASCRIPT/TYPESCRIPT PROJECT ----------------
elif [[ "$#" -eq 1 && "$default" != "J" ]] || [ "$default" != "T" ];then
  main "$#" "$default"

  #----------- INVALID INPUT ----------------
elif [ "$#" -gt 2 ];then
  echo -e "${RED}Unexpected input${NC}"
  exit
fi


# TODO:###########1) O flag not taken care of.#######################
##################2) dependency installment not done#################
##################3)extension (add ext .js is missing)###############
##################4) Add typescript project option###################
##################5) Prompt to select project type###################
#       6) Option to open project folder

##---------------------- DEFAULT FLAG --------------------------
#       5) default - creates your progect auomatically without any prompt
##########6) javascript - for javascript project option###############
##########7) typescript - for typescript project option###############


## Author: OLUWATOBI AKINOLA SAMUEL
## Version: 1.0.0
## Codename: itsoluwatobby
## Description: A short project to help you get started with your node.js project
## Email: itsoluwatobby@gmail.com
