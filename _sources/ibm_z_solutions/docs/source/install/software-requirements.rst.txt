.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2026                                    .
.. ...........................................................................
.. TODO:
..    1) Request all contributors provide a reference (ref) back to the
..       collections ansible_content page like the ibm_zos_core collection.
..       For now, static links are used (which might actually be safer :) )
.. ...........................................................................
=====================
Software requirements
=====================

Event-Driven Ansible is a validated content collection that is designed to be customizable, with no strict dependencies.

Collection requirements
-----------------------

Before you install an **Ansible for IBM Z** collection, review the requirements
for both the :term:`control node<Control node>` and the
:term:`managed node<Managed node>`.

This collection provides sample configurations that you can adapt the collection to your specific environments. 
This documentation describes the dependencies required to use the collection out of the box. 

Control node
------------

The :term:`control node<Control node>` is Ansible Automation Platform (AAP), 
review the `Red Hat Ansible Automation Platform Life Cycle`_ to select a supported AAP version. 
  
The collection comprises of playbooks which require: 

 - `z/OS Core collection`_ 1.13.x or later
 - `Community General collection`_ 12.0.0 or later


Managed node
------------

The :term:`managed node<Managed node>` requires the following be installed and
configured:

 - `z/OS`_
 - `z/OS shell`_
 - `z/OS OpenSSH`_
 - IBM `Open Enterprise SDK for Python`_
 - IBM `Z Open Automation Utilities`_ (ZOAU)

Dependency matrix
-----------------

The dependency matrix lists the minimum component versions for each collection that became generally available (GA) 
for both, the control node and managed node.  

   +---------+----------------------------+----------------------------------------------------+-----------------------------------------------------+
   | Version |   Event Source             | Control Node                                       |   Managed Node                                      |
   +=========+============================+====================================================+=====================================================+
   | 1.0.x   |- IBM zSecure v3.1          |- `z/OS Core collection`_  1.13.x or later          |- `z/OS`_ V2R5 - V3Rx                                |
   |         |- Apache Kafka for Z v1.1.0 |- `Community General collection`_ 12.0.0 or later   |- `z/OS shell`_                                      |
   |         |                            |- `AAP`_ 2.6 or later                               |- `z/OS OpenSSH`_                                    |
   |         |                            |                                                    |- IBM `Open Enterprise SDK for Python`_              |
   |         |                            |                                                    |- IBM `Z Open Automation Utilities`_ 1.3.6 or later, |
   |         |                            |                                                    |  1.5.0 or earlier                                   |
   +---------+----------------------------+----------------------------------------------------+-----------------------------------------------------+


.. .............................................................................
.. Global Links
.. .............................................................................

.. _Red Hat Ansible Automation Platform Life Cycle:
   https://access.redhat.com/support/policy/updates/ansible-automation-platform
.. _z/OS Core collection:
   https://ibm.github.io/z_ansible_collections_doc/ibm_zos_core/docs/source/ansible_content.html
.. _Community General collection:
   https://docs.ansible.com/projects/ansible/latest/collections/community/general/index.html
.. _z/OS OpenSSH:
   https://www.ibm.com/docs/en/zos/latest?topic=zbed-zos-openssh
.. _Open Enterprise SDK for Python lifecycle:
   https://www.ibm.com/support/pages/lifecycle/search?q=5655-PYT
.. _Z Open Automation Utilities:
   https://www.ibm.com/docs/en/zoau/latest
.. _z/OS shell:
   https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.4.0/com.ibm.zos.v2r4.bpxa400/part1.html
.. _AAP:
   https://access.redhat.com/support/policy/updates/ansible-automation-platform
.. _Open Enterprise SDK for Python:
   https://www.ibm.com/products/open-enterprise-python-zos
.. _z/OS:
   https://www.ibm.com/docs/en/zos