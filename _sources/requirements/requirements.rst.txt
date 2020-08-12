.. ...........................................................................
.. © Copyright IBM Corporation 2020                                          .
.. ...........................................................................

============
Requirements
============

A control node is any machine with Ansible installed. From the control node,
you can run commands and playbooks from a laptop, desktop, or server.
However, you cannot run **IBM z/OS core collection** on a Windows system.

A managed node is often referred to as a target node, or host, and it is managed
by Ansible. Ansible need not be installed on a managed node, but SSH must be
enabled.

The nodes listed below require these specific versions of software:



.. toctree::
   :maxdepth: 1

   requirements_controller


Managed node
============

Each offering can vary.... more info here...

Offerings
---------

.. toctree::
   :maxdepth: 1

   z/OS core </../ibm_zos_core/docs/source/requirements_managed>
   z/OS IMS </../ibm_zos_ims/docs/source/requirements_managed>
