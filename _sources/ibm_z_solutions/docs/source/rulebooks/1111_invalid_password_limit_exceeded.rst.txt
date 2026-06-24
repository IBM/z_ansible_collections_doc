.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2026                                    .
.. ...........................................................................

.. _1111_invalid_password_limit_exceeded: 

1111_invalid_password_limit_exceeded - Monitor zSecure alerts from Kafka for password threshold exceeded alert
====================================

.. contents::
   :local:
   :depth: 1


Synopsis
--------

This rulebook monitors RACF password threshold breach events from zSecure alerts delivered through Kafka. It uses event correlation to match the zSecure alert (C2P1111I) with the subsequent RACF system message (ICH408I), confirming that a real password related security incident has occurred.

When both events are matched within the correlation window, the rulebook triggers the configured AAP job template to perform the response workflow.

The correlation between two events reduces false positives by requiring confirmation from both zSecure and RACF before any automated action is taken.

Rulebook
-------

.. code-block:: yaml

   ---
   - name: Monitor zSecure Alerts from Kafka for Password Threshold Exceeded Alert (C2P1111I)
     hosts: all
     sources:
       - name: kafka
         ansible.eda.kafka:
           topic: "{{ kafka_topic }}"
           host: "{{ kafka_host }}"
           port: "{{ kafka_port }}"
           security_protocol: "{{ security_protocol }}"
           ssl_cafile: "{{ cafile }}"

         filters:
           - ibm.ibm_eda_zos.security_alerts:
               event_source: "kafka"

     rules:
       - name: Handle Invalid Password Threshold Exceeded Alert (C2P1111I)
         condition:
           all:
             # Event A: zSecure Alert 1111
             - events.a << (
                 event.body.alert_code == "C2P1111I"
               )
             # Event B: RACF ICH408I AFTER alert 1111
             - events.b << (
                 event.body.message is search("ICH408I")
                 and event.body.message is search("LOGON/JOB INITIATION")
                 and events.a.meta.received_at < event.meta.received_at
               )
           timeout: 90
         action:
           run_job_template:
             name: zSecure - Respond to Password Limit Exceeded
             organization: "Default"

Parameters
----------

Sources
~~~~~~
**kafka**

Connects to a Kafka broker to consume zSecure alert messages and RACF system messages.

**topic**
   The Kafka topic name that carries zSecure alerts and RACF messages.
   
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
   The security protocol for the Kafka connection. Common values are SSL and PLAINTEXT.
   
   :required: True
   :type: str

**ssl_cafile**
   Path to the CA certificate file used for SSL/TLS verification.
   
   :required: True (when using SSL)
   :type: str

Filters
-------

**ibm.ibm_eda_zos.security_alerts**

Filter plugin that parses and structures zSecure alert messages and RACF system messages from Kafka events. Without this filter the rulebook conditions will not match because the fields they reference do not exist in the raw Kafka payload.

**event_source**
   Specifies the source type of the event stream.
   
   :required: True
   :type: str
   :choices: kafka

Rules
-----

**Handle Invalid Password Threshold Exceeded Alert**

Alert codes monitored:
~~~~~~~~~~~~~~~~~~~~~~~

* **C2P1111I**: zSecure alert that indicats password threshold exceeded.
* **ICH408I**: RACF message confirming logon or job initiation failure.

Event correlation logic
^^^^^^^^^^^^^^^^^^^^^^^

This rule uses a two event correlation pattern:

* Event A captures the zSecure alert C2P1111I from Kafka.
* Event B captures the corresponding RACF ICH408I message.
* Temporal validation ensures Event B arrives after Event A.
* A 90 second correlation window applies between the two events.

Condition
^^^^^^^^^

.. code-block:: yaml

   all:
     # Event A: zSecure Alert 1111
     - events.a << (
         event.body.alert_code == "C2P1111I"
       )
     # Event B: RACF ICH408I AFTER alert 1111
     - events.b << (
         event.body.message is search("ICH408I")
         and event.body.message is search("LOGON/JOB INITIATION")
         and events.a.meta.received_at < event.meta.received_at
       )

Timeout
^^^^^^^

The rule has a 90 second correlation window. If Event B is not received within 90 seconds of Event A, the correlation expires and the rule does not trigger.

Action
^^^^^^

Launches the AAP job template zSecure - Respond to Password Limit Exceeded in the Default organization. Both matched events are passed to the job template through ansible_eda.events.a and ansible_eda.events.b. The response workflow performed by the job template is documented on the corresponding playbook page in this collection.

Event structure
---------------

Event A (zSecure Alert C2P1111I)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: json

   {
     "body": {
       "alert_code": "C2P1111I",
       "alert_message": "PASSWORD THRESHOLD EXCEEDED FOR USER123",
       "hostname": "ZSYS01",
       "target_user": "USER123",
       "timestamp": "2024-01-15T10:30:00Z"
     },
     "meta": {
       "received_at": "2024-01-15T10:30:01Z"
     }
   }

Event B (RACF ICH408I Message)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~``

