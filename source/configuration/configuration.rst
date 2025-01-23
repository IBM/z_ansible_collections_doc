.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025                                    .
.. ...........................................................................

======================
Software Configuration
======================

Ansible is agentless automation software installed on the control node. From
the control node, Ansible will interact with the managed node remotely using
SSH and REST from a command-line interface or optionally, advanced
orchestration with Ansible Automation Platform.

The **Ansible for IBM Z** collections will require additional configuration
such that SSH or REST endpoints be available and configured for communication.

Here you will find instructions on how to configure Ansible for IBM Z
collections and perform a simple module test.

.. toctree::
   :maxdepth: 1

   z/OS core<collection-configuration>
   z/OS CICS<coming_soon>
   z/OS IMS<coming_soon>
   z/OS Sys Auto<coming_soon>
   z/OSMF<coming_soon>
   Z HMC<coming_soon>
