.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2021                                          .
.. ...........................................................................

==========================
Frequently Asked Questions
==========================

General
=======

How do I install an Ansible for IBM Z collection?
-------------------------------------------------
There are several options for installing **Ansible for IBM Z** collections,
including Ansible Galaxy, Automation Hub, private Galaxy server, or from a
Git repository.

For detailed instructions on how to install a collection, review
*Software Installation's* topic :ref:`Ansible for IBM Z<install-collections>`.

What are the requirements for Ansible for IBM Z collections?
------------------------------------------------------------
Each **Ansible for IBM Z** collection, or version of a collection will have
different requirements and dependencies.


To find out more details, review th :ref:`Software Requirements<software-requirements>`.

How can I test if Ansible can reach a z/OS managed node (host)?
---------------------------------------------------------------
If you have installed the IBM z/OS Core collection, you can use the ``zos_ping``
module, otherwise you can use the ``ansible.builtin.ping`` module that is included
with Ansible.

With the *ibm.ibm_zos_core.zos_ping* module from the command line:

.. code-block:: sh

   ansible all \
   -i '<zos-host-name>,' \
   -u '<user>' \
   -m 'ibm.ibm_zos_core.zos_ping' \
   --scp-extra-args='-O' \
   -k

With the *ansible.builtin.ping* module from the command line:

.. code-block:: sh

   ansible all \
   -i '<zos-host-name>,' \
   -u '<user>' \
   -m 'ansible.builtin.ping' \
   -e 'ansible_python_interpreter=</path/to/zos/python/python3>' \
   -k

How much memory and RAM do I need to install a collection?
----------------------------------------------------------
Requirements may vary based on how many hosts Ansible will manage
simultaneously (which is controlled by the forks parameter in the ansible.cfg file).

To avoid resource conflicts, Ansible recommends 1 GB of memory per 10 forks.

Do I have to upgrade to the latest version of a collection when there is a new release?
---------------------------------------------------------------------------------------
Although it is not required, it is recommended that you upgrade to the
latest release as they often contain bugfixes to existing modules and plugins.

If you are currently facing issues with any of the modules, upgrading to the
latest release could likely resolve the problem.

How can I determine which version of a collection I am using?
-------------------------------------------------------------
Using the *ansible-galaxy* command, you can list the collections version and path
to where the  collection is located.

.. code-block:: sh

   ansible-galaxy collection list

For detailed instructions on how to check a collection version, review
*Software Installation's* topic :ref:`Ansible for IBM Z<install-collections>`.

How do I upgrade a collection to the latest version?
----------------------------------------------------
To upgrade the collection to the latest available version, use the `ansible-galaxy`` command.

.. code-block:: sh

   ansible-galaxy collection install <namespace>.<collection name> --upgrade

For detailed instructions on how to upgrade a collection, review
*Software Installation's* topic :ref:`Upgrade Ansible for IBM Z<install-collections>`.

How frequently are the collections updated?
-------------------------------------------
The **Ansible for IBM Z** collections are released on a flexible cycle. Each
collection manages the release cadence which can vary depending on the complexity
of the features being developed.

For detailed explanation of a collections release cycle, review
the collections :ref:`collections life cycle<collection-life-cycles>`.


Where can I find the documentation for an Ansible for IBM Z collection?
-----------------------------------------------------------------------
Documentation for all collections can be accessed in:

- `Ansible Automation Hub IBM Z collections`_.
- `Ansible Galaxy IBM Z collections`_.
- `Red Hat Ansible Certified Content for Z`_ site.
- ansible-doc command, e.g. ``ansible-doc zos_copy``

.. _Ansible Automation Hub IBM Z collections:
   https://console.redhat.com/ansible/automation-hub/?page_size=12&view_type=list&tags=zos
.. _Ansible Galaxy IBM Z collections:
   https://galaxy.ansible.com/ui/collections/?page_size=10&view_type=null&sort=namespace&page=1&keywords=ibm_z*&namespace=ibm&tags=infrastructure
.. _Red Hat Ansible Certified Content for Z:
   https://ibm.github.io/z_ansible_collections_doc/index.html
.. _collections documentation:
   https://cloud.redhat.com/ansible/automation-hub/?page_size=12&view_type=list&tags=zos

Can I make a request for a new module or enhancement?
-----------------------------------------------------
Absolutely, if you have an idea you would like to share, there are several ways to
communicate this to IBM. Before creating a request in any of the recommended processes
we recommend you look over the current open requests to see if its already been
requested.

To request a new module or enhancement, you can do so by suggesting an idea
in the `IBM Ideas portal`_.

Optionally, you can go directly to the collections repository and create an issue
describing your request.

* `IBM z/OS Core <https://github.com/ansible-collections/ibm_zos_core/issues/new/choose>`_
* `IBM z/OS CICS <https://github.com/ansible-collections/ibm_zos_cics/issues/new/choose>`_
* `IBM z/OS IMS  <https://github.com/ansible-collections/ibm_zos_ims/issues/new/choose>`_
* `IBM z/OS Sys Auto <https://github.com/ansible-collections/ibm_zos_sysauto/issues/new/choose>`_
* `IBM z/OSMF <https://github.com/IBM/ibm_zosmf/issues>`_
* `IBM Z HMC <https://github.com/zhmcclient/zhmc-ansible-modules/issues>`_

.. _IBM Ideas portal:
   https://ideas.ibm.com

Playbooks
=========

Where can I learn about the best practices to use when developing playbooks?
----------------------------------------------------------------------------
There are several resources we recommend developers review when they are creating
playbooks, see:

* `Ansible tips and tricks <https://docs.ansible.com/ansible/2.8/user_guide/playbooks_best_practices.html>`_
* `Playbook contribution guidelines from IBM <https://github.com/IBM/z_ansible_collections_samples/blob/main/docs/share/contribution-guidelines.md#playbook-development-guidelines>`_

