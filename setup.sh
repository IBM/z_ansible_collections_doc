################################################################################
# Copyright (c) IBM Corporation 2020
################################################################################

################################################################################
# Usage:
#   Optionally configure variables in `env.cfg` for this script, else accept
#   the defaults
#
# Description:
#   This script can run with our with the clone of the repository. Its purpose
#   is to ensure that the dependencies are installed needed to generate
#   documentation using tooling such as Sphinx, Sphnix-version and
#   ansible-extract all while reading dynamic and static restructured text.
#
#   If the dependencies are not met below, the script will try to install them
#   based on whether you have Python installed or not as well as the operating
#   system type.
#
#   Note: Currently the only fully supported operating system to install
#   dependencies is Mac OSX. If you have  the dependencies installed, you can
#   run this for any operating system.
#
# Dependencies:
#   Git:
#           - installed and configured
#               $ see https://git-scm.com/download/mac
#           - install using xcode:
#               $ xcode-select --install; git --version
#           - install using homebrew:
#               $ brew install git; git --version
#           - binary install:
#               $ https://sourceforge.net/projects/git-osx-installer/
#           - After installing git ensure  you configure:
#               $ git config --global user.name “your_github_username”
#               $ git config --global user.email "your_email@github.com"
#   openssl:
#           - Openssl is used to configure the Python installation. Easiest
#             approach is to use brew, which will install it at
#             location `/usr/local/opt/openssl@1.1`
#               $ brew install openssl
#           - Optionally you can follow this tutorial and install it from the
#             archive `openssl-1.1.1b.tar.gz`
#               $ https://help.dreamhost.com/hc/en-us/articles/360001435926-Installing-OpenSSL-locally-under-your-username
#   Ansible:
#           - Ansible playbooks are the scripts that generate the doc, thus
#             Ansible is needed.
#               $ https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#from-pip
#
################################################################################

################################################################################
# Configure variables
################################################################################


# Detect the OS and call the appropriate python source build function.
os_detection_python_source_build()
{
    echo "Detecting operating system type to determine if eligible to build Python from source."

    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Detected Mac OSX, will build Python frome source."
        mac_python_source_build
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Detected Linux distribution, build from Python source is unsupported."
        unsupported_python_source_build
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        echo "Detected POSIX emulator for Windows, build from Python source is unsupported."
        unsupported_python_source_build
    elif [[ "$OSTYPE" == "msys" ]]; then
        echo "Detected Linux Shell for Windows distribution, build from Python source is unsupported."
        unsupported_python_source_build
    elif [[ "$OSTYPE" == "win32" ]]; then
            echo "Windows shell detected, unsupported"
        echo "Detected Windows distribution, build from Python source is unsupported."
        unsupported_python_source_build
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        echo "Detected Unix distribution, build from Python frome source is unsupported."
        unsupported_python_source_build
    else
        echo "Unable to determine operating system type."
        unsupported_python_source_build
    fi
}

# As more supported OS builds are added, propagate this function and replace
# the prefix 'unsupported_' with something like "debian_", ie `debian_python_source_build()`
unsupported_python_source_build()
{
    echo "Unsupported operating system."
    echo "Consider the following commands if you would like to build in an Ubuntu docker image."
    ubuntu_docker_commands
    echo "Exiting without change to the system."
    exit 1
}

mac_python_source_build()
{
    if [[ $(command -v /usr/local/opt/openssl\@1.1/bin/openssl) == "" ]]; then
        echo "Building Python from source requires Openssl 1.1 be installed, checking dependencies."
        echo "Unable to find Openssl 1.1, will use Homebrew to install Openssl 1.1."

        # Check and if needed install Homebrew
        install_homebrew

        echo "Updating Homebrew with latest packages to ensure successful installation of Openssl."
        brew update

        echo "Installing Openssl with Homebrew."
        brew install openssl
    fi

    # Check for git as someone may have downloaded this script without cloning the repository so they may not have Git
    if [[ $(command -v git) == "" ]]; then
        echo "Building Python from source requires Git be installed, checking dependencies."
        echo "Unable to find Git, will use Homebrew to install Git."

        # Check and if needed install Homebrew
        install_homebrew

        echo "Installing Git with Homebrew."
        brew install git
    fi

    # Create directory to clone the Git Python repository configured in env.cfg
    echo "Creating directory $PY_HOME to clone the Git Python repository."
    mkdir -p $PY_HOME
    cd $PY_HOME

    # Clone the public Python Git repo
    echo "Cloning Git Python repository into directory $PY_HOME/cpython "
    git clone git@github.com:python/cpython.git
    cd cpython

    # Checkout the Python version configured in env.cfg
    echo "Checking out Git Python version $PY_VERSION"
    git checkout tags/v$PY_VERSION

    # Make a directory for the Python installation and build
    echo "Creating directory $PY_HOME/$PY_VERSION Python install from source."
    mkdir -p $PY_HOME/$PY_VERSION

    echo "Configuring and building Python from source, this will take a while."
    ./configure --enable-optimizations --with-openssl=/usr/local/opt/openssl\@1.1/ --prefix=$PY_HOME/$PY_VERSION

    echo "Installing Python fronm source into directory $PY_HOME/$PY_VERSION."

    make
    make install

    echo "Completed cloning Git Python, bulding and installing from source."

    # CD back to where we started
    cd $PWD
}

