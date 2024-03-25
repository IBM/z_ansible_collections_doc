.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2024                                    .
.. ...........................................................................

============
Requirements
============

Before you install any IBM® z/OS® collection, you must configure a
**control node** and **managed node** with a minimum set of requirements. The
following sections detail the specific software requirements for the control and
managed nodes.

Control node
============
A control node is any machine with Ansible® installed. From the control node,
you can run commands and playbooks from a laptop, desktop, or server. However,
Windows® is not a supported controller for Ansible collections managing a z/OS
node.

All IBM z/OS collections are either `Ansible Automation Platform Certified Content`_ (AAP) or undergoing certification. Thus, the supported versions of Ansible align with the `AAP Life Cycle`_. For support, the controller must use the supported version of Ansible and when applicable the collections dependencies.

The minimum software requirements for IBM z/OS collections are:

* `ansible-core`_: 2.15 (AAP 2.4) or later
* `IBM Open Enterprise SDK for Python`_: 3.11 or later
* `OpenSSH`_

   * Modules which can have Ansible tasks delegated to a localhost need not
     have OpenSSH enabled. Such modules often rely on a REST API for automation.
     Refer to the collections listed in the **Managed node** section
     to review which collections leverage a REST endpoint.

Each offering in the **Red Hat® Ansible Certified Content for IBM Z** offering
can vary in terms of the requirements for the control node. When you install any of them, review the specific dependencies and required/supported software versions, if any.

.. _ansible-core:
   https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
.. _IBM Open Enterprise SDK for Python:
   https://www.ibm.com/products/open-enterprise-python-zos
.. _OpenSSH:
   https://www.openssh.com/
.. _Ansible Automation Platform Certified Content:
   https://access.redhat.com/articles/3642632
.. _AAP Life Cycle:
   https://access.redhat.com/support/policy/updates/ansible-automation-platform

Managed node
============

A managed node is often referred to as a target node, or host, and it is managed
by Ansible. Ansible need not be installed on a managed node.
Each offering in the IBM z/OS collections varies in terms of the requirements for
the managed node. Select one of the following offerings to learn
more about the specific dependencies and required/supported software versions.

.. toctree::
   :maxdepth: 1

   z/OS core </../ibm_zos_core/docs/source/requirements_managed>
   z/OS CICS <../ibm_zos_cics/docs/source/requirements_managed>
   z/OS IMS </../ibm_zos_ims/docs/source/requirements_managed>
   z/OS Sys Auto <../ibm_zos_sysauto/docs/source/requirements_managed>
   z/OS z/OSMF <../ibm_zosmf/docs/source/requirements_managed>
   Z HMC <../zhmc-ansible-modules/docs/source/requirements_managed>