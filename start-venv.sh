################################################################################
# Copyright (c) IBM Corporation 2020
################################################################################

source env.cfg

echo "Preparing to lunch Python virtual enviroment $PY_HOME/venv."
echo "This script runs the virtual enviroment in a spawned shell, not a subprocess."
echo "To exit the virtual enviroment, type the terminal command \'exit\'."

/bin/sh -c ". $PY_HOME/venv/bin/activate; python3 --version; pip3 --version; exec /bin/sh -i"
