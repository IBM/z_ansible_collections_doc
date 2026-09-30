.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2026                                   .
.. ...........................................................................
.. TODO:
..    1) Request all contributors provide a reference (ref) back to the
..       collections ansible_content page like the ibm_zos_core collection.
..       For now, static links are used (which might actually be safer :) )
.. ...........................................................................
============
Event filter
============

Synopsis
--------

* The IBM Event-Driven Ansible collection provides a custom event filter, named ``ibm.ibm_eda_zos.security_alerts``, to preprocess event data before it is evaluated by the rule engine. This ensures that the data is in the ideal format for rule evaluation by exposing important attributes such as user names, group names, data set names, and security metadata at the top level.

* The event filter currently supports predefined zSecure alerts.

Parameters
----------

**event_source**
   Name of the event source. The filter currently supports ``kafka``. If the event source is not ``kafka``, the filter returns the event unchanged.

   :required: True
   :type: str
   :default: None

Examples
~~~~~~~~

.. code-block:: yaml

   - name: Monitor zSecure Alerts from Kafka for Group Authority Change
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


Attributes
----------

The filter extracts and adds the following attributes to the event body.

Top-level attributes
~~~~~~~~~~~~~~~~~~~~

.. list-table::
   :header-rows: 1
   :widths: 18 20 32 30

   * - Key
     - Type
     - Value Description
     - Sample Alerts Supported
   * - hostname
     - string
     - Host name of where the event came from
     - all alerts
   * - alert_code
     - string
     - zSecure alert code
     - all alerts
   * - alert_message
     - string
     - Full zSecure alert message including the alert code and text
     - all alerts
   * - action_user
     - string | null if not available
     - User that is performing an action
     - 1105, 1106, 1119, 1121, 1201, 1202, 1203, 1204, 1209, 1210, 1211, 1212, 1213, 1214, 1215, 1216, 1302, 1303, 1304, 1305, 1306, 1307, 1401, 1402, 1403, 1404, 1405, 1406, 1409, 1410, 1411, 1501, 1502, 1503, 1506, 1507, 1701
   * - group_name
     - string | null if not available
     - RACF group name
     - 1107, 1108, 1114, 1701
   * - ip_address
     - string | null if not available
     - IP address
     - 1124, 1125
   * - job_name
     - string | null if not available
     - Job name that is referred to
     - 1101, 1301, 1302, 1804, 1805, 1806
   * - target_user
     - string | null if not available
     - User that an action is performed upon
     - 1102, 1103, 1104, 1105, 1106, 1107, 1108, 1109, 1110, 1111, 1112, 1113, 1114, 1115, 1119, 1120, 1121, 1122, 1123, 1124, 1407, 1410, 1411, 1701
   * - unix_path
     - string | null if not available
     - UNIX file or directory path
     - 1401, 1402, 1403, 1404, 1409
   * - access_level
     - string | null if not available
     - Access level (e.g. READ, UPDATE, ALTER)
     - 1110, 1201, 1202, 1203, 1209, 1210, 1211, 1212, 1213, 1214, 1303, 1304, 1402, 1403
   * - authority_type
     - string | null if not available
     - Authority type (e.g. SPECIAL, OPERATIONS)
     - 1105, 1106, 1109, 1114
   * - user_category
     - string | null if not available
     - User category (e.g. non-SPECIAL, non-OPERATIONS)
     - 1109, 1110

``dataset`` sub-dictionary
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. list-table::
   :header-rows: 1
   :widths: 22 20 30 28

   * - Key
     - Type
     - Value Description
     - Sample Alerts Supported
   * - dataset.dataset_name
     - string | null if not available
     - Data set name
     - 1201, 1202, 1203, 1204, 1205, 1206, 1207, 1208, 1209, 1210, 1211, 1212, 1213, 1214, 1215, 1216, 1217, 1218, 1302
   * - dataset.pds_member
     - string | null if not available
     - PDS member name
     - 1214
   * - dataset.volume_serial
     - string | null if not available
     - Volume serial or SMS-managed indicator
     - 1205, 1206, 1217, 1218
   * - dataset.program_name
     - string | null if not available
     - Program name or UNIX path of the program
     - 1302, 1405, 1406, 1408

