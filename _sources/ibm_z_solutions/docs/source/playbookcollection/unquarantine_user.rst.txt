.. ...........................................................................
.. © Copyright IBM Corporation 2026                                          .
.. ...........................................................................

.. _unquarantine_user:


unquarantine_user -- Remove CONTAIN attribute and resume user access
====================================================================

.. contents::
   :local:
   :depth: 1


Synopsis
--------

Remove the CONTAIN attribute from a RACF user and resume their access after a security incident 
has been resolved.

This playbook is typically launched manually or by an EDA rulebook after a security incident has 
been investigated and resolved. The playbook issues the RACF ALTUSER command to remove the CONTAIN 
attribute and resume normal access for a previously quarantined user. The playbook verifies the 
change by listing the user's attributes and sets status information for downstream notification 
processes.

Variables
---------

From the rulebook event
~~~~~~~~~~~~~~~~~~~~~~~~

These variables are populated automatically from the matched event when the rulebook launches 
the job template:

target_user
  The RACF user ID to be unquarantined. Defaults to 'UNKNOWN' if not provided.

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
for notification purposes. The playbook then skips the unquarantine actions.

Phase 2: Execute unquarantine and verify (valid user only)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When a valid user ID is provided, the playbook does the following:

1. Issues the ALTUSER command to remove the CONTAIN attribute and resume the user's access. The 
   command uses both NOCONTAIN (to remove the containment) and RESUME (to restore access) parameters. 
   The command is executed with a maximum return code of 0, requiring complete success.

2. Verifies the unquarantine by issuing the LISTUSER command for the affected user. The output 
   displays the user's current RACF attributes, confirming whether the CONTAIN attribute was removed 
   and access was restored.

3. Sets status information using ``set_stats`` to record whether the ALTUSER command succeeded or 
   failed. This status message is available to downstream processes, such as email notification playbooks.

4. Logs the result to the AAP job output, showing whether the unquarantine command was successful.


Output
------

The playbook produces two outputs:

* A status message set via ``set_stats`` that indicates whether the ALTUSER command was executed 
  successfully or failed. This message is available to subsequent playbooks or notification workflows.

* A run summary in the AAP job output showing the target user, RACF command results, and the user's 
  attributes after the unquarantine attempt.


Prerequisites
-------------

* The AAP job template must include a Machine credential for z/OS SSH access.
* The z/OS user running the playbook must be permitted to issue the TSO command.
* The z/OS user must have RACF authority to execute the ALTUSER command with the NOCONTAIN and 
  RESUME attributes.
* The ``target_user`` must exist in RACF and currently have the CONTAIN attribute applied (if 
  'UNKNOWN', the playbook will skip unquarantine actions).
* The security incident that triggered the original quarantine should be fully investigated and 
  resolved before running this playbook.


Notes
-----

* The playbook executes on the host specified by the ``target_hosts`` variable, which should be 
  defined in the AAP inventory used by the job template.
* The ALTUSER command requires return code 0 for success, which is stricter than the 
  :ref:`quarantine_user` playbook that accepts return codes up to 4.
* The NOCONTAIN parameter removes the containment restriction, while RESUME restores the user's 
  ability to log on and access resources.
* This playbook is the counterpart to :ref:`quarantine_user` and should only be executed after 
  proper security review and approval.
* The ``set_stats`` data is available to subsequent playbooks in the same workflow, enabling 
  notification playbooks to include the unquarantine status in alert emails.
* All output is written to the AAP job log. Restrict access to job logs if your security policy 
  requires it.
* Consider implementing approval workflows or change management processes before allowing this 
  playbook to execute, as it restores access to a previously restricted user.


See also
--------

* To apply the CONTAIN attribute, use :ref:`quarantine_user` playbook.
* To issue RACF commands, use the `ibm.ibm_zos_core.zos_tso_command <https://ibm.github.io/z_ansible_collections_doc/ibm_zos_core/docs/source/modules/zos_tso_command.html>`_ module.
* Email notification playbooks that consume the ``set_stats`` data from this playbook.
* Security incident management procedures that govern when users can be unquarantined.