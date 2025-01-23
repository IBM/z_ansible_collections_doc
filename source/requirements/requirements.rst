.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025                                    .
.. Navigation: Project >Installation & Execution > Software requirements     .
.. Note: Each collection will need to update the requirements to a generic
..       name/file and ensure it's included as collection-requirement.rst
.. ...........................................................................


.. _requirements:

=====================
Software requirements
=====================

Before you install an **Ansible for IBM Z** collection, you must configure
the :term:`control node<Control node>` and depending on the collection,
the :term:`managed node<Managed node>` with a minimum set of requirements.

Each Ansible for IBM Z collection, or each version of a collection can have
different requirements or dependencies. To find out more details, check the
following links for the specific collection.

.. toctree::
   :maxdepth: 1

   z/OS core <collection-requirements>
   z/OS CICS <../ibm_zos_cics/docs/source/requirements>
   z/OS IMS <../ibm_zos_ims/docs/source/requirements_managed>
   z/OS Sys Auto <../ibm_zos_sysauto/docs/source/requirements>
   z/OSMF <../ibm_zosmf/docs/source/requirements>
   Z HMC <../zhmc-ansible-modules/docs/source/requirements_managed>