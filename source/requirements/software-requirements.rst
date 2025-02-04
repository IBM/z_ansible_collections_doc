.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025                                    .
.. TODO: Contributors need to provide references or we need to build once to
..       figure out the URLs to use over references. These references must be
..       in a file named requirements/collection-requirements.rst
.. ...........................................................................

.. _software-requirements:

=====================
Software requirements
=====================

Before you install an **Ansible for IBM Z** collection, review the requirements
for both the :term:`control node<Control node>` and the
:term:`managed node<Managed node>`.

Each **Ansible for IBM Z** collection, or version of a collection can have
different requirements or dependencies. To find out more details, click the
following collection links.

..
   Commenting out the navigation index till its decided it is beneficial.
   Because it is using the same coming soon target, it will cause
   duplicated entry found in toctree.

   toctree::
   :maxdepth: 1
   :hidden:

   z/OS core <collection-requirements>
   z/OS CICS <../ibm_zos_cics/docs/source/requirements>
   z/OS IMS <../ibm_zos_ims/docs/source/requirements_managed>
   z/OS Sys Auto <../ibm_zos_sysauto/docs/source/requirements>
   z/OSMF <../ibm_zosmf/docs/source/requirements>
   Z HMC <../zhmc-ansible-modules/docs/source/requirements_managed>

.. grid:: 1 1 2 2
    :gutter: 1

    .. grid-item::

        .. grid:: 1 1 1 1
            :gutter: 1

            .. grid-item-card:: :bdg-link-primary:`z/OS core collection<collection-requirements.html>`
                  :padding: 0

                  - :ref:`Control node <ibm-zos-core-collection-requirements-control-node>`
                  - :ref:`Control node <ibm-zos-core-collection-requirements-managed-node>`
                  - :ref:`Dependency matrix <ibm-zos-core-collection-requirements-dependency-matrix>`

            .. grid-item-card:: :bdg-link-primary:`z/OS IMS collection<collection-requirements.html>`
                  :padding: 0

                  - :ref:`Control node <ibm-zos-core-collection-requirements-control-node>`
                  - :ref:`Control node <ibm-zos-core-collection-requirements-managed-node>`
                  - :ref:`Dependency matrix <ibm-zos-core-collection-requirements-dependency-matrix>`

            .. grid-item-card:: :bdg-link-primary:`z/OS CICS collection<collection-requirements.html>`
                  :padding: 0

                  - :ref:`Control node <ibm-zos-core-collection-requirements-control-node>`
                  - :ref:`Control node <ibm-zos-core-collection-requirements-managed-node>`
                  - :ref:`Dependency matrix <ibm-zos-core-collection-requirements-dependency-matrix>`

    .. grid-item::

        .. grid:: 1 1 1 1
            :gutter: 1

            .. grid-item-card:: :bdg-link-primary:`z/OSMF collection<collection-requirements.html>`
                  :padding: 0

                  - :ref:`Control node <ibm-zos-core-collection-requirements-control-node>`
                  - :ref:`Control node <ibm-zos-core-collection-requirements-managed-node>`
                  - :ref:`Dependency matrix <ibm-zos-core-collection-requirements-dependency-matrix>`

            .. grid-item-card:: :bdg-link-primary:`Z HMC collection<collection-requirements.html>`
                  :padding: 0

                  - :ref:`Control node <ibm-zos-core-collection-requirements-control-node>`
                  - :ref:`Control node <ibm-zos-core-collection-requirements-managed-node>`
                  - :ref:`Dependency matrix <ibm-zos-core-collection-requirements-dependency-matrix>`

            .. grid-item-card:: :bdg-link-primary:`System Automation collection<collection-requirements.html>`
                  :padding: 0

                  - :ref:`Control node <ibm-zos-core-collection-requirements-control-node>`
                  - :ref:`Control node <ibm-zos-core-collection-requirements-managed-node>`
                  - :ref:`Dependency matrix <ibm-zos-core-collection-requirements-dependency-matrix>`
