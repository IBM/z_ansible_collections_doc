.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025                                    .
.. ...........................................................................
=========================
Collection configurations
=========================

After installing the IBM z/OS core collection, you will need to configure
some files so that the collection can locate the dependencies it needs to
run modules on the managed node.

Step 1: Directory Structure
===========================

.. dropdown:: To configure the collection ...

    To configure the collection, it is best to begin by creating the directory
    structure that will combine the various elements; playbooks, inventory,
    variables (group_vars & host_vars) as well as environment variables.

    In this example, we are using the alternative directory layout that places
    inventory with ``group_vars`` and ``host_vars`` which is particularly useful
    if the variables contained in ``groups_vars`` and ``host_vars`` don't have
    much in common with other systems, eg Linux, Windows, etc.

    This directory structure complete with playbook and configurations is
    available in our samples repository.

    The directory structure should be created on the control node, that is
    where Ansible is running.

    .. code-block:: sh

        /playbooks/
                ├── my_playbook.yml       # A playbook
                ├── another_playbook.yml  # Another playbook
                ├── ansible.cfg           # Custom Ansible configuration
                ├── inventories/
                    └── host_vars/        # Assign variables to particular systems
                        └── zos_host.yml
                    └── group_vars/       # Assign variables to particular groups
                        └── all.yml
                    └── inventory.yml     # Inventory file for production systems


    The following commands will also create this directory structure in the `/tmp`
    directory.

    .. code-block:: sh

        mkdir -p /tmp/playbooks;
        touch /tmp/playbooks/my_playbook.yml;
        touch /tmp/playbooks/another_playbook.yml;
        touch /tmp/playbooks/ansible.cfg;
        mkdir -p /tmp/playbooks/inventories;
        mkdir -p /tmp/playbooks/inventories/host_vars;
        touch /tmp/playbooks/inventories/host_vars/zos_host.yml;
        mkdir -p /tmp/playbooks/inventories/group_vars;
        touch /tmp/playbooks/inventories/group_vars/all.yml;
        touch /tmp/playbooks/inventories/inventory.yml;


Step 2: Host variables (host_vars)
==================================

