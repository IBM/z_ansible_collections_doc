.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2026                                   .
.. ...........................................................................
.. TODO:
..    1) Request all contributors provide a reference (ref) back to the
..       collections ansible_content page like the ibm_zos_core collection.
..       For now, static links are used (which might actually be safer :) )
.. ...........................................................................

==================
Introduction and architecture
==================

Event-Driven ansible
--------------------------------------------------

Event-Driven Ansible (EDA) is an automation framework that enables organizations to respond to events in real time. It connects event sources to automated responses through rulebooks, allowing for intelligent, automated decision-making based on events that occur in your infrastructure.

Event-Driven ansible for IBM Z
--------------------------------------------------

Event-Driven Ansible for IBM Z extends EDA capabilities to IBM Z® mainframe environments, enabling the following capabilities:

- **Real-time monitoring** of IBM z/OS® systems, subsystems, and applications.
- **Automated incident response** to system events and alerts.
- **Proactive problem resolution** before issues affect business operations.
- **Integration** with existing z/OS monitoring tools and event management systems.
- **Compliance automation** for mainframe security and operational policies.

Key benefits
--------------------------------------------------

- **Reduced mean time to detect (MTTD) and mean time to resolve (MTTR)**: Faster detection and resolution of issues.
- **24/7 automation**: Continuous monitoring and response without human intervention.
- **Consistency**: Standardized responses to common events.
- **Scalability**: Ability to handle multiple z/OS systems and logical partitions (LPARs) simultaneously.
- **Integration**: Connection between mainframe events and enterprise automation workflows.


==================================================
Architecture
==================================================

Architecture flow
--------------------------------------------------

::

Event Source → Rulebook → Condition → Action → z/OS Execution
::


Layered architecture
--------------------------------------------------

::

   +-----------------------------------+
   | zSecure Alert (Event Source)      |
   +-----------------------------------+
                  |
                  v
   +-----------------------------------+
   | Event-Driven Ansible              |
   | (Rulebook Engine)                 |
   +-----------------------------------+
                  |
                  v
   +-----------------------------------+
   | Validated Content                 |
   | (Playbooks/Use Cases)             |
   +-----------------------------------+
                  |
                  v
   +-----------------------------------+
   | Certified Content                 |
   | (IBM Z Collections)               |
   +-----------------------------------+
                  |
                  v
   +-----------------------------------+
   | z/OS System Execution             |
   +-----------------------------------+


Architecture explanation
--------------------------------------------------

1. **Event source**: Generates events (logs, alerts, messages).
2. **Rulebook engine**: Evaluates conditions and matches rules.
3. **Validated content**: Defines the automation workflow.
4. **Certified content**: Runs tasks on IBM Z systems.
5. **z/OS execution**: Performs the actual system operations.



Components
--------------------------------------------------

1. Event sources
~~~~~~~~~~~~~~~~~~~~~~~~

Event sources capture and forward events from IBM Z systems:

- **IBM zSecure® alerts** (email or log).
- **Apache Kafka topics**.
- **Webhooks**.
- **File watchers**.
- **Syslog streams**.
- **Simple Network Management Protocol (SNMP) traps**.

2. Rulebook engine
~~~~~~~~~~~~~~~~~~~~~~~~~

The core of EDA that performs the following functions:

- Receives incoming events.
- Evaluates conditions.
- Matches events to rules.
- Triggers appropriate actions.

3. Rulebooks
~~~~~~~~~~~~~~~~~~~~~~~~~

YAML-based definitions that specify the following information:

.. code-block:: yaml

   - Event source configuration
   - Conditions to match
   - Actions to run

::

4. Actions
~~~~~~~~~~~~~~~~~~~~~~~

Actions that are triggered when rules match:

- **Trigger Ansible playbooks**.
- **Run jobs or commands**.
- **Send notifications**.
- **Update tickets**.
- **Run operator commands**.

5. Execution environment
~~~~~~~~~~~~~~~~~~~~~~~~~

Container-based environment that performs the following functions:

- Runs automation tasks.
- Uses IBM Z Ansible collections.
- Provides isolated execution context.