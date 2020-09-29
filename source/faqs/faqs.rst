.. ...........................................................................
.. © Copyright IBM Corporation 2020                                          .
.. ...........................................................................

Installation, versions
======================

How do I install a collection?
------------------------------

You can install a collection using one of the following options:

* Ansible Galaxy : Use the ``ansible-galaxy`` command with the **install**
  option to install a collection hosted in Galaxy on your control node

* Automation Hub and Private Galaxy server:  You can use the ``ansible-galaxy``
  command with the **install** option to install a collection on your
  control node hosted in Automation Hub or a private Galaxy server.
  You need to configure the ``auth_url`` option and the API ``token``  in
  **ansible.cfg** for each server name.

* Local installation: You can use the ``ansible-galaxy`` collection install
  command to install a collection built from source. To build your own
  collection, you must clone the Git repository, build the collection archive,
  and install the collection.

For detailed instructions on how to install a collection, see our
`installation doc`_.

What do I require to install a collection?
------------------------------------------
All **IBM z/OS collections** require **Ansible 2.9 or later**,
**Python 2.7 or later** and **Open SSH** on the Ansible controller.

On the z/OS managed node, a particular **IBM z/OS collection** or release can
have a different set of requirements. Before you install any
**IBM z/OS collection**, review the collection `requirements`_.

.. _requirements:
   https://ibm.github.io/z_ansible_collections_doc/requirements/requirements.html


How do I install and configure ZOAU?
------------------------------------

* For a brief overview of **ZOAU**, review our `ZOAU documentation`_.
* Configuring Ansible host or group vars, review our `variable configuration`_.
* For configuration information, visit the `ZOAU product page`_.
  * Select the latest version and then select "Installing and configuring ZOA Utilities".

.. _ZOAU documentation:
   https://ibm.github.io/z_ansible_collections_doc/ibm_zos_core/docs/source/requirements_managed.html#zoau

.. _ZOAU product page:
   https://www.ibm.com/support/knowledgecenter/en/SSKFYE

.. _variable configuration:
   https://github.com/IBM/z_ansible_collections_samples/blob/master/docs/share/configuration_guide.md#variables


Where can I download the latest version of Python?
--------------------------------------------------

Refer to `IBM Open Enterprise Python product page`_ to find out how to get
access to Python.

.. _IBM Open Enterprise Python product page:
   https://www.ibm.com/products/open-enterprise-python-zos


Do I need any additional installation on z/OS?
----------------------------------------------

Different collections as part of the offering will have different requirements.
Refer to the `release notes`_ of a collection to determine the specific
requirements.


Ansible Tower/AWX: How much memory and RAM do I need to install a collection?
-----------------------------------------------------------------------------

For **Ansible Tower**, Ansible recommends a minimum of 4GB RAM for for
Tower installation.

Additional RAM requirements may vary based on how many hosts Tower will manage
simultaneously (which is controlled by the forks parameter in the job template
or the system ansible.cfg file).

To avoid resource conflicts, Ansible recommends 1 GB of memory per
10 forks + 2GB reservation for Tower. For example, if forks is set to 400, 
40 GB of memory is recommended. See the capacity algorithm to determine resource requirements. 

For more information about the requirements, see `system requirements`_.

.. _system requirements:
   https://docs.ansible.com/ansible-tower/latest/html/installandreference/requirements_refguide.html


For individual **playbooks**, the memory usage is dependent on a few factors:

* The number of z/OS hosts managed by the playbook and the number of forks created by 
  Ansible
* The number of tasks within the playbook
* The modules used within the playbook
* The number of tasks that are delegated to the local host
* Whether fact gathering is turned on or off in the playbook


Do I have to upgrade to the latest version of a collection when there is a new release?
---------------------------------------------------------------------------------------

Although it is not required, we recommended that you upgrade to the
latest release as they often contain bugfixes to existing modules and plugins.

If you are currently facing issues with any of the modules, upgrading to the
latest release could likely resolve the problem.


How can I know which version of a collection I am using?
--------------------------------------------------------

Navigate to the directory where you have installed your collection. The default
installation directory is:

.. code-block:: sh

   ~/.ansible/collections/ansible_collections/ibm/<collection-name>

After you have navigated to that directory, run the following command:
``cat MANIFEST.json | grep version``


How do I update a collection to the latest version?
---------------------------------------------------

The easiest and recommended way to update your collection is by using the
`ansible-galaxy` command:

.. code-block:: sh

   ansible-galaxy collection install <collection-name:version> --force

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

Yes, they are idempotent. Repeated execution of the modules included in
**Red Hat Ansible Certified Content for IBM Z** does not produce different
behavior.

Which modules support check mode?
---------------------------------

Modules that currently support check mode:  ``zos_data_set``

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


Troubleshooting, Messages
=========================

How can I test if an Ansible or z/OS module is able to reach the target (host)?
-------------------------------------------------------------------------------
You can test if a collection is installed and is working correctly by executing
the command illustrated in the example below. Ensure that you change the host
name to your remote z/OS host, as well as the user and Python binary path.

.. note::
   The following example illustrates testing the installation of the
   z/OS core collection.

.. code-block:: sh

    ansible all \
    -i '<zos-host-name>,' \
    -c 'ibm.ibm_zos_core.zos_ssh' \
    -u 'user-name' \
    -m 'ibm.ibm_zos_core.zos_ping' \
    -e 'ansible_python_interpreter=/path/to/zos/python/binary'


