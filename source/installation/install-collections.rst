.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2024                                    .
.. ...........................................................................

.. JH, Jul 2024 - Draft content.

============================
Install IBM z/OS collections
============================

You can install and set up IBM z/OS® collections with several options, including Ansible Galaxy, Automation Hub, private Galaxy server, or local build.

Prerequisites
=============

Before installing any collection, you must make sure the collection requirements are meet through the use of `environment variables`_. The preferred configuration is to place the environment variables in ``group_vars`` and ``host_vars``, you can find examples of this configuration under **Configuration** of any project in the `Ansible Z Playbook Repository`_.

.. note::
    If you are testing a configuration, it can be helpful to set the environment variables in a playbook. See `How to put environment variables in a playbook`_.

To install ZOAU Python wheel, see `Python wheel installation method`_.


Option 1: Install with Ansible Galaxy
=====================================

Ansible Galaxy is the community repository for Ansible for IBM Z® collections. You can find various details such as collection information and collection content in the Ansible Galaxy page of a collection.

How to install a collection
---------------------------

#. In the **info** panel on the collection's Ansible Galaxy page, you can find the command for installing a specific collection, which is in this general form:

   .. code-block:: sh

      $ ansible-galaxy collection install <namespace>.<collection name>

   .. note:: 
      The namespace for all Ansible for IBM Z collections is ``ibm``. You can select the collection name from: ``ibm_zos_core``, ``ibm_zos_ims``, ``ibm_zos_cics``, ``ibm_zhmc``, ``ibm_zos_sysauto``, and ``ibm_zosmf``.

#. Enter the command in the terminal to install it on your control node.

#. Verify the location of the collection by running the following command. You'll see the name, version, and location of the installed collection.

   .. code-block:: sh

      $ ansible-galaxy collection list

.. note::
   **About collection dependencies:** Some collections are dependent on other collections, such as the IBM z/OS IMS collection, which has a dependency on the IBM z/OS core collection. The dependencies are already defined in the Ansible Galaxy, the dependent collections will be installed even if you don't install them manually.

You can also include it in a ``requirements.yml`` file and install it with ``ansible-galaxy collection install -r requirements.yml``, using the format:

   .. code-block:: sh

      collections:
         - name: <namespace>.<collection name>

How to install a specific version
---------------------------------

* You can install a specific version of the collection or downgrade to a lower version. For example, you can use the following command to install version 1.0.0 for the IBM z/OS core collection:

   .. code-block:: sh

      ansible-galaxy collection install ibm.ibm_zos_core:1.0.0

* You can also install a **beta version** of the collection. A beta version is only available on Ansible Galaxy and is only supported by the community before it becomes General Availability (GA). Use the following command to install a beta version for the IBM z/OS core collection:

   .. code-block:: sh

      ansible-galaxy collection install ibm.ibm_zos_core:1.10.0-beta.1

For more information about installing Ansible collections, see `Installing collections (Ansible Documentation)`_.


Option 2: Install with Automation Hub and Private Galaxy server
===============================================================

The procedure of configuring access to a privcate Galaxy server is the same as that of connecting a client to Automation Hub. You can use the ``ansible-galaxy collection install`` command to install a collection on the control node hosted in Automation Hub or a private Galaxy server.

By default, ``ansible-galaxy`` uses ``https://galaxy.ansible.com`` as the Galaxy server, but you can configure the ``ansible-galaxy collection`` command to use other servers. For more information, see `Configuring the ansible-galaxy client (Ansible Documentation)`_.

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

To learn more about configuration, see `Ansible Configuration Settings (Ansible Documentation)`_.


Option 3: Local build
=====================

You can git clone the repository of a collection, and use the ``ansible-galaxy collection build`` command to build the collection into an archive that can be later install locally.

To build a collection from the Git repository:

   #. Git clone a collection repository:

      .. code-block:: sh

         $ git clone git@github.com:<path/to/repository>/<collection name>.git

   #. Enter the collection folder and build the collection archive:

      .. code-block:: sh

         cd <collection name>
         ansible-galaxy collection build

      Example output of a locally built collection:

      .. code-block:: sh

         $ ansible-galaxy collection build
         Created collection for ibm.<collection name> at /Users/user/git/ibm/zos-ansible/<collection name>/<collection name>-1.0.0.tar.gz

      .. note::

         * Collection archive names will change depending on the release version. The names adhere to this convention:

            **<namespace>-<collection>-<version>.tar.gz**, for example, **ibm-ibm_zos_core-1.0.0.tar.gz**

         * If you build a collection with Ansible version 2.9 or earlier, you may see the following warning that you can ignore:

            **[WARNING]: Found unknown keys in collection galaxy.yml at '/Users/user/git/ibm/zos-ansible/<collection name>/galaxy.yml': build_ignore**

   #. Install the locally built collection:

      .. code-block:: sh

         $ ansible-galaxy collection install ibm-<collection name>-1.0.0.tar.gz

      In the output of collection installation, note the installation path to access the sample playbook:

      .. code-block:: sh

         Process install dependency map
         Starting collection install process
         Installing 'ibm.<collection name>:1.0.0' to '/Users/user/.ansible/collections/ansible_collections/ibm/<collection name>'

      You can use the ``-p`` option in the ``ansible-galaxy`` command to specify the installation path. For example:
      
      .. code-block:: sh

        $ ansible-galaxy collection install ibm-<collection name>-1.0.0.tar.gz -p /home/ansible/collections

    For more information, see `Installing a collection from a git repository (Ansible Documentation)`_.

.. External links
.. _environment variables: https://github.com/IBM/z_ansible_collections_samples/blob/main/docs/share/zos_core/configuration_guide.md#environment-variables
.. _Ansible Z Playbook Repository: https://github.com/IBM/z_ansible_collections_samples
.. _How to put environment variables in a playbook: https://github.com/ansible-collections/ibm_zos_core/discussions/657
.. _Python wheel installation method: https://www.ibm.com/docs/en/zoau/1.3.x?topic=installing-zoau#python-wheel-installation-method
.. _Installing collections (Ansible Documentation): https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#installing-collections
.. _Configuring the ansible-galaxy client (Ansible Documentation): https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#configuring-the-ansible-galaxy-client
.. _Ansible Configuration Settings (Ansible Documentation): https://docs.ansible.com/ansible/latest/reference_appendices/config.html
.. _Installing a collection from a git repository (Ansible Documentation): https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#installing-a-collection-from-a-git-repository