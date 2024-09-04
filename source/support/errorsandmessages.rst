.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2024                                          .
.. ...........................................................................

.. _errorsandmessages:

==========================
Common errors and messages
==========================

How can I test if an Ansible or z/OS module is able to reach the target (host)?
-------------------------------------------------------------------------------
You can test if a collection is installed and is working correctly by executing
the command illustrated in the example below. Ensure that you change the host
name to your remote z/OS host, as well as the user and Python binary path.

.. note::
   The following example illustrates testing the installation of the
   z/OS core collection.

.. code-block:: sh

    ansible all \
    -i '<zos-host-name>,' \
    -c 'ibm.ibm_zos_core.zos_ssh' \
    -u 'user-name' \
    -m 'ibm.ibm_zos_core.zos_ping' \
    -e 'ansible_python_interpreter=/path/to/zos/python/binary'


The above command executes the ``zos_ping`` module against your remote
z/OS host. If the command succeeds and returns the following output,
the collection was installed correctly.

.. code-block:: sh

    <zos-host-name> | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }

Which modules are affected when using ``askpass`` instead of SSH authentication?
---------------------------------------------------------------------------------
Data transfer modules such as ``zos_copy`` and ``zos_fetch`` depend on the
authenticated ``SSH`` connection from the control node to the managed node. When
using these modules, ensure that the connection from the controller to the
managed node is authenticated using an SSH key. Both
``zos_copy`` and ``zos_fetch`` modules do not support Ansible ad-hoc
``--ask-pass``.


Does a user running Ansible on USS need to have any special privileges?
-------------------------------------------------------------------------
Whether special user privileges are required would depend on the type of task
Ansible is performing on the remote host. For instance, accessing or
changing system resources with insufficient access permissions,
would require elevated privileges.

If a task requires ``root`` privileges on USS, you can execute the it with the
``become: yes`` parameter. Alternatively, if you want to execute a task as a
particular user, you can use ``become_user: <user_name>`` parameter.


What causes the error: **"unsupported parameter"**? How do I fix it?
--------------------------------------------------------------------
This tends to happen when you are specifying a parameter to a module that it
doesn't support or is deprecated. Update your collection to the latest version
and review the collection requirements in the `release notes`_ to make sure you
are using the latest version of the modules and carefully examine the module
documentation to understand what parameters it supports.

.. _release notes:
   https://ibm.github.io/z_ansible_collections_doc/release/release.html


When using IBM Python, why do I get this error?
-----------------------------------------------
.. code-block::

   UnicodeDecodeError: 'utf-8' codec can't decode byte in position 0: invalid continuation byte"

The most likely cause of this error is that you have not properly set up your
environment variables for your managed node. Refer to the following
`configuration guide`_ to understand which environment variables need to be
defined.

.. _configuration guide:
    https://github.com/IBM/z_ansible_collections_samples/blob/main/docs/share/zos_core/configuration_guide.md


What causes this error during the playbook execution? How do I fix it?
----------------------------------------------------------------------

.. code-block:: sh

   EDC5129I No such file or directory.: b'mvscmdauth'", "rc": 129


``mvscmdauth`` is a **ZOAU** shell utility. This error tends to happen when
**ZOAU** installation is not added to the system **PATH**. Modify your host
variables and add the ``bin`` directory of the **ZOAU** installation. for
example, if **ZOAU** was installed in ``/usr/lpp/IBM/zoau``, you should add
``/usr/lpp/IBM/zoau/bin`` to **PATH**.


Why do I get this error during the playbook execution ?
-------------------------------------------------------

.. code-block:: sh

   IOError: [Errno 21] Is a directory: u'/tmp/xxx'


It is likely that the ``/tmp`` directory of the managed node is full and cannot
store any more data. Clear the ``/tmp`` directory and re-run the
playbook.


Why do I get this warning during the playbook execution ?
---------------------------------------------------------

.. code-block:: sh

   [WARNING]: Python Warning: Incorrect Python Found

It is likely that you are using an older version of the collection which was
supported by the **Rocket Python** distribution. Verify that you have installed
**IBM Open Enterprise SDK for Python** on your z/OS managed node and upgrade
to the latest version of the collection. To learn more about how to upgrade the
collection, see our `installation doc`_ or the sample `repository doc`_.

.. _repository doc:
    https://docs.ansible.com/ansible/latest/user_guide/collections_using.html#id2

.. _installation doc:
   https://ibm.github.io/z_ansible_collections_doc/installation/installation.html

.. note::

   By default the ``ansible-galaxy install`` command installs the latest
   collection.

Why do I get this error during the playbook execution ?
-------------------------------------------------------

.. code-block:: sh

   Internal Error: Unable to find message file for command: mvscmdmsg

``mvscmdmsg`` is a **ZOAU** utility. Generally, this issue appears when the
environment variables are configured incorrectly. Refer to the
`configuration guide`_ documentation to understand how to properly configure
these variables.


Why does my managed z/OS system pre-login prompt cause the ``zos_copy`` and ``zos_fetch`` modules to fail?
----------------------------------------------------------------------------------------------------------

By default, ``SFTP`` redirects **pre-login** prompts to system **stderr**,
which ``zos_copy`` interprets as a failure. You can bypass this behavior and
ignore stderr content by setting **ignore_sftp_stderr** parameter of
``zos_copy`` to **true**.


If I run into a problem when using an Ansible collection for IBM Z, how should I seek support?
----------------------------------------------------------------------------------------------
* For issues related to the Ansible collections, raise a GitHub issue against the appropriate collection repository:

  * `IBM z/OS core <https://github.com/ansible-collections/ibm_zos_core/issues/new/choose>`_
  * `IBM z/OS CICS <https://github.com/ansible-collections/ibm_zos_cics/issues/new/choose>`_
  * `IBM z/OS IMS  <https://github.com/ansible-collections/ibm_zos_ims/issues/new/choose>`_
  * `IBM z/OS Sys Auto <https://github.com/ansible-collections/ibm_zos_sysauto/issues/new/choose>`_
  * `IBM z/OSMF <https://github.com/IBM/ibm_zosmf/issues>`_
  * `IBM Z HMC <https://github.com/zhmcclient/zhmc-ansible-modules/issues>`_

* If you encounter a specific **CICS server-related issue**, raise a case against the CICS team
  as you would normally do with other CICS products.

  * For CICS collection-related issues, gather the CICS `MustGather`_ data before contacting
    the support team.


.. _Mustgather:
   https://www.ibm.com/docs/en/cics-ts/5.6?topic=support-ansible-zos-cics-collection
