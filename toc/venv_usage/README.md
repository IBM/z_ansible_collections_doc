<!-- Breadcrumbs -->
[Home](../README.md) ▸ [Python Virtual Environment](README.md)

## Setup a Python virtual environment for generating documentation

A Python virtual enviroment option is available using the `setup.sh` script that will include
everything needed to build, generate and publish documentation for the
**Red Hat Certified Content for IBM Z** offering.  


The Python virtual environment option does not differ much from the Containerized option,
yet there a number of reasons to use the container over the Python virtual environment:  
- A venv is lightweight, eas to setup, simple to use, and local to the host.  
- Smaller in size in comparison to a container.  

With either solution (containerized or virtual environments), building, generating and
publishing documentation will be the same process.

If you continue on through this tutorial, then you have elected to use a Python virtual
environment to generate documetation and will pass on the containerized solution. 

## 1.0 Clone the repository
Begin by cloning the repository, this assumes you have a GitHub id. When you clone the
repository, it will create a directory named `z_ansible_collections_doc`, this is a good
time to decide where you want managed your cloned repositories, for example you might want
to have this directory structure `~/gh/` which will yield `~/gh/z_ansible_collections_doc`.

Clone the repository with the command:
```
git clone https://github.com/IBM/z_ansible_collections_doc.git
```

## 2.0 Setup the Python Virtual Environment
Next, set up the virtual enviroment, if you are experiended in setting up virtual environments
you can do so using the requirements file but you must review the requirements section before
you try to install any dependencies. 

### 2.1 Requirements
The depdencies are currently frozen to particulare versions, this is purposely done until some
bugs are patched in some of the dependencies peventing newer dependencies from being used. 

Because of the frozn dependency versions, the Python virtual environment must be based on
Python 3.9.x, no later or earlier versions can be used. If you are on a mac, you can use
brew to install Python 3.9 which typically installs it in directory `/opt/homebrew/bin`. 

You can use brew commmand:
```
brew install python@3.9
```

### 2.2 Configuration
In an upcoming step you will use the  `./setup.sh` script to create the Python virtual environment
and install the dependencies into the virtual environment. To do so, you may have to instruct
the script where to find the Python 3.9 installation by modifying `env.cfg`.

If you do not know where Python 3.9 is installed, you can use the brew command to find this or
run the `./setup.sh` script and it will list all the Python versions and the respective paths.

Using `setup.sh`:
```
./setup.sh
```

Yiedls:
```
[INFO] Detecting python installations, the latest version will be used to create the venv.
[INFO] Discovered python Version=3.9.6, Path=/usr/bin/python3.
[INFO] Discovered python Version=3.9.19, Path=/opt/homebrew/bin/python3.9.
[INFO] Discovered python Version=3.10.14, Path=/opt/homebrew/bin/python3.10.
[INFO] Discovered python Version=3.11.9, Path=/opt/homebrew/bin/python3.11.
[INFO] Discovered python Version=3.12.4, Path=/opt/homebrew/bin/python3.12.
[INFO] Discovered python Version=3.12.4, Path=/opt/homebrew/bin/python3.12.
[INFO] Discovered python Version=3.12.4, Path=/opt/homebrew/bin/python3.12.
[ERROR] This installation has only been tested with Python version 3.9, you must use this version.
[ERROR] This intallation has either detected or been configured to use usupported version 3.12.4.
[ERROR] If you have more than one version of python installed, set the environment variable 'PYTHON_EXE_PATH' in 'env.cfg' to a supported Python version.
```

From the `setup.sh` you can see that it has discovered Python 3.9 at `Path=/opt/homebrew/bin/python3.9`.
You will also noticed the ERROR messages that it has detected the system python being version `3.12.4` 
and is instructiong you to change configuration file `env.cfg`, variable `PYTHON_EXE_PATH` with the
path to Python 3.9 which would then look like:

```
PYTHON_EXE_PATH="/opt/homebrew/bin/python3.9"
```

If you want to use brew to find the installation path, run the command:
```
brew info python@3.9
```

Yields:
```
==> python@3.9: stable 3.9.22 (bottled)
...
.....
==> Caveats
Python is installed as
  /opt/homebrew/bin/python3.9
```

### 2.3 Build the Python virtual environment
Once you have install the requirements and configured `env.cfg` as needed, you can use the script
`setup.sh` to install the Python virtual environment and all its dependencies by running:

```
./setup.sh
```

Yields (truncated to reduce the verbosity):
```
[INFO] Creating virtual Python environment using Python /opt/homebrew/bin/python3.9
[INFO] Initializing Python virtual environment and installing all documentation dependencies.
Collecting alabaster==0.7.16 (from -r /tmp/z_ansible_collections_doc/venv/3.9.19/requirements.txt (line 1))
...
....
Installing collected packages: wrapt, webencodings, voluptuous, typing-extensions, sphinx-jinja, ....
```

### 2.4 Validate the Python virtual environment
Once the `setup.sh` is complete, you can start your Python virtual environment, if you are
inexperienced doing so, a script has been provided to simplify the starting of the Python
virtual environment. 

To start the environment, run the script:
```
./py-venv.sh
```

Yeilds:
```
Starting virtual environment.
To exit the virtual enviroment, type the terminal command 'exit' and press return.

The default interactive shell is now zsh.
To update your account to use zsh, please run `chsh -s /bin/zsh`.
For more details, please visit https://support.apple.com/kb/HT208050.
(3.9.19) exit
exit
/tmp/z_ansible_collections_doc $: ./py-venv.sh
Starting virtual environment.
To exit the virtual enviroment, type the terminal command 'exit' and press return.
```

Now you are ready to begin generating documentation. 
