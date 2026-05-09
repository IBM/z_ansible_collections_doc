.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025
..
.. This is an orphaned page because its not included in any toctree
.. 'orphan' if set, warnings about this file not being included in any toctree
..  will be suppressed.
.. ...........................................................................

:orphan:

==================
Migration guide
==================

Migration guide helps organizations transition from traditional IBM Z automation approaches to Ansible for IBM Z. 
Whether you are migrating from manual operational processes, legacy scripting languages such as REXX, CLIST, or JCL, or from existing automation tools, 
this guide provides a structured approach to adopting modern, scalable automation practices on IBM Z environments.

The guide introduces the available Ansible for IBM Z collections and explains how they can be used to automate common z/OS administration, application management,
middleware operations, and infrastructure tasks. It also highlights recommended migration strategies, best practices, and key considerations to help teams 
modernize their automation workflows while maintaining operational stability and reliability.
By following this guide, organizations can reduce manual effort, improve consistency, accelerate operational processes, and 
integrate IBM Z automation into broader enterprise automation ecosystems.


Here are the Migration guides for each collections:

.. toctree::
   :maxdepth: 1
   :hidden:

   z/OS Core <../ibm_zos_core/docs/source/migration-guide>
  

.. grid:: 3
    :gutter: 1

    .. grid-item::

        .. grid:: 1 1 1 1
            :gutter: 1

            .. grid-item-card:: z/OS Core
               :link: ../ibm_zos_core/docs/source/migration-guide.html

               For more information on migration guide, click.


  

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