.. ...........................................................................
.. © Copyright IBM Corporation 2026                                          .
.. ...........................................................................

.. _gather_listuser_information:


gather_listuser_information -- Gather RACF user details and send security notification
=======================================================================================

.. contents::
   :local:
   :depth: 1


Synopsis
--------

Gather RACF user details and send a security notification when a group authority change is detected.

This playbook is launched by the ``1107_1108_group_auth_status`` rulebook when zSecure reports 
a group authority change (alert C2P1107I for granted or C2P1108I for removed) on z/OS. The playbook 
gathers RACF user context for the affected user, formats an HTML alert notification, and emails 
the notification to the configured security recipients.


Variables
---------

From the rulebook event
~~~~~~~~~~~~~~~~~~~~~~~~

These variables are populated automatically from the matched event when the rulebook launches 
the job template:

alert_code
  The zSecure alert code (C2P1107I or C2P1108I).

  | **type**: str

alert_message
  The descriptive message about the group authority change.

  | **type**: str

hostname
  The z/OS system name where the authority change occurred.

  | **type**: str

target_user
  The RACF user ID affected by the change.

  | **type**: str

group_name
  The RACF group name involved in the change.

  | **type**: str


From the AAP job template
~~~~~~~~~~~~~~~~~~~~~~~~~~

Ensure that you define these variables on the AAP job template that launches the playbook:

security_alert_recipients
  List of email addresses that receive the alert notification.

  | **type**: list of str

security_alert_sender
  Email address shown as the sender of the notification.

  | **type**: str

smtp_server
  Hostname or IP address of the SMTP server.

  | **type**: str

smtp_server_port
  Port number of the SMTP server.

  | **type**: int

system_environment
  Environment variables required for z/OS shell access, such as shared address space settings.

  | **type**: dict


Process walkthrough
-------------------

The playbook runs in three phases.

Phase 1: Gather RACF user context
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook connects to the z/OS host identified in the event and runs the LISTUSER command 
for the affected RACF user. The output is captured and parsed to extract the user ID, owner, 
creation date, default group, and attributes. If the command fails or the user is not found, 
the playbook substitutes fallback values so the workflow can continue.

Phase 2: Build the notification
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook renders an HTML email body from a Jinja2 template. The template receives the 
original alert details from the rulebook and the parsed RACF user context from Phase 1. 
This produces a single security notification that includes both the trigger event and the 
verified user information.

Phase 3: Send the notification and log results
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook sends the HTML notification to the configured email recipients through the SMTP 
server. The SMTP connection is made from the AAP controller, not from z/OS. Success or failure 
of each step is logged to the AAP job output, and a summary is recorded at the end of the run.


Output
------

The playbook produces two outputs:

* An HTML email delivered to the configured security recipients, contains the alert details 
  and the gathered RACF user context.

* A run summary in the AAP job output showing the alert code, target user, hostname, status 
  of the RACF query, and status of the email delivery.


Prerequisites
-------------

* Ensure that the Jinja2 template file is present in the playbook templates directory.
* Ensure that the AAP job template includes a Machine credential for z/OS SSH access.
* The z/OS user running the playbook must be permitted to issue the TSO command.
* The SMTP server must be reachable from the AAP controller.
* The configured email recipients must be valid mailboxes.


Notes
-----

* The playbook executes on the ``zos_target`` inventory host, defined in the AAP inventory 
  used by the job template.
* Email sending is delegated to localhost, so the SMTP connection originates from the AAP controller.
* HTML email requires the recipient mail client to render HTML. Provide a plain text fallback 
  in the template if your environment requires it.
* All output is written to the AAP job log. Restrict access to job logs if your security policy 
  requires it.


See also
--------

* The :ref:`1107_1108_group_auth_status` rulebook that launches this playbook.
* To issue the the LISTUSER command, use the `ibm.ibm_zos_core.zos_tso_command <https://ibm.github.io/z_ansible_collections_doc/ibm_zos_core/docs/source/modules/zos_tso_command.html>`_ module.
* To send the notification, use the `community.general.mail <https://docs.ansible.com/ansible/latest/collections/community/general/mail_module.html>`_ module.
