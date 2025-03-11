.. ...........................................................................
.. © Copyright IBM Corporation 2020                                          .
.. ...........................................................................

==========================
Requirements
==========================

The **IBM Z System Automation collection** requires both a **control node** and a
**managed node** to be configured with the following set of requirements. The
control node is often referred to as the **controller** and the
managed node as the **host**.

Control node
============
The controller is where the Ansible engine that runs the playbook is installed.
Refer to RedHat Ansible Certified Content documentation for more on the `controllers dependencies`_.

Managed node
============
The **Managed node** is often referred to as a target node, or host, and is the node that is managed by Ansible.
Ansible does not need to be installed on a managed node.

* `IBM Z System Automation`_: V4.2 with PTF for SPE APAR OA59461 applied.

   The `IBM Z System Automation Operations REST server`_ must be installed, configured and running on **at least one** z/OS system in an SA-Plex
   where the managed node runs in. Information about the IBM Z System Automation Operations REST server can be configured in the Ansible `inventory`_
   or in the Ansible ``vars``, such as the host name and port number.
   
   The authentication information to connect to the IBM Z System Automation Operations REST server is provided when running a playbook
   or it will be prompted during playbook run.
   
   For more details about installation and configuration, refer to the `Configure and Run the System Automation Operations REST Server`_ documentation.


.. _controllers dependencies:
   https://ibm.github.io/z_ansible_collections_doc/requirements/requirements_controller.html
.. _inventory:
   https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html
.. _IBM z/OS:
   https://www.ibm.com/support/knowledgecenter/SSLTBW_2.2.0/com.ibm.zos.v2r2/en/homepage.html
.. _IBM Z NetView:
   https://www.ibm.com/support/knowledgecenter/en/SSZJDU_6.3.0/com.ibm.iznetview.doc_6.3.0/netv630_welcome_kc.html
.. _IBM Z System Automation:
   https://www.ibm.com/support/knowledgecenter/SSWRCJ_4.2.0/com.ibm.safos.doc_4.2/kc_welcome-444.html
.. _Configure and Run the System Automation Operations REST Server:
   https://www.ibm.com/support/knowledgecenter/de/SSWRCJ_4.2.0/com.ibm.safos.doc_4.2/InstallPlan/set_up_rest_server.html
.. _IBM Z System Automation Operations REST server:
   https://www.ibm.com/support/knowledgecenter/de/SSWRCJ_4.2.0/com.ibm.safos.doc_4.2/ProgrammersReference/Overview_rest_server.html