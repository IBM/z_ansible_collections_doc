.. ...........................................................................
.. © Copyright IBM Corporation 2020                                          .
.. ...........................................................................

============
Requirements
============

Before you install any IBM z/OS collection, you must configure a control node and
managed node with a minimum set of requirements. The following sections detail the
specific software requirements for the control and managed nodes.

Control node
============
A control node is any machine with Ansible installed. From the control node,
you can run commands and playbooks from a laptop, desktop, or server.
However, you cannot run a collection on a Windows system. All IBM z/OS collections
require the following these versions of software:

* `Ansible version`_: 2.9 or later
* `Python`_: 2.7 or later
* `OpenSSH`_

.. _Ansible version:
   https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
.. _Python:
   https://www.python.org/downloads/release/latest
.. _OpenSSH:
   https://www.openssh.com/


.. .. toctree::
..    :maxdepth: 1

..    requirements_controller


Managed node
============

A managed node is often referred to as a target node, or host, and it is managed
by Ansible. Ansible need not be installed on a managed node, but SSH must be
enabled. Each offering in the IBM z/OS collections varies in terms of the requirements for
the managed node. Select one of the following offerings to learn
more about the specific dependencies and required/supported software versions.

Offerings
---------

.. toctree::
   :maxdepth: 1

   z/OS core </../ibm_zos_core/docs/source/requirements_managed>
   z/OS IMS </../ibm_zos_ims/docs/source/requirements_managed>
