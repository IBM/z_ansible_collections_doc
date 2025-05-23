#!/bin/sh

################################################################################
# Copyright (c) IBM Corporation 2020, 2023
################################################################################

################################################################################
# Usage:
#   Optionally configure variables in `env.cfg` for this script, else accept
#   the defaults
#
# Description:
#   This script is depended on this repository. Its will build a Python
#   virtual environment (venv) suitable for generating documentation for
#   Red Hat® Ansible Certified Content for IBM Z. The venv will contaion
#   the necessary dependencies to generate documentation uch as Sphinx and
#   ansible-extract.
#
################################################################################

################################################################################
# Configure variables
################################################################################

PYTHON_VERSION="0"

# Normalize the version from 3.10.13 to 3010013000 so it can be used for comparison.
# This will prefix each integer with up to 3 zero's so 10 -> 010, 13 -> 013
# so 3.10.13 translates:
#  3 - no impact, its after the decimal
# 10 - gets converted to 010
# 13 - gets converted to 013
# 000 - comes from the last printf octet
normalize_version() {
    echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }';
    exit
}

normalize_version_major_minor() {
    echo "$@" | awk -F. '{ printf("%d%03d\n", $1,$2); }';
    exit
}

# Search PATH for known python installations and add some other known paths
find_in_path() {
    result=""
    # Temporary patch to aid those who might not have all pythons in path.
    OTHER_PYTHON_PATHS="/Library/Frameworks/Python.framework/Versions/Current/bin:/opt/homebrew/bin:"
    PATH="${OTHER_PYTHON_PATHS}${PATH}"
    IFS=:
    for x in $PATH; do
        if [ -x "$x/$1" ]; then
            result=${result}" $x/$1"
        fi
    done
    echo $result
}

# Find the most recent python in a users path to be used to build a venv, if PYTHON_EXE_PATH
# is set in env.cfg then use that instead.
discover_python(){
    if [[ -z "$PYTHON_EXE_PATH" ]]; then
        # Don't use which, it only will find first in path within script
        # for python_found in `which python3 | cut -d" " -f3`;
        # Also don't use PYTHON_VERSION=`python -c 'import sys; version=sys.version_info[:3]; print("{0}.{1}.{2}".format(*version))'`
        # as it will rely on the first python in PATH and for now its best to rely on the latest python on a host.
        echo "[INFO] Detecting python installations, the latest version will be used to create the venv."
        pys=("python3" "python3.8" "python3.9" "python3.10" "python3.11" "python3.12" "python3.13" "python3.14")
        for py in "${pys[@]}"; do
            for python_found in `find_in_path $py`; do
                ver=`${python_found} --version | cut -d" " -f2`
                ver_path="$python_found"
                # echo "[INFO] Found Python instalaltion: $ver_path"
            done


            if [ $(normalize_version $ver) -ge $(normalize_version $PYTHON_VERSION) ]; then
                PYTHON_VERSION="$ver"
                PYTHON_EXE_PATH="$ver_path"
                echo "[INFO] Discovered python Version=${PYTHON_VERSION}, Path=${PYTHON_EXE_PATH}."
            fi
        done

    else
        PYTHON_VERSION=`${PYTHON_EXE_PATH} --version | cut -d" " -f2`
    fi

    # Lets check that both the Python path and version have been discovered else exit with a message
    if [[ -z "$PYTHON_VERSION" ]] && [[ -z "$PYTHON_EXE_PATH" ]]; then
        echo "[ERROR] Python has not been configured or discovered, review env.cfg or add python to PATH so it cna be discovered 'export PATH=...' "
        exit
    fi

    # There are wheel and setuptools issues when using later Python versions like 3.11 that
    # have not been diagnosed currently, so for now we will force python 3.9
    if [ $(normalize_version_major_minor $PYTHON_VERSION_SUPPORTED) -ne $(normalize_version_major_minor $PYTHON_VERSION) ]; then
        echo "[ERROR] This installation has only been tested with Python version ${PYTHON_VERSION_SUPPORTED}, you must use this version."
        echo "[ERROR] This intallation has either detected or been configured to use usupported version ${PYTHON_VERSION}."
        echo "[ERROR] If you have more than one version of python installed, set the environment variable 'PYTHON_EXE_PATH' in 'env.cfg' to a supported Python version."
        exit
    fi
}
 
# Builds a virtual Python installation
python_venv_build()
{

    echo "[INFO] Creating directory for Python virtual environment at $PYTHON_VENV_HOME/venv/$PYTHON_VERSION."
    mkdir -p $PYTHON_VENV_HOME/venv/$PYTHON_VERSION

    echo "[INFO] Creating virtual Python environment using Python ${PYTHON_EXE_PATH}"
    $PYTHON_EXE_PATH -m venv $PYTHON_VENV_HOME/venv/$PYTHON_VERSION
}

# Launches and configures the Python virtual environment will all dependencies
python_launch_venv()
{
    echo "[INFO] Initializing Python virtual environment and installing all documentation dependencies."
    cp requirements.txt $PYTHON_VENV_HOME/venv/$PYTHON_VERSION

    #/bin/sh -c ". $PY_HOME/venv/bin/activate; python3 --version; pip3 --version; pip3 install -r $PY_HOME/requirements.txt; exec /bin/sh -i"

    # Beyond creating and initializing a venv, this line of code appears to want to diff if the venv exists, if so uninstall an prior packages yet looks incomplete but harmless.
    # To actually complete the logic, either do a diff of requirements.txt and remove_dep.txt before into diff.txt or simply force recreation, since its
    # not causing any harm right now, we can leave it as is. 
    /bin/sh -c ". $PYTHON_VENV_HOME/venv/$PYTHON_VERSION/bin/activate; touch $PYTHON_VENV_HOME/venv/$PYTHON_VERSION/remove_dep.txt; pip3 freeze>$PYTHON_VENV_HOME/venv/$PYTHON_VERSION/remove_dep.txt; if [[ -s diff.txt ]]; then pip3 uninstall -r $PYTHON_VENV_HOME/venv/$PYTHON_VERSION/remove_dep.txt -y; fi ; rm -rf $PYTHON_VENV_HOME/venv/$PYTHON_VERSION/remove_dep.txt; pip3 install -r $PYTHON_VENV_HOME/venv/$PYTHON_VERSION/requirements.txt; exec /bin/sh -i"

    echo "[INFO] To exit a Python virtual enviroment, type 'exit' and press return."
    echo "[INFO] To luanch the virutual enviroment again, there are 2 options:"
    echo "[INFO]   1) Run the shell script included with the z_ansible_collections_doc repository: \`./py-start-venv.sh\`. and when you want to end the virtual enviroment, type 'exit'. and press enter."
    echo "[INFO]   2) Run the command $PYTHON_VENV_HOME/venv/$PYTHON_VERSION/bin/activate and when you want to end the virtual enviroment, type 'deactivate' and press enter."
}


################################################################################
# MAIN
################################################################################

# ------------------------------------------------------------------------------
# Avoid expanding aliases, if your Python is aliased in your profile, you could
# enable this step, just don't count on this for all users systems.
# ------------------------------------------------------------------------------
# shopt -s expand_aliases
# source ~/.bash_profile

# Source configurations
source ./env.cfg

if [[ -z "$PYTHON_VENV_HOME" ]]; then
    PYTHON_VENV_HOME=`pwd`
fi

discover_python
python_venv_build
python_launch_venv

