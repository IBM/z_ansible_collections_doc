.. ...........................................................................
.. © Copyright IBM Corporation 2026                                          .
.. ...........................................................................

.. _send_alert_email:


send_alert_email -- Send HTML email notification to security administrators
============================================================================

.. contents::
   :local:
   :depth: 1


Synopsis
--------

Send an HTML email notification to security administrators when a zSecure alert is detected.

This playbook is launched by EDA rulebooks after a security event is detected and processed on z/OS. 
The playbook renders an HTML email notification from a Jinja2 template, incorporating alert details 
from the triggering event and any action status from preceding playbooks in the workflow. The 
notification is sent to configured security recipients via SMTP.


Variables
---------

From the rulebook event
~~~~~~~~~~~~~~~~~~~~~~~~

These variables are populated automatically from the matched event when the rulebook launches 
the job template:

alert_message
  The descriptive message about the security event. Defaults to 'N/A' if not provided.

  | **type**: str

alert_code
  The zSecure alert code identifying the type of security event. Defaults to 'N/A' if not provided.

  | **type**: str

target_user
  The RACF user ID affected by the security event. Defaults to 'N/A' if not provided.

  | **type**: str

group_name
  The RACF group name involved in the event (if applicable). Defaults to 'N/A' if not provided.

  | **type**: str

job_name
  The job name associated with the event (if applicable). Defaults to 'N/A' if not provided.

  | **type**: str

hostname
  The z/OS system name where the event occurred. Defaults to 'N/A' if not provided.

  | **type**: str


From the AAP job template
~~~~~~~~~~~~~~~~~~~~~~~~~~

These variables must be defined on the AAP job template that launches the playbook:

security_alert_recipients
  List of email addresses that receive the alert notification.

  | **type**: str

security_alert_sender
  Email address shown as the sender of the notification.

  | **type**: str

smtp_server
  Hostname or IP address of the SMTP server.

  | **type**: str

smtp_server_port
  Port number of the SMTP server.

  | **type**: str

target_hosts
  The inventory host or group where the playbook executes. Defaults to 'localhost' if not specified.

  | **type**: str


From preceding playbooks (via set_stats)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set_command_message
  Status message from a preceding playbook in the workflow (e.g., :ref:`quarantine_user` or 
  :ref:`remove_uid_access`) indicating whether remediation actions succeeded or failed. Defaults 
  to 'no command' if not set.

  | **type**: str


Process walkthrough
-------------------

The playbook runs in two phases.

Phase 1: Build the HTML notification
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook renders an HTML email body from a Jinja2 template located at 
``templates/racf_email_alert.html.j2``. The template receives all alert details from the rulebook 
event, email configuration variables, and the command status message from any preceding playbooks. 
This produces a formatted HTML notification that includes both the trigger event details and any 
remediation actions taken.

Phase 2: Send the notification
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook sends the HTML notification to the configured email recipients through the SMTP server. 
The email includes:

1. **Subject line**: "zSecure alert - [alert_message]"
2. **From address**: The configured ``security_alert_sender``
3. **To addresses**: All recipients in the ``security_alert_recipients`` list
4. **Body**: The rendered HTML content with full alert context

The SMTP connection is delegated to localhost, meaning it originates from the AAP controller rather 
than the target z/OS system.


Output
------

The playbook produces one primary output:

* An HTML email delivered to the configured security recipients, containing the alert details, system 
  information, affected user or resource, and the status of any remediation actions taken by preceding 
  playbooks in the workflow.

* The AAP job output logs the email sending operation, including success or failure status.


Prerequisites
-------------

* The Jinja2 template file ``racf_email_alert.html.j2`` must be present in the playbook's templates 
  directory.
* The SMTP server must be reachable from the AAP controller.
* The configured email recipients must be valid mailboxes.
* If this playbook is part of a workflow, preceding playbooks should use ``set_stats`` to provide 
  the ``command_message`` variable.


Notes
-----

* The playbook executes on the host specified by the ``target_hosts`` variable but delegates email 
  sending to localhost, so the SMTP connection originates from the AAP controller.
* HTML email requires the recipient mail client to render HTML. Ensure your email template provides 
  appropriate formatting for your environment.
* All event variables default to 'N/A' if not provided, ensuring the playbook can run even with 
  incomplete event data.
* The ``command_message`` variable captures status from preceding playbooks in a workflow, allowing 
  a single email to report both the alert and the remediation outcome.
* All output is written to the AAP job log. Restrict access to job logs if your security policy 
  requires it.
* This playbook is typically the final step in a security workflow, executed after remediation 
  playbooks like :ref:`quarantine_user`, or :ref:`remove_uid_access`.


See also
--------

* The EDA rulebooks that launch this playbook (e.g., :ref:`1101_logon_by_unknown_user`, :ref:`1103_superuser_logon`, :ref:`1107_1108_group_auth_status`).
* To send the notification, see the `community.general.mail <https://docs.ansible.com/ansible/latest/collections/community/general/mail_module.html>`_ module.
* To set status command through ``set_stats``, see the :ref:`quarantine_user`, and :ref:`remove_uid_access` playbooks. 
* Use the ``templates/racf_email_alert.html.j2`` Jinja2 template for the email body.
