.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2024                                    .
.. ...........................................................................

============
Requirements
============

Before you install any IBM® z/OS® collection, you must configure a
**control node** and a **managed node** with a minimum set of requirements.

.. _control-node-label:

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

Support matrix
==============

Different collection versions may have different requirements for the control node and managed node. To find more information about dependencies for each version, check its support matrix.

.. toctree::
   :maxdepth: 1

   z/OS core collection <supportmatrix>