.. code-block:: json

   {
     "body": {
       "message": "ICH408I USER(USER123) LOGON/JOB INITIATION - INVALID PASSWORD",
       "hostname": "ZSYS01",
       "timestamp": "2024-01-15T10:30:15Z"
     },
     "meta": {
       "received_at": "2024-01-15T10:30:16Z"
     }
   }

Event A body fields
~~~~~~~~~~~~~~~~~~

* **alert_code**: the zSecure alert code (C2P1111I).
* **alert_message**: descriptive message about the password threshold breach.
* **hostname**: the z/OS system where the event occurred.
* **target_user**: the RACF user ID that exceeded the password threshold.
* **timestamp**: ISO 8601 timestamp of the alert.

Event B body fields
~~~~~~~~~~~~~~~~~~~

* **message**: the RACF ICH408I system message containing the user ID and failure reason.
* **hostname**: the z/OS system where the logon failure occurred.
* **timestamp**: ISO 8601 timestamp of the RACF message.

Variables
---------

When you activate the rulebook in Ansible Automation Platform, the following variables are defined:

.. code-block:: yaml

   kafka_topic: "zsecure-alerts"
   kafka_host: "kafka.example.com"
   kafka_port: 9093
   security_protocol: "SSL"
   cafile: "/path/to/ca-cert.pem"

Examples
--------

Example 1: Basic Activation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create a rulebook activation in Ansible Automation Platform with the following activation variables:

.. code-block:: yaml

   kafka_topic: "zsecure-security-alerts"
   kafka_host: "kafka-broker.company.com"
   kafka_port: 9093
   security_protocol: "SSL"
   cafile: "/etc/kafka/certs/ca-cert.pem"

Example 2: Testing Event Correlation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To test the rulebook, publish both events to your Kafka topic with appropriate timing.

**Step 1: Publish Event A (zSecure Alert)**

.. code-block:: bash

   echo '{
     "body": {
       "alert_code": "C2P1111I",
       "alert_message": "PASSWORD THRESHOLD EXCEEDED FOR TESTUSER",
       "hostname": "ZSYS01",
       "target_user": "TESTUSER",
       "timestamp": "2024-01-15T10:30:00Z"
     },
     "meta": { "received_at": "2024-01-15T10:30:01Z" }
   }' | kafka-console-producer \
        --broker-list kafka-broker:9093 \
        --topic zsecure-alerts

**Step 2: Publish Event B within 90 seconds**

.. code-block:: bash

   echo '{
     "body": {
       "message": "ICH408I USER(TESTUSER) LOGON/JOB INITIATION - INVALID PASSWORD",
       "hostname": "ZSYS01",
       "timestamp": "2024-01-15T10:30:15Z"
     },
     "meta": { "received_at": "2024-01-15T10:30:16Z" }
   }' | kafka-console-producer \
        --broker-list kafka-broker:9093 \
        --topic zsecure-alerts

Example 3: Adjusting the Correlation Timeout
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your environment needs a longer correlation window, change the timeout value:

.. code-block:: yaml

   rules:
     - name: Handle Invalid Password Threshold Exceeded Alert (C2P1111I)
       condition:
         all:
           - events.a << (event.body.alert_code == "C2P1111I")
           - events.b << (
               event.body.message is search("ICH408I")
               and event.body.message is search("LOGON/JOB INITIATION")
               and events.a.meta.received_at < event.meta.received_at
             )
         timeout: 120

Notes
----

* The rulebook runs continuously, monitoring the Kafka topic for new events.
* Event correlation is stateful and maintains event history within the timeout window.
* Multiple correlation windows can be active simultaneously for different users.
* Ensure that the zsecure filter plugin is installed in the decision environment for the conditions to evaluate correctly.
* Before you activate the rulebook, ensure that the referenced AAP work template exists.
* System clocks should be synchronised between Kafka, AAP and z/OS for accurate timestamp comparison.

Troubleshooting
--------------

Rulebook not triggering
~~~~~~~~~~~~~~~~~~~~~~~

* Verify whether both Event A and Event B are published to Kafka.
* Verify whether the event format matches the expected structure for both events.
* Verify whether the ICH408I message contains the text LOGON/JOB INITIATION.
* Review activation logs for correlation timeout messages.
* Validate timestamp fields are present in event metadata.

Event correlation timeout
~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Verify whether the system clock synchronisation between Kafka and AAP.
* Increase the timeout value if messages are delayed in your pipeline.
* Verify whether the Event B is published after Event A.
* Review Kafka consumer lag metrics.

Events not matching
~~~~~~~~~~~~~~~~~~~

* Enable verbose logging in activation settings.
* Verify whether the alert_code field in Event A.
* Confirm the ICH408I message format in Event B.
* Verify whether the filter plugin is correctly parsing events.

See also
--------

- Playbook suggestion, see :ref:`gather_password_policy_information`.
- `Ansible Automation Platform - Getting started as an automation developer <https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.6/get_started-assembly_gs_auto_dev>`_.