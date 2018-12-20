# Information

**Main repo is on Gitlab** [gready-ws](https://gitlab.com/denys.makeienko/gready-ws)

# What is script for?
 
This script will prepare your workspace for comfortable work.
### Packages that will be installed:

* **apt-transport-https \
    ca-certificates \
    curl \
    build-essential \
    software-properties-common**

* **Google Chrome** 
* **git, htop, mc**
* `(Optional)` [Tilix](https://gnunn1.github.io/tilix-web/) or [Guake](https://github.com/Guake/guake)
* `(Optional)` [Docker](https://docs.docker.com/install/)
* `(Optional)` [VSCode](https://code.visualstudio.com/) or [Sublime Text 3](https://www.sublimetext.com/)

Also, script will install **zsh** with [oh-my-zsh](https://ohmyz.sh/) and add some usefull aliases. 
You can disable installing **zsh shell** with option `-s bash`

## Command Line Options

Use **"-e [ sublime | vscode ]"** to choose editor

Use **"-d"** - to choose whether to install Docker

Use **"-t [ guake | tilix ] "**- to choose which terminal do you prefer

Use **"-s [ zsh | bash ] "**- to choose which shell do you prefer



## How to

Download script and execute 

```
curl https://gitlab.com/denys.makeienko/gready-ws/raw/master/gready-ws.sh |bash -s -- -[option]
```

`OR`

download it manualy and run with any option you need
