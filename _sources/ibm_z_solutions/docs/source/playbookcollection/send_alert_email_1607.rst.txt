.. ...........................................................................
.. © Copyright IBM Corporation 2026                                          .
.. ...........................................................................

.. _send_alert_email_1607:


send_1607_alert_email -- Send HTML email notification for SMF Record Flood alert
================================================================================

.. contents::
   :local:
   :depth: 1


Synopsis
--------

Send an HTML email notification to security administrators when zSecure alert C2P1607I
(SMF Record Flood) is detected.

This playbook is launched as the second job in the **EDA - SMF 1607 Response Workflow**, which is
triggered by the :ref:`1607_SMF_Flood_Alert` rulebook. The playbook renders an HTML email body
from the ``smf_1607_alert_email.html.j2`` Jinja2 template, incorporating alert details from both
correlated EDA events (C2P1607I and IFA780A) and the diagnostic output produced by the preceding
:ref:`1607_diagnostic` playbook. The notification is delivered to the configured security
recipients via SMTP.


Variables
---------

From the EDA event context
~~~~~~~~~~~~~~~~~~~~~~~~~~~

These variables are available automatically to all jobs in an EDA-launched workflow through
``ansible_eda.events``. Ensure that this playbook runs inside the **EDA - SMF 1607 Response Workflow**;
and the workflow is triggered by the EDA rulebook for these references to be populated.

ansible_eda.events.c2p1607i.body.alert_code
  The zSecure alert code, always ``C2P1607I`` for this workflow.

  | **type**: str

ansible_eda.events.c2p1607i.body.alert_message
  The descriptive message from zSecure that describes the SMF record flood condition. Used as the
  email subject line.

  | **type**: str

ansible_eda.events.c2p1607i.body.hostname
  The z/OS system name where the SMF record flood was detected.

  | **type**: str

ansible_eda.events.ifa780a.body.alert_message
  The full text of the correlated IFA780A WTO message. Rendered in the email body to provide
  context about which SMF record type triggered the flood filter.

  | **type**: str


From the AAP job template
~~~~~~~~~~~~~~~~~~~~~~~~~~

Ensure that these variables are defined on the AAP job template that launches the playbook:

security_alert_recipients
  One or more email addresses that receive the alert notification.

  | **type**: str

security_alert_sender
  Email address shown as the sender of the notification.

  | **type**: str

smtp_server
  Hostname or IP address of the SMTP server used to deliver the notification.

  | **type**: str

smtp_server_port
  Port number of the SMTP server.

  | **type**: int

aap_controller_host
  Hostname of the AAP controller. Used to build a clickable link to the workflow job in the
  email body. Required when ``awx_workflow_job_id`` is set.

  | **type**: str

target_hosts
  The inventory host or group where the playbook runs. Defaults to ``localhost`` if not
  specified.

  | **type**: str


From preceding playbooks (via set_stats)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These variables are published by the :ref:`1607_diagnostic` playbook by using ``set_stats`` and are
available automatically to this playbook when both run in the same AAP workflow.

smf_record_type
  The numeric SMF record type extracted from the IFA780A WTO message. Rendered in the alert
  summary box in the email body. Defaults to ``UNKNOWN`` if the diagnostic playbook could not
  extract the value.

  | **type**: str

smf_flood_time
  The flood detection time extracted from the IFA780A WTO message (format ``HH.MM.SS``).
  Rendered in the alert summary box in the email body. Defaults to ``UNKNOWN`` if the diagnostic
  playbook could not extract the value.

  | **type**: str

d_smf_output
  The formatted output of the ``D SMF`` operator command captured by the diagnostic playbook.
  Rendered in the Diagnostics section of the email body. The section is omitted from the email
  if this variable is undefined or empty.

  | **type**: str


Process walkthrough
-------------------

The playbook runs in three steps.

Step 1: Build the workflow URL
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Constructs a direct URL to the AAP workflow job using ``aap_controller_host`` and the built-in
``awx_workflow_job_id`` variable. If ``awx_workflow_job_id`` is not set, the URL is set to
``None`` and the link is omitted from the email body.

Step 2: Render the HTML notification body
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Renders the ``templates/smf_1607_alert_email.html.j2`` Jinja2 template using
``ansible.builtin.set_fact`` with the ``lookup('template', ...)`` plugin. The rendered HTML
incorporates:

* Alert code, hostname, SMF record type, and flood detection time from the C2P1607I event and
  the diagnostic results.