The above command executes the ``zos_ping`` module against your remote
z/OS host. If the command succeeds and returns the following output,
the collection was installed correctly.

.. code-block:: sh

    <zos-host-name> | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }

Which modules are affected when  using ``askpass`` instead of SSH authentication?
---------------------------------------------------------------------------------
Data transfer modules such as ``zos_copy`` and ``zos_fetch`` depend on the
authenticated ``SSH`` connection from the control node to the managed node. When
using these modules, ensure that the connection from the controller to the
managed node is authenticated using an SSH key. Both
``zos_copy`` and ``zos_fetch`` modules do not support Ansible ad-hoc
``--ask-pass``.


Does a user running Ansible on USS need to have any special privileges?
-------------------------------------------------------------------------
Whether special user privileges are required would depend on the type of task
Ansible is performing on the remote host. For instance, accessing or
changing system resources with insufficient access permissions,
would require elevated privileges.

If a task requires ``root`` privileges on USS, you can execute the it with the 
``become: yes`` parameter. Alternatively, if you want to execute a task as a
particular user, you can use ``become_user: <user_name>`` parameter.


What causes the error: **"unsupported parameter"**? How do I fix it?
-----------------------------------------------------------------------------------------------
This tends to happen when you are specifying a parameter to a module that it
doesn't support or is deprecated. Update your collection to the latest version
and review the collection requirements in the `release notes`_ to make sure you
are using the latest version of the modules and carefully examine the module
documentation to understand what parameters it supports.


When using IBM Python, why do I get this error?
-----------------------------------------------
.. code-block:: sh

   UnicodeDecodeError: 'utf-8' codec can't decode byte in position 0: invalid continuation byte"

The most likely cause of this error is that you have not properly set up your
environment variables for your managed node. Refer to the following
`configuration guide`_ to understand which environment variables need to be
defined.

.. _configuration guide:
    https://github.com/IBM/z_ansible_collections_samples/blob/master/docs/share/configuration_guide.md


What causes this error during the playbook execution? How do I fix it?
----------------------------------------------------------------------

.. code-block:: sh

   EDC5129I No such file or directory.: b'mvscmdauth'", "rc": 129


``mvscmdauth`` is a **ZOAU** shell utility. This error tends to happen when
**ZOAU** installation is not added to the system **PATH**. Modify your host
variables and add the ``bin`` directory of the **ZOAU** installation. for
example, if **ZOAU** was installed in ``/usr/lpp/IBM/zoau``, you should add
``/usr/lpp/IBM/zoau/bin`` to **PATH**.


Why do I get this error during the playbook execution ?
-------------------------------------------------------

.. code-block:: sh

   IOError: [Errno 21] Is a directory: u'/tmp/xxx'
   

It is likely that the ``/tmp`` directory of the managed node is full and cannot
store any more data. Clear the ``/tmp`` directory and re-run the
playbook.


Why do I get this warning during the playbook execution ?
---------------------------------------------------------

.. code-block:: sh

   [WARNING]: Python Warning: Incorrect Python Found

It is likely that you are using an older version of the collection which was
supported by the **Rocket Python** distribution. Verify that you have installed
**IBM Open Enterprise Python for z/OS** on your z/OS managed node and upgrade
to the latest version of the collection. To learn more about how to upgrade the
collection, see our `installation doc`_ or the sample `repository doc`_.

.. _repository doc:
    https://docs.ansible.com/ansible/latest/user_guide/collections_using.html#id2

.. note::

   By default the ``ansible-galaxy install`` command installs the latest
   collection.

Why do I get this error during the playbook execution ?
-------------------------------------------------------

.. code-block:: sh

   Internal Error: Unable to find message file for command: mvscmdmsg

``mvscmdmsg`` is a **ZOAU** utility. Generally, this issue appears when the
environment variables are configured incorrectly. Refer to the
`configuration guide`_ documentation to understand how to properly configure
these variables.


Why does my managed z/OS system pre-login prompt cause the ``zos_copy`` and ``zos_fetch`` modules to fail?
----------------------------------------------------------------------------------------------------------

By default, ``SFTP`` redirects **pre-login** prompts to system **stderr**,
which ``zos_copy`` interprets as a failure. You can bypass this behavior and
ignore stderr content by setting **ignore_sftp_stderr** parameter of
``zos_copy`` to **true**.


Community
=========

Where can I open issues and track them?
----------------------------------------------
You can track open issues and raise new issues for bugs, feature issues, or
comments in our `contributing topic`_.

.. _contributing topic:
    https://ibm.github.io/z_ansible_collections_doc/reference/community.html

How frequently are the collections updated?
-------------------------------------------
We follow Agile methodologies to continuously deliver new features. The
complexity of the features drives the release cadence. We encourage you to
review the release notes to learn about our latest release.

What collections are offered as part of RedHat certified content?
-----------------------------------------------------------------
Currently, we offer collections for z/OS core and z/OS IMS under the Red Hat
Ansible Certified Content available in Ansible Automation Hub and Galaxy. These
collections offer a seamless, unified workflow orchestration with configuration
management, provisioning, and application deployment in one easy-to-use
platform.

Can I contribute new modules to the collection?
-----------------------------------------------
We are currently not accepting community contributions. We do encourage you to
open git issues for bugs, comments or feature requests. To learn more about how
to contribute to a collection, see our `contributing topic`_.

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
    https://github.com/IBM/z_ansible_collections_samples/blob/master/docs/share/configuration_guide.md

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
