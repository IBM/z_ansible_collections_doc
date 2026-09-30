.. ...........................................................................
.. © Copyright IBM Corporation 2026                                          .
.. ...........................................................................

.. _send_alert_message:


send_slack_message -- Send Slack notification to security administrators
========================================================================

.. contents::
   :local:
   :depth: 1


Synopsis
--------

Send a Slack notification to security administrators when a zSecure alert is detected.

This playbook is launched by EDA rulebooks after a security event is detected and processed on z/OS.
The playbook supports two event shapes: a dedicated block for SMF Record Flood events (alert 1607 — C2P1607I)
and a standard fallback block for all other events arriving under ``ansible_eda.event.body``.
Each block constructs a formatted Slack message and posts it to a configured Slack channel using a webhook URL.
When running inside an AAP workflow, a direct link to the workflow job execution is included in the notification.


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

hostname
  The z/OS system name where the event occurred. Defaults to 'N/A' if not provided.

  | **type**: str

smf_record_type
  The SMF record type associated with the flood event. Applies only to the SMF Record Flood block
  (alert 1607 — C2P1607I). Defaults to 'N/A' if not provided.

  | **type**: str


From the AAP job template / Controller environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ensure that these variables are defined on the AAP job template that launches the playbook:

slack_webhook
  The Slack incoming webhook URL (or token) used to authenticate and post messages to the designated Slack channel.

  | **type**: str

aap_controller_host
  The hostname or IP address of the AAP controller instance. Used to construct the workflow execution URL.

  | **type**: str

awx_workflow_job_id
  The workflow job execution ID automatically provided by AAP when the job runs inside a workflow. If not present,
  empty, or the string ``'None'``, the workflow URL defaults to ``'None'``.

  | **type**: str


Process walkthrough
-------------------

The playbook evaluates the incoming event and routes it to the appropriate block.

**Block 1 — SMF Record Flood (alert 1607 — C2P1607I)**

Triggered when ``ansible_eda.events`` is defined and ``ansible_eda.events.c2p1607i`` is defined.

1. **Extracts alert information**: Retrieves ``alert_code``, ``alert_message``, and ``hostname`` from ``ansible_eda.events.c2p1607i.body``.
2. **Builds the workflow URL**: Constructs a direct link to the running AAP workflow job execution.
3. **Posts the Slack message**: Uses the ``community.general.slack`` module to post a formatted message containing:

   * **Header**: ``*zSecure EDA Alert Code — {{ alert_code }}*``
   * **Host**: ``*Host:* `{{ hostname }}```
   * **Alert**: ``*Alert:* `{{ alert_message }}```
   * **SMF Record Type**: ``*SMF Record Type:* `{{ smf_record_type }}```
   * **Workflow Link**: ``*View Response Workflow:* <{{ workflow_url }}|Run ID {{ awx_workflow_job_id }}>``

**Block 2 — Standard alert (fallback)**

Triggered when ``ansible_eda.event`` is defined. Handles all other events arriving under ``ansible_eda.event.body``.

1. **Extracts alert information**: Retrieves ``alert_code``, ``alert_message``, and ``hostname`` from ``ansible_eda.event.body``.
2. **Builds the workflow URL**: Constructs a direct link to the running AAP workflow job execution.
3. **Posts the Slack message**: Uses the ``community.general.slack`` module to post a formatted message containing:

   * **Header**: ``*zSecure EDA Alert Code — {{ alert_code }}*``
   * **Host**: ``*Host:* `{{ hostname }}```
   * **Alert**: ``*Alert:* `{{ alert_message }}```
   * **Workflow Link**: ``*View Response Workflow:* <{{ workflow_url }} | Run ID {{ awx_workflow_job_id }}>``


Output
------

The playbook produces one primary output:

* A formatted Slack message posted to the configured Slack channel via webhook, containing the alert code, target host,
  descriptive alert message, SMF record type (C2P1607I block only), and AAP workflow execution URL.

* The AAP job output logs the status of the Slack message delivery.


Prerequisites
-------------

* An incoming webhook URL configured in Slack and provided via the ``slack_webhook`` variable.
* Network connectivity from the AAP execution environment to the Slack API endpoint.
* The ``community.general`` collection installed in the execution environment.


Notes
-----

* The playbook runs on ``localhost`` (the AAP controller / execution environment) rather than on the target z/OS system.
* Event variables default to 'N/A' if not provided, ensuring the playbook can execute even with partial event data.
* The ``workflow_url`` guards against empty strings, Python ``None``, and the string ``'None'``, falling back to the
  literal value ``'None'`` when no valid ``awx_workflow_job_id`` is present.
* The two blocks are mutually exclusive: the C2P1607I block runs when ``ansible_eda.events.c2p1607i`` is defined;
  the standard block runs when ``ansible_eda.event`` is defined.
* To add support for a new event shape, add a new block with its own ``when:`` condition and tasks.
* This playbook can be executed as a standalone notification job or as part of a remediation workflow.


See also
--------

* The EDA rulebooks that launch this playbook (e.g., :ref:`1212_access_read_data_set`, :ref:`1213_access_read_data_set`).
* To send the notification, see the `community.general.slack <https://docs.ansible.com/ansible/latest/collections/community/general/slack_module.html>`_ module.