* The full IFA780A WTO message text.
* The automated action narrative.
* An optional clickable link to the AAP response workflow job (when available).
* The ``D SMF`` diagnostic output (when provided by the preceding diagnostic playbook).

Step 3: Send the notification
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Delivers the HTML email to the configured recipients using the ``community.general.mail`` module.
The email includes:

1. **Subject line**: ``zSecure alert - <alert_message>`` where ``alert_message`` is taken from
   ``ansible_eda.events.c2p1607i.body.alert_message``.
2. **From address**: The configured ``security_alert_sender``.
3. **To addresses**: All recipients in ``security_alert_recipients``.
4. **Body**: The rendered HTML content.

The SMTP connection is delegated to ``localhost``, meaning it originates from the AAP controller
rather than from the target z/OS system.


Output
------

The playbook produces one output:

* An HTML email delivered to the configured security recipients. The email contains the alert
  summary (alert code, hostname, SMF record type, and flood detection time), the correlated
  IFA780A WTO message, the automated action narrative, an optional link to the AAP workflow job,
  and — when available — the ``D SMF`` diagnostic output captured by the preceding
  :ref:`1607_diagnostic` playbook.

* The AAP job output logs the email sending operation, including success or failure status and
  the resolved list of recipients.


Prerequisites
-------------

* The Jinja2 template ``smf_1607_alert_email.html.j2`` and its base template
  ``racf_alert_base.html.j2`` must be present in the playbook's ``templates/`` directory.
* The SMTP server must be reachable from the AAP controller.
* The configured email recipients must be valid mailboxes.
* This playbook must run inside the **EDA - SMF 1607 Response Workflow** so that
  ``ansible_eda.events.c2p1607i`` and ``ansible_eda.events.ifa780a`` are populated.
* The :ref:`1607_diagnostic` playbook should run before this playbook in the same workflow so
  that ``smf_record_type``, ``smf_flood_time``, and ``d_smf_output`` are available via
  ``set_stats``.


Notes
-----

* The playbook sets ``gather_facts: false`` because no Ansible facts about the target host are
  required to send an email.
* Email sending is always delegated to ``localhost``, so the SMTP connection originates from the
  AAP controller regardless of the value of ``target_hosts``.
* If ``d_smf_output`` is undefined or empty, the Diagnostics section is omitted from the email
  body. The email is still sent with all other sections intact.
* All output is written to the AAP job log. Restrict access to job logs if your security policy
  requires it.
* This playbook is the second job in the **EDA - SMF 1607 Response Workflow**, executed after
  :ref:`1607_diagnostic`.


Email template
--------------

The playbook renders ``templates/smf_1607_alert_email.html.j2``, which extends the shared
``racf_alert_base.html.j2`` base template. The base template provides the HTML document
structure, ``<head>``, inline CSS, and the opening ``<body>`` tag.

Template structure
~~~~~~~~~~~~~~~~~~

The template renders the following sections in order:

1. **Alert summary box** (``.alert-box``) — Displays the alert code, hostname, resolved SMF
   record type, and flood detection time. This section is always rendered.

2. **Alert details box** (``.info-box``) — Displays the descriptive zSecure alert message, the
   full IFA780A WTO message text, the automated action narrative, and — when available — a
   clickable link to the AAP workflow job.

3. **Diagnostics section** (``.warning-box``) — Displays the ``D SMF`` operator command output
   inside a ``<pre>`` block. This section is rendered only when ``d_smf_output`` is defined and
   non-empty.

4. **Footer** — A muted italic line identifying the message as an automated alert from
   Event-Driven Ansible.

Template notes
~~~~~~~~~~~~~~

* The ``smf_record_type`` and ``smf_flood_time`` fields render as ``UNKNOWN`` if the diagnostic
  playbook could not extract either value.
* The **Response Workflow** link is omitted from the email when ``awx_workflow_job_id`` is not
  set.
* The Diagnostics section is omitted from the email when ``d_smf_output`` is not available.
* The base template ``racf_alert_base.html.j2`` carries a ``racf_`` prefix because it is shared
  across all zSecure alert email templates in this collection, not only SMF alerts.


See also
--------

* The :ref:`1607_SMF_Flood_Alert` rulebook that triggers the response workflow.
* The :ref:`1607_diagnostic` playbook that runs before this playbook and publishes
  ``smf_record_type``, ``smf_flood_time``, and ``d_smf_output``.
* To send the notification, see the `community.general.mail <https://docs.ansible.com/ansible/latest/collections/community/general/mail_module.html>`_ module.
* Use the ``templates/smf_1607_alert_email.html.j2`` Jinja2 template for the email body.
