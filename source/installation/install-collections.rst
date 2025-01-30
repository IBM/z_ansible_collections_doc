.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025                                    .
.. ...........................................................................

.. _install-collections:

=================
Ansible for IBM Z
=================

There are several options for installing **Ansible for IBM Z** collections,
including Ansible Galaxy, Automation Hub, private Galaxy server, or from a
Git repository.

This guide will discuss installing **Ansible for IBM Z** collections; for all
software requirements, see :ref:`software-requirements`.

Option 1: Install from Ansible Galaxy
=====================================

.. dropdown:: Ansible **Galaxy** is the community repository for Ansible ...
    :color: primary
    :icon: command-palette

    Ansible **Galaxy** is the community repository for Ansible for IBM Z collections.
    You can find various details such as collection information and collection
    content in the Ansible Galaxy page of a collection.

    .. dropdown:: Install a collection from Ansible **Galaxy** ...
        :icon: command-palette

        Install a collection from Ansible Galaxy, you can find the installation
        command for installing a specific collection.

        #. Using the ``ansible-galaxy`` command, the general command form below will
           install the latest version of a collection.

           .. code-block:: sh

              ansible-galaxy collection install <namespace>.<collection name>

           The namespace for Ansible for IBM Z collections is ``ibm``. The following
           are the available collection names you can select from:

              - ibm_zos_core
              - ibm_zos_ims
              - ibm_zos_cics
              - ibm_zhmc
              - ibm_zos_sysauto
              - ibm_zosmf

        #. Verify the location of the collection by running the following command.
           You'll see the name, version, and location of the installed collection.

           .. code-block:: sh

              ansible-galaxy collection list

           .. note::
              Ansible collection dependencies, some collections are dependent on
              other collections, such as the IBM z/OS IMS collection, which has a
              dependency on the IBM z/OS core collection. The collections
              dependencies will be automatically installed, even if you don't
              selectively install them.

           If you have multiple collections to install, you can enter the collection
           names into a **requirements.yml** file and install them with
           ``ansible-galaxy collection install -r requirements.yml``.

           The **requirements.yml** is a YAML file with the format:

           .. code-block:: sh

              collections:
                 - name: <namespace>.<collection name>

    ..   dropdown:: Install a specific collection version from Ansible Galaxy ...
         :icon: command-palette

         Install a specific collection version from Ansible Galaxy. For example,
         you can use the following command to install version 1.0.0 for the
         IBM z/OS core collection:

            .. code-block:: sh

               ansible-galaxy collection install ibm.ibm_zos_core:1.0.0

         A **beta version** is only available on Ansible Galaxy and is only supported
         by the community, once it is General Availability (GA), it will be  promoted
         to Ansible Automation Platform and eligible for entitlement. A beta is not
         considered the latest version by Ansible Galaxy, to install a beta of the
         IBM z/OS core collection, run the following command:

            .. code-block:: sh

               ansible-galaxy collection install ibm.ibm_zos_core:1.10.0-beta.1

         For more information about installing Ansible collections,
         see `Installing collections (Ansible Documentation)`_.

Option 2: Install from Automation Hub
=====================================

.. dropdown:: Configuring access to a **Ansible Automation Platform** ...
    :color: primary
    :icon: command-palette

    Configuring access to a **Ansible Automation Platform** is the same as that of
    connecting a client to a **private Galaxy server**. You can use the
    ``ansible-galaxy collection install`` command to install a collection on the
    control node hosted in Ansible Automation Platform or a private Galaxy server.

    .. dropdown:: By default, the **ansible-galaxy** command ...
       :icon: file-code

       By default, the ``ansible-galaxy`` command uses ``https://galaxy.ansible.com`` as the
       Galaxy server, but you can configure the ``ansible-galaxy collection`` command to use
       other servers by editing the configuration file, **ansible.cfg**.

       For more information, see `Configuring the ansible-galaxy client (Ansible Documentation)`_.

       To configure:

       * Set the **auth_url** option for each server name.
       * Set the API token for each server name. To obtain an API token from Automation Hub,
          select the Offline token from `Connect to Hub`_.

       The automation hub API token authenticates your ansible-galaxy client to the Red Hat
       automation hub server. To learn more about configuration,
       see `Creating the API token in automation hub`_.

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

       To learn more about configuration, see `Ansible Configuration Settings (Ansible Documentation)`_.

    .. dropdown:: By default, the ``ansible-galaxy`` command ...
       :icon: file-code

        Install a collection from Ansible Automation Hub after having updated the configuration
        (ansible.cfg), return to the :ref:`Install a collection<install-collections>` reference and
        follow along to install a collection.


Option 3: Install from Git repository
=====================================

.. dropdown:: Install a collection from a **Git** repository using the URI ...
    :color: primary
    :icon: command-palette

    Install a collection from a Git repository using the URI of the repository
    and the ``ansible-galaxy collection install`` command. You can also specify a branch,
    commit, or tag using the comma-separated git commit-ish syntax.

    To build and install a collection from a Git repository, for example, the IBM z/OS core
    collection, use the below commands.

       #. Install a specific GitHub release (v1.12.0):

          .. code-block:: sh

             ansible-galaxy collection install -f git@github.com:ansible-collections/ibm_zos_core.git,v1.12.0

       #. Install the collection from the **dev** branch:

          .. code-block:: sh

             ansible-galaxy collection install git@github.com:ansible-collections/ibm_zos_core.git,dev

       #. Install from the **dev** branch using SSH authentication by including the prefix **git+**:

          .. code-block:: sh

             ansible-galaxy collection install git+https://github.com/ansible-collections/ibm_zos_core.git,dev

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
.. # Forced HTML line break, use this at the end of a sentence like.... |br|
.. ...........................................................................
.. |br| raw:: html

   <br/>