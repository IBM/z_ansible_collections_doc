.. ...........................................................................
.. © Copyright IBM Corporation 2020                                          .
.. ...........................................................................

=========
Playbooks
=========

An `Ansible playbook`_ consists of organized instructions that define work for
a managed node (host) to be managed with Ansible.

There are **many** playbooks available in our `samples repository`_ contributed
by the **Red Hat Ansible Certified Content for IBM Z** team. The
Git samples repository contain playbooks that  demonstrate various topics such
as:

* `z/OS administration`_
* `z/OS concepts`_
* `IMS`_

Playbooks, content, and topics are added to the
`samples repository`_ regularly. We encourage you to **Watch** the repository to
get notified by Git when there are updates.

The sample playbooks can be run with the ``ansible-playbook`` command and with
a little modification, the included **inventory**, **ansible.cfg**
and **host_vars** can be tailored to your environment. Each sample will
include all the necessary content that is needed to run a sample playbook.
For more information, refer to the documentation included with each sample
in the `samples repository`_.

.. _Ansible playbook:
   https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#playbooks-intro
.. _samples repository:
   https://github.com/IBM/z_ansible_collections_samples/blob/master/README.md
.. _z/OS administration:
   https://github.com/IBM/z_ansible_collections_samples/tree/master/zos_administration
.. _z/OS concepts:
   https://github.com/IBM/z_ansible_collections_samples/tree/master/zos_concepts
.. _IMS:
   https://github.com/IBM/z_ansible_collections_samples/tree/master/ims


Concepts
========

The `basic concepts`_ common to playbooks, the artifacts needed to run a
playbook such as **inventory** and **variables**, instructions on how
to run a playbook, and run it in the debug mode are discussed in
the following sections.

.. _basic concepts:
   https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html

Inventory
---------

Ansible works with multiple managed nodes (hosts) that must be written into a
list known as **inventory**. After the inventory is defined, you
can use the patterns to select the hosts or groups that you want Ansible to
manage. Review the `inventory section`_ in the corresponding documentation to
learn more about how inventory is defined.

.. _inventory section:
   https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html

Variables
---------

Host variables (host_vars) enable you to `manage the variables`_ and organize the
the variable values easily. Host variables can be stored either in the
**inventory** file or separate **host_vars** or **group_vars** variable files.
Each sample in the `samples repository`_ can vary on which **host_vars** or
**group_vars** are required. For more information, review the documentation that is included with
each sample.

.. _manage the variables:
   https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html#organizing-host-and-group-variables

Run a playbook
--------------

Use the Ansible command ``ansible-playbook`` to run a playbook.  The
command syntax is ``ansible-playbook -i <inventory> <playbook>``; for example,
``ansible-playbook -i inventory sample.yaml``.

For further reading, review `run your first command and playbook`_ and follow
up with `about playbooks`_.

.. _about playbooks:
   https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#about-playbooks

.. _run your first command and playbook:
   https://docs.ansible.com/ansible/latest/network/getting_started/first_playbook.html#run-your-first-command-and-playbook

Debugging
---------

Optionally, you can configure the console logging verbosity during playbook
execution. This is helpful in situations where communication is failing and
you want to obtain more details. To adjust the logging verbosity, append more
letter `v`'s; for example, `-v`, `-vv`, `-vvv`, or `-vvvv`. Each letter `v`
increases logging verbosity similar to traditional logging levels INFO, WARN,
ERROR, DEBUG.

.. note::
   It is a good practice to review the playbook samples before executing them.
   It will help you understand the requirements in terms of space, location,
   names, authority, and the artifacts that will be created and cleaned up. Although
   samples are always written to operate without the need for the user's
   configuration, flexibility is written into the samples because it is not
   easy to determine if a sample has access to the host's resources.
   Review the playbook notes sections for additional details and
   configuration.



