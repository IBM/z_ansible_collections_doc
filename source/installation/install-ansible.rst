.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2024                                    .
.. ...........................................................................

===============
Install Ansible
===============

You must install the correct version of Ansible® before you download and install any IBM z/OS® collection.

Prerequisites
-------------

Before installing Ansible, make sure the required versions of Python is installed on your control node. You can check which version needs to be installed from :ref:`requirements`. 

Procedures
----------

Ansible's community packages are distributed in two ways: ``ansible`` or ``ansible-core``. To find out which package to use, see `Selecting an Ansible package and version to install`_.

You can install Ansible with ``pipx`` or ``pip``:

    - `Install Ansible with pipx`_
    - `Install Ansible with pip`_

Additionally, you can install Ansible to containers or install Ansible for development. For detailed information, see `Install Ansible`_.

Verify installation
-------------------

After you installed Ansible on the control node, make sure the installation is successful by following the instructions in `Confirm your installation`_.

.. External links:
.. _Selecting an Ansible package and version to install: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#selecting-an-ansible-package-and-version-to-install
.. _Install Ansible with pipx: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible-with-pipx
.. _Install Ansible with pip: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible-with-pip
.. _Install Ansible:https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible
.. _Confirm your installation: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#confirming-your-installation