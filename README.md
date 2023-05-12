# NODE.JS STARTER
#### This script gets you started with your node.js project with little or configuration. All you need to do is run the script.

```bash
  ./starter.sh option option
```
----
> _Included Flags_
* javascript ( j ) _**working**_
* typescript ( t ) _**in progress...**_
* javascript default ( j d ) _**in progress...**_
* typescript default ( t d ) _**in progress...**_
* default ( d ) _**in progress...**_

---
The default flag gets you started with your project in no time, with 5 default project folders 

> **DEFAULT FOLDERS**
1. controller
1. model
1. routes
1. helper
1. middleware

> **DEFAULT FILES**
1. .env
1. .gitignore >> [ includes the .env and node_modules ]
1. index.js > [ entry point can also be of your choosen ]

> How to: 
```bash
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
* [ ] Extension name isn't really necessary
* [x] Custom project folders


> FUNTIONS TREE
```
  main -- entry point
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
    |
  fileCreation
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
             |               ____checksWrongInput
      installDependencies---|
             |              |____clearShell
             |
             |                  _____clearShell       
  createProjectDirectories-----|
                               |_____checksWrongInput
```