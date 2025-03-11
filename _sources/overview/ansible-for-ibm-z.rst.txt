.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025                                    .
.. ...........................................................................
.. TODO:
..    1) Request all contributors provide a reference (ref) back to the
..       collections ansible_content page like the ibm_zos_core collection.
..       For now, static links are used (which might actually be safer :) )
.. ...........................................................................

==================
Ansible for IBM Z
==================

**Ansible for IBM Z** is a suite of collections designed to automate and manage
IBM Z environments using Ansible, an open-source automation platform. It provides
a wide range of Ansible collections that are developed by IBM and certified
by Red Hat.

It enables development, operations and automation on z/OS, middleware
products, and other IBM Z systems and resources. The collections in
Ansible for IBM Z offer a seamless, unified workflow, orchestration with
configuration management, provisioning, and application deployment in
one easy-to-use platform.

The Ansible for IBM Z offerings are actively expanding to automate common
configuration and management tasks for software in the broader IBM Z community.

Today, the available collections include:

.. grid:: 1 1 2 2
    :gutter: 1

    .. grid-item::

        .. grid:: 1 1 1 1
            :gutter: 1

            .. grid-item-card:: :bdg-ref-primary:`ibm-zos_core-collection` :octicon:`link-external`
                  :padding: 0

                  With the `IBM z/OS Core`_ collection, you will be able to:

                  - Submit and access output for batch jobs.
                  - Create, edit, archive and unarchive data sets.
                  - Run operator commands, REXX and shell scripts.
                  - Initialize volumes.
                  - Backup and restore data sets and volumes.

            .. grid-item-card:: :bdg-link-primary:`z/OS IMS<../ibm_zos_ims/docs/ansible_content.html>` :octicon:`link-external`
                  :padding: 0

                  With the `IBM z/OS IMS`_ collection, you will be able to:

                  - Generate IMS Database Descriptors (DBD).
                  - Generate Program Specification Blocks (PSB).
                  - Generate Application Control Blocks (ACB).
                  - Run IMS type-1 commands.
                  - Run IMS IMS type-2 commands.

            .. grid-item-card:: :bdg-link-primary:`z/OS CICS<../ibm_zos_cics/docs/ansible_content.html>` :octicon:`link-external`
                  :padding: 0

                  With the `IBM z/OS CICS`_ collection, you will be able to:

                  - Manage CICS resources.
                  - Manage CICS definitions.
                  - Provision CICS regions.
                  - Deprovision CICS regions.
                  - Start or stop a CICS region.

    .. grid-item::

        .. grid:: 1 1 1 1
            :gutter: 1

            .. grid-item-card:: :bdg-link-primary:`z/OS Management Facility<../ibm_zosmf/docs/ansible_content.html>` :octicon:`link-external`
                  :padding: 0

                  With the `IBM z/OS Management Facility`_ collection, you will be able to:

                  - Create z/OSMF workflows.
                  - Run z/OSMF workflows.
                  - Delete z/OSMF workflows.
                  - Provision and manage z/OS software.
                  - Validate and provision security requirements.

            .. grid-item-card:: :bdg-link-primary:`Z HMC<../zhmc-ansible-modules/docs/ansible_content.html>` :octicon:`link-external`
                  :padding: 0

                  With the `IBM Z HMC`_ collection, you will be able to:

                  - Create, update and delete partitions.
                  - Access operating system messages.
                  - Configure adapters.
                  - Manage HMC users.
                  - Update SE and HMC firmware.

            .. grid-item-card:: :bdg-link-primary:`Z System Automation<../ibm_zos_sysauto/docs/ansible_content.html>` :octicon:`link-external`
                  :padding: 0

                  With the `IBM Z System Automation`_ collection, you will be able to:

                  - Create dynamic resources from a template.
                  - Delete dynamic resources from a template.

                  |br|
                  |br|
                  |br|

.. ...........................................................................
.. # Forced HTML line break, use this at the end of a sentence like.... |br|
.. ...........................................................................

.. |br| raw:: html

   <br/>

.. ...........................................................................
.. # Site content links
.. ...........................................................................

.. _IBM z/OS Core:
   ../ibm_zos_core/docs/source/ansible_content.html
.. _IBM z/OS CICS:
   ../ibm_zos_cics/docs/ansible_content.html
.. _IBM z/OS IMS:
   ../ibm_zos_ims/docs/ansible_content.html
.. _IBM Z System Automation:
   ../ibm_zos_sysauto/docs/ansible_content.html
.. _IBM z/OS Management Facility:
   ../ibm_zosmf/docs/ansible_content.html
.. _IBM Z HMC:
   ../zhmc-ansible-modules/docs/ansible_content.html