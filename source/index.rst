.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2021                                    .
.. ...........................................................................

================================================================
Red Hat Ansible Certified Content for IBM Z Documentation (test)
================================================================

**(JH: this page is still under development. Not the final version.)**

Welcome to the Red Hat® Ansible® Certified Content for IBM Z® documentation! Here you will find step-by-step user walkthroughs, best practices, resources and use cases to aid in your Ansible on IBM Z journey.

Intro to Ansible for IBM Z
==========================

**Red Hat Ansible Certified Content for IBM Z** (also known as **Ansible for IBM Z**) provides the ability to connect IBM Z to your wider enterprise automation strategy through the Ansible Automation Platform ecosystem. This enables development and operations automation on IBM Z through a seamless, unified workflow orchestration with configuration management, provisioning, and application deployment in one easy-to-use platform.

This solution comes together as one bundle through the coordinated effort of various offerings. Each offering is represented in a distribution format known as collections that can include playbooks, roles, modules, and plugins.

Getting started with Ansible for IBM Z
======================================

**(JH: this is a mock-up. more details to come...)**

If you're new to Ansible for IBM Z, follow the guide to start your journey:

.. 1- Ansible basic concepts
:doc:`1. Ansible basic concepts<basic-concepts>` (30 minutes)
   Common Ansible concepts that you should understand before using Ansible for IBM Z or reading the documentation.

.. 2- Prerequisites for installation
:doc:`2. Install required dependencies<installation/installation-index>` (30 minutes)
   Before installing Ansible, you need to ensure that the required dependencies are installed.

.. 3- Installation guides
:doc:`3. Install Ansible<installation/installation>` (30 minutes)
   Find avilable options for installing Ansible on your local machine.

.. I need to check the steps in Ansible z trial
.. 4- Configure the Ansible inventory
:doc:`4. Configure the Ansible inventory` (30 minutes)
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


Other Resources
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
   :caption: Welcome
   :hidden:

   welcome/overview
   welcome/basic-concepts
   welcome/sample-repo
   welcome/ztrial-intro

.. toctree::
   :maxdepth: 2
   :caption: Getting Started
   :hidden:

   requirements/index-requirements
   installation/index-installation

.. toctree::
   :maxdepth: 2
   :caption: Roadmaps and Releases
   :hidden:

   z/OS core<release/zos-core-release-overview>
   .. z/OS CICS and its release overview page
   .. z/OS IMS and its release overview page
   .. and so on

.. toctree::
   :maxdepth: 1
   :caption: Ansible Content
   :hidden:

   z/OS core<ibm_zos_core/docs/ansible_content>
   z/OS CICS<ibm_zos_cics/docs/ansible_content>
   z/OS IMS<ibm_zos_ims/docs/ansible_content>
   z/OS Sys Auto<ibm_zos_sysauto/docs/ansible_content>
   z/OS z/OSMF<ibm_zosmf/docs/ansible_content>
   Z HMC<zhmc-ansible-modules/docs/ansible_content>

.. toctree::
   :maxdepth: 1
   :caption: Troubleshooting
   :hidden:

   troubleshooting/errorsandmessages

.. toctree::
   :maxdepth: 1
   :caption: Support
   :hidden:

   support/get-support
   support/index-life-cycle
   support/faqs

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
