.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2024                                    .
.. ...........................................................................

============
Requirements
============

Before you install any IBM® z/OS® collection, you must configure a
**control node** and a **managed node** with a minimum set of requirements.

Control node
============
A control node is any machine with Ansible® installed. From the control node,
you can run commands and playbooks from a laptop, desktop, or server. However,
Windows® is not a supported controller for Ansible collections managing a z/OS
node.

Managed node
============

A managed node is often referred to as a target node, or host, and it is managed
by Ansible. Ansible need not be installed on a managed node.


Each IBM z/OS collection varies in terms of the requirements for the controlled node and the managed node. And for different versions of the same collection, the requirements could be different as well. Check out each collection's support matrix below to learn about the specific requirements.

.. toctree::
   :maxdepth: 1

   z/OS core (new) <supportmatrix(new)>
   z/OS core </../ibm_zos_core/docs/source/requirements_managed>
   z/OS CICS <../ibm_zos_cics/docs/source/requirements_managed>
   z/OS IMS </../ibm_zos_ims/docs/source/requirements_managed>
   z/OS Sys Auto <../ibm_zos_sysauto/docs/source/requirements_managed>
   z/OS z/OSMF <../ibm_zosmf/docs/source/requirements_managed>
   Z HMC <../zhmc-ansible-modules/docs/source/requirements_managed>