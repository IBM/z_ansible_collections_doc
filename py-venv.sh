################################################################################
# Copyright (c) IBM Corporation 2020, 2023
################################################################################

source env.cfg

if [[ -z "$PYTHON_VENV_HOME" ]]; then
    PYTHON_VENV_HOME=`pwd`
fi

echo "Starting virtual environment."
echo "To exit the virtual enviroment, type the terminal command 'exit' and press return."

/bin/sh -c ". $PYTHON_VENV_HOME/venv/*/bin/activate; exec /bin/bash -i"

