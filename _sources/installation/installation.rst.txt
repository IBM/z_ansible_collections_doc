.. ...........................................................................
.. © Copyright IBM Corporation 2020-21                                          .
.. ...........................................................................

============
Installation
============

Collections are a distribution format for prepackaged Ansible content including
playbooks, roles, modules, and plugins that enable you to quickly set up your
automation project. Collections are hosted and available for installation from
Ansible Galaxy.

Before you install a collection, review the `requirements`_ to learn about any
dependencies and determine the appropriate installation option.

You can install a **Red Hat® Ansible® Certified Content for IBM Z® collection**
using one of these options:

- `Ansible Galaxy`_
- `Ansible Automation Hub`_
- `Local build`_

.. _Ansible Galaxy:
   installation.html#ansible-galaxy

.. _Ansible Automation Hub:
   installation.html#automation-hub-and-private-galaxy-server

.. _Local build:
   installation.html#id3

For more information on installing collections, see `using collections`_.

.. _using collections:
   https://docs.ansible.com/ansible/latest/user_guide/collections_using.html

.. _requirements:
   https://ibm.github.io/z_ansible_collections_doc/requirements/requirements.html

Ansible Galaxy
==============
Ansible Galaxy enables you to quickly configure your automation project with
content from the Ansible community. Ansible Galaxy provides prepackaged units of
work known as collections. You can use the `ansible-galaxy`_ command with
the ``install`` option to install a collection on your system, also referred to
as the control node.

Collections are installed using the **ibm** namespace followed by the collection
name. Collection names can be placed under the section labeled
**Ansible Content**. For example, ``ibm_zos_core``, ``ibm_zos_ims``,
``ibm_zos_cics``, ``ibm_zhmc`` and ``ibm_zos_sysauto`` are collection names
and the installation command would follow this syntax:

.. code-block:: sh

   $ ansible-galaxy collection install <namespace>.<collection name>

You can install an Ansible collection in one of these ways:

Fresh installation
------------------
By default, the `ansible-galaxy`_ command installs the latest available
collection. If you would like to install a previous version of a collection or if
the installation is unsuccessful, use the ``--force`` option to override an existing
installation or use a range identifier to install a specific version.

Use this command for a fresh installation:

.. code-block:: sh

   $ ansible-galaxy collection install ibm.<collection name>

Overriding an existing installation
-----------------------------------
If you want to override a previously installed version of a collection, use the
``--force`` option.

Use this command to override an existing version:

.. code-block:: sh

   $ ansible-galaxy collection install --force ibm.<collection name>

Installing a pre-release version
--------------------------------
A pre-release version of a collection is denoted by appending a hyphen and a series of
dot separated identifiers immediately following the patch version.
**IBM Z collections** follow `semantic versioning`_ that includes a pre-release
naming convention that requires a range identifier. For example, **1.1.0-beta.1**.
The `ansible-galaxy`_ command ignores any **pre-release** versions unless
the identifier is set to that pre-release version.


Here is an example command to install a pre-release version of a collection:

.. code-block:: sh

   $ ansible-galaxy collection install ibm.<collection name>:1.1.0-beta.1

By default, all collections are installed in ``~/.ansible/collections``. You can
use the `-p` option with `ansible-galaxy` to specify an installation path such as:

.. code-block:: sh

   $ ansible-galaxy collection install ibm.<collection name> -p /home/ansible/collections

The progress of the installation is output to the console:

.. code-block:: sh

   Process install dependency map
   Starting collection install process
   Installing 'ibm.<collection name>:1.0.0' to '/Users/user/.ansible/collections/ansible_collections/ibm/<collection name>  '

For more information on installing collections with Ansible Galaxy,
see `installing collections`_.

.. _installing collections:
   https://docs.ansible.com/ansible/latest/user_guide/collections_using.html#installing-collections-with-ansible-galaxy
.. _semantic versioning:
   https://semver.org/
.. _ansible-galaxy:
   https://docs.ansible.com/ansible/latest/cli/ansible-galaxy.html

Automation Hub and Private Galaxy server
========================================
Configuring access to a private Galaxy server follows the same procedure
that you would use to configure your client to point to Automation Hub.
You can use the `ansible-galaxy`_ command with the ``install`` option to
install a collection on the control node hosted in Automation Hub or a private
Galaxy server.

