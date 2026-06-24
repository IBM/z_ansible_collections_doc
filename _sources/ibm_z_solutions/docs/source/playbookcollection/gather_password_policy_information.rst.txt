.. ...........................................................................
.. © Copyright IBM Corporation 2026                                          .
.. ...........................................................................

.. _gather_password_policy_information:


gather_password_policy_information -- Validate password breach and gather policy
=================================================================================

.. contents::
   :local:
   :depth: 1


Synopsis
--------

Validate a RACF password threshold breach, gather the current password policy, and send a 
security notification.

This playbook is launched by the ``1111_invalid_password_limit_exceeded`` rulebook when zSecure 
alert C2P1111I has been confirmed by a correlated RACF ICH408I logon denial. The playbook validates 
that the ICH408I message refers to the same user identified in the zSecure alert, retrieves the 
current RACF password policy from z/OS, formats an HTML alert notification, and emails the 
notification to the configured security recipients.


Variables
---------

From the rulebook events
~~~~~~~~~~~~~~~~~~~~~~~~~

This playbook is triggered by a two event correlation. Variables come from both correlated events:

alert_code
  The zSecure alert code C2P1111I, sourced from the first correlated event (events.a).

  | **type**: str

alert_message
  The descriptive zSecure alert message, sourced from events.a.

  | **type**: str

target_user
  The RACF user ID that exceeded the password threshold, sourced from events.a.

  | **type**: str

hostname
  The z/OS system name where the breach occurred, sourced from events.a.

  | **type**: str

ich408i_message
  The RACF ICH408I logon denial text, sourced from the second correlated event (events.b).

  | **type**: str


From the AAP job template
~~~~~~~~~~~~~~~~~~~~~~~~~~

These variables must be defined on the AAP job template that launches the playbook:

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

The playbook runs in four phases.

Phase 1: Validate the correlated events
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook checks that the RACF ICH408I message refers to the same user identified in the 
zSecure C2P1111I alert. This guards against a spurious correlation where the two events happen 
to fall in the same time window but actually relate to different users. If the user identification 
does not match, the playbook stops with a clear failure message.

Phase 2: Gather the current password policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook connects to the z/OS host identified in the event and runs SETROPTS LIST to retrieve 
the current RACF system options. The output is parsed to extract the configured invalid password 
attempt threshold. If the command fails or the threshold cannot be parsed, the playbook substitutes 
fallback values so the workflow can continue.

Phase 3: Build the notification
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook renders an HTML email body from a Jinja2 template. The template receives the original 
alert details, the ICH408I message, and the password policy gathered in Phase 2. This produces a 
single notification that gives the security team the breach context and the relevant policy setting 
in one message.

Phase 4: Send the notification and log results
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The playbook sends the HTML notification to the configured email recipients through the SMTP server. 
The SMTP connection is made from the AAP controller, not from z/OS. Success or failure of each step 
is logged to the AAP job output, and a summary is recorded at the end of the run.


Output
------

The playbook produces two outputs:

* An HTML email delivered to the configured security recipients, contain the alert details, 
  the ICH408I logon denial text, and the current password threshold.

* A summary report in the AAP job log showing the alert code, user ID, hostname, parsed password 
  threshold, status of the SETROPTS query, and status of the email delivery.


Prerequisites
-------------

* The Jinja2 template file must be present in the playbook templates directory.
* The AAP job template must include a Machine credential for z/OS SSH access.
* The z/OS user running the playbook must be permitted to issue the SETROPTS LIST TSO command.
* The SMTP server must be reachable from the AAP controller.
* The configured email recipients must be valid mailboxes.


Notes
-----

* The playbook executes on the ``zos_target`` inventory host, defined in the AAP inventory used 
  by the job template.
* The playbook depends on both events.a and events.b being present in the launch payload. It cannot 
  be run standalone with manual variables unless the same structure is supplied.
* Email sending is delegated to localhost, so the SMTP connection originates from the AAP controller.
* HTML email requires the recipient mail client to render HTML. Provide a plain text fallback in 
  the template if your environment requires it.


See also
--------

* The :ref:`1111_invalid_password_limit_exceeded` rulebook that launches this playbook.
* To issue the SETROPTS LIST command, use the `ibm.ibm_zos_core.zos_tso_command <https://ibm.github.io/z_ansible_collections_doc/ibm_zos_core/docs/source/modules/zos_tso_command.html>`_ module.
* To send the notification, use the `community.general.mail <https://docs.ansible.com/ansible/latest/collections/community/general/mail_module.html>`_ module.