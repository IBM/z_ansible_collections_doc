.. ...........................................................................
.. © Copyright IBM Corporation 2020                                          .
.. ...........................................................................

=========
Playbooks
=========

An `Ansible playbook`_ consists of organized instructions that define work for
a managed node (host) to be managed with Ansible.

There are many playbooks available in our `samples repository`_ contributed
and supported by **Red Hat Ansible Certified Content for IBM Z**. The repository
playbooks demonstrate various topics that include `z/OS administration`_,
`z/OS concepts`_ and `IMS`_. The sample playbook can be run with the
``ansible-playbook`` command with some modification to the **inventory**,
**ansible.cfg** and **group_vars**.

You can find the playbook content included with each sample in the
`samples repository`_. For more information, refer to
the documentation included with each sample.

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


Inventory
=========

Ansible works with multiple managed nodes (hosts) that must be written into a
list known as **inventory**. After the inventory is defined, you
can use the patterns to select the hosts or groups that you want Ansible to run
against. Review the `inventory section`_ in the corresponding documentation to
learn more about how inventory is defined.

.. _inventory section:
   https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html

Group_vars
==========

Group variables (group_vars) enable you to manage the variables and organize the
the variable values easily. Group variables can be stored either in the
inventory file or separate host and group variable files.

Each sample in the `samples repository`_ can vary on which **group_vars** are
required, review the documentation that is included with each sample.

Run a playbook
==============

Use the Ansible command ``ansible-playbook`` to run the sample playbook.  The
command syntax is ``ansible-playbook -i <inventory> <playbook>``; for example,
``ansible-playbook -i inventory sample.yaml``.

Optionally, you can configure the console logging verbosity during playbook
execution. This is helpful in situations where communication is failing and
you want to obtain more details. To adjust the logging verbosity, append more
letter `v`'s; for example, `-v`, `-vv`, `-vvv`, or `-vvvv`. Each letter `v`
increases logging verbosity similar to traditional logging levels INFO, WARN,
ERROR, DEBUG.

.. note::
   It is a good practice to review the playbook samples before executing them.
   It will help you understand what requirements in terms of space, location,
   names, authority, and artifacts will be created and cleaned up. Although
   samples are always written to operate without the need for the user's
   configuration, flexibility is written into the samples because it is not
   easy to determine if a sample has access to the host's resources.
   Review the playbook notes sections for additional details and
   configuration.

   Sample playbooks often perform operations such as copying data or
   submitting JCL that are included with the sample under a files directory.
   Review the sample artifacts for necessary edits to allow for submission on
   the target system.

.. _ask-pass documentation:
   https://linux.die.net/man/1/sshpass


