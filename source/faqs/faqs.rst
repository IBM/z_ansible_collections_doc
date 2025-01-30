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


To find out more details, review th :ref:`Software Requirements<software-requirements>.

How can I test if Ansible can reach a z/OS managed node (host)?
---------------------------------------------------------------
If you have installed the IBM z/OS core collection, you can use the ``zos_ping``
module, otherwise you can use the ``ansible.builtin.ping`` module that is included
Ansible.

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
------------------------------------------------------------
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

The Ansible for IBM Z collections are released on a flexible cycle. Each
collection manages the release cadence which can vary depending on the complexity
of the features being developed.

For detailed explanation of a collections release cycle, review
the collections :ref:`collections life cycle<collection-life-cycles>`.


Where can I find the documentation for a particular collection?
---------------------------------------------------------------
Collections certified with Red Hat Automation Hub will have integrated
documentation. If you have entitlement to Automation Hub, you can
view the `collections documentation`_. You can also navigate to
**Ansible Automation Hub** --> **Collections** --> **enter a collection name in the
Filter by keywords field** --> **Documentation**.

Optionally, you can access documentation under **Ansible Content** in the
Red Hat Ansible Certified Content for IBM Z collection documentation site.

.. _collections documentation:
   https://cloud.redhat.com/ansible/automation-hub/?page_size=12&view_type=list&tags=zos

Modules, Playbooks
==================

What are the best practices for module development and testing z/OS Ansible modules?
------------------------------------------------------------------------------------

For recommendations on module development and testing, see the
`community guides`_.

.. _community guides:
   https://ibm.github.io/z_ansible_collections_doc/ibm_zos_core/docs/source/community_guides.html#development


Do the modules leave any objects or files behind after a playbook completes running?
------------------------------------------------------------------------------------

The modules create temporary files and folders on the managed z/OS system
(usually in the ``/tmp`` directory), which are then cleaned up after the module
execution.

The only other instance where objects are left behind is when a
module option has been configured to perform a backup.


Are the modules idempotent?
---------------------------

.. Yes, they are idempotent. Repeated execution of the modules included in
.. **Red Hat Ansible Certified Content for IBM Z** does not produce different
.. behavior.

Repeated execution of the modules included in **Red Hat Ansible Certified Content
for IBM Z** does not produce different behavior. To check if a module is idempotent,
please review the module **Notes** that you intend to use in the playbook.

Which modules support check mode?
---------------------------------

Modules that currently support check mode:  ``zos_data_set``, ``zos_job_query``,
and ``zos_mvs_raw``.

Can I customize when my module should fail?
-------------------------------------------
Yes, you can override the default failure condition by using the built-in mechanisms
for overriding module failures that Ansible provides. For example, we have published a
`sample playbook`_ which shows how you can customize the failure condition of the
cmci_get module so that it ignores failures due to finding no programs.

.. _sample playbook:
   https://github.com/IBM/z_ansible_collections_samples/tree/main/zos_subsystems/cics/cmci/override_failure

Where can I find a sample playbook?
-----------------------------------

You can find many sample playbooks, links to blogs, and other community
resources in the
`Samples repository for Red Hat Ansible Certified Content for IBM Z`_.

.. _Samples repository for Red Hat Ansible Certified Content for IBM Z:
   https://github.com/IBM/z_ansible_collections_samples


Are there any specific requirements for running a playbook?
-----------------------------------------------------------
Running a playbook has a few requirements that could be dependent on the
included collections as well as space, location, names, and authority. A
few artifacts will be created and cleaned up to enable running a playbook. To
review the requirements, see `playbooks`_.

.. _playbooks:
   https://ibm.github.io/z_ansible_collections_doc/playbooks/playbooks.html


How can I customize how Ansible operates in my environment?
-----------------------------------------------------------

You can specify what configuration Ansible uses when running playbooks by
modifying the ``ansible.cfg`` file or defining the **ANSIBLE_CONFIG** environment
variable. For more information, refer to the `configuration guide for Ansible`_.

.. _configuration guide for Ansible:
   https://docs.ansible.com/ansible/latest/installation_guide/intro_configuration.html

How do I test my playbooks?
---------------------------

There a couple of testing strategies you can follow to test your playbooks.
Refer to the official testing  `strategies recommended by Ansible`_.

.. _strategies recommended by Ansible:
  https://docs.ansible.com/ansible/latest/reference_appendices/test_strategies.html

Support
=======

If I run into a problem when using an Ansible collection for IBM Z, how should I seek support?
----------------------------------------------------------------------------------------------
For issues related to the Ansible collections, raise a GitHub issue against the
appropriate collection repository:

* `IBM z/OS core <https://github.com/ansible-collections/ibm_zos_core/issues/new/choose>`_
* `IBM z/OS CICS <https://github.com/ansible-collections/ibm_zos_cics/issues/new/choose>`_
* `IBM z/OS IMS  <https://github.com/ansible-collections/ibm_zos_ims/issues/new/choose>`_
* `IBM z/OS Sys Auto <https://github.com/ansible-collections/ibm_zos_sysauto/issues/new/choose>`_
* `IBM z/OSMF <https://github.com/IBM/ibm_zosmf/issues>`_
* `IBM Z HMC <https://github.com/zhmcclient/zhmc-ansible-modules/issues>`_

Community
=========

Where can I open issues and track them?
----------------------------------------------
You can track open issues and raise new issues for bugs, feature issues, or
comments in our `contributing topic`_.

.. _contributing topic:
    https://ibm.github.io/z_ansible_collections_doc/reference/community.html

Can I contribute new modules to the collection?
-----------------------------------------------
We are currently not accepting community contributions. We do encourage you to
open git issues for bugs, comments or feature requests. To learn more about how
to contribute to a collection, see our `contributing topic`_.

Others
======

How are precedence rules defined in Ansible?
--------------------------------------------

Ansible offers four sources for controlling its behavior. In order of precedence
from lowest (most easily overridden) to highest (overrides all others), the
categories are:

* Configuration settings
* Command-line options
* Playbook keywords
* Variables


For a more detailed explanation of precedence rules, refer to both the
`official documentation`_ and `reference`_.

.. _official documentation:
   https://docs.ansible.com/ansible/latest/reference_appendices/general_precedence.html

.. _reference:
   https://docs.ansible.com/ansible/latest/reference_appendices/config.html#the-configuration-file>>


.. ..........................................................................
.. . Global doc links
.. ..........................................................................

.. _configuration guide:
    https://github.com/IBM/z_ansible_collections_samples/blob/main/docs/share/zos_core/configuration_guide.md

.. _installation doc:
   https://ibm.github.io/z_ansible_collections_doc/installation/installation.html

.. _release notes:
   https://ibm.github.io/z_ansible_collections_doc/release/release.html

.. _contributing topic:
    https://ibm.github.io/z_ansible_collections_doc/reference/community.html


.. ..........................................................................
.. . Disabled for the time being, when the collections can contribute content
.. . enable this feature
.. ..........................................................................
.. Offerings
.. =========
..
.. .. toctree::
..    :maxdepth: 1
..
..    z/OS core </../ibm_zos_core/docs/source/faqs.rst>
..    z/OS IMS </../ibm_zos_ims/docs/source/faqs.rst>
