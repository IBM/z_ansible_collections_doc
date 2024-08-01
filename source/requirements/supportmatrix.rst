.. ...........................................................................
.. © Copyright IBM Corporation 2024                                          .
.. ...........................................................................

.. _zos-core-support-matrix:

===================================
The ``ibm_zos_core`` support matrix
===================================

This table describes the dependencies information for the ``ibm_zos_core`` collection.

+---------+----------------------------+---------------------------------------------------+---------------+---------------+
| Version | Controller                 | Managed Node                                      | GA            | End of Life   |
+=========+============================+===================================================+===============+===============+
| 1.10.x  |- `ansible-core`_ >=2.15.x  |- `z/OS`_ V2R4 - V2Rx                              | 21 June 2024  | 21 June 2026  |
|         |- `Ansible`_ >=8.0.x        |- `z/OS shell`_                                    |               |               |
|         |- `AAP`_ >=2.4              |- IBM `Open Enterprise SDK for Python`_            |               |               |
|         |                            |- IBM `Z Open Automation Utilities`_ >=1.3.0       |               |               |
+---------+----------------------------+---------------------------------------------------+---------------+---------------+
| 1.9.x   |- `ansible-core`_ >=2.14    |- `z/OS`_ V2R4 - V2Rx                              | 05 Feb 2024   | 30 April 2025 |
|         |- `Ansible`_ >=7.0.x        |- `z/OS shell`_                                    |               |               |
|         |- `AAP`_ >=2.3              |- IBM `Open Enterprise SDK for Python`_            |               |               |
|         |                            |- IBM `Z Open Automation Utilities`_ 1.2.5 - 1.2.x |               |               |
+---------+----------------------------+---------------------------------------------------+---------------+---------------+
| 1.8.x   |- `ansible-core`_ >=2.14    |- `z/OS`_ V2R4 - V2Rx                              | 13 Dec 2023   | 30 April 2025 |
|         |- `Ansible`_ >=7.0.x        |- `z/OS shell`_                                    |               |               |
|         |- `AAP`_ >=2.3              |- IBM `Open Enterprise SDK for Python`_            |               |               |
|         |                            |- IBM `Z Open Automation Utilities`_ 1.2.4 - 1.2.x |               |               |
+---------+----------------------------+---------------------------------------------------+---------------+---------------+
| 1.7.x   |- `ansible-core`_ >=2.14    |- `z/OS`_ V2R4 - V2Rx                              | 10 Oct 2023   | 30 April 2025 |
|         |- `Ansible`_ >=7.0.x        |- `z/OS shell`_                                    |               |               |
|         |- `AAP`_ >=2.3              |- IBM `Open Enterprise SDK for Python`_            |               |               |
|         |                            |- IBM `Z Open Automation Utilities`_ 1.2.3 - 1.2.x |               |               |
+---------+----------------------------+---------------------------------------------------+---------------+---------------+
| 1.6.x   |- `ansible-core`_ >=2.9.x   |- `z/OS`_ V2R3 - V2Rx                              | 28 June 2023  | 30 April 2025 |
|         |- `Ansible`_ >=2.9.x        |- `z/OS shell`_                                    |               |               |
|         |- `AAP`_ >=1.2              |- IBM `Open Enterprise SDK for Python`_            |               |               |
|         |                            |- IBM `Z Open Automation Utilities`_ 1.2.2 - 1.2.x |               |               |
+---------+----------------------------+---------------------------------------------------+---------------+---------------+
| 1.5.x   |- `ansible-core`_ >=2.9.x   |- `z/OS`_ V2R3 - V2Rx                              | 25 April 2023 | 25 April 2025 |
|         |- `Ansible`_ >=2.9.x        |- `z/OS shell`_                                    |               |               |
|         |- `AAP`_ >=1.2              |- IBM `Open Enterprise SDK for Python`_            |               |               |
|         |                            |- IBM `Z Open Automation Utilities`_ 1.2.2 - 1.2.x |               |               |
+---------+----------------------------+---------------------------------------------------+---------------+---------------+

These are the available component versions when an ``ibm_zos_core`` collection becomes generally available (GA). You should use them as the minimum requirements because the underlying component version is likely to change when it reaches end of life (EOL). When a component version goes EOL, you need to update to a supported new version.

For example, if a collection is released with a minimum version of ``ansible-core 2.14.0 (Ansible 7.0)`` and later that ansible-core (Ansible) goes EOL, a newer supported version of ansible-core (Ansible) must be selected. 

.. note::
    **Important:** When you choose a newer `ansible-core (Ansible)` version, review the [ansible-core support matrix] to select the appropriate dependencies. Different releases of `ansible-core` can require different controller and managed node dependencies such as is the case with Python.

If the controller is Ansible Automation Platform (AAP), review the `Red Hat Ansible Automation Platform Life Cycle`_
to select a supported AAP version.

For IBM product lifecycle information, you can search for products using a product name, version or ID. For example,
to view IBM's **Open Enterprise SDK for Python** lifecycle, search on product ID `5655-PYT`_, and for **Z Open Automation Utilities**,
search on product ID `5698-PA1`_.

.. .............................................................................
.. Global Links
.. .............................................................................
.. _ansible-core support matrix:
   https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-core-support-matrix
.. _AAP:
   https://access.redhat.com/support/policy/updates/ansible-automation-platform
.. _Red Hat Ansible Automation Platform Life Cycle:
   https://access.redhat.com/support/policy/updates/ansible-automation-platform
.. _Automation Hub:
   https://www.ansible.com/products/automation-hub
.. _Open Enterprise SDK for Python:
   https://www.ibm.com/products/open-enterprise-python-zos
.. _Z Open Automation Utilities:
   https://www.ibm.com/docs/en/zoau/latest
.. _z/OS shell:
   https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.4.0/com.ibm.zos.v2r4.bpxa400/part1.htm
.. _z/OS:
   https://www.ibm.com/docs/en/zos
.. _Open Enterprise SDK for Python lifecycle:
   https://www.ibm.com/support/pages/lifecycle/search?q=5655-PYT
.. _5655-PYT:
   https://www.ibm.com/support/pages/lifecycle/search?q=5655-PYT
.. _Z Open Automation Utilities lifecycle:
   https://www.ibm.com/support/pages/lifecycle/search?q=5698-PA1
.. _5698-PA1:
   https://www.ibm.com/support/pages/lifecycle/search?q=5698-PA1
.. _ansible-core:
   https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-core-support-matrix
.. _Ansible:
   https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html#ansible-core-support-matrix