.. dropdown:: In the following section we will discuss the ``host_vars`` ...

    In the following section we will discuss the ``host_vars`` that will
    automatically be expanded into environment variables. These variables
    are used to instruct the collection on where it can find IBM
    `Open Enterprise SDK for Python`_ and IBM `Z Open Automation Utilities`_
    (ZOAU) dependencies.

    If you have not installed either dependency, please review the
    :ref::`managed node requirements<ibm-zos-core-collection-requirements>`
    for this collection.

    Before continuing, you must have the following information:

        #. the absolute path of where **IBM Open Enterprise SDK for Python** is installed.
        #. the IBM Open Enterprise SDK for Python **version** installed, eg 3.12
        #. the absolute path of where **Z Open Automation Utilities** (ZOAU) is installed.
        #. the absolute path of the **ZOAU python package** (zoautil-py) which can vary
        depending if ``pip3`` was used to install the python package.
            - If ``pip3`` was **not** used to install the python package, you can find
              the package under ${ZOAU_HOME}/lib/${python_version}
            - If ``pip3`` was used to install the package, the following command can
            aid in finding the absolute path to the package.

            .. code-block:: sh

                pip3 show zoautil-py

            Which will contain the **Location** of the package, for example:

            .. code-block:: sh

                Name: zoautil-py
                Version: 1.3.0.1
                Summary: Automation utilities for z/OS
                Home-page: https://www.ibm.com/docs/en/zoau/latest
                Author: IBM
                Author-email: csosoft@us.ibm.com
                Location: /zstack/zpm/python/3.10.0.0/lib/python3.10/site-packages

    Now that you have gathered the required dependency details, edit the file
    ``zos_host.yml`` located at ``/tmp/playbooks/inventories/host_vars/zos_host.yml``
    that was created in a previous step. You will need to configure the following
    properties:

    - PYZ - the python installation home path on the z/OS manage node
    - PYZ_VERSION - the version of python on the z/OS managed node
    - ZOAU - the ZOAU installation home on the z/OS managed node
    - ZOAU_PYTHON_LIBRARY_PATH - the path to the ZOAU python library 'zoautil_py'

    If you have installed the ZOAU python package using ``pip3``, enter this into
    ``zos_host.yml`` and update only the first 4 properties with dependency information
    (PYZ, PYZ_VERSION, ZOAU, ZOAU_PYTHON_LIBRARY_PATH).

    .. code-block:: sh

        PYZ: "/usr/lpp/IBM/cyp/v3r12/pyz"
        PYZ_VERSION: "3.12"
        ZOAU: "/usr/lpp/IBM/zoautil"
        ZOAU_PYTHON_LIBRARY_PATH: "/usr/lpp/IBM/cyp/v3r12/pyz/lib/python3.12/site-packages/"
        ansible_python_interpreter: "{{ PYZ }}/bin/python3"

    If you are using the included pre-compiled python binaries included with ZOAU,
    enter this into ``zos_host.yml``` and update only the first 3 properties with
    dependency information (PYZ, PYZ_VERSION, ZOAU).

    .. code-block:: sh

        PYZ: "/usr/lpp/IBM/cyp/v3r12/pyz"
        PYZ_VERSION: "3.12"
        ZOAU: "/usr/lpp/IBM/zoautil"
        ZOAU_PYTHON_LIBRARY_PATH: "{{ ZOAU }}/lib/{{ PYZ_VERSION }}"
        ansible_python_interpreter: "{{ PYZ }}/bin/python3"


Step 3: Group variables (group_vars)
====================================

.. dropdown:: In the following section we will discus ``group_vars`` ...

    In the following section we will discus ``group_vars``, part of the
    environment variables which instruct the collection where it can find
    IBM `Open Enterprise SDK for Python`_ and IBM
    `Z Open Automation Utilities`_ (ZOAU) dependencies.

    In the ``all.yml`` file located at ``/tmp/playbooks/inventories/group_vars/all.yml``,
    paste the following below, there is no need to edit this content. The ``host_vars``
    variables from the previous step will be automatically substituted into the
    environment variables (below) by ansible.

    Notice the indentation, ensure it is retained before you save the file.

    .. code-block:: sh

        environment_vars:
        _BPXK_AUTOCVT: "ON"
        ZOAU_HOME: "{{ ZOAU }}"
        PYTHONPATH: "{{ ZOAU_PYTHON_LIBRARY_PATH }}"
        LIBPATH: "{{ ZOAU }}/lib:{{ PYZ }}/lib:/lib:/usr/lib:."
        PATH: "{{ ZOAU }}/bin:{{ PYZ }}/bin:/bin:/var/bin"
        _CEE_RUNOPTS: "FILETAG(AUTOCVT,AUTOTAG) POSIX(ON)"
        _TAG_REDIR_ERR: "txt"
        _TAG_REDIR_IN: "txt"
        _TAG_REDIR_OUT: "txt"
        LANG: "C"
        PYTHONSTDINENCODING: "cp1047"


Strep 4: Inventory
==================

.. dropdown:: Ansible interacts with managed nodes (hosts) ...

    Ansible interacts with managed nodes (hosts) using a list known as `inventory`_.
    It is a configuration file that specifies the hosts and group of hosts
    on which Ansible commands, modules, and playbooks will operate. It also defines
    variables and connection details for those hosts, such as IP address. For more
    information, see `Building Ansible inventories`_.

    The following inventory is explained.

    - **systems** is a group that contains one managed host, **zos1**.
    - **zos1** is the name chosen for managed node, you can choose any name. \
    - **ansible_host** is an ansible reserved keyword that is the hostname ansible
      will connect to and run automated tasks on, it can be an LPAR, ZVM, etc.
    - **ansible_user** is an ansible reserved keyword that is the user Ansible will
      use to connect to the managed node, generally and OMVS segment.

    Edit the file ``inventory.yml`` located at ``/tmp/playbooks/inventories/inventory.yml``
    and paste the following below. You will need to update the properties
    **ansible_host** and **ansible_user**.

    .. code-block:: sh

        systems:
            hosts:
                zos1:
                ansible_host: zos_managed_node_host_name_or_ip
                ansible_user: zos_managed_node_ssh_user

Step 5: User
============

This collection connects to the managed node over SSH via the ansible user defined in inventory or
optionally the command line, thus requiring access to z/OS UNIX System Services (USS). From a security
perspective, the collection will require both an OMVS segment and TSO segment in the users profile.

With the ADDGROUP command you can:

- define a new group to RACF.
- add a profile for the new group to the RACF database.
- specify z/OS® UNIX System Services information for the group being defined to RACF.
- specify that RACF is to automatically assign an unused GID value to the group.

With the ADDUSER command you can:

- define a new user to RACF.
- add a profile for the new user to the RACF database.
- create a connect profile that connects the user to the default group.
- create an OMVS segment.
- create a TSO segment.

 Operands explained:

- *uuuuuuuu* Specifies the user to be defined to RACF. 1 - 8 alphanumeric characters.
  A user id can contain any of the supported symbols A-Z, 0-9, #, $, or @.
- *gggggggg* Specifies the name of a RACF-defined group to be used as the default
  group for the user. If you do not specify a group, RACF uses your current connect
  group as the default. 1 - 8 alphanumeric characters, beginning with an alphabetic
  character. A group name can contain any of the supported symbols A-Z, 0-9, #, $, or @.
- *nnnnnnnn* Specifies a RACF-defined user or group to be assigned as the owner of the
  new group. If you do not specify an owner, you are defined as the owner of the group.
- *pppppppp* Specifies the user's initial logon password. This password is always set
  expired, thus requiring the user to change the password at initial logon.
- *aaaaaaaa* Specifies the user's default TSO account number. The account number you
  specify must be protected by a profile in the ACCTNUM general resource class, and
  the user must be granted READ access to the profile.

When issuing these RACF commands, you might require sufficient authority to the proper
resources. It is recommended you review the `RACF language reference`_.

You can define a new group to RACF with command:

.. code-block:

    ADDGROUP gggggggg OMVS(AUTOGID)

You can add a new user with RACF command:

.. code-block:

   ADDUSER uuuuuuuu DFLTGRP(gggggggg) OWNER(nnnnnnnn) PASSWORD(pppppppp) TSO(ACCTNUM(aaaaaaaa) PROC(pppppppp)) OMVS(HOME(/u/uuuuuuuu) PROGRAM('/bin/sh')) AUTOUID


To learn more about creating users with RACF, see `RACF command syntax`_.


Step 6: Security
================

Some of the modules in the collection will perform operations that require the playbook user to
have appropriate authority with various RACF resource classes. Each module documents which access
is needed in the **note** section. A user is described as the remote SSH user executing playbook
tasks, who can also obtain escalated privileges to execute as another user.

Prerequisites
=============
Before installing any collection, ensure the collection requirements are met through the use of `environment variables`_. The preferred configuration is to place the environment variables in ``group_vars`` and ``host_vars``, you can find examples of this configuration under **Configuration** of any project in the `Ansible Z Playbook Repository`_.

.. note::
    If you are testing a configuration, it can be helpful to set the environment variables in a playbook. See `How to put environment variables in a playbook`_.

To install ZOAU Python wheel, see `Python wheel installation method`_.


.. ...........................................................................
.. External links
.. ...........................................................................
.. _environment variables:
   https://github.com/IBM/z_ansible_collections_samples/blob/main/docs/share/zos_core/configuration_guide.md#environment-variables
.. _Ansible Z Playbook Repository:
   https://github.com/IBM/z_ansible_collections_samples
.. _How to put environment variables in a playbook:
   https://github.com/ansible-collections/ibm_zos_core/discussions/657
.. _Python wheel installation method:
   https://www.ibm.com/docs/en/zoau/1.3.x?topic=installing-zoau#python-wheel-installation-method
.. _Installing collections (Ansible Documentation):
   https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#installing-collections
.. _Configuring the ansible-galaxy client (Ansible Documentation):
   https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#configuring-the-ansible-galaxy-client
.. _Ansible Configuration Settings (Ansible Documentation):
   https://docs.ansible.com/ansible/latest/reference_appendices/config.html
.. _Installing a collection from a git repository (Ansible Documentation):
   https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#installing-a-collection-from-a-git-repository
.. _Connect to Hub:
   https://cloud.redhat.com/ansible/automation-hub/token/
.. _Creating the API token in automation hub:
    https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.4/html/getting_started_with_automation_hub/hub-create-api-token#hub-create-api-token


.. _Open Enterprise SDK for Python:
   https://www.ibm.com/products/open-enterprise-python-zos
.. _Z Open Automation Utilities:
   https://www.ibm.com/docs/en/zoau/latest
.. _inventory:
   https://ibm.github.io/z_ansible_collections_doc/welcome/basic-concepts.html#term-Inventory
.. _Building Ansible inventories: https://docs.ansible.com/ansible/latest/inventory_guide/index.html#
.. _RACF command syntax:
   https://www.ibm.com/docs/en/zos/3.1.0?topic=syntax-addgroup-add-group-profile
.. _RACF language reference:
   https://www.ibm.com/docs/en/zos/3.1.0?topic=racf-zos-security-server-command-language-reference