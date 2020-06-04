################################################################################
# Copyright (c) IBM Corporation 2020
################################################################################

################################################################################
# Prerequisites:
#   Configure: variables in `env.cfg` for this script
#
#   This script will try to install the prerequisites:
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
#   ansible:
#           - Ansible playbooks are the scripts that generate the doc, thus
#             Ansible is needed.
#               $ https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#from-pip
#
# Description:
#   Set up a directory structures, clone the public python repository, build the
#   python package from source, install python, create an virtual enviroment and
#   install all the requirements needed to generate this sites documentation.
#
################################################################################

################################################################################
# Configure variables
################################################################################

if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "This script supports Mac, future versions could support other distributions."
    echo "Consider the following commands if you would like to build doc in a docker image."
    docker_ubuntu
    echo "Exiting without change to the system."
    exit 1
fi
source env.cfg

echo "This script will create and launch the enviroment to generte documentation."
echo "This script should only be run once, afterwards you can bring up the environment with the shell script \`./py-start-venv.sh\`."

echo "Checking to see if brew is installed."
if [[ $(command -v brew) == "" ]]; then
    # TODO: Do we need to export the path for brew install of git?
    # export PATH="/usr/local/bin:${PATH}"
    echo "Unable to find Homebrew,  will install Hombrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Discovered Home, will update Homebrew"
    brew update
fi

echo "Checking to see if Git is installed."
if [[ $(command -v git) == "" ]]; then
    echo "Unable to find Git, will install using Hombrew"
    brew install git
fi

echo "Checking to see if Openssl 1.1 is installed."
if [[ $(command -v command -v /usr/local/opt/openssl\@1.1/bin/openssl) == "" ]]; then
    echo "Unable to find Openssl 1.1, will install using Hombrew"
    brew install openssl
fi

# Create dir, clone Git python repo, checkout what is specified in $GIT_BRANCH_TAG
echo "Creating directory" $PY_HOME_DEV_GIT
mkdir -p $PY_HOME_DEV_GIT
cd $PY_HOME_DEV_GIT

echo "Cloning Python repository and checking out" $GIT_BRANCH_TAG
git clone git@github.com:python/cpython.git
cd cpython
git checkout $GIT_BRANCH_TAG

# Make dir for install, configure python build, make installation
echo "Creating Python install from source"
mkdir -p $PY_HOME
./configure --enable-optimizations --with-openssl=/usr/local/opt/openssl\@1.1/ --prefix=$PY_HOME
make
make install

# Create the virtual enviroment
echo "Creating reusable virtual Python environment"
$PY_HOME/bin/python3 -m venv $PY_HOME/venv

# Running a virtual environment (venv) from a script (source $PY_HOME/venv/bin/activate)
# runs in the current process and ends when the script ends, to do this headless
# we will use a subprocess. Similarly, we need to install the dependencies into
# the virutual enviroment so all this is done in the next line of code.
echo "Initializing Python virtual environment and installing all documentation generation dependencies"
/bin/bash -c ". $PY_HOME/venv/bin/activate; python3 --version; pip3 --version; pip3 install -r requirements.txt; exec /bin/bash -i"

################################################################################
# These commands need to be run in the virutal env, they are just for reference
################################################################################
# Install the requirements using the requirements.txt
#$PY_HOME/bin/pip3 install -r requirements.txt

# What is being installed through the requirments.txt
# $PY_HOME/bin/pip3 freeze
# $PY_HOME/bin/pip3 install Sphinx
# $PY_HOME/bin/pip3 install ansible-doc-extractor
# $PY_HOME/bin/pip3 install ansible


# List of commands to spin up and confifure a docker image
docker_ubuntu()
{
echo "docker pull ubuntu"
echo "docker run -it ubuntu /bin/bash"
echo "apt update"
echo "apt install software-properties-common"
echo "add-apt-repository ppa:deadsnakes/ppa"
echo "apt install python3.8"
echo "python3.8 --version"
echo "apt-get install git-core"
echo "apt-get install vim"
echo "apt-get install python3-venv"
echo "apt install iputils-ping"
echo "apt install python3-pip"
echo "mkdir -p /usr/py/venv"
echo "python3 -m venv /usr/py/venv/"
echo "pip3 install -r requirements.txt"
echo "mkdir /git"
echo "cd /git"
echo "ssh-keygen -t rsa -C \"your@gmail.com\""
echo "cat /root/.ssh/id_rsa.pub"
echo "Visit github.com > account > settings > SSH and GPG Keys  ( https://github.com/settings/keys ) > \"New SSH Key\""
echo "git clone git@github.com:ansible-collections/ibm_zos_core.git"
echo "cd /git/ibm_zos_core/docs"
echo "make html"
}


