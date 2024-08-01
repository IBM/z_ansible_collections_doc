.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2021                                    .
.. ...........................................................................

=========================================================
Red Hat Ansible Certified Content for IBM Z Documentation
=========================================================

Welcome to the Ansible for IBM Z docs site! Here you will find step-by-step user walkthroughs, best practices, resources and use cases to aid in your Ansible on IBM Z journey.

.. Maybe outline how the Ansible for IBM Z bundle is constructed and how each collection is maintained

The Ansible for IBM Z advantage
===============================

**Red Hat® Ansible Certified Content for IBM Z** (also known as Ansible for IBM Z) provides the ability to connect IBM Z to clients' wider enterprise automation strategy through the Ansible Automation Platform ecosystem. This enables development and operations automation on Z through a seamless, unified workflow orchestration with configuration management, provisioning, and application deployment in one easy-to-use platform.

This solution comes together as one offering through the coordinated effort of all the offerings. Each offering is represented in a distribution format known as collections that can include playbooks, roles, modules, and plugins.

The Ansible for IBM Z ultimate guide
====================================

Follow this 10-step installation walkthrough to get started with Ansible for IBM Z.

.. 1- Ansible basic concepts
:ref:`1. Ansible basic concepts<basic-concepts>` (30 minutes)
   Common Ansible concepts that you should understand before using Ansible for IBM Z or reading the documentation.

.. 2- Prerequisites for installation
:doc:`2. Install required dependencies<requirements/supportmatrix>`
   Before installing Ansible, you need to ensure that the required dependencies are installed.

.. 3- Installation guides
:doc:`3. Install Ansible<installation/installation>`
   Find avilable options for installing Ansible on your local machine.

.. I need to check the steps in Ansible z trial
.. 4- Configure the Ansible inventory
:doc:`4. Configure the Ansible inventory`
   Do this, do that.

:doc:`5. Create an Ansible playbook`
   Do this, do that.

Z trial
=======

Drive automation via Ansible playbooks from the Ansible for IBM Z Playbook Repository utilizing Red Hat Ansible Certified Content for IBM Z and learn how to:
- Acquire z/OS status.
- Handle basic dataset operations.
- Perform job management.
- Explore additional sample playbooks.


Other resources
===============

:ref:`Sample playbook repository`
   Here you will find all the sample playbooks provided by IBM.

:ref:`IBM community`
   Get latest news and connect with other community members.

:ref:`Ansible community guild`
   In this monthly call, we get together with the community to share updates, use cases and user experience efforts.

:ref:`Ansible for IBM Z spotlight seris`
   In this quarterly publication, we shine a light on our users. Find out featured users here.



.. Hidden TOCs

.. toctree::
   :maxdepth: 1
   :caption: Welcome (new)
   :hidden:

   overview
   basic-concepts
   sample-repo

.. toctree::
   :maxdepth: 2
   :caption: Installation guide
   :hidden:

   requirements
   installation

.. toctree::
   :maxdepth: 1
   :caption: Ansible Content

   z/OS core<ibm_zos_core/docs/ansible_content>
   z/OS CICS<ibm_zos_cics/docs/ansible_content>
   z/OS IMS<ibm_zos_ims/docs/ansible_content>
   z/OS Sys Auto<ibm_zos_sysauto/docs/ansible_content>
   z/OS z/OSMF<ibm_zosmf/docs/ansible_content>
   Z HMC<zhmc-ansible-modules/docs/ansible_content>

.. toctree::
   :maxdepth: 1
   :caption: Release Notes
   :hidden:

   release/roadmap
   release/release

.. toctree::
   :maxdepth: 1
   :caption: Troubleshooting
   :hidden:

   troubleshooting/errorsandmessages

.. toctree::
   :maxdepth: 1
   :caption: FAQs
   :hidden:

   faqs/faqs

.. toctree::
   :maxdepth: 1
   :caption: Help
   :hidden:

   help/faqs
   help/getsupport

.. toctree::
   :maxdepth: 1
   :caption: Reference
   :hidden:

   reference/documentation
   reference/community
   reference/helpful_links

.. ..........................................................................
.. . TODO
.. ..........................................................................
.. . Disabled for the time being
.. ..........................................................................
..   howdoi/howdoi
