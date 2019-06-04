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

Also, script will install **zsh** with [oh-my-zsh](https://ohmyz.sh/).
You can disable installing **zsh shell** with option `-s bash` or omit this key.

## Command Line Options

Use **"-e [ sublime | vscode ]"** to choose editor

Use **"-d"** - to choose whether to install Docker

Use **"-t [ guake | tilix ] "**- to choose which terminal do you prefer

Use **"-s [ zsh | bash ] "**- to choose which shell do you prefer



## How to

Download script using `curl` (if present) or `wget` and execute.

Download with `curl`

```
curl -O https://gitlab.com/denys.makeienko/gready-ws/raw/master/gready-ws.sh
```

or with `wget`

```
wget https://gitlab.com/denys.makeienko/gready-ws/raw/master/gready-ws.sh
```

and run it
```
bash gready-ws.sh [-key] [value]
```
