.. ...........................................................................
.. © Copyright IBM Corporation 2020                                          .
.. ...........................................................................

Managed node
============
The managed z/OS® node is the host that is managed by Ansible®, as identified in
the Ansible inventory.

The **IBM Z® System Automation collection** requires the optional component
called **System Automation Operations REST server**. This provides a RESTful API
for many operations tasks that can be used to integrate SA operations into
Ansible® and other products.

* `IBM Z System Automation`_: V4.2 with PTF for SPE APAR OA59461 applied.

The `IBM Z System Automation Operations REST server`_ must be installed,
configured and running on **at least one** z/OS system in an SA-Plex where an
Ansible node is managed. Information about the IBM Z System Automation
Operations REST server can be configured in the Ansible `inventory`_
or in the Ansible ``vars``, such as the host name and port number.

The authentication information to connect to the IBM Z System Automation
Operations REST server is provided when running a playbook
or it will be prompted during playbook run.

For more details about installation and configuration, refer to the
`Configure and Run the System Automation Operations REST Server`_ documentation.


.. _IBM Z System Automation:
   https://www.ibm.com/support/knowledgecenter/SSWRCJ_4.2.0/com.ibm.safos.doc_4.2/kc_welcome-444.html
.. _Configure and Run the System Automation Operations REST Server:
   https://www.ibm.com/support/knowledgecenter/de/SSWRCJ_4.2.0/com.ibm.safos.doc_4.2/InstallPlan/set_up_rest_server.html

.. ...........................
.. TODO:
.. `inventory` should really point to https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html
.. but we can't until playbooks are removed from doc and move to the playbooks repository
.. ...........................

.. _inventory:
   playbooks.html#inventory
.. _IBM Z System Automation Operations REST server:
   https://www.ibm.com/support/knowledgecenter/de/SSWRCJ_4.2.0/com.ibm.safos.doc_4.2/ProgrammersReference/Overview_rest_server.html   