In general, some of the foundational practices are:

* Playbooks use whitespace and comments for maintainability.
* Playbooks use variables and assign them descriptive names.
* Groups tasks logically with blocks.
* Use strategic debug messages to demonstrate progress.
* Use *group_vars* and *host_vars* in projects which is particularly useful if the variables contained
  in groups_vars and host_vars don't have much in common with other systems.
* Use modules and roles from multiple collections to achieve results.
* Plan `keywords`_ accordingly to control execution, for example; `Asynchronous, polling`_, `serial`_, etc

.. _keywords:
   https://docs.ansible.com/ansible/latest/reference_appendices/playbooks_keywords.html#playbook-keywords
.. _Asynchronous, polling:
   https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_async.html
.. _serial:
   https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_strategies.html#setting-the-batch-size-with-serial


Does the user running the Ansible playbook need to have any special privileges?
-------------------------------------------------------------------------------
Some of the modules in Ansible for IBM Z will perform operations that require the
playbook user to have appropriate authority with various RACF resource classes.
Each module documents which access is needed in the notes section. A user is
described as the remote SSH user executing playbook tasks, who can also obtain
escalated privileges to execute as another user.

For module documentation, review :ref:`collections<ansible-content>`

Modules
=======

Can I contribute or modify the source for the Ansible for IBM Z collections?
----------------------------------------------------------------------------
Yes, currently the collections don't offer publicly accessible pipelines to test
changes you contribute, but the development teams can review the changes, provide feedback
and run the changes in the development pipelines so that the changes can be accepted.

Several of the collections offer detailed instructions on how to develop, test and
contribute changes, for this content, review the :ref:`contributing<community_contributions>`
topic.


Do the Ansible for IBM Z modules leave any files behind after a playbook completes?
-----------------------------------------------------------------------------------
Modules only leave files behind when configured to do so, for example, when copying files
or performing a backup. During execution, modules create temporary files and folders on the
managed node, usually in the ``/tmp`` directory, which are then removed after the module
has completed execution.

The remote ``/tmp`` directory used by Ansible can be changed by updating the Ansible environment
variable `ANSIBLE_REMOTE_TEMP`_ or configuration `remote_tmp`_.

.. _ANSIBLE_REMOTE_TEMP:
   https://docs.ansible.com/ansible/latest/collections/environment_variables.html#envvar-ANSIBLE_REMOTE_TEMP
.. _remote_tmp:
   https://docs.ansible.com/ansible/latest/collections/ansible/builtin/sh_shell.html#parameter-remote_tmp


Are the Ansible for IBM Z modules idempotent?
---------------------------------------------
Some modules according to their documentation will not produce different results executed multiple times,
but other modules can be idempotent when the playbook tasks included Ansible conditionals such as
`changed`_ and `changed_when`_.

.. _changed:
   https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_conditionals.html#basic-conditionals-with-when
.. _changed_when:
   https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_error_handling.html#defining-changed

Do the Ansible for IBM Z modules support check mode?
----------------------------------------------------
Please refer to the modules :ref: `documentation<ansible-content>` to understand how the module
supports check mode.

Where can I find a sample playbooks that are using the Ansible for IBM Z collections?
-------------------------------------------------------------------------------------
You can find many sample playbooks, links to blogs, and other community
resources in the
`Samples repository for Red Hat Ansible Certified Content for IBM Z`_.

.. _Samples repository for Red Hat Ansible Certified Content for IBM Z:
   https://github.com/IBM/z_ansible_collections_samples


How can I customize how Ansible operates in my environment?
-----------------------------------------------------------
You can specify what configuration Ansible uses when running playbooks by
modifying the ``ansible.cfg`` file or defining the **ANSIBLE_CONFIG** environment
variable. For more information, refer to the `configuration guide for Ansible`_.

.. _configuration guide for Ansible:
   https://docs.ansible.com/ansible/latest/installation_guide/intro_configuration.html

How can I test the playbooks I have written?
--------------------------------------------
There are testing strategies you can follow to test your playbooks.
Refer to the official testing `strategies recommended by Ansible`_.

.. _strategies recommended by Ansible:
  https://docs.ansible.com/ansible/latest/reference_appendices/test_strategies.html

Support
=======

If I encounter a problem with an Ansible for IBM Z collection, how can I obtain support?
----------------------------------------------------------------------------------------
There are two paths to obtaining support, for entitled Ansible Automation platform customers,
you can open support cases on any Ansible for IBM Z collection, otherwise, you create a GitHub
issue on the collections repository.

For detailed instructions on how to obtain support, see section :ref:`getting-support`.

Messages
========

What causes the *unsupported parameter* error?
----------------------------------------------
This happens when you specify a module option that either does not exist or
is deprecated. Carefully examine the module documentation to understand what
parameters it supports.

What causes the *utf-8 codec can't decode byte* error?
------------------------------------------------------
The most likely cause of this error is that you have not properly set up your
environment variables for your managed node. Refer to the following
`configuration guide`_ to understand which environment variables need to be
defined.

.. code-block::

   UnicodeDecodeError: 'utf-8' codec can't decode byte in position 0: invalid continuation byte"

.. _configuration guide:
    https://github.com/IBM/z_ansible_collections_samples/blob/main/docs/share/zos_core/configuration_guide.md


What causes the *IOError* during playbook execution?
----------------------------------------------------
It is likely that the ``/tmp`` directory of the managed node is full and cannot
store any more data. Clear the ``/tmp`` directory and re-run the playbook.

.. code-block:: sh

   IOError: [Errno 21] Is a directory: u'/tmp/xxx'