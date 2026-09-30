.. ...........................................................................
.. © Copyright IBM Corporation 2026                                          .
.. ...........................................................................

.. _1607_diagnostic:


1607_diagnostic -- Capture SMF flood diagnostics for zSecure alert C2P1607I
============================================================================

.. contents::
   :local:
   :depth: 1


Synopsis
--------

Capture system diagnostics when zSecure alert C2P1607I (SMF Record Flood) is detected.

This playbook runs as the first job in the **EDA - SMF 1607 Response Workflow**, which the
:ref:`1607_SMF_Flood_Alert` rulebook triggers. The playbook issues the ``D SMF`` operator
command to capture the current SMF recording status on the target z/OS system, extracts the
SMF record type and flood detection time from the correlated IFA780A WTO message, and
publishes the derived values for downstream notification jobs in the same workflow.


Variables
---------

From the EDA event context
~~~~~~~~~~~~~~~~~~~~~~~~~~~

These variables are available automatically to all jobs in an EDA-launched workflow through
``ansible_eda.events``. This playbook must run inside the **EDA - SMF 1607 Response Workflow**;
the workflow must be triggered by the EDA rulebook for these references to be populated.

ansible_eda.events.c2p1607i.body.alert_code
  The zSecure alert code, always ``C2P1607I`` for this workflow.

  | **type**: str

ansible_eda.events.c2p1607i.body.hostname
  The z/OS system name where the SMF record flood was detected.

  | **type**: str

ansible_eda.events.ifa780a.body.alert_message
  The IFA780A WTO message text. Read by the playbook ``vars:`` block as ``flood_wto_message``
  and used to extract both the SMF record type and the flood detection time by using a regular expression.

  | **type**: str

From the AAP job template
~~~~~~~~~~~~~~~~~~~~~~~~~~

Ensure that these variables are defined on the AAP job template that launches the playbook:

target_hosts
  The inventory host or group where the ``D SMF`` operator command is issued. Defaults to
  ``localhost`` if not specified on the job template.

  | **type**: str

system_environment
  Environment variables required for z/OS shell access, such as shared address space settings.

  | **type**: dict


How the playbook works
----------------------

The playbook runs in five steps.

Step 1: Capture current SMF status
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook issues the ``D SMF`` operator command on the target z/OS system by using the
``ibm.ibm_zos_core.zos_operator`` module. Both ``ignore_errors: true`` and
``ignore_unreachable: true`` are set so that a command failure does not abort the workflow.

If the command succeeds, the playbook formats the raw console response into the ``d_smf_output``
variable, prefixed with a ``==== D SMF ====`` header for clarity in the notification email.
If the command fails or the host is unreachable, a separate fallback task sets ``d_smf_output``
to a static message (``D SMF command could not be executed.``) so that subsequent steps and
the notification email always have a defined value.

Step 2: Extract the SMF record type
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook parses the ``flood_wto_message`` variable — resolved from
``ansible_eda.events.ifa780a.body.alert_message`` in the ``vars:`` block — by using
``regex_findall`` to extract the numeric SMF record type that
triggered the flood filter. If the pattern does not match — for example, if the message text is
absent or malformed — the variable is set to ``UNKNOWN`` so the workflow can continue without
interruption.

Step 3: Extract the flood detection time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook parses the same ``flood_wto_message`` variable by using ``regex_findall`` to extract
the time at which the flood was detected. If no time value is found in the message, the variable
is set to ``UNKNOWN``.

Step 4: Display diagnostic summary
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook logs a formatted summary to the AAP job output, including the alert code, resolved
SMF record type, flood detection time, hostname, and ``D SMF`` command status (``Success`` or
``Failed``). This output is visible in the AAP job log for review.

Step 5: Publish derived results for downstream jobs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook publishes ``smf_record_type``, ``smf_flood_time``, and ``d_smf_output`` by using
``ansible.builtin.set_stats`` so they are available to subsequent jobs in the
**EDA - SMF 1607 Response Workflow**, specifically the notification job that renders and sends
the alert email.


Output
------

The playbook produces three workflow-level outputs by using ``set_stats``:

* **smf_record_type**: The numeric SMF record type extracted from the IFA780A message, or
  ``UNKNOWN`` if extraction failed.

* **smf_flood_time**: The flood detection time extracted from the IFA780A message (format
  ``HH.MM.SS``), or ``UNKNOWN`` if extraction failed.

* **d_smf_output**: The formatted output of the ``D SMF`` operator command, including the
  ``==== D SMF ====`` header, or a fallback message if the command could not be executed.

The :ref:`send_alert_email_1607` playbook uses all three values to populate the HTML notification
email.


Prerequisites
-------------

* The AAP job template must include a Machine credential for z/OS SSH access.
* The z/OS user running the playbook must be authorized to issue the ``D SMF`` operator command.
* The ``ibm.ibm_zos_core`` collection must be installed in the execution environment.
* Ensure that this playbook runs as a job inside the **EDA - SMF 1607 Response Workflow**, as it
  depends on ``ansible_eda.events`` that is populated by the EDA rulebook.


Notes
-----

* The playbook sets ``gather_facts: false`` because no Ansible facts are required for the
  operator command or regex extraction.
* The ``D SMF`` operator task uses ``ignore_errors: true`` and ``ignore_unreachable: true`` so
  that a command failure or an unreachable host does not abort the workflow. If either condition
  occurs, the fallback task sets ``d_smf_output`` to ``D SMF command could not be executed.``
  so that the notification email always has a defined value for the diagnostics section.
* The ``D SMF`` command output is joined into a single multi-line string. On systems where the
  operator command produces a large response, the output is truncated to what the
  ``ibm.ibm_zos_core.zos_operator`` module returns.
* If ``flood_wto_message`` is empty or does not contain the expected pattern, both
  ``smf_record_type`` and ``smf_flood_time`` are set to ``UNKNOWN`` and the email renders
  cleanly with that placeholder value.
* Step 4 logs alert details to the AAP job log. Restrict access to job logs as required by your
  security policy.
* ``set_stats`` publishes data at the AAP workflow level, making all three variables available
  to all subsequent jobs in the workflow.


See also
--------

* The :ref:`1607_SMF_Flood_Alert` rulebook that triggers this playbook as part of the response workflow.
* The :ref:`send_alert_email_1607` playbook that consumes ``smf_record_type``, ``smf_flood_time``, and ``d_smf_output`` to send the notification.
* To issue operator commands on z/OS, see the `ibm.ibm_zos_core.zos_operator <https://ibm.github.io/z_ansible_collections_doc/ibm_zos_core/docs/source/modules/zos_operator.html>`_ module.