.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2021                                          .
.. ...........................................................................

=======================
IBM Z System Automation
=======================
The **IBM Z System Automation collection**, also represented as `ibm_zos_sysauto`_ in this document,
is  part of the broader initiative to bring Ansible Automation to IBM Z® through the offering
**Red Hat® Ansible Certified Content for IBM Z®**.

The **IBM Z System Automation collection** supports operational tasks using the IBM Z System Automation Operations API 
such as creating and deleting `dynamic resources`_ from a template defined in the current active policy of an `IBM Z System Automation`_ environment.

The Ansible roles in this collection are written in Ansible and interact with the `Operations REST server component`_ of IBM Z System Automation.

.. _ibm_zos_sysauto:
   https://galaxy.ansible.com/ibm/ibm_zos_sysauto
.. _IBM Z System Automation:   
   https://www.ibm.com/products/z-system-automation
.. _Operations REST server component:
   https://www.ibm.com/support/knowledgecenter/de/SSWRCJ_4.2.0/com.ibm.safos.doc_4.2/Integrating.html
.. _dynamic resources:
   https://www.ibm.com/support/knowledgecenter/de/SSWRCJ_4.2.0/com.ibm.safos.doc_4.2/UserGuide/Dynamic_Resources.html
  
   
.. toctree::
   :maxdepth: 1
   :caption: Collection Content

   source/roles  