.. ...........................................................................
.. © Copyright IBM Corporation 2020                                          .
.. ...........................................................................

=================
Content / General
=================

How do I know if Ansible is installed on the controller?
========================================================
 You can execute the ``ansible --version`` to see the Ansible version and the
 adhoc ``ping`` command.

 .. code-block:: sh

    ansible all -i "host.vmec.svl.ibm.com," -c 'ibm.ibm_zos_core.zos_ssh' -u host_user -m 'ibm.ibm_zos_core.zos_ping' -e 'ansible_python_interpreter="export _BPXK_AUTOCVT=ON ; /u/oeusr01/python/pyz_3_8_2/usr/lpp/IBM/cyp/v3r8/pyz/bin/python3"'

How do I know the collection installed on the controller?
=========================================================

 After you have reviewed the instructions (link) you can execute the adhoc
 ``zos_ping`` command:

 .. code-block:: sh

    ansible all -i "host.vmec.svl.ibm.com," -c 'ibm.ibm_zos_core.zos_ssh' -u host_user -m 'ibm.ibm_zos_core.zos_ping'


How do i configure ZOAU?
========================

You can review our documentation that provides the environment variables
needed for Ansible here and how to install it from ZAOUs product page.

How much memory do I need?
==========================

TBD

Where can I get Python?
=======================

TBD

Where can I get ZOAU?
=====================

TBD

Do this require me to install something on z/OS?
================================================

TBD

Do the modules leave any objects/files behind?
==============================================

TBD


.. ..........................................................................
.. . TODO
.. ..........................................................................
.. . Disabled for the time being, when the collections can contribute content
.. . enable this feature
.. ..........................................................................
.. Offerings
.. =========
..
.. .. toctree::
..    :maxdepth: 1
..
..    z/OS core </../ibm_zos_core/docs/source/faqs.rst>
..    z/OS IMS </../ibm_zos_ims/docs/source/faqs.rst>