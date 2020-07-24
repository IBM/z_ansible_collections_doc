.. ...........................................................................
.. © Copyright IBM Corporation 2020                                          .
.. ...........................................................................

=========
Playbooks
=========

The sample playbooks that are **included** in the **IBM z/OS collections**
demonstrate how to use the collection content.

Documentation
=============

An `Ansible playbook`_ consists of organized instructions that define work for
a managed node (host) to be managed with Ansible.

A `playbooks directory`_ that contains a sample playbook is included in the
**IBM z/OS core collection**. The sample playbook can be run with the
``ansible-playbook`` command with some modification to the **inventory**,
**ansible.cfg** and **group_vars**.

You can find the playbook content that is included with the collection in the
same location where the collection is installed. For more information, refer to
the `installation documentation`_. In the following examples, this document will
refer to the installation path as ``~/.ansible/collections/ibm/ibm_zos_core``.

.. _Ansible playbook:
   https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#playbooks-intro
.. _playbooks directory:
   https://github.com/ansible-collections/ibm_zos_core/tree/master/playbooks
.. _installation documentation:
   installation.html


Configuration and Setup
=======================

Each offering can vary.... more info here...

Offerings
---------

.. toctree::
   :maxdepth: 1

   z/OS core </../ibm_zos_core/docs/source/playbook_config_setup>
   z/OS IMS </../ibm_zos_ims/docs/source/playbook_config_setup>

Inventory
=========

Each offering can vary.... more info here...

Offerings
---------

.. toctree::
   :maxdepth: 1

   z/OS core </../ibm_zos_core/docs/source/playbook_inventory>
   z/OS IMS </../ibm_zos_ims/docs/source/playbook_inventory>

Group_vars
==========

Each offering can vary.... more info here...

Offerings
---------

.. toctree::
   :maxdepth: 1

   z/OS core </../ibm_zos_core/docs/source/playbook_group_vars>
   z/OS IMS </../ibm_zos_ims/docs/source/playbook_group_vars>


Run a playbook
==============

Each offering can vary.... more info here...

Offerings
---------

.. toctree::
   :maxdepth: 1

   z/OS core </../ibm_zos_core/docs/source/playbook_run>
   z/OS IMS </../ibm_zos_ims/docs/source/playbook_run>
