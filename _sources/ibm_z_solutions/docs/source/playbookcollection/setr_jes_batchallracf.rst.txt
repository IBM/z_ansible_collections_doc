.. ...........................................................................
.. © Copyright IBM Corporation 2026                                          .
.. ...........................................................................

.. _setr_jes_batchallracf:


setr_jes_batchallracf -- Enable RACF authentication for all batch jobs
=======================================================================

.. contents::
   :local:
   :depth: 1


Synopsis
--------

Enable RACF authentication for all batch jobs by activating the JES BATCHALLRACF option.

This playbook is launched by an EDA rulebook when zSecure reports a security event indicating that 
batch jobs are being submitted without proper RACF authentication. The playbook issues the SETROPTS 
command to activate the JES BATCHALLRACF option, which requires all batch jobs to include a valid 
user ID and password on the JOB statement. The playbook verifies the change by listing the current 
RACF options and sets status information for downstream notification processes.


Variables
---------

From the rulebook event
~~~~~~~~~~~~~~~~~~~~~~~~

These variables are populated automatically from the matched event when the rulebook launches 
the job template:

alert_message
  The descriptive message about the security event that triggered the SETROPTS command. Defaults 
  to 'No Message Text' if not provided.

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

The playbook runs in three phases.

Phase 1: Display the alert message
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook logs the alert message from the triggering event to the AAP job output, providing 
context for why the SETROPTS command is being executed.

Phase 2: Activate JES BATCHALLRACF
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook issues the ``SETROPTS JES(BATCHALLRACF)`` command to activate the BATCHALLRACF option. 
When active, this option requires JES to verify that every batch job includes a valid RACF user ID 
and password on the JOB statement. Jobs submitted without proper credentials will be rejected. The 
command result is captured for status reporting.

Phase 3: Verify and report the change
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook:

1. Queries the current RACF options by issuing the SETROPTS LIST command. This displays all active 
   RACF options, including the JES-BATCHALLRACF setting.

2. Parses the output to determine whether the JES-BATCHALLRACF option is active or inactive. The 
   status is extracted by searching for the text "JES-BATCHALLRACF OPTION IS ACTIVE" in the command 
   output.

3. Logs the status to the AAP job output, confirming whether the option is now active.

4. Sets status information using ``set_stats`` to record whether the SETROPTS command succeeded or 
   failed. This status message is available to downstream processes, such as email notification playbooks.


Output
------

The playbook produces two outputs:

* A status message set via ``set_stats`` that indicates whether the SETROPTS command was executed 
  successfully or failed. This message is available to subsequent playbooks or notification workflows.

* A run summary in the AAP job output showing the alert message, the SETROPTS command result, and 
  the verified status of the JES-BATCHALLRACF option (active or inactive).


Prerequisites
-------------

* The AAP job template must include a Machine credential for z/OS SSH access.
* The z/OS user running the playbook must be permitted to issue the TSO command.
* The z/OS user must have RACF SPECIAL or OPERATIONS authority to execute the SETROPTS command.
* The JES subsystem must be active and configured to support RACF authentication.


Notes
-----

* The playbook executes on the host specified by the ``target_hosts`` variable, which should be 
  defined in the AAP inventory used by the job template.
* The SETROPTS command with return code 0 indicates success. Higher return codes indicate warnings 
  or errors.
* The JES-BATCHALLRACF option is a system-wide setting that affects all batch job submissions on 
  the z/OS system.
* When BATCHALLRACF is active, batch jobs must include both USER= and PASSWORD= parameters on the 
  JOB statement, or they will be rejected by JES.
* The ``set_stats`` data is available to subsequent playbooks in the same workflow, enabling 
  notification playbooks to include the SETROPTS status in alert emails.
* All output is written to the AAP job log. Restrict access to job logs if your security policy 
  requires it.
* This remediation action helps prevent unauthorized batch job submissions and ensures proper audit 
  trails for all batch activity.


See also
--------

* The :ref:`1101_logon_by_unknown_user` rulebook launch this playbook when batch security violations are detected.
* To issue RACF commands, see the `ibm.ibm_zos_core.zos_tso_command <https://ibm.github.io/z_ansible_collections_doc/ibm_zos_core/docs/source/modules/zos_tso_command.html>`_ module.
* RACF documentation for `SETROPTS JES(BATCHALLRACF)`_ command.
* Email notification playbooks that consume the `set_stats` data from this playbook.



.. .............................................................................
.. Global Links
.. .............................................................................

.. _SETROPTS JES(BATCHALLRACF):
..  https://www.ibm.com/docs/en/zos/3.2.0?topic=racf-setropts-options