By default, the ``ansible-galaxy`` command is configured to access
``https://galaxy.ansible.com`` as the server when you install a
collection. The `ansible-galaxy` client can be configured to point to Ansible
Automation Hub or other servers, such as a privately running Galaxy server, by
configuring the server list in the ``ansible.cfg`` file. Ansible searches for
``ansible.cfg`` in the following locations in this order:

   * ANSIBLE_CONFIG (environment variable if set)
   * ansible.cfg (in the current directory)
   * ~/.ansible.cfg (in the home directory)
   * /etc/ansible/ansible.cfg

To configure a Galaxy server list in the ansible.cfg file:

  * Add the server_list option under the [galaxy] section to one or more
    server names.
  * Create a new section for each server name.
  * Set the url option for each server name.

For Automation Hub, you additionally need to:

  * Set the auth_url option for each server name.
  * Set the API token for each server name. For more information on API tokens,
    see `Get API token from the version dropdown to copy your API token`_.

.. _Get API token from the version dropdown to copy your API token:
   https://cloud.redhat.com/ansible/automation-hub/token/

.. note::

   When hosting a private Galaxy server or pointing to Hub, available content may not
   be always consistent with what is available on Ansible Galaxy server.

The following example shows a configuration for Automation Hub, a private
running Galaxy server, and Galaxy:

.. code-block:: yaml

   [galaxy]
   server_list = automation_hub, galaxy, private_galaxy

   [galaxy_server.automation_hub]
   url=https://cloud.redhat.com/api/automation-hub/
   auth_url=https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token
   token=<hub_token>

   [galaxy_server.galaxy]
   url=https://galaxy.ansible.com/

   [galaxy_server.private_galaxy]
   url=https://galaxy-dev.ansible.com/
   token=<private_token>

For more configuration information, see
`configuring the ansible-galaxy client`_ and `Ansible Configuration Settings`_.

.. _configuring the ansible-galaxy client:
   https://docs.ansible.com/ansible/latest/user_guide/collections_using.html#configuring-the-ansible-galaxy-client

.. _Ansible configuration Settings:
   https://docs.ansible.com/ansible/latest/reference_appendices/config.html


Local build
===========

You can use the ``ansible-galaxy collection install`` command to install a
collection built from source. To build your own collection, you must clone the
Git repository, build the collection archive, and install the collection. The
``ansible-galaxy collection build`` command packages the collection into an
archive that can later be installed locally without having to use Hub or
Galaxy.

To build a collection from the Git repository:

   1. Choose and `git clone`_ a collection repository:

      .. code-block:: sh

         $ git clone git@github.com:<path/to/repository>/<collection name>.git

   2. Build the collection by running the ``ansible-galaxy collection build``
      command, which must be run from inside the collection.

      .. code-block:: sh

         cd <collection name>
         ansible-galaxy collection build

      Example output of a locally built collection:

      .. code-block:: sh

         $ ansible-galaxy collection build
         Created collection for ibm.<collection name> at /Users/user/git/ibm/zos-ansible/<collection name>/<collection name>-1.0.0.tar.gz

   .. note::

      * Collection archive names will change depending on the release version. The
        names adhere to this convention:

          **<namespace>-<collection>-<version>.tar.gz**, for example, **ibm-ibm_zos_core-1.0.0.tar.gz**
      * If you build a collection with Ansible version 2.9 or earlier, you may see the following warning that you can ignore:

         **[WARNING]: Found unknown keys in collection galaxy.yml at '/Users/user/git/ibm/zos-ansible/<collection name>/galaxy.yml': build_ignore**


   3. Install the locally built collection:

      .. code-block:: sh

         $ ansible-galaxy collection install ibm-<collection name>-1.0.0.tar.gz

      In the output of collection installation, note the installation path to access the sample playbook:

      .. code-block:: sh

         Process install dependency map
         Starting collection install process
         Installing 'ibm.<collection name>:1.0.0' to '/Users/user/.ansible/collections/ansible_collections/ibm/<collection name>'

      You can use the ``-p`` option with ``ansible-galaxy`` to specify the
      installation path. For example,``ansible-galaxy collection install ibm-<collection name>-1.0.0.tar.gz -p /home/ansible/collections``.

      For more information, see `installing collections with Ansible Galaxy`_.

      .. _installing collections with Ansible Galaxy:
         https://docs.ansible.com/ansible/latest/user_guide/collections_using.html#installing-collections-with-ansible-galaxy

      .. _git clone:
         https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository
