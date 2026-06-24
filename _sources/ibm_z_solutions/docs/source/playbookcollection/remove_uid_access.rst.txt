.. ...........................................................................
.. © Copyright IBM Corporation 2026                                          .
.. ...........................................................................

.. _remove_uid_access:


remove_uid_access -- Remove OMVS UID(0) access from a RACF user
================================================================

.. contents::
   :local:
   :depth: 1


Synopsis
--------

Remove OMVS UID(0) access from a RACF user when a security alert detects unauthorized superuser activity.

This playbook is launched by an EDA rulebook when zSecure reports a security event involving 
unauthorized UID(0) or superuser access on z/OS. The playbook removes the user's OMVS UID by 
setting it to NONE, preventing further OMVS shell access. The playbook verifies the change by 
listing the user's OMVS attributes before and after the modification and sets status information 
for downstream notification processes.


Variables
---------

From the rulebook event
~~~~~~~~~~~~~~~~~~~~~~~~

These variables are populated automatically from the matched event when the rulebook launches 
the job template:

target_user
  The RACF user ID whose OMVS UID access will be removed.

  | **type**: str

alert_message
  The descriptive message about the security event that triggered the UID removal.

  | **type**: str


From the AAP job template
~~~~~~~~~~~~~~~~~~~~~~~~~~

These variables must be defined on the AAP job template that launches the playbook:

target_hosts
  The inventory host or group where the playbook executes. Defaults to 'localhost' if not specified.

  | **type**: str

system_environment
  Environment variables required for z/OS shell access, such as shared address space settings.

  | **type**: dict


Process walkthrough
-------------------

The playbook runs in two phases based on whether a valid user ID is provided.

Phase 1: Validate the target user
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook checks if the ``target_user`` variable contains a valid RACF user ID. If the value 
is 'UNKNOWN', the playbook logs a message indicating it cannot proceed and sets a status message 
for notification purposes. The playbook then skips the UID removal actions.

Phase 2: Execute UID removal and verify (valid user only)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If a valid user ID is provided, the playbook connects to the z/OS host and performs the following actions:

1. Queries the current OMVS UID status by issuing the LISTUSER command with the OMVS and NORACF 
   parameters. This displays the user's current OMVS segment attributes, including the UID value. 
   The output is captured and logged for audit purposes.

2. Removes the UID by issuing the ALTUSER command with OMVS(NOUID). This sets the user's UID to 
   NONE, effectively removing their ability to access OMVS shells and Unix System Services. The 
   command is executed with error handling to capture any failures.

3. Verifies the UID removal by issuing the LISTUSER command again to display the user's OMVS 
   attributes after the change. This confirms whether the UID was successfully set to NONE.

4. Sets status information using ``set_stats`` to record whether the ALTUSER command succeeded or 
   failed. This status message is available to downstream processes, such as email notification playbooks.

5. Logs the result to the AAP job output, showing whether the UID removal command was successful.


Output
------

The playbook produces two outputs:

* A status message set through ``set_stats`` that indicates whether the ALTUSER command was executed 
  successfully or failed. This message is available to subsequent playbooks or notification workflows.

* A run summary in the AAP job output showing the alert message, target user, OMVS UID status before 
  the change, RACF command results, and the OMVS UID status after the change.


Prerequisites
-------------

* The AAP job template must include a Machine credential for z/OS SSH access.
* The z/OS user running the playbook must be permitted to issue the TSO command.
* The z/OS user must have RACF authority to execute the ALTUSER command with OMVS segment modifications.
* The ``target_user`` must exist in RACF and have an OMVS segment (if 'UNKNOWN', the playbook will 
  skip UID removal actions).


Notes
-----

* The playbook executes on the host specified by the ``target_hosts`` variable, which should be 
  defined in the AAP inventory used by the job template.
* The ALTUSER command accepts return codes up to 4 as successful, allowing for informational messages 
  while still removing the UID.
* The NORACF parameter on LISTUSER displays only the OMVS segment attributes, reducing output verbosity.
* Setting UID to NONE (NOUID) prevents the user from accessing OMVS shells and Unix System Services 
  but does not affect their TSO or batch access.
* The ``set_stats`` data is available to subsequent playbooks in the same workflow, enabling 
  notification playbooks to include the UID removal status in alert emails.
* All output is written to the AAP job log. Restrict access to job logs if your security policy 
  requires it.
* This action is typically used in response to unauthorized UID(0) access or superuser privilege 
  escalation attempts.


See also
--------

* The :ref:`1103_superuser_logon` rulebook that launch this playbook.
* To issue the RACF command, use the `ibm.ibm_zos_core.zos_tso_command <https://ibm.github.io/z_ansible_collections_doc/ibm_zos_core/docs/source/modules/zos_tso_command.html>`_ module.
* To apply the CONTAIN attribute, use the :ref:`quarantine_user` playbook.
* Email notification playbooks that consume the ``set_stats`` data from this playbook.