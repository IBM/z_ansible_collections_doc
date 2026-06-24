.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2026                                   .
.. ...........................................................................
.. TODO:
..    1) Request all contributors provide a reference (ref) back to the
..       collections ansible_content page like the ibm_zos_core collection.
..       For now, static links are used (which might actually be safer :) )
.. ...........................................................................

=============================
Introduction and Architecture
=============================

Overview
--------

Event-Driven Ansible (EDA) is an automation framework that enables organizations to respond to events in real time. 
It connects event sources to automated responses through rulebooks, allowing for intelligent, automated decision-making based on events that occur in your infrastructure.

EDA is a pre-built, tested, and supported automation validated content for IBM Z environments, ensuring reliability and best practices out of the box.

For more information on validated content, see :ref:`certified-validated-ibm-z`.

**Core capabilities**

* Real-time monitoring of IBM z/OS systems, subsystems, and applications.
* Automated incident response to system events and alerts.
* Proactive problem resolution before issues affect business operations.
* Integration with existing z/OS monitoring tools and event management systems.
* Compliance automation for mainframe security and operational policies.

**Key benefits**

* Reduced mean time to detect (MTTD) and mean time to resolve (MTTR): Faster detection and resolution of issues.
* 24/7 automation: Continuous monitoring and response without human intervention.
* Consistency: Standardized responses to common events.
* Scalability: Ability to handle multiple z/OS systems and logical partitions (LPARs) simultaneously.
* Integration: Connection between mainframe events and enterprise automation workflows.


Architecture
------------

The following architecture illustrates how Event-Driven Ansible for IBM Z automates the detection, evaluation, and response to security events in a z/OS environment.

In this scenario, a security event generated on z/OS is captured, enriched, and streamed through an event pipeline. Event-Driven Ansible evaluates the event against defined rules and triggers an automation playbook to perform the appropriate response.

Architecture flow
~~~~~~~~~~~~~~~~~~

::

   Security event generated on z/OS
          ↓
   Security monitoring solution detects the event
          ↓
   WTO or syslog message created
          ↓
   Common Data Provider captures and enriches the event
          ↓
   Kafka publishes the event to subscribed consumers
          ↓
   Event-Driven Ansible rulebook evaluates the event
          ↓
   Automation Controller runs the playbook
          ↓
   Playbook validates the event and performs actions
          ↓
   Notify stakeholders or execute remediation

Architecture explanation
~~~~~~~~~~~~~~~~~~~~~~~~

Security event generation
^^^^^^^^^^^^^^^^^^^^^^^^^^

A security-related event, such as a configuration change, access request, policy violation, or privileged operation, occurs on a z/OS system.

Event detection
^^^^^^^^^^^^^^^

Security monitoring tools identify the event and generate an alert for further processing.

Message creation
^^^^^^^^^^^^^^^

The detected event is recorded as a WTO or syslog message, making it available through the z/OS logging infrastructure.

Event capture and enrichment
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

IBM Common Data Provider for z Systems captures the message, enriches it with additional context, and forwards it to the Data Streamer.

Event transformation and streaming
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Data Streamer formats and transforms the event before publishing it to a Kafka topic for downstream consumers.

Event evaluation
^^^^^^^^^^^^^^^

An Event-Driven Ansible rulebook subscribes to the Kafka topic and evaluates the incoming event against predefined conditions.

Automated execution
^^^^^^^^^^^^^^^^^^^

When a rule matches, Event-Driven Ansible invokes Automation Controller to execute the associated playbook.

Response and notification
^^^^^^^^^^^^^^^^^^^^^^^^^

The playbook validates the event and performs the configured actions, such as:

- Sending notifications to security or operations teams.
- Collecting additional diagnostic information.
- Executing remediation tasks.
- Creating audit records or tickets.
- Initiating follow-up automation workflows.

Why this architecture matters
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This architecture demonstrates how IBM Z security events can be integrated into an enterprise event-driven automation workflow. By combining native z/OS monitoring capabilities with Event-Driven Ansible, organizations can automate the processing and response to security events while maintaining consistent operational practices.

This design provides the following benefits:

- Faster detection and processing of security events.
- Automated and consistent response workflows.
- Centralized orchestration through Ansible Automation Platform.
- Improved operational efficiency by reducing manual intervention.
- Enhanced auditability and traceability across the event lifecycle.

Components
~~~~~~~~~~

Security event sources on z/OS
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The z/OS environment generates security and operational events that drive the automation workflow. Typical event sources include:

- SAF and RACF for authorization and access management.
- IBM zSecure solutions for security monitoring and alert generation.
- WTO, syslog, RACF database, and SMF for logging and audit records.

Common Data Provider and event transport
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

IBM Common Data Provider for z Systems captures and forwards z/OS event data by using:

- zLog Forwarder to capture system messages.
- Configuration Tool to define routing and transformation rules.
- Data Streamer to normalize and package events.
- Kafka to distribute event streams to subscribed consumers.

Event-Driven Ansible rulebook engine
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Event-Driven Ansible layer performs the following actions:

- Subscribes to security event streams.
- Evaluates incoming events against rulebook conditions.
- Correlates event data when required.
- Triggers automated actions based on matching rules.

Automation content
^^^^^^^^^^^^^^^^^^

Automation content defines how events are processed:

- Rulebooks specify event sources, conditions, and actions.
- Playbooks implement validation, orchestration, and remediation logic.
- IBM Z collections provide modules for interacting with z/OS systems and services.

Execution and response
^^^^^^^^^^^^^^^^^^^^^^

Automation Controller executes the required automation tasks, which can include:

- Validating security events against organizational policies.
- Running z/OS automation tasks.
- Executing remediation or recovery actions.
- Sending notifications to administrators or operations teams.
- Recording results for auditing and compliance purposes.