``resource`` sub-dictionary
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. list-table::
   :header-rows: 1
   :widths: 22 20 30 28

   * - Key
     - Type
     - Value Description
     - Sample Alerts Supported
   * - resource.resource_class
     - string | null if not available
     - RACF resource class name (e.g. FACILITY, PROGRAM)
     - 1110, 1301, 1303, 1304, 1305, 1307, 1504, 1505, 1506, 1507
   * - resource.resource_name
     - string | null if not available
     - RACF resource name within the class
     - 1110, 1303, 1304, 1305, 1307, 1411

``smf`` sub-dictionary
~~~~~~~~~~~~~~~~~~~~~~

.. list-table::
   :header-rows: 1
   :widths: 22 20 30 28

   * - Key
     - Type
     - Value Description
     - Sample Alerts Supported
   * - smf.smf_record_type
     - string | null if not available
     - SMF record type number
     - 1607, 1608, 1611, 1616
   * - smf.smf_subsystem
     - string | null if not available
     - SMF subsystem identifier
     - 1616
   * - smf.smf_records_lost
     - string | null if not available
     - Number of SMF records lost
     - 1602
   * - smf.wto_msgid
     - string | null if not available
     - WTO message ID
     - 1601, 1607, 1608

.. note::

   A ``null`` value for ``access_level`` means no access level was found in the alert message.
   A string value of ``"NONE"`` means the attribute was found and the RACF access authority is
   ``NONE`` — the lowest level in the RACF hierarchy, denoting no access granted. These two values
   are not equivalent and should be treated as distinct when writing rule conditions.

Input and output examples
-------------------------

The event filter expects events following a similar structure below:

* The ``message`` attribute contains the raw alert message with the actual alert text enclosed in double quotes. After the raw alert message is extracted, the filter gathers additional fields from it.
* The ``metadata`` attribute is a comma-separated string with the host name as the first value.
* The filter returns an event dictionary with additional extracted fields added to the original event. If processing fails, the original event is returned unchanged.
* If an attribute does not exist in the alert message, the filter returns a null value.

Example for alert code C2P1101I:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before event filter:
~~~~~~~~~~~~~~~~~~~~

.. code-block:: json

   {
     "headerName": "zOS-SYSLOG-Console:1.0.0",
     "hasHeaderTopic": "true",
     "metadata": "sample_host.ibm.com,SYSLOG,1.0.0,zOS-SYSLOG-Console,ZOS_HOST-SYSLOG,-0400,XESDEV,ZOS_HOST,1774419235120",
     "message": "NC,002B,26083 23.13.55.120 -0700,ZOS_HOST,TSU00121,USRT004 ,00000000000000000000000000000000,00000210,USRT004 ,80,\" C2P1101I LOGON BY UNKNOWN USER * JOB TESTJOB\""
   }


After event filter:
~~~~~~~~~~~~~~~~~~

.. code-block:: yaml

   body:
     access_level: null
     action_user: null
     alert_code: C2P1101I
     alert_message: C2P1101I LOGON BY UNKNOWN USER * JOB TESTJOB
     authority_type: null
     dataset:
       dataset_name: null
       pds_member: null
       program_name: null
       volume_serial: null
     group_name: null
     hasHeaderTopic: 'true'
     headerName: zOS-SYSLOG-Console:1.0.0
     hostname: sample_host.ibm.com
     ip_address: null
     job_name: TESTJOB
     message: >-
       NC,002B,26083 23.13.55.120 -0700,ZOS_HOST,TSU00121,USRT004
       ,00000000000000000000000000000000,00000210,USRT004 ,80," C2P1101I LOGON BY
       UNKNOWN USER * JOB TESTJOB"
     metadata: >-
       sample_host.ibm.com,SYSLOG,1.0.0,zOS-SYSLOG-Console,ZOS_HOST-SYSLOG,-0400,XESDEV,ZOS_HOST,1774419235120
     resource:
       resource_class: null
       resource_name: null
     smf:
       smf_record_type: null
       smf_records_lost: null
       smf_subsystem: null
       wto_msgid: null
     target_user: null
     unix_path: null
     user_category: null

Example for alert code C2P1105I:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before event filter:
~~~~~~~~~~~~~~~~~~~~

