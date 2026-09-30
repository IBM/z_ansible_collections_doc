.. ...........................................................................
.. © Copyright IBM Corporation 2026                                          .
.. ...........................................................................

.. _1607_SMF_Flood_Alert:

1607_SMF_Flood_Alert - Monitor zSecure alerts from Kafka for SMF Record Flood alert
====================================================================================

.. contents::
   :local:
   :depth: 1


Synopsis
--------

This rulebook monitors SMF record flood events that are delivered by Kafka. It uses two-event
correlation to match an IFA780A WTO message, which indicates that the SMF internal message filter
triggered for a specific record type, with the corresponding zSecure alert C2P1607I that confirms
the flood condition.

When both events are matched within the correlation window, the rulebook starts the configured
AAP workflow template to perform the response workflow.

The two-event correlation reduces false positives by requiring confirmation from both the z/OS
SMF subsystem (IFA780A) and zSecure (C2P1607I) before any automated action is taken.


Rulebook
--------


.. code-block:: yaml

   - name: Rule to handle alert 1607 - SMF Record Flood
     hosts: all

     sources:
       - name: kafka
         ansible.eda.kafka:
           topic: "{{ kafka_topic }}"
           host: "{{ kafka_host }}"
           port: "{{ kafka_port }}"
           security_protocol: "{{ security_protocol }}"
           ssl_cafile: "{{ cafile }}"
           check_hostname: true

         filters:
           - ibm.ibm_eda_zos.security_alerts:
               event_source: "kafka"

     rules:
       - name: Handle SMF Record Flood - C2P1607I

         condition:
           all:
             - events.ifa780a << event.body.message is regex("IFA780A SMF RECORD FLOOD MSG FILTER FOR TYPE")
             - events.c2p1607i << event.body.alert_code == "C2P1607I"
           timeout: 90 seconds

         action:
           run_workflow_template:
             name: "EDA - SMF 1607 Response Workflow"
             organization: "Default"

Parameters
----------

Sources
~~~~~~~

**kafka**

Connects to a Kafka broker to consume both zSecure alert messages and z/OS WTO messages.

**topic**
   The Kafka topic name that carries zSecure alerts and WTO messages.

   :required: True
   :type: str

**host**
   The Kafka broker hostname or IP address.

   :required: True
   :type: str

**port**
   The Kafka broker port number.

   :required: True
   :type: int

**security_protocol**
   The security protocol for the Kafka connection. Common values are ``SSL`` and ``PLAINTEXT``.

   :required: True
   :type: str

**ssl_cafile**
   Path to the CA certificate file used for SSL/TLS verification.

   :required: True (when using SSL)
   :type: str

**check_hostname**
   Enable SSL hostname verification. Set to ``true`` to verify that the broker hostname matches
   the certificate.

   :required: False
   :default: true
   :type: bool


Filters
~~~~~~~

**ibm.ibm_eda_zos.security_alerts**

Filter plugin that parses and structures both zSecure alert messages and z/OS WTO messages from
Kafka events. Without this filter, the rulebook conditions will not match because the fields they
reference do not exist in the raw Kafka payload.

**event_source**
   Specifies the source type of the event stream.

   :required: True
   :type: str
   :choices: kafka


Rules
~~~~~

**Handle SMF Record Flood - C2P1607I**

Alert codes and messages monitored:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* **C2P1607I**: zSecure alert indicating an SMF record flood condition has been detected.
* **IFA780A**: z/OS WTO message issued by the SMF subsystem when its internal message filter
  activates for a specific record type during a flood.

Event correlation logic
^^^^^^^^^^^^^^^^^^^^^^^^

This rule uses a two-event correlation pattern:

* Event ``ifa780a`` captures the IFA780A WTO message from the z/OS SMF subsystem, matched
  using a regex against the message text.
* Event ``c2p1607i`` captures the zSecure alert C2P1607I confirming the flood condition.
* Both events must arrive within the 90-second correlation window in any order.

Condition
^^^^^^^^^

.. code-block:: yaml

   all:
     - events.ifa780a << event.body.message is regex("IFA780A SMF RECORD FLOOD MSG FILTER FOR TYPE")
     - events.c2p1607i << event.body.alert_code == "C2P1607I"

Timeout
^^^^^^^

The rule has a 90-second correlation window. If the second event does not arrive within 90
seconds of the first, the correlation expires and the rule does not trigger.

Action
^^^^^^

Launches the AAP workflow template **EDA - SMF 1607 Response Workflow** in the Default
organization. Both matched events are available to all workflow jobs through
``ansible_eda.events.ifa780a`` and ``ansible_eda.events.c2p1607i``. The workflow response is
documented on the corresponding playbook pages in this collection.


Event structure
---------------

Event ifa780a (IFA780A WTO Message)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: json

   {
     "body": {
       "alert_message": "IFA780A SMF RECORD FLOOD MSG FILTER FOR TYPE 30 ACTIVE",
       "hostname": "ZSYS01",
       "timestamp": "2024-01-15T10:30:00Z"
     },
     "meta": {
       "received_at": "2024-01-15T10:30:01Z"
     }
   }

Event c2p1607i (zSecure Alert C2P1607I)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: json

   {
     "body": {
       "alert_code": "C2P1607I",
       "alert_message": "C2P1607I SMF record flood detected for type 30 on ZSYS01",
       "hostname": "ZSYS01",
       "timestamp": "2024-01-15T10:30:05Z"
     },
     "meta": {
       "received_at": "2024-01-15T10:30:06Z"
     }
   }

