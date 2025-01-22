.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025                                    .
.. ...........................................................................

======================
Software Configuration
======================

Ansible is agentless automation software installed on the control node. From
the control node, Ansible will interact with the manage node remotely with SSH
and REST from a command-line interface or optionally, advanced orchestration
with Ansible Automation Platform.

The Ansible for IBM Z collections will require additional configuration
such that configuration properly connects with SSH or REST endpoints be
available and configured for communication.

Here you will find instructions on how to configure IBM Z collections
and perform a simple module test.

.. toctree::
   :maxdepth: 1

   z/OS core<../ibm_zos_core/docs/ansible_content>
   z/OS CICS<../ibm_zos_cics/docs/ansible_content>
   z/OS IMS<../ibm_zos_ims/docs/ansible_content>
   z/OS Sys Auto<../ibm_zos_sysauto/docs/ansible_content>
   z/OSMF<../ibm_zosmf/docs/ansible_content>
   Z HMC<../zhmc-ansible-modules/docs/ansible_content>



Prerequisites
=============
Before installing any collection, ensure the collection requirements are met through the use of `environment variables`_. The preferred configuration is to place the environment variables in ``group_vars`` and ``host_vars``, you can find examples of this configuration under **Configuration** of any project in the `Ansible Z Playbook Repository`_.

.. note::
    If you are testing a configuration, it can be helpful to set the environment variables in a playbook. See `How to put environment variables in a playbook`_.

To install ZOAU Python wheel, see `Python wheel installation method`_.