# Installs Homebrew
install_homebrew()
{
    if [[ $(command -v brew) == "" ]]; then
        echo "Building Python from source requires some dependencies installed with Homebrew, chekcking for Homebrew."
        echo "Unable to find Homebrew,  will install Hombrew."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

# Builds a virtual Python installation 
python_venv_build()
{
    # A Python verson was passed into the function
    if [[ -n "$1" ]]; then
        # This uses Python version this script detected
        PY_VERSION=$1
    fi

    # A Python installation path was passed into the function
    if [[ -n "$2" ]]; then
        # This uses Python installation path this script detected
        PY_EXE=$2
    else
        # Use the python from the source build
        PY_EXE=$PY_HOME/$PY_VERSION/bin/python3
    fi

    echo "Creating directory for Python virtual environment at $PY_VENV_HOME/$PY_VERSION/venv."
    mkdir -p $PY_VENV_HOME/$PY_VERSION/venv

    echo "Creating virtual Python environment using Python $PY_HOME"
    $PY_EXE -m venv $PY_VENV_HOME/$PY_VERSION/venv
}

# Launches and configures the Python virtual environment will all dependencies
python_launch_venv()
{
    # Running a virtual environment (venv) from a script (source $PY_HOME/venv/bin/activate)
    # runs in the current process and ends when the script ends, to do this headless
    # we will use a subprocess. Similarly, we need to install the dependencies into
    # the virutual enviroment, all this is done in this function
    echo "Initializing Python virtual environment and installing all documentation dependencies."
    echo "To exit the Python virtual enviroment type 'exit' and press return."
    echo "To luanch the virutual enviroment again, there are 2 options:"
    echo "   1) Run the shell script included with the z_ansible_collections_doc repository: \`./py-start-venv.sh\`. and when you want to end the virtual enviroment, type 'exit'. and press enter."
    echo "   2) Run the command $PY_VENV_HOME/$PY_VERSION/venv/bin/activate and when you want to end the virtual enviroment, type 'deactivate' and press enter."

    if [[ -f "requirements.txt" ]]; then
        cp requirements.txt $PY_VENV_HOME/$PY_VERSION/venv
    else
        # Generate a requirements.txt based on static content in this script
        generate_static_requirements_txt
    fi

    #/bin/bash -c ". $PY_HOME/venv/bin/activate; python3 --version; pip3 --version; pip3 install -r $PY_HOME/requirements.txt; exec /bin/bash -i"
    /bin/bash -c ". $PY_VENV_HOME/$PY_VERSION/venv/bin/activate; touch $PY_VENV_HOME/$PY_VERSION/venv/remove_dep.txt; pip3 freeze>$PY_VENV_HOME/$PY_VERSION/venv/remove_dep.txt; if [[ -s diff.txt ]]; then pip3 uninstall -r $PY_VENV_HOME/$PY_VERSION/venv/remove_dep.txt -y; fi ; rm -rf $PY_VENV_HOME/$PY_VERSION/venv/remove_dep.txt; pip3 install -r $PY_VENV_HOME/$PY_VERSION/venv/requirements.txt; exec /bin/bash -i"
}

# List of commands to spin up and confifure a docker image, this is work in
# progress TODO list but believe this set of commands will get you going
ubuntu_docker_commands()
{
    echo "List of commands and instructions to build a Ubuntu docker container."
    echo ""
    echo "$ docker pull ubuntu"
    echo "$ docker run -it ubuntu /bin/bash"
    echo "$ apt update"
    echo "$ apt install software-properties-common"
    echo "$ add-apt-repository ppa:deadsnakes/ppa"
    echo "$ apt install python3.8"
    echo "$ python3.8 --version"
    echo "$ apt-get install git-core"
    echo "$ apt-get install vim"
    echo "$ apt-get install python3-venv"
    echo "$ apt install iputils-ping"
    echo "$ apt install python3-pip"
    echo "$ mkdir -p /usr/py/venv"
    echo "$ python3 -m venv /usr/py/venv/"
    echo "$ pip3 install -r requirements.txt"
    echo "$ mkdir /git"
    echo "$ cd /git"
    echo "Authorize your ssh key to Github if this is the first time your container is connecting to Github:"
    echo "$ ssh-keygen -t rsa -C \"your@gmail.com\""
    echo "$ cat /root/.ssh/id_rsa.pub"
    echo "Copy the contents of /root/.ssh/id_rsa.pub to Github."
    echo "Visit github.com > account > settings > SSH and GPG Keys  ( https://github.com/settings/keys ) > \"New SSH Key\""
    echo "Now you can clone the z_ansible_collections_doc repository"
    echo "$ git clone git@github.com:IBM/z_ansible_collections_doc.git"
    echo "$ ansible-playbook -i inventory site-builder.yml --ask-vault-pass"
}

# The requirements.txt should really be gotten from the respository, can't
# ensure this static copy will always be updated but for those who want to run
# without the overhead of a repo clone, this should suffice
generate_static_requirements_txt()
{
    echo "Generating requirments from static script content."
    echo "Next time use the requirements.txt included with repo https://github.com/IBM/z_ansible_collections_doc ."
    touch $PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "alabaster==0.7.12">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "ansible==2.9.5">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "ansible-doc-extractor==0.1.2">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "appdirs==1.4.3">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "astroid==2.2.5">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "Babel==2.8.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "certifi==2020.4.5.1">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "cffi==1.14.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "chardet==3.0.4">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "click==7.1.2">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "colorclass==2.2.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "cryptography==2.8">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "distlib==0.3.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "docutils==0.16">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "filelock==3.0.12">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "idna==2.9">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "imagesize==1.2.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "isort==4.3.15">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "Jinja2==2.11.2">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "lazy-object-proxy==1.3.1">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "MarkupSafe==1.1.1">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "mccabe==0.6.1">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "mdToRst==1.1.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "packaging==20.3">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "pathspec==0.7.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "pycodestyle==2.5.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "pycparser==2.20">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "Pygments==2.6.1">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "pylint==2.3.1">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "pyparsing==2.4.7">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "pytz==2020.1">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "PyYAML==5.3">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "requests==2.23.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "rstcheck==3.3.1">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "six==1.14.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "snowballstemmer==2.0.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "Sphinx==3.0.3">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "sphinx-jinja==1.1.1">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "sphinx-rtd-theme==0.4.3">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "sphinx-versions==1.0.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "sphinxcontrib-applehelp==1.0.2">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "sphinxcontrib-devhelp==1.0.2">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "sphinxcontrib-htmlhelp==1.0.3">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "sphinxcontrib-jsmath==1.0.1">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "sphinxcontrib-qthelp==1.0.3">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "sphinxcontrib-serializinghtml==1.1.4">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "typed-ast==1.4.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "urllib3==1.25.9">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "virtualenv==20.0.15">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "voluptuous==0.11.7">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "wrapt==1.11.1">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
    echo "yamllint==1.21.0">>$PY_VENV_HOME/$PY_VERSION/venv/requirements.txt
}


################################################################################
# MAIN
################################################################################

PWD=`pwd`

# ------------------------------------------------------------------------------
# Avoid expanding aliases, if your Python is aliased in your profile, you could
# enable this step, just don't count on this for all users systems.
# ------------------------------------------------------------------------------
# shopt -s expand_aliases
# source ~/.bash_profile

# Source configurations
source env.cfg

# A user could be executing this script wihout an env.cfg so lets populate with a default
if [[ -z "$PY_HOME" ]]; then
    PY_HOME=~/git/python
fi

# A user could be executing this script wihout an env.cfg so lets populate with a default
if [[ -z "$PY_VERSION" ]]; then
    PY_VERSION=3.8.3
fi

# A user could be executing this script wihout an env.cfg so lets populate with a default
if [[ -z "$PY_VENV_HOME" ]]; then
    PY_VENV_HOME=~/.venv
fi

echo "Checking host for a Python installation."
PYTHON_VERSION=`python -c 'import sys; version=sys.version_info[:3]; print("{0}.{1}.{2}".format(*version))'`

if [[ -n "$PYTHON_VERSION" ]]; then
    echo "Detected Python version $PYTHON_VERSION on host."

    if [[ "$PYTHON_VERSION" > "3.7.0" ]]; then
        echo "Evaluating host Python installation."
        PYTHON_VERSION_PATH=`python -c 'import sys; print(sys.executable)'`

        if [[ $(command -v $PYTHON_VERSION_PATH --version) == "" ]]; then
            echo "Unable to find executible for Python version $PYTHON_VERSION, will continue installtion and Python from source."

            os_detection_python_source_build
            python_venv_build
            python_launch_venv
        else
            echo "Successful evaluation of Python version $PYTHON_VERSION, will create Python virtual environment from installation path $PYTHON_VERSION_PATH."

            python_venv_build $PYTHON_VERSION $PYTHON_VERSION_PATH
            python_launch_venv
        fi
    else
        echo "Python version $PYTHON_VERSION on host does not meet the minimum Pythion version 3.7.0 needed for documentation generation."
        echo "Will continue installtion and build Python from source."
        os_detection_python_source_build
        python_venv_build
        python_launch_venv
    fi
else
    # No Python on host, install python from source, build it and virtualize it
    echo "Unable to detect Python installed on system, will install Python from source."
    os_detection_python_source_build
    python_venv_build
    python_launch_venv
fi