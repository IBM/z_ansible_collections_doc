.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2024                                    .
.. ...........................................................................

.. _upgrade-or-delete:

==============================
Upgrade or delete a collection
==============================

After you installed an IBM z/OS collection, you may need to upgrade or delete it.

How to upgrade to the latest version
====================================

If you install a collection from Ansible Galaxy, it will not be upgraded automatically when you upgrade the Ansible package. To upgrade the collection to the latest available version, run the following command:

   .. code-block:: sh
      ansible-galaxy collection install <namespace>.<collection name> --upgrade

How to delete a collection
==========================

#. If you need to delete a collection, navigate to the collection directory and remove the collection that you'd like to uninstall by using this command:

   .. code-block:: sh

      $ rm -rf <path_to_collection_directory>/<collection name>

#. Verify the uninstallation by running this command:

   .. code-block:: sh

      $ ansible-galaxy collection list
