################################################################################
# Copyright (c) IBM Corporation 2020
################################################################################

source env.cfg

# A user could be executing this script wihout an env.cfg so lets populate with a default
if [[ -z "$PY_VERSION" ]]; then
    PY_VERSION=3.8.3
fi

# A user could be executing this script wihout an env.cfg so lets populate with a default
if [[ -z "$PY_VENV_HOME" ]]; then
    PY_VENV_HOME=~/.venv
fi

echo "Preparing to lunch Python virtual enviroment $PY_VENV_HOME/$PY_VERSION/venv."
echo "This script runs the virtual enviroment in a spawned shell, not a subprocess."
echo "To exit the virtual enviroment, type the terminal command 'exit' and press return."

/bin/bash -c ". $PY_VENV_HOME/$PY_VERSION/venv/bin/activate; exec /bin/bash -i"

