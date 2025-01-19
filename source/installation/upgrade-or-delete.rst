.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2024                                    .
.. ...........................................................................

.. _upgrade-or-delete:

==============================
Upgrade or delete a collection
==============================

After you have installed an Ansible IBM Z collection, you may need to upgrade
or remove it.

How to upgrade to the latest version
====================================

If you install a collection from Ansible Galaxy, it will not be upgraded
automatically when you upgrade the Ansible package. To upgrade the collection
to the latest available version, run the following command:

   .. code-block:: sh
      ansible-galaxy collection install <namespace>.<collection name> --upgrade

   .. note::
      This will also update dependencies unless ``--no-deps`` is provided.

How to remove a collection
==========================

#. To remove a collection, navigate to the collection directory and remove the
collection by using this command:

   .. code-block:: sh

      $ rm -rf <path_to_collection_directory>/<collection name>

If you you do not know where Ansible is installed, you can use the ``--version``
option to show the installation path. 

If you have installed **ansible-core**, you can test this by checking
the version with command:

   .. code-block:: sh

      $ ansible --version

If you have installed **ansible**, you can test this by checking
the version with command:

   .. code-block:: sh

      $ ansible-community --version


#. Verify the uninstallation by running this command:

   .. code-block:: sh

      $ ansible-galaxy collection list
