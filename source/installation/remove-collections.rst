.. ...........................................................................
.. © Copyright IBM Corporation 2025                                          .
.. ...........................................................................

.. _remove-collections:

========================
Remove Ansible for IBM Z
========================

You may want to remove an **IBM Ansible for Z** collection for various reasons,
for example, you installed the collection into the host and wanted it installed
in a Python virtual environment.

#. To remove a collection, navigate to the collection directory and remove the
   collection by using this command:

   .. code-block:: sh

      rm -rf <path_to_collection_directory>/<collection name>

#. If you you do not know where the collection is installed, you can use the
   ``ansible-galaxy`` command to show the installation path for a specific
   collection with command:

   .. code-block:: sh

      ansible-galaxy collection list ibm.ibm_zos_core

#. Verify the uninstallation by running this command:

   .. code-block:: sh

      ansible-galaxy collection list