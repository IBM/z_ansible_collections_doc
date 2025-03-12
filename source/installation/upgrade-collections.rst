.. ...........................................................................
.. © Copyright IBM Corporation 2025
..
.. This is an orphaned page because its not included in any toctree
.. 'orphan' if set, warnings about this file not being included in any toctree
..  will be suppressed.
.. ...........................................................................

:orphan:

.. _upgrade-collections:

=========================
Upgrade Ansible for IBM Z
=========================

**IBM Ansible for Z** collections are not automatically upgraded when newer
versions release. After you have installed an **Ansible IBM Z** collection,
you may need to upgrade the collection to leverage the benefits a new
collection is delivering.

To upgrade the collection to the latest available version, use the following
command syntax. To learn more about the namespace and collection name, see
:ref:`install a collection<install-collections>`.

    .. code-block:: sh

        ansible-galaxy collection install <namespace>.<collection name> --upgrade

.. note::

    This will also update the dependent collections unless ``--no-deps`` is provided.
