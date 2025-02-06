.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025                                    .
.. ...........................................................................

======================
Software Configuration
======================

Ansible is agentless automation software installed on the
:term:`control node<Control node>`. From the control node, Ansible will interact
with the :term:`managed node<Managed node>` remotely using
*SSH* and *REST* from a command-line interface or optionally, advanced
orchestration with Ansible Automation Platform.

The **Ansible for IBM Z** collections will require additional configuration
to ensure that **SSH** or **REST** endpoints are available and configured for
communication.

Here you will find instructions on how to configure **Ansible for IBM Z**
collections and perform a simple module test.

.. toctree::
   :maxdepth: 1
   :hidden:

   z/OS core<../tmp_zos_core/configuration>
   z/OS CICS<../coming_soon>
   z/OS IMS<../coming_soon>
   z/OS Sys Auto<../coming_soon>
   z/OSMF<../coming_soon>
   Z HMC<../coming_soon>

.. grid:: 1 1 2 2
    :gutter: 1

    .. grid-item::

        .. grid:: 1 1 1 1
            :gutter: 1

            .. grid-item-card:: z/OS core software configuration
               :link: ../tmp_zos_core/configuration.html

               **Click** to review the collection configuration.

            .. grid-item-card:: z/OS IMS software configuration
               :link: ../coming_soon.html

               **Click** to review the collection configuration.

            .. grid-item-card:: z/OS CICS software configuration
               :link: ../coming_soon.html

               **Click** to review the collection configuration.

    .. grid-item::

        .. grid:: 1 1 1 1
            :gutter: 1

            .. grid-item-card:: z/OSMF software configuration
               :link: ../coming_soon.html

               **Click** to review the collection configuration.

            .. grid-item-card:: Z HMC software configuration
               :link: ../coming_soon.html

               **Click** to review the collection configuration.

            .. grid-item-card:: z/OS System Automation software configuration
               :link: ../coming_soon.html

               **Click** to review the collection configuration.