.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025                                    .
.. ...........................................................................

.. _install-ansible:

=======
Ansible
=======

Before installing Ansible, it is recommended you review the **Ansible for IBM Z**
collections requirements to align the Ansible version to a supported version.

For **Ansible for IBM Z** requirements, review the topic
:ref"`software requirements<software-requirements>`.

If you prefer watching videos, you can follow the steps discussed in the guide,
`Set up your Ansible control node for getting started with Ansible for IBM Z`_.

Prerequisites
-------------

After you have decided on an Ansible version, ensure the required version of Python
is installed on the control node. You can review which version of Python is required
by reviewing the `ansible-core support matrix`_.

Procedures
----------

Ansible's community packages are distributed in two ways: ``ansible``
or ``ansible-core``. To find out which package to use, see
`Selecting an Ansible package and version to install`_.

You can install Ansible with ``pipx`` or ``pip``:

    - `Install Ansible with pipx`_
    - `Install Ansible with pip`_

Additionally, you can install Ansible to containers or upgrade the
Ansible version. For detailed information, see `Install Ansible`_
and select the appropriate option.

Verify installation
-------------------

After you installed Ansible on the control node, ensure the installation
is successful.

If you have installed **ansible-core**, you can test this by checking
the version with command:

   .. code-block:: sh

      ansible --version

If you have installed **ansible**, you can test this by checking
the version with command:

   .. code-block:: sh

      ansible-community --version


 To learn more about configuration, see `Confirm your installation`_.

Test installation
-----------------

After you have verified the installation, you can run a simple Ansible
adhoc command utilizing the `ansible.builtin.ping module`_ module to test
the installation.

   .. code-block:: sh

      ansible localhost -m ansible.builtin.ping

.. ...........................................................................
.. External links
.. ...........................................................................
.. _Selecting an Ansible package and version to install:
    https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#selecting-an-ansible-package-and-version-to-install
.. _Install Ansible with pipx:
    https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible-with-pipx
.. _Install Ansible with pip:
    https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible-with-pip
.. _Install Ansible:
    https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible
.. _Confirm your installation:
    https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#confirming-your-installation
.. _Set up your Ansible control node for getting started with Ansible for IBM Z:
    https://mediacenter.ibm.com/media/Set%20up%20your%20Ansible%20control%20node%20for%20getting%20started%20with%20Ansible%20for%20IBM%20Z/1_r9g0duq3
.. _ansible.builtin.ping module:
   https://ansible.builtin.ping/
.. _ansible-core support matrix:
   https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-core-support-matrix