.. code-block:: json
  
  {
  "headerName":"zOS-SYSLOG-Console:1.0.0",
  "hasHeaderTopic":"true",
  "metadata":"sample_host.ibm.com,SYSLOG,1.0.0,zOS-SYSLOG-Console,ZOS_HOST-SYSLOG,-0400,XESDEV,ZOS_HOST,1774419235120",
  "message": "NC,002B,26083 23.13.55.120 -0700,ZOS_HOST,TSU00121,USRT004,00000000000000000000000000000000,00000210,USRT004 ,80,\" C2P1105I System authority SPECIAL granted to C##BMR2 by C##BMR1\""
  }

After event filter:
~~~~~~~~~~~~~~~~~~

.. code-block:: yaml

   body:
     access_level: null
     action_user: C##BMR1
     alert_code: C2P1105I
     alert_message: C2P1105I System authority SPECIAL granted to C##BMR2 by C##BMR1
     authority_type: SPECIAL
     dataset:
       dataset_name: null
       pds_member: null
       program_name: null
       volume_serial: null
     group_name: null
     hasHeaderTopic: 'true'
     headerName: zOS-SYSLOG-Console:1.0.0
     hostname: sample_host.ibm.com
     ip_address: null
     job_name: null
     message: >-
       NC,002B,26083 23.13.55.120 -0700,ZOS_HOST,TSU00121,USRT004
       ,00000000000000000000000000000000,00000210,USRT004 ,80," C2P1105I System
       authority SPECIAL granted to C##BMR2 by C##BMR1"
     metadata: >-
       sample_host.ibm.com,SYSLOG,1.0.0,zOS-SYSLOG-Console,ZOS_HOST-SYSLOG,-0400,XESDEV,ZOS_HOST,1774419235120
     resource:
       resource_class: null
       resource_name: null
     smf:
       smf_record_type: null
       smf_records_lost: null
       smf_subsystem: null
       wto_msgid: null
     target_user: C##BMR2
     unix_path: null
     user_category: null

Example for alert code C2P1214I:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before event filter:
~~~~~~~~~~~~~~~~~~~~

.. code-block:: json

   {
     "hasHeaderTopic": "true",
     "headerName": "zOS-SYSLOG-Console:1.0.0",
     "metadata": "sample_host.ibm.com,SYSLOG,1.0.0,zOS-SYSLOG-Console,ZOS_HOST-SYSLOG,-0400,XESDEV,ZOS_HOST,1774419235120",
     "message": "N ,0057,25267 00.00.00.000 -0700,ZOS_HOST,STCXXXXX,        ,00800000000000000000000000000000,00000010,C2POLICE,00,\" C2P1214I REPLACE action by C##ASCH on UPDATE sensitive member IEASYS81 in data set USER.PARMLIB \""
   }


After event filter:
~~~~~~~~~~~~~~~~~~~

.. code-block:: yaml

   body:
     access_level: UPDATE
     action_user: C##ASCH
     alert_code: C2P1214I
     alert_message: C2P1214I REPLACE action by C##ASCH on UPDATE sensitive member IEASYS81 in data set USER.PARMLIB
     authority_type: null
     dataset:
       dataset_name: USER.PARMLIB
       pds_member: IEASYS81
       program_name: null
       volume_serial: null
     group_name: null
     hasHeaderTopic: 'true'
     headerName: zOS-SYSLOG-Console:1.0.0
     hostname: sample_host.ibm.com
     ip_address: null
     job_name: null
     message: >-
       N ,0057,25267 00.00.00.000 -0700,ZOS_HOST,STCXXXXX,        ,00800000000000000000000000000000,00000010,C2POLICE,00,"
       C2P1214I REPLACE action by C##ASCH on UPDATE sensitive member IEASYS81
       in data set USER.PARMLIB "
     metadata: >-
       sample_host.ibm.com,SYSLOG,1.0.0,zOS-SYSLOG-Console,ZOS_HOST-SYSLOG,-0400,XESDEV,ZOS_HOST,1774419235120
     resource:
       resource_class: null
       resource_name: null
     smf:
       smf_record_type: null
       smf_records_lost: null
       smf_subsystem: null
       wto_msgid: null
     target_user: null
     unix_path: null
     user_category: null

.. note::

   Currently, only **kafka** is supported as the event source. Events from other sources pass through unchanged.

.. note::

   The attributes listed above were chosen based on predefined zSecure alerts. The **Sample Alerts Supported** column identifies which alerts each attribute applies to. If the event filter is applied to an unsupported alert, the event might pass through unchanged, or the extracted attributes might be inaccurate because those message structures are not guaranteed to match the patterns that the filter expects.