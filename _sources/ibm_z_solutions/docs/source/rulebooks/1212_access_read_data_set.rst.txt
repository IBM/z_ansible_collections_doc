.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2026                                    .
.. ...........................................................................

.. _1212_access_read_data_set:

1212_access_read_data_set - Monitor zSecure alerts from Kafka for access >= READ on a sensitive dataset
========================================================================================================

.. contents::
   :local:
   :depth: 1


Synopsis
--------

This rulebook monitors RACF when a user gains READ access or higher to a sensitive dataset. The zSecure-generated event is a C2P1212I alert and is delivered through Kafka.

When the alert is received, the rulebook starts the configured AAP workflow template to perform the response workflow. Unlike rulebooks that use multi-event correlation, this rulebook uses a single-event condition. Each zSecure alert in this family is self-contained, so no corroborating event is required and no timeout is needed.

Rulebook
--------

.. code-block:: yaml

   - name: Rule to handle alert 1212 - Access >= READ on sensitive data set
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
       - name: "Handle alert 1212 - Access >= READ on sensitive data set"
         condition: event.body.alert_code == "C2P1212I"
         action:
           run_workflow_template:
             name: "EDA - Alert 1212 Response Workflow"
             organization: "Default"

Parameters
----------

Sources
~~~~~~~

**kafka**

Connects to a Kafka broker to consume zSecure alert messages.

**topic**
   The Kafka topic name that carries zSecure alerts.

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

**check_hostname**
   Enable SSL hostname verification.

   :required: True (default)
   :type: Boolean

Filters
~~~~~~~

**ibm.ibm_eda_zos.security_alerts**

Filter plugin that parses and structures zSecure alert messages from Kafka events. Without this filter, the rulebook condition will not match because the alert code field will not exist in the raw payload.

**event_source**
   Specifies the source type of the event stream.

   :required: True
   :type: str
   :choices: kafka

Rules
~~~~~

**Handle alert 1212 – Access >= READ on sensitive data set**

Alert codes monitored:

* **C2P1212I**: zSecure alert indicating that a user has accessed a sensitive dataset with an access level of READ or higher.

Condition
~~~~~~~~~

This rule uses a single-event condition that matches the alert code:

.. code-block:: python

   event.body.alert_code == "C2P1212I"

The rule fires immediately when any incoming event satisfies the condition. There is no correlation window because each zSecure alert is self-contained, and no second event is required.

Action
~~~~~~

Launches the AAP workflow template ``EDA - Alert 1212 Response Workflow`` in the Default organization. The matched event is passed to the workflow template through ``ansible_eda.event``. The response performed by the workflow template is documented on the corresponding playbook page in this collection.

Event structure
---------------

Event (C2P1212I)
~~~~~~~~~~~~~~~~

.. code-block:: json

   {
     "body": {
       "alert_code": "C2P1212I",
       "alert_message": "C2P1212I READ access by USER001 on site-sensitive READ data set DATA.SET.NAME",
       "hostname": "ZSYS01",
       "action_user": "USER001",
       "timestamp": "2024-01-15T10:30:00Z"
     },
     "meta": {
       "received_at": "2024-01-15T10:30:01Z"
     }
   }

Event body fields
-----------------

* **alert_code**: the zSecure alert code (C2P1212I).
* **alert_message**: descriptive message about the sensitive dataset access event.
* **hostname**: the z/OS system where the event occurred.
* **action_user**: the user ID that accessed the dataset.
* **timestamp**: ISO 8601 timestamp of the alert.

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
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create a rulebook activation in Ansible Automation Platform with the following activation variables:

.. code-block:: yaml

   kafka_topic: "zsecure-security-alerts"
   kafka_host: "kafka-broker.company.com"
   kafka_port: 9093
   security_protocol: "SSL"
   cafile: "/etc/kafka/certs/ca-cert.pem"

Example 2: Testing the Rule
~~~~~~~~~~~~~~~~~~~~~~~~~~~

To test the rulebook, publish a sample event to your Kafka topic.

Publish a C2P1212I event:

.. code-block:: bash

   echo '{
     "body": {
       "alert_code": "C2P1212I",
       "alert_message": "C2P1212I READ access by USER001 on site-sensitive READ data set DATA.SET.NAME",
       "hostname": "ZSYS01",
       "action_user": "USER001",
       "timestamp": "2024-01-15T10:30:00Z"
     },
     "meta": { "received_at": "2024-01-15T10:30:01Z" }
   }' | kafka-console-producer \
        --broker-list kafka-broker:9093 \
        --topic zsecure-alerts

Notes
-----

* The rulebook runs continuously, monitoring the Kafka topic for new events.
* Each event is processed independently. There is no correlation window or timeout.
* Ensure that the zSecure filter plugin is installed in the decision environment so that the condition can be evaluated correctly.
* Before you activate the rulebook, ensure that the referenced AAP workflow template exists.
* Synchronize system clocks between Kafka, AAP, and z/OS for accurate event timestamps.

Troubleshooting
---------------

Rulebook not triggering
~~~~~~~~~~~~~~~~~~~~~~~

* Verify that C2P1212I events are published to Kafka.
* Verify that the event format matches the expected structure.
* Verify that the alert code field is present and exactly matches the expected value.
* Review the activation logs for errors.

Events not matching
~~~~~~~~~~~~~~~~~~~

* Enable verbose logging in the activation settings.
* Verify that the alert code field value is exact and case-sensitive.
* Verify that the filter plugin is parsing the events correctly.

See Also
--------

-  Playbook suggestions, see :ref:`send_alert_message`.
- `Ansible Automation Platform - Getting started as an automation developer <https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.6/get_started-assembly_gs_auto_dev>`_.
