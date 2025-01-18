.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025                                    .
.. ...........................................................................

=========================
Install IBM Z collections
=========================

There are several options for installing IBM Z collections, including Ansible
Galaxy, Automation Hub, private Galaxy server, or from a Git repository.

Option 1: Install with Ansible Galaxy
=====================================

Ansible Galaxy is the community repository for Ansible for IBM Z® collections.
You can find various details such as collection information and collection
content in the Ansible Galaxy page of a collection.

.. _Install a collection:

Install a collection
--------------------

#. In a collection's Ansible Galaxy page, you can find the installation
command for installing a specific collection. The general command form
below will install the latest version of a collection.

   .. code-block:: sh

      $ ansible-galaxy collection install <namespace>.<collection name>

   .. note::
      The namespace for all Ansible for IBM Z collections is ``ibm``. |br|
      The following are the available collection names you can select from:
         - ``ibm_zos_core``
         - ``ibm_zos_ims``
         - ``ibm_zos_cics``
         - ``ibm_zhmc``
         - ``ibm_zos_sysauto``
         - ``ibm_zosmf``

#. Enter the ``ansible-galaxy`` command in the terminal to install the
   collection on your control node.

#. Verify the location of the collection by running the following command.
   You'll see the name, version, and location of the installed collection.

   .. code-block:: sh

      $ ansible-galaxy collection list

   .. note::
      **About collection dependencies:** Some collections are dependent on
      other collections, such as the IBM z/OS IMS collection, which has a
      dependency on the IBM z/OS core collection. The collections
      dependencies have been defined in Ansible Galaxy, thus the dependent
      collections will be installed even if you don't selectively install
      them.

   If have multiple collections to install, you can enter the collection
   names into a **requirements.yml** file and install them with
   ``ansible-galaxy collection install -r requirements.yml``.

   The **requirements.yml** is a YAML file with the format:

   .. code-block:: sh

      collections:
         - name: <namespace>.<collection name>


Install a collection version
----------------------------

* You can install a specific version of the collection. For example, you
  can use the following command to install version 1.0.0 for the
  IBM z/OS core collection:

   .. code-block:: sh

      ansible-galaxy collection install ibm.ibm_zos_core:1.0.0

* A **beta version** is only available on Ansible Galaxy and is only supported
  by the community, once it is General Availability (GA), it will be  promoted
  to Ansible Automation Platform and eligible for entitlement. A beta is not
  considered the latest version by Ansible Galaxy, to install a beta of the
  IBM z/OS core collection, run the following command:

   .. code-block:: sh

      ansible-galaxy collection install ibm.ibm_zos_core:1.10.0-beta.1

For more information about installing Ansible collections,
see `Installing collections (Ansible Documentation)`_.


Option 2: Install with Automation Hub and Private Galaxy server
===============================================================

The procedure of configuring access to a private Galaxy server is the same as that
of connecting a client to Ansible Automation Platform. You can use the
``ansible-galaxy collection install`` command to install a collection on the control
node hosted in Ansible Automation Platform or a private Galaxy server.

By default, ``ansible-galaxy`` uses ``https://galaxy.ansible.com`` as the Galaxy server,
but you can configure the ``ansible-galaxy collection`` command to use other servers.
For more information, see `Configuring the ansible-galaxy client (Ansible Documentation)`_.

For Ansible Automation Platform:

  * Set the **auth_url** option for each server name.
  * Set the API token for each server name. To obtain an API token from Automation Hub,
    select the Offline token from `Connect to Hub`_.

The automation hub API token authenticates your ansible-galaxy client to the Red Hat
automation hub server. To learn more about configuration,
see `Creating the API token in automation hub`_.

Configure ansible-galaxy

The following example shows an **ansible.cfg** configuration for Ansible Automation
Platform, a private Galaxy server, and Ansible Galaxy. The search order is managed
with the **server_list** option contained in the configuration. The configuration will
be accessed in this ordering:

   - ANSIBLE_CONFIG (environment variable if set)
   - ansible.cfg (in the current directory)
   - ~/.ansible.cfg (in the home directory)
   - /etc/ansible/ansible.cfg

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

After having updated the configuration, return to the :ref:`Install a collection` reference and
follow along to install a collection.

To learn more about configuration, see `Ansible Configuration Settings (Ansible Documentation)`_.


Option 3: Git repository
========================

You can install a collection from a Git repository using the
URI of the repository and the ``ansible-galaxy collection install``
command. You can also specify a branch, commit, or tag using the
comma-separated git commit-ish syntax.

For example, to build and install the IBM z/OS core collection from the Git repository:

   #. Install the version 1.12.0:

      .. code-block:: sh

         $ ansible-galaxy collection install -f git@github.com:ansible-collections/ibm_zos_core.git,v1.9.0

   #. Install from the **dev** branch:

      .. code-block:: sh

         $ ansible-galaxy collection install git@github.com:ansible-collections/ibm_zos_core.git,dev

   #. Install from the **dev** branch using SSH authentication by including the prefix **git+**:

      .. code-block:: sh

         $ ansible-galaxy collection install git+https://github.com/ansible-collections/ibm_zos_core.git,dev

    For more information, see `Installing a collection from a git repository (Ansible Documentation)`_.

.. ...........................................................................
.. External links
.. ...........................................................................
.. _environment variables:
   https://github.com/IBM/z_ansible_collections_samples/blob/main/docs/share/zos_core/configuration_guide.md#environment-variables
.. _Ansible Z Playbook Repository:
   https://github.com/IBM/z_ansible_collections_samples
.. _How to put environment variables in a playbook:
   https://github.com/ansible-collections/ibm_zos_core/discussions/657
.. _Python wheel installation method:
   https://www.ibm.com/docs/en/zoau/1.3.x?topic=installing-zoau#python-wheel-installation-method
.. _Installing collections (Ansible Documentation):
   https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#installing-collections
.. _Configuring the ansible-galaxy client (Ansible Documentation):
   https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#configuring-the-ansible-galaxy-client
.. _Ansible Configuration Settings (Ansible Documentation):
   https://docs.ansible.com/ansible/latest/reference_appendices/config.html
.. _Installing a collection from a git repository (Ansible Documentation):
   https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#installing-a-collection-from-a-git-repository
.. _Connect to Hub:
   https://cloud.redhat.com/ansible/automation-hub/token/
.. _Creating the API token in automation hub:
    https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.4/html/getting_started_with_automation_hub/hub-create-api-token#hub-create-api-token

.. ...........................................................................
.. # HTML line break
.. ...........................................................................
.. |br| raw:: html

   <br/>


Prerequisites
=============
Before installing any collection, ensure the collection requirements are met through the use of `environment variables`_. The preferred configuration is to place the environment variables in ``group_vars`` and ``host_vars``, you can find examples of this configuration under **Configuration** of any project in the `Ansible Z Playbook Repository`_.

.. note::
    If you are testing a configuration, it can be helpful to set the environment variables in a playbook. See `How to put environment variables in a playbook`_.

To install ZOAU Python wheel, see `Python wheel installation method`_.