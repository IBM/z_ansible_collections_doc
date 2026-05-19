.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2026                                   .
.. ...........................................................................
.. TODO:
..    1) Request all contributors provide a reference (ref) back to the
..       collections ansible_content page like the ibm_zos_core collection.
..       For now, static links are used (which might actually be safer :) )
.. ...........................................................................

=============================
Introduction and architecture
=============================

Event-Driven ansible
----------------------

Event-Driven Ansible (EDA) is an automation framework that enables organizations to respond to events in real time. It connects event sources to automated responses through rulebooks, allowing for intelligent, automated decision-making based on events that occur in your infrastructure.

Event-Driven ansible for IBM Z
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Event-Driven Ansible for IBM Z extends EDA capabilities to IBM Z® mainframe environments, enabling the following capabilities:

- **Real-time monitoring** of IBM z/OS® systems, subsystems, and applications.
- **Automated incident response** to system events and alerts.
- **Proactive problem resolution** before issues affect business operations.
- **Integration** with existing z/OS monitoring tools and event management systems.
- **Compliance automation** for mainframe security and operational policies.

Key benefits
~~~~~~~~~~~~~

- **Reduced mean time to detect (MTTD) and mean time to resolve (MTTR)**: Faster detection and resolution of issues.
- **24/7 automation**: Continuous monitoring and response without human intervention.
- **Consistency**: Standardized responses to common events.
- **Scalability**: Ability to handle multiple z/OS systems and logical partitions (LPARs) simultaneously.
- **Integration**: Connection between mainframe events and enterprise automation workflows.



Architecture
--------------------------------------------------

Architecture use case: zSecure Privileges
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following architecture shows how Event-Driven Ansible for IBM Z can automate the review and response process for unauthorized privilege changes on a production LPAR. In this scenario, an authority change is detected on z/OS, enriched and streamed through the event pipeline, evaluated by Event-Driven Ansible, and then handled by an automation playbook.

Architecture flow
~~~~~~~~~~~~~~~~~

::

   RACF authority change
          ↓
   zSecure Alert detects the change
          ↓
   WTO and syslog message created on z/OS
          ↓
   Common Data Provider captures and formats the event
          ↓
   Kafka publishes the event to subscribed consumers
          ↓
   Event-Driven Ansible rulebook matches the event
          ↓
   Automation Controller runs the playbook
          ↓
   Playbook validates authorization and responds
          ↓
   Notify security administrator or revoke access

Layered architecture
~~~~~~~~~~~~~~~~~~~~

::

   ┌──────────────────────────────────────────────────────────────┐
   │                         z/OS domain                          │
   │                                                              │
   │  SAF → RACF → zSecure Alert → WTO/syslog                     │
   │              │                                               │
   │              └→ RACF DB / SMF / zSecure Audit                │
   │                                                              │
   │  Common Data Provider                                        │
   │    - zLog Forwarder                                          │
   │    - Configuration Tool                                      │
   │    - Data Streamer                                           │
   │                                                              │
   │  Kafka topics publish normalized security events             │
   └──────────────────────────────────────────────────────────────┘
                               ↓
   ┌──────────────────────────────────────────────────────────────┐
   │              Ansible Automation Platform 2.5                 │
   │                                                              │
   │  Platform Gateway                                            │
   │  Event-Driven Ansible                                        │
   │  Automation Hub                                              │
   │  Automation Controller                                       │
   └──────────────────────────────────────────────────────────────┘
                               ↓
   ┌──────────────────────────────────────────────────────────────┐
   │                    Automated response layer                  │
   │                                                              │
   │  Validate request authorization                              │
   │  Run Ansible playbook                                        │
   │  Revoke unauthorized access if required                      │
   │  Email summary to security administrator                     │
   └──────────────────────────────────────────────────────────────┘

Architecture explanation
~~~~~~~~~~~~~~~~~~~~~~~~~~

1. **Privilege change initiation**: A RACF authority change is issued on a production LPAR, for example by using a command that changes a user's privileges.
2. **Security detection**: IBM zSecure Command Verifier and IBM zSecure Alert monitor the activity and detect the authority change for the affected user ID.
3. **Message creation on z/OS**: zSecure Alert creates a WTO message, which is also made available through the z/OS logging and syslog path.
4. **Event capture and enrichment**: IBM Common Data Provider for z Systems captures the message through the zLog Forwarder exit, tags it, and sends it to the Data Streamer.
5. **Event transformation and streaming**: The Data Streamer formats the message data and applies the configured transform logic before publishing the event through Kafka.
6. **Event matching in Event-Driven Ansible**: An Event-Driven Ansible rulebook subscribes to the Kafka topic, evaluates the event content, and matches the rulebook condition.
7. **Automated execution**: Event-Driven Ansible calls Automation Controller to run the playbook associated with the matched event.
8. **Authorization decision**: The playbook checks whether the privilege change is authorized.
9. **Response and notification**:
   - If the change is authorized, a summary is emailed to the security administrator.
   - If the change is not authorized, the user access is revoked and a summary is emailed to the security administrator.

Why this architecture matters
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This architecture demonstrates how IBM Z security events can be integrated into an enterprise event-driven automation flow. It combines native z/OS security monitoring with Event-Driven Ansible so that privileged access changes can be reviewed quickly and handled consistently.

The design is particularly useful for the following goals:

- **Faster detection of privileged access changes** on production systems.
- **Automated enforcement** when a privilege change is not authorized.
- **Consistent response workflows** for security operations teams.
- **Centralized orchestration** through Ansible Automation Platform.
- **Improved auditability** by linking detection, decision, and response activities.


Components
~~~~~~~~~~~

1. Security event sources on z/OS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The z/OS domain generates and exposes the security event that drives the automation flow. In this use case, the main event-producing components are:

- **SAF and RACF** for system authorization and privilege management.
- **IBM zSecure Command Verifier** for monitoring and validating command activity.
- **IBM zSecure Alert** for detecting authority changes and generating alerts.
- **WTO, syslog, RACF DB, and SMF** for message creation, logging, and audit records.

2. Common Data Provider and event transport
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

IBM Common Data Provider for z Systems captures and forwards z/OS event data for downstream consumption. In this use case, the relevant components are:

- **zLog Forwarder** to capture the WTO/syslog message.
- **Configuration Tool** to define routing and transformation behavior.
- **Data Streamer** to normalize and package messages.
- **Kafka** to deliver the transformed event stream to subscribed consumers.

3. Event-Driven Ansible rulebook engine
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Event-Driven Ansible layer performs the following functions:

- Subscribes to the Kafka topic that carries security events.
- Receives normalized event payloads from the streaming layer.
- Evaluates rulebook conditions against the event content.
- Triggers the appropriate automated response when a rule matches.

4. Automation content
~~~~~~~~~~~~~~~~~~~~~~~

The automation content defines how the privileged-access use case is handled:

- **Rulebooks** define the event source, conditions, and actions.
- **Playbooks** implement the authorization check and response logic.
- **IBM Z collections** provide the modules used to interact with z/OS systems and services.

5. Execution and response
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Automation Controller and the IBM Z automation content execute the required response actions, such as:

- **Validate the privilege change** against an approved authorization source.
- **Run z/OS automation tasks** by using supported IBM Z modules.
- **Revoke unauthorized access** when the detected change is not approved.
- **Send notifications** to the security administrator.