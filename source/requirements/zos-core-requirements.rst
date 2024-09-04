.. ...........................................................................
.. © Copyright IBM Corporation 2024                                          .
.. ...........................................................................

.. _zos-core-requirements:

==========================================
z/OS core collection software requirements
==========================================

The following table shows the required component versions when an ``ibm_zos_core`` collection becomes generally available (GA). You should use them as the minimum requirements because the underlying component version is likely to change when it reaches end of life (EOL). When a component version goes EOL, you need to update to a supported new version.

Control node
------------

When you choose a newer ``ansible-core (Ansible)`` version, review the `ansible-core support matrix`_ to select the appropriate dependencies. Different releases of `ansible-core``` can require different control node and managed node dependencies such as is the case with Python. For example, if a collection is released with a minimum version of ``ansible-core 2.14.0 (Ansible 7.0)`` and later that ansible-core (Ansible) goes EOL, a newer supported version of ansible-core (Ansible) must be selected. 

If you use control nodes with Ansible Automation Platform (AAP), review the `Red Hat Ansible Automation Platform Life Cycle`_ to select a supported AAP version.

Managed node
------------

The managed node (the machine that Ansible is managing) does not require Ansible to be installed, but requires Python to run Ansible-generated Python code and IBM z/OS environment to be set up.

For IBM product lifecycle information, you can search for products using the product's name, version or ID on `IBM Support product lifecycle`_. 

- For the lifecycle of **IBM Open Enterprise SDK for Python**, search on product ID `5655-PYT`_.
- For **IBM Z Open Automation Utilities**, search on product ID `5698-PA1`_.

Dependency matrix
-----------------

This table shows a complete list of dependencies for control nodes and managed nodes:

+---------+----------------------------+---------------------------------------------------+
| Version | Control Node               | Managed Node                                      |
+=========+============================+===================================================+
| 1.10.x  |- `ansible-core`_ >=2.15.x  |- `z/OS`_ V2R4 - V2Rx                              |
|         |- `Ansible`_ >=8.0.x        |- `z/OS shell`_                                    |
|         |- `AAP`_ >=2.4              |- `IBM Open Enterprise SDK for Python`_            |
|         |                            |- `IBM Z Open Automation Utilities`_ >=1.3.0       |
+---------+----------------------------+---------------------------------------------------+
| 1.9.x   |- `ansible-core`_ >=2.14    |- `z/OS`_ V2R4 - V2Rx                              |
|         |- `Ansible`_ >=7.0.x        |- `z/OS shell`_                                    |
|         |- `AAP`_ >=2.3              |- `IBM Open Enterprise SDK for Python`_            |
|         |                            |- `IBM Z Open Automation Utilities`_ 1.2.5 - 1.2.x |
+---------+----------------------------+---------------------------------------------------+
| 1.8.x   |- `ansible-core`_ >=2.14    |- `z/OS`_ V2R4 - V2Rx                              |
|         |- `Ansible`_ >=7.0.x        |- `z/OS shell`_                                    |
|         |- `AAP`_ >=2.3              |- `IBM Open Enterprise SDK for Python`_            |
|         |                            |- `IBM Z Open Automation Utilities`_ 1.2.4 - 1.2.x |
+---------+----------------------------+---------------------------------------------------+
| 1.7.x   |- `ansible-core`_ >=2.14    |- `z/OS`_ V2R4 - V2Rx                              |
|         |- `Ansible`_ >=7.0.x        |- `z/OS shell`_                                    |
|         |- `AAP`_ >=2.3              |- `IBM Open Enterprise SDK for Python`_            |
|         |                            |- `IBM Z Open Automation Utilities`_ 1.2.3 - 1.2.x |
+---------+----------------------------+---------------------------------------------------+
| 1.6.x   |- `ansible-core`_ >=2.9.x   |- `z/OS`_ V2R3 - V2Rx                              |
|         |- `Ansible`_ >=2.9.x        |- `z/OS shell`_                                    |
|         |- `AAP`_ >=1.2              |- `IBM Open Enterprise SDK for Python`_            |
|         |                            |- `IBM Z Open Automation Utilities`_ 1.2.2 - 1.2.x |
+---------+----------------------------+---------------------------------------------------+
| 1.5.x   |- `ansible-core`_ >=2.9.x   |- `z/OS`_ V2R3 - V2Rx                              |
|         |- `Ansible`_ >=2.9.x        |- `z/OS shell`_                                    |
|         |- `AAP`_ >=1.2              |- `IBM Open Enterprise SDK for Python`_            |
|         |                            |- `IBM Z Open Automation Utilities`_ 1.2.2 - 1.2.x |
+---------+----------------------------+---------------------------------------------------+

.. .............................................................................
.. Global Links
.. .............................................................................
.. _ansible-core support matrix:
   https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-core-support-matrix
.. _Red Hat Ansible Automation Platform Life Cycle:
   https://access.redhat.com/support/policy/updates/ansible-automation-platform
.. _IBM Support product lifecycle:
    https://www.ibm.com/support/pages/lifecycle/search/
.. _5655-PYT:
   https://www.ibm.com/support/pages/lifecycle/search?q=5655-PYT
.. _5698-PA1:
   https://www.ibm.com/support/pages/lifecycle/search?q=5698-PA1
.. _AAP:
   https://access.redhat.com/support/policy/updates/ansible-automation-platform
.. _Automation Hub:
   https://www.ansible.com/products/automation-hub
.. _IBM Open Enterprise SDK for Python:
   https://www.ibm.com/products/open-enterprise-python-zos
.. _IBM Z Open Automation Utilities:
   https://www.ibm.com/docs/en/zoau/latest
.. _z/OS shell:
   https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.4.0/com.ibm.zos.v2r4.bpxa400/part1.htm
.. _z/OS:
   https://www.ibm.com/docs/en/zos
.. _Open Enterprise SDK for Python lifecycle:
   https://www.ibm.com/support/pages/lifecycle/search?q=5655-PYT
.. _Z Open Automation Utilities lifecycle:
   https://www.ibm.com/support/pages/lifecycle/search?q=5698-PA1
.. _ansible-core:
   https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-core-support-matrix
.. _Ansible:
   https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-core-support-matrix