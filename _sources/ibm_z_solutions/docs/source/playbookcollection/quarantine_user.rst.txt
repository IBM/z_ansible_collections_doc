.. ...........................................................................
.. © Copyright IBM Corporation 2026                                          .
.. ...........................................................................

.. _quarantine_user:


quarantine_user -- Quarantine a RACF user by applying CONTAIN attribute
========================================================================

.. contents::
   :local:
   :depth: 1


Synopsis
--------

Quarantine a RACF user by applying the CONTAIN attribute when a security alert is detected.

This playbook is launched by an EDA rulebook when zSecure reports a security event requiring 
immediate user containment on z/OS. The playbook issues the RACF ALTUSER command to apply the 
CONTAIN attribute to the affected user, verifies the change by listing the user's attributes, 
and sets status information for downstream notification processes.


Variables
---------

From the rulebook event
~~~~~~~~~~~~~~~~~~~~~~~~

These variables are populated automatically from the matched event when the rulebook launches 
the job template:

target_user
  The RACF user ID to be quarantined.

  | **type**: str

alert_message
  The descriptive message about the security event that triggered the quarantine.

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
for notification purposes. The playbook then skips the quarantine actions.

Phase 2: Execute quarantine and verify (valid user only)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When a valid user ID is provided, the playbook:

1. Issues the ALTUSER command to apply the CONTAIN attribute to the user. The command is executed 
   with a maximum return code of 4 to allow for informational messages while still treating the 
   operation as successful.

2. Verifies the quarantine by issuing the LISTUSER command for the affected user. The output 
   displays the user's current RACF attributes, confirming whether the CONTAIN attribute was applied.

3. Sets status information using ``set_stats`` to record whether the ALTUSER command succeeded or 
   failed. This status message is available to downstream processes, such as email notification playbooks.

4. Logs the result to the AAP job output, showing whether the quarantine command was successful.


Output
------

The playbook produces two outputs:

* A status message set through ``set_stats`` that indicates whether the ALTUSER command was executed 
  successfully or failed. This message is available to subsequent playbooks or notification workflows.

* A run summary in the AAP job output showing the alert message, target user, RACF command results, 
  and the user's attributes after the quarantine attempt.


Prerequisites
-------------

* The Jinja2 template file must be present in the playbook templates directory.
* The AAP job template must include a Machine credential for z/OS SSH access.
* The z/OS user running the playbook must be permitted to issue the TSO command.
* The z/OS user must have RACF authority to execute the ALTUSER command with the CONTAIN attribute.
* The ``target_user`` must exist in RACF (if 'UNKNOWN', the playbook will skip quarantine actions).


Notes
-----

* The playbook executes on the host specified by the ``target_hosts`` variable, which should be 
  defined in the AAP inventory used by the job template.
* The ALTUSER command accepts return codes up to 4 as successful, allowing for informational messages 
  while still applying the CONTAIN attribute.
* The ``set_stats`` data is available to subsequent playbooks in the same workflow, enabling 
  notification playbooks to include the quarantine status in alert emails.
* All output is written to the AAP job log. Restrict access to job logs if your security policy 
  requires it.
* The CONTAIN attribute prevents the user from logging on to TSO or accessing protected resources 
  until the attribute is removed.


See also
--------

* The :ref:`1101_logon_by_unknown_user` rulebook that launch this playbook.
* To issue the RACF commands, see `ibm.ibm_zos_core.zos_tso_command <https://ibm.github.io/z_ansible_collections_doc/ibm_zos_core/docs/source/modules/zos_tso_command.html>`_ module.
* To remove the CONTAIN attribute, use the :ref:`unquarantine_user` playbook.
* Email notification playbooks that consume the ``set_stats`` data from this playbook.