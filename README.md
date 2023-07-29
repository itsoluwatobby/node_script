# NODE.JS STARTER
#### This script gets you started with your node.js project with little or configuration. All you need to do is run the script.

> Requirement
* npm
* node

BASH_VERSION = 5.1.16(1)-release

```bash
  ./starter.sh option option
```
----
> _Included Flags_
* help ( h )
* javascript ( j )
* typescript ( t )
* javascript default ( j d )
* typescript default ( t d )
* default ( d )

---
The default flag gets you started with your project in no time, with 5 default project folders 

> **DEFAULT FOLDERS**
1. controller
1. model
1. routes
1. helper
1. middleware
1. dist ---- for _**TYPESCRIPT**_
1. src ---- for _**TYPESCRIPT**_

> **DEFAULT FILES**
1. tsconfig.json ---- for _**TYPESCRIPT**_
1. .env
1. node_modules
1. .gitignore >> [ includes the .env and node_modules ]
1. index.js > [ entry point can also be of your choosen ]

> How to: 
```bash

  ./starter help OR ./starter h # Opens up the help page
  
  ./starter <option1> <option2>

  option1 includes: javascript/j, typescript/t, default/d, help/h (case insensitive)
  option2 includes: default/d (case insensitive)
  
  ./starter javascript default OR ./starter j d # creates a default Javascript server with an express server
  
  ./starter # returns a prompt to select your project type (js or ts)

  ./starter default # creates a default js server

  ./starter javascript # prompts you to create your js node server
  
  ./starter javascript default # creates a default js server

  ./starter typescript # prompts you to create your ts node server
  
  ./starter typescript default # creates a default ts server
```

---
> _FEATURES_

* [x] Creates project with a default http server
* [x] You get choose either an express or http server template
* [x] Typescript server template and config file
* [x] Javascript server template
* [ ] Option to open project folder
* [x] Extension name isn't really necessary
* [x] Custom project folders


> FUNCTIONS TREE
```
  main----entry point
    |
    |<---------helpFunction
    |
  optionCheck
    |___
    |   |
    |  noEntry
    |___|
    |  
  mainProgram
    |___
    |   |
    |  checksWrongInput
    |  fileNameChecker
    |___|
    |               ____indexFile
  fileCreation<----|
    |              |____defaultProject
    |___
    |   |
    |  checksWrongInput
    |  fileNameChecker
    |___| 
    |
  createProject
    |_________|
    |       tsConfigFile
    |                 |
  serverJsTemplate    |
    |                 |
    |             serverTsTemplate
    |_________________|
             |
             |
      dependencyHasLength
             |
             |               ____checksWrongInput
      installDependencies---|
             |              |____clearShell
             |
             |
          hasLength
             |
    hasConflicting_Dirnames
             |                  _____clearShell       
  createProjectDirectories-----|
                               |_____checksWrongInput
```