Event ifa780a body fields
~~~~~~~~~~~~~~~~~~~~~~~~~~

* **alert_message**: the full IFA780A WTO message text, including the SMF record type number.
* **hostname**: the z/OS system where the SMF flood was detected.
* **timestamp**: ISO 8601 timestamp of the WTO message.

Event c2p1607i body fields
~~~~~~~~~~~~~~~~~~~~~~~~~~~

* **alert_code**: the zSecure alert code (``C2P1607I``).
* **alert_message**: A descriptive message about the SMF record flood condition.
* **hostname**: The z/OS system on which the flood was detected.
* **timestamp**: The ISO 8601 timestamp of the alert.


Variables
---------

When you activate the rulebook in Ansible Automation Platform, the following variables must be
defined:

.. code-block:: yaml

   kafka_topic: "zsecure-alerts"
   kafka_host: "kafka.example.com"
   kafka_port: 9093
   security_protocol: "SSL"
   cafile: "/path/to/ca-cert.pem"


Examples
--------

Example 1: Basic Activation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create a rulebook activation in Ansible Automation Platform with the following activation
variables:

.. code-block:: yaml

   kafka_topic: "zsecure-security-alerts"
   kafka_host: "kafka-broker.company.com"
   kafka_port: 9093
   security_protocol: "SSL"
   cafile: "/etc/kafka/certs/ca-cert.pem"

Example 2: Testing Event Correlation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To test the rulebook, publish both events to your Kafka topic. Both events must arrive within
90 seconds of each other.

**Step 1: Publish the IFA780A WTO message**

.. code-block:: bash

   echo '{
     "body": {
       "alert_message": "IFA780A SMF RECORD FLOOD MSG FILTER FOR TYPE 30 ACTIVE",
       "hostname": "ZSYS01",
       "timestamp": "2024-01-15T10:30:00Z"
     },
     "meta": { "received_at": "2024-01-15T10:30:01Z" }
   }' | kafka-console-producer \
        --broker-list kafka-broker:9093 \
        --topic zsecure-alerts

**Step 2: Publish the C2P1607I alert within 90 seconds**

.. code-block:: bash

   echo '{
     "body": {
       "alert_code": "C2P1607I",
       "alert_message": "C2P1607I SMF record flood detected for type 30 on ZSYS01",
       "hostname": "ZSYS01",
       "timestamp": "2024-01-15T10:30:05Z"
     },
     "meta": { "received_at": "2024-01-15T10:30:06Z" }
   }' | kafka-console-producer \
        --broker-list kafka-broker:9093 \
        --topic zsecure-alerts

Example 3: Adjusting the Correlation Timeout
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your environment experiences delays between the IFA780A message and the C2P1607I alert,
increase the timeout value:

.. code-block:: yaml

   rules:
     - name: Handle SMF Record Flood - C2P1607I
       condition:
         all:
           - events.ifa780a << event.body.message is regex("IFA780A SMF RECORD FLOOD MSG FILTER FOR TYPE")
           - events.c2p1607i << event.body.alert_code == "C2P1607I"
         timeout: 120 seconds


Notes
-----

* The rulebook runs continuously, monitoring the Kafka topic for new events.
* Event correlation is stateful and maintains event history within the 90-second timeout window.
* Multiple correlation windows can be active simultaneously for concurrent flood events on
  different z/OS systems or for different SMF record types.
* Both matched events are available through ``ansible_eda.events`` to all jobs in the launched
  workflow.
* Ensure that the ``ibm.ibm_eda_zos.security_alerts`` filter plugin is installed in the
  decision environment for the conditions to evaluate correctly.
* Before you activate the rulebook, ensure that the workflow template
  **EDA - SMF 1607 Response Workflow** exists and is accessible in AAP.
* System clocks should be synchronized between Kafka, AAP, and z/OS for reliable event
  sequencing within the correlation window.


Troubleshooting
---------------

Rulebook not triggering
~~~~~~~~~~~~~~~~~~~~~~~~

* Verify whether both the IFA780A WTO message and the C2P1607I alert are published to
  Kafka.
* Verify whether the event format matches the expected structure for both events.
* Verify whether the IFA780A message text contains the phrase
  ``IFA780A SMF RECORD FLOOD MSG FILTER FOR TYPE``.
* Review the activation logs for correlation timeout messages.
* Confirm the ``ibm.ibm_eda_zos.security_alerts`` filter plugin is installed in the decision
  environment.

Event correlation timeout
~~~~~~~~~~~~~~~~~~~~~~~~~~

* Increase the timeout value if the IFA780A message and C2P1607I alert are consistently
  arriving more than 90 seconds apart in your environment.
* Review Kafka consumer lag to determine whether events are delayed in the pipeline.
* Verify that system clocks are synchronized between Kafka and AAP.

Events not matching
~~~~~~~~~~~~~~~~~~~~

* Enable verbose logging in the activation settings.
* Verify whether the ``alert_code`` field in the C2P1607I event is exactly ``C2P1607I``
  and case-sensitive.
* Verify whether the IFA780A message text matches the regex pattern
  ``IFA780A SMF RECORD FLOOD MSG FILTER FOR TYPE``.
* Confirm that the filter plugin is correctly parsing and structuring the raw Kafka events.


See also
--------

- Playbook suggestions, see :ref:`1607_diagnostic`, and :ref:`send_alert_email_1607`.
- `Ansible Automation Platform - Getting started as an automation developer <https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.6/get_started-assembly_gs_auto_dev>`_.
