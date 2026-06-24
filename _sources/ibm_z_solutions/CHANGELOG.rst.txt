===============================
ibm.ibm\_eda\_zos Release Notes
===============================

.. contents:: Topics

v1.0.0
======

Release Summary
---------------

Release Date: '2026-06-18'
Initial release of the ibm.ibm_eda_zos collection, providing Event Driven Ansible
solutions for IBM Z security monitoring and automated response capabilities.
This collection integrates with zSecure alerts and provides comprehensive
security event handling for z/OS environments.

Major Changes
-------------

- Added security_alerts event filter plugin for processing zSecure alerts from Kafka
- Initial release of ibm.ibm_eda_zos collection for Event Driven Ansible on IBM Z

Minor Changes
-------------

- Add documentation for collection usage and examples
- Added HTML email templates for formatted security alert notifications with alert-specific layouts
- Added rulebook for detecting invalid password limit exceeded events (alert 1111)
- Added rulebook for detecting logon attempts by unknown users (alert 1101)
- Added rulebook for monitoring superuser logon events (alert 1103)
- Added rulebook for tracking group authorization status changes (alerts 1107/1108)
- Created *gather_listuser_information* playbook for user account details
- Created *gather_password_policy_information* playbook for policy compliance checks
- Created *quarantine_user* playbook for automated account suspension
- Created *remove_uid_access* playbook for emergency access revocation
- Created *send_alert_email* playbook for security notification distribution
- Created *setr_jes_batchallracf* playbook for JES batch security configuration
- Created *unquarantine_user* playbook for account restoration
- Included base template with consistent styling and reusable components for RACF user information

Known Issues
------------

- **Alert Format Compatibility**: The *security_alerts* event filter extracts
  attributes based on user-specific zSecure alert message patterns. Some custom
  or non-standard alert formats may not be fully parsed.

  **Workaround**: For unsupported formats, you can use Ansible-supported operators
  in rule conditions to identify specific alerts, and Jinja2 filters (including 
  Python string methods) in the action section to extract data for playbook variables.

  **Example Event Structure**

  Below is an example of an incoming Kafka event for alert "Update on APF data set (1204)":

  .. code-block:: json

     {
       "headerName": "zOS-SYSLOG-Console:1.0.0",
       "hasHeaderTopic": "true",
       "metadata": "sample_host.ibm.com,SYSLOG,1.0.0,zOS-SYSLOG-Console,ZOS_HOST-SYSLOG,-0400,XESDEV,ZOS_HOST,1774419235120",
       "message": "NC,002B,26083 23.13.55.120 -0700,ZOS_HOST,TSU00121,USRT004 ,00000000000000000000000000000000,00000210,USRT004 ,80,\" C2P1204I Update by user C##ASCH on APF data set C##A.D.C##NEW.APF.LOAD\""
     }

  **Custom Parsing Example**

  The following rulebook demonstrates how to parse custom alert formats using
  Ansible operators in conditions and Jinja2 filters in actions:

  .. code-block:: yaml

     - name: Process APF dataset alert
       hosts: all
       sources:
         - ansible.eda.kafka:
             host: localhost
             port: 9092
             topic: zsecure-alerts
       rules:
         - name: Extract username and dataset from APF alert
           # Condition: Use Ansible operator to match specific alert code C2P1204I
           condition: event.body.message is search("C2P1204I", ignore_case=false)
           
           action:
             run_playbook:
               name: handle_apf_alert.yml
               extra_vars:
                 # Action: Use Jinja2 filters to extract username (C##ASCH) and
                 # dataset name (C##A.D.C##NEW.APF.LOAD) to pass to playbook
                 username: "{{ event.body.message.split('user')[1].strip().split()[0] }}"
                 dataset_name: "{{ event.body.message.split('data set')[1].strip().split()[0] }}"
                 full_event: "{{ event }}"

  This approach allows you to handle any alert format by customizing the parsing
  logic in your rulebooks.
