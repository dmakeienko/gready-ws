# Information

This script will set up your workspace for comfortable work.

## Platform

Tested on: 

|    Platform      | Tested   |
|------------------|----------|
| **Ubuntu 16.04** |    ✓     |
| **Ubuntu 18.04** |    ✓     |
| **Ubuntu 19.04** |    ✓     |

# What is script for?
 
This script will set up your workspace for comfortable work.
### Packages that will be installed:

* **apt-transport-https \
    ca-certificates \
    curl \
    build-essential \
    software-properties-common**

* **Google Chrome** 
* **git, htop, mc**
* `(Optional)` [Tilix](https://gnunn1.github.io/tilix-web/)
* `(Optional)` [Docker](https://docs.docker.com/install/)
* `(Optional)` [VSCode](https://code.visualstudio.com/)
* `(Optional)` [Packer](https://www.packer.io/), [tfenv](https://github.com/tfutils/tfenv)

Also, script will install **zsh** with [oh-my-zsh](https://ohmyz.sh/).
You can disable installing **zsh shell** with option `-s bash` or omit this key.

## Command Line Options

Use **"-e"** to install VS Code

Use **"-d"** - to choose whether to install Docker

Use **"-t"** - to install Tilix

Use **"-u"** - to install devops tools (terraform, packer, AWS CLI v2 etc)

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
