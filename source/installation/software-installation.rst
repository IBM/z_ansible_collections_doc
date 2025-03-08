.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025                                    .
.. ...........................................................................

=====================
Software Installation
=====================

Ansible is agentless automation software that you install on a host,
referred to as the :term:`control node<Control node>`. Ansible enables
cross-platform automation and orchestration at scale and is IBM's
recommendation for enterprise automation.

From the :term:`control node<Control node>`, Ansible can manage any number and
combination of Z systems, subsystems, instances and devices remotely with ``SSH``
and ``REST`` from a command-line interface or optionally, advanced orchestration
with Ansible Automation Platform.

Click on a topic to learn more about installing Ansible and managing Ansible
collections.

..  toctree::
   :maxdepth: 1
   :hidden:

   install-ansible
   install-collections
   upgrade-collections
   remove-collections

.. grid:: 1 1 2 2
    :gutter: 1

    .. grid-item::

        .. grid:: 1 1 1 1
            :gutter: 1

            .. grid-item-card:: Ansible :octicon:`link-external`
               :link: install-ansible
               :link-type: ref

               Click to learn more on how to install Ansible.

            .. grid-item-card:: Ansible for IBM Z :octicon:`link-external`
               :link: install-collections
               :link-type: ref

               Click to learn more on how to install Ansible for IBM Z collections.

    .. grid-item::

        .. grid:: 1 1 1 1
            :gutter: 1

            .. grid-item-card:: Upgrade Ansible for IBM Z :octicon:`link-external`
               :link: upgrade-collections
               :link-type: ref

               Click to learn more on how to upgrade Ansible for IBM Z collections.

            .. grid-item-card:: Remove Ansible for IBM Z :octicon:`link-external`
               :link: remove-collections
               :link-type: ref

               Click to learn more on how to remove Ansible for IBM Z collections.
