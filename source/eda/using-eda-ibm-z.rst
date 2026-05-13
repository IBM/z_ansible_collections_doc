.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2026                                   .
.. ...........................................................................
.. TODO:
..    1) Request all contributors provide a reference (ref) back to the
..       collections ansible_content page like the ibm_zos_core collection.
..       For now, static links are used (which might actually be safer :) )
.. ...........................................................................


Using Event-Driven Ansible for IBM Z
====================================

Detailed use cases
==================================================

The following use cases demonstrate production-ready implementations for responding to IBM zSecure alerts with comprehensive error handling, ServiceNow® integration, and detailed notifications.

---

Use case 1: Unknown user logon detection (Alert 1101)
--------------------------------------------------

**Scenario**: Detect and quarantine unknown users attempting to log on to the system.

**Alert example:**

::

   Subject: Alert 1101: Logon by unknown user * job TSOB
   Alert 1101: Logon by unknown user * job TSOB

::


**Rulebook** (``rulebooks/zsecure_unknown_user.yml``):

.. code-block:: yaml

   ---
   - name: zSecure Unknown User Detection
     hosts: zos_systems
     sources:
       - name: zsecure_alerts
         type: email
         args:
           host: imap.example.com
           port: 993
           username: "{{ vault_email_user }}"
           password: "{{ vault_email_password }}"
           folder: INBOX
           filter: "SUBJECT 'Alert 1101'"

     rules:
       - name: Quarantine Unknown User
         condition: event.alert_id == "1101"
         action:
           run_playbook:
             name: playbooks/quarantine_unknown_user.yml
             extra_vars:
               user_id: "{{ event.user_id }}"
               job_name: "{{ event.job_name }}"
               system_id: "{{ event.system_id }}"

::


**Playbook** (``playbooks/quarantine_unknown_user.yml``):

.. code-block:: yaml

   ---
   - name: Quarantine Unknown User
     hosts: "{{ ansible_eda.event.system_id }}"
     gather_facts: false
     
     vars:
       user_id: "{{ ansible_eda.event.user_id }}"
       admin_user: "{{ vault_racf_admin }}"
       admin_email: "{{ vault_admin_email }}"
     
     tasks:
       - name: Contain the unknown user (quarantine)
         ibm.ibm_zos_core.zos_tso_command:
           commands:
             - "ALU {{ user_id }} REVOKED"
         register: quarantine_result
       
       - name: Send notification to admin
         ansible.builtin.mail:
           host: smtp.example.com
           port: 587
           to: "{{ admin_email }}"
           subject: "ACTION REQUIRED: Unknown User {{ user_id }} Quarantined"
           body: |
             Unknown User Detected and Quarantined
             
             WHO performed the action: Event-Driven Ansible (EDA)
             WHO/WHAT triggered the alert: Unknown user {{ user_id }} attempted logon
             WHO is doing the automation: {{ admin_user }}
             WHAT was the action: User {{ user_id }} has been REVOKED (quarantined)
             WHEN was the action performed: {{ ansible_date_time.iso8601 }}
             WHAT platform: Ansible Automation Platform / Event-Driven Ansible
             HOW: Automated RACF command via zSecure Alert 1101
             
             System: {{ ansible_eda.event.system_id }}
             Job Name: {{ ansible_eda.event.job_name }}
             
             ACTION REQUIRED: Should this user be added to RACF?
             - YES: Add user to RACF with appropriate permissions
             - NO: User will remain quarantined
         delegate_to: localhost
       
       - name: Log quarantine action
         ansible.builtin.lineinfile:
           path: /var/log/zsecure_actions.log
           line: "{{ ansible_date_time.iso8601 }} | Alert 1101 | User {{ user_id }} quarantined | System {{ ansible_eda.event.system_id }}"
           create: yes
         delegate_to: localhost

::


---

Use case 2: Superuser (uid 0) logon detection (Alert 1103)
--------------------------------------------------

**Scenario**: Automatically remove uid(0) from users who log on with UNIX® superuser privileges.

**Alert example:**

::

   Subject: Alert 1103: Superuser C##BMR1 logon to TSO
   Alert 1103: Superuser C##BMR1 logon to TSO

::


**Rulebook** (``rulebooks/zsecure_superuser.yml``):

.. code-block:: yaml

   ---
   - name: zSecure Superuser Detection
     hosts: zos_systems
     sources:
       - name: zsecure_alerts
         type: email
         args:
           host: imap.example.com
           port: 993
           username: "{{ vault_email_user }}"
           password: "{{ vault_email_password }}"
           folder: INBOX
           filter: "SUBJECT 'Alert 1103'"

     rules:
       - name: Remove Superuser Privilege
         condition: event.alert_id == "1103"
         action:
           run_playbook:
             name: playbooks/remove_superuser.yml
             extra_vars:
               user_id: "{{ event.user_id }}"
               system_id: "{{ event.system_id }}"

::


**Playbook** (``playbooks/remove_superuser.yml``):

.. code-block:: yaml

   ---
   - name: Remove uid(0) from User
     hosts: "{{ ansible_eda.event.system_id }}"
     gather_facts: false
     
     vars:
       user_id: "{{ ansible_eda.event.user_id }}"
    admin_email: "{{ vault_admin_email }}"
  
  tasks:
    - name: Remove uid(0) from OMVS segment
      ibm.ibm_zos_core.zos_tso_command:
        commands:
          - "ALU {{ user_id }} OMVS(UID(1000))"
      register: remove_result
    
    - name: Send notification
      ansible.builtin.mail:
        host: smtp.example.com
        port: 587
        to: "{{ admin_email }}"
        subject: "SECURITY ACTION: uid(0) Removed from {{ user_id }}"
        body: |
          Superuser Privilege Automatically Removed
          
          WHO performed the action: Event-Driven Ansible (EDA)
          WHO/WHAT triggered the alert: User {{ user_id }} logged on with uid(0)
          WHO is doing the automation: RACF Admin (omvsadm)
          WHAT was the action: Removed uid(0) from OMVS segment, assigned uid(1000)
          WHEN was the action performed: {{ ansible_date_time.iso8601 }}
          WHAT platform: Ansible Automation Platform / Event-Driven Ansible
          HOW: Automated RACF ALU command via zSecure Alert 1103
          
          System: {{ ansible_eda.event.system_id }}
          
          NOTE: This action may be disruptive if processes were running under uid(0).
          Please verify system stability and user access.
      delegate_to: localhost
    
    - name: Log action
      ansible.builtin.lineinfile:
        path: /var/log/zsecure_actions.log
        line: "{{ ansible_date_time.iso8601 }} | Alert 1103 | uid(0) removed from {{ user_id }} | System {{ ansible_eda.event.system_id }}"
        create: yes
      delegate_to: localhost
::


---

Use case 3: System authority changes (Alerts 1105-1108)
--------------------------------------------------

**Scenario**: Monitor and document all system authority changes (SPECIAL, OPERATIONS, AUDITOR) with LISTUSER output.

**Alert Examples:**
- **1105**: System authority granted
- **1106**: System authority removed
- **1107**: Group authority granted
- **1108**: Group authority removed

**Rulebook** (``rulebooks/zsecure_authority_changes.yml``):
.. code-block:: yaml

---
- name: zSecure Authority Change Monitoring
  hosts: zos_systems
  sources:
    - name: zsecure_alerts
      type: email
      args:
        host: imap.example.com
        port: 993
        username: "{{ vault_email_user }}"
        password: "{{ vault_email_password }}"
        folder: INBOX
        filter: "SUBJECT 'Alert 110'"

  rules:
    - name: Document Authority Changes
      condition: >
        event.alert_id == "1105" or
        event.alert_id == "1106" or
        event.alert_id == "1107" or
        event.alert_id == "1108"
      action:
        run_playbook:
          name: playbooks/document_authority_change.yml
          extra_vars:
            alert_id: "{{ event.alert_id }}"
            user_id: "{{ event.user_id }}"
            authority: "{{ event.authority }}"
            granted_by: "{{ event.granted_by }}"
            system_id: "{{ event.system_id }}"
::


**Playbook** (``playbooks/document_authority_change.yml``):
.. code-block:: yaml

---
- name: Document Authority Change with LISTUSER
  hosts: "{{ ansible_eda.event.system_id }}"
  gather_facts: false
  
  vars:
    user_id: "{{ ansible_eda.event.user_id }}"
    alert_id: "{{ ansible_eda.event.alert_id }}"
    authority: "{{ ansible_eda.event.authority }}"
    admin_email: "{{ vault_admin_email }}"
    alert_descriptions:
      "1105": "System authority granted"
      "1106": "System authority removed"
      "1107": "Group authority granted"
      "1108": "Group authority removed"
  
  tasks:
    - name: Run LISTUSER command
      ibm.ibm_zos_core.zos_tso_command:
        commands:
          - "LISTUSER {{ user_id }}"
      register: listuser_output
    
    - name: Parse LISTUSER output
      set_fact:
        user_profile: "{{ listuser_output.output[0].content }}"
    
    - name: Create ServiceNow ticket
      ansible.builtin.uri:
        url: "https://servicenow.example.com/api/now/table/incident"
        method: POST
        headers:
          Content-Type: "application/json"
          Authorization: "Bearer {{ vault_snow_token }}"
        body_format: json
        body:
          short_description: "zSecure Alert {{ alert_id }}: {{ alert_descriptions[alert_id] }} for {{ user_id }}"
          description: |
            Authority Change Detected
            
            Alert ID: {{ alert_id }}
            Description: {{ alert_descriptions[alert_id] }}
            User: {{ user_id }}
            Authority: {{ authority }}
            Changed By: {{ ansible_eda.event.granted_by }}
            System: {{ ansible_eda.event.system_id }}
            Timestamp: {{ ansible_date_time.iso8601 }}
            
            Current User Profile (LISTUSER output):
            {{ user_profile }}
          category: "Security"
          subcategory: "RACF"
          urgency: "2"
          impact: "2"
      delegate_to: localhost
      register: snow_ticket
    
    - name: Send email notification with LISTUSER output
      ansible.builtin.mail:
        host: smtp.example.com
        port: 587
        to: "{{ admin_email }}"
        subject: "zSecure Alert {{ alert_id }}: Authority Change for {{ user_id }}"
        body: |
          Authority Change Summary
          
          WHO performed the action: {{ ansible_eda.event.granted_by }}
          WHO/WHAT triggered the alert: Authority change for {{ user_id }}
          WHO is doing the automation: RACF Admin (omvsadm)
          WHAT was the action: {{ alert_descriptions[alert_id] }}
          WHEN was the action performed: {{ ansible_eda.event.date_time }}
          WHAT platform: Ansible Automation Platform / Event-Driven Ansible
          HOW: Automated LISTUSER command via zSecure Alert {{ alert_id }}
          
          Authority: {{ authority }}
          System: {{ ansible_eda.event.system_id }}
          
          ServiceNow Ticket: {{ snow_ticket.json.result.number }}
          
          Current User Profile:
          {{ user_profile }}
          
          Please review and validate this authority change.
      delegate_to: localhost
    
    - name: Log authority change
      ansible.builtin.lineinfile:
        path: /var/log/zsecure_authority_changes.log
        line: "{{ ansible_date_time.iso8601 }} | Alert {{ alert_id }} | User {{ user_id }} | Authority {{ authority }} | Changed by {{ ansible_eda.event.granted_by }} | Ticket {{ snow_ticket.json.result.number }}"
        create: yes
      delegate_to: localhost
::


---

Use case 4: Invalid password attempts (Alert 1111)
--------------------------------------------------

**Scenario**: Detect brute force attacks by counting invalid password attempts within a time window.

**Alert Example:**
::

Subject: Alert 1111: Invalid password attempts exceed limit for C##BSG2
Alert 1111: Invalid password attempts exceed limit for C##BSG2
::


**Rulebook** (``rulebooks/zsecure_password_attacks.yml``):
.. code-block:: yaml

---
- name: zSecure Password Attack Detection
  hosts: zos_systems
  sources:
    - name: zsecure_alerts
      type: email
      args:
        host: imap.example.com
        port: 993
        username: "{{ vault_email_user }}"
        password: "{{ vault_email_password }}"
        folder: INBOX
        filter: "SUBJECT 'Alert 1111'"

  rules:
    - name: Detect Brute Force Attack
      condition: >
        event.alert_id == "1111"
      throttle:
        once_within: 10 minutes
        group_by_attributes:
          - event.user_id
      action:
        run_playbook:
          name: playbooks/respond_to_brute_force.yml
          extra_vars:
            user_id: "{{ event.user_id }}"
            system_id: "{{ event.system_id }}"
            attempt_count: "{{ event.attempt_count }}"
::


**Playbook** (``playbooks/respond_to_brute_force.yml``):
.. code-block:: yaml

---
- name: Respond to Brute Force Attack
  hosts: "{{ ansible_eda.event.system_id }}"
  gather_facts: false
  
  vars:
    user_id: "{{ ansible_eda.event.user_id }}"
    security_email: "{{ vault_security_email }}"
  
  tasks:
    - name: Revoke user account
      ibm.ibm_zos_core.zos_tso_command:
        commands:
          - "ALU {{ user_id }} REVOKED"
      register: revoke_result
    
    - name: Create high-priority security incident
      ansible.builtin.uri:
        url: "https://servicenow.example.com/api/now/table/incident"
        method: POST
        headers:
          Content-Type: "application/json"
          Authorization: "Bearer {{ vault_snow_token }}"
        body_format: json
        body:
          short_description: "SECURITY ALERT: Brute Force Attack on {{ user_id }}"
          description: |
            Potential Brute Force Attack Detected
            
            User: {{ user_id }}
            System: {{ ansible_eda.event.system_id }}
            Invalid Attempts: {{ ansible_eda.event.attempt_count }}
            Detection Time: {{ ansible_date_time.iso8601 }}
            
            AUTOMATED ACTION TAKEN:
            - User account {{ user_id }} has been REVOKED
            - Alert throttled to prevent duplicate actions (10 minute window)
            
            INVESTIGATION REQUIRED:
            - Review system logs for source IP/terminal
            - Determine if legitimate user or attack
            - Coordinate with user if legitimate
          category: "Security"
          subcategory: "Brute Force Attack"
          urgency: "1"
          impact: "1"
          priority: "1"
      delegate_to: localhost
      register: snow_ticket
    
    - name: Send urgent security alert
      ansible.builtin.mail:
        host: smtp.example.com
        port: 587
        to: "{{ security_email }}"
        subject: "URGENT: Brute Force Attack Detected - {{ user_id }}"
        body: |
          SECURITY ALERT: Potential Brute Force Attack
          
          WHO performed the action: Event-Driven Ansible (EDA)
          WHO/WHAT triggered the alert: {{ ansible_eda.event.attempt_count }} invalid password attempts for {{ user_id }}
          WHO is doing the automation: Security Admin
          WHAT was the action: User {{ user_id }} REVOKED
          WHEN was the action performed: {{ ansible_date_time.iso8601 }}
          WHAT platform: Ansible Automation Platform / Event-Driven Ansible
          HOW: Automated response to zSecure Alert 1111
          
          System: {{ ansible_eda.event.system_id }}
          ServiceNow Ticket: {{ snow_ticket.json.result.number }}
          
          IMMEDIATE ACTION REQUIRED:
          1. Review system logs for attack source
          2. Verify if legitimate user or attacker
          3. Contact user if legitimate access issue
          4. Consider IP blocking if external attack
          
          Note: Alert throttling active - duplicate alerts within 10 minutes suppressed
      delegate_to: localhost
    
    - name: Log security incident
      ansible.builtin.lineinfile:
        path: /var/log/zsecure_security_incidents.log
        line: "{{ ansible_date_time.iso8601 }} | BRUTE_FORCE | Alert 1111 | User {{ user_id }} | Attempts {{ ansible_eda.event.attempt_count }} | REVOKED | Ticket {{ snow_ticket.json.result.number }}"
        create: yes
      delegate_to: localhost
::


---

Use case 5: Emergency user logon (Alert 1102)
--------------------------------------------------

**Scenario**: Detect emergency user logon and create ServiceNow ticket for validation.

**Alert example:**

::

   Subject: Alert 1102: emergency user IBMUSER logged on
   CP21102I emergency user IBMUSER logged on

::


**Rulebook** (``rulebooks/zsecure_emergency_user.yml``):

.. code-block:: yaml

   ---
   - name: zSecure Emergency User Detection
     hosts: zos_systems
     sources:
       - name: zsecure_alerts
         type: email
         args:
           host: imap.example.com
           port: 993
           username: "{{ vault_email_user }}"
           password: "{{ vault_email_password }}"
           folder: INBOX
           filter: "SUBJECT 'Alert 1102'"

     rules:
       - name: Validate Emergency User Logon
         condition: event.alert_id == "1102"
         action:
           run_playbook:
             name: playbooks/validate_emergency_logon.yml
             extra_vars:
               user_id: "{{ event.user_id }}"
               system_id: "{{ event.system_id }}"

::


**Playbook** (``playbooks/validate_emergency_logon.yml``):

.. code-block:: yaml

   ---
   - name: Validate Emergency User Logon
     hosts: localhost
     gather_facts: false
     
     vars:
       user_id: "{{ ansible_eda.event.user_id }}"
       admin_email: "{{ vault_admin_email }}"
     
     tasks:
       - name: Create ServiceNow validation ticket
         ansible.builtin.uri:
           url: "https://servicenow.example.com/api/now/table/incident"
           method: POST
           headers:
             Content-Type: "application/json"
             Authorization: "Bearer {{ vault_snow_token }}"
           body_format: json
           body:
             short_description: "VALIDATION REQUIRED: Emergency User {{ user_id }} Logon"
             description: |
               Emergency User Logon Detected
               
               User: {{ user_id }}
               System: {{ ansible_eda.event.system_id }}
               Logon Time: {{ ansible_date_time.iso8601 }}
               
               VALIDATION REQUIRED:
               Is there a confirmed emergency situation that justifies this logon?
               
               Please verify:
               1. Emergency situation exists and is documented
               2. Proper authorization was obtained
               3. Emergency user access is necessary
               4. Alternative access methods were unavailable
               
               If emergency is NOT confirmed, immediate action may be required.
             category: "Security"
             subcategory: "Emergency Access"
             urgency: "2"
             impact: "2"
         register: snow_ticket
       
       - name: Send notification
         ansible.builtin.mail:
           host: smtp.example.com
           port: 587
           to: "{{ admin_email }}"
           subject: "VALIDATION REQUIRED: Emergency User {{ user_id }} Logon"
           body: |
             Emergency User Logon Detected
             
             WHO performed the action: {{ user_id }}
             WHO/WHAT triggered the alert: Emergency user logon
             WHAT was the action: Emergency user {{ user_id }} logged on
             WHEN: {{ ansible_date_time.iso8601 }}
             WHERE: System {{ ansible_eda.event.system_id }}
             
             ServiceNow Ticket: {{ snow_ticket.json.result.number }}
             
             ACTION REQUIRED:
             Please validate if there is a confirmed emergency situation.
             Update the ServiceNow ticket with validation results.
             
             Note: This alert requires external validation to confirm emergency status.

::


---

Additional IBM zSecure alert responses
--------------------------------------------------

Alert 1119: Non-expiring password enabled
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **Action**: Create audit ticket for review.
- **Notification**: Email security team.

Alert 1112: Password history flushed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **Action**: Log event and create security ticket.
- **Notification**: Email security team.

Alert 1113: Suspect password changes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **Action**: Create investigation ticket.
- **Notification**: Email security team.

Alert 1115: Too many violations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **Action**: Review user activity, consider suspension.
- **Notification**: Email security team with violation summary.

Alert 1104: Highly authorized user revoked
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **Action**: Immediate notification to management.
- **Notification**: Email security and management teams.

Alert 1109: SPECIAL authority used by non-SPECIAL user
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **Action**: Create high-priority security ticket.
- **Notification**: Email security team immediately.

Alert 1110: Non-OPERATIONS user accessed with OPERATIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **Action**: Create security ticket for investigation.
- **Notification**: Email security team.

Alert 1120: Major administrative activity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- **Action**: Document activity with LISTUSER output.
- **Notification**: Email audit team.

---

Configuration variables
--------------------------------------------------

Create ``group_vars/zos_systems/zsecure.yml``:

.. code-block:: yaml

   ---
   # zSecure Integration Variables
=====
zsecure_email_source: "C2POLICE@DINO"
zsecure_alert_folder: "INBOX"

=====
Admin Configuration
=====
racf_admin_user: "OMVSADM"
security_team_email: "security-team@example.com"
admin_email: "racf-admin@example.com"
audit_team_email: "audit-team@example.com"

=====
ServiceNow Integration
=====
servicenow_url: "https://servicenow.example.com"
servicenow_api_path: "/api/now/table/incident"

=====
Throttling Configuration
=====
brute_force_window: "10 minutes"
brute_force_threshold: 3

=====
Quarantine Settings
=====
quarantine_method: "REVOKED"  # Options: REVOKED, REVOKED+CONTAINED

=====
Notification Settings
=====
notification_method: "email"  # Options: email, slack, both
slack_webhook_url: "https://hooks.slack.com/services/YOUR/WEBHOOK/URL"

=====
Logging
=====
zsecure_log_path: "/var/log/zsecure_actions.log"
security_incident_log: "/var/log/zsecure_security_incidents.log"
authority_change_log: "/var/log/zsecure_authority_changes.log"
::


---

Simple rulebook examples
==================================================

---

Example 2: Unknown user logon detection
--------------------------------------------------

**Rulebook:** ``rulebooks/unknown_user_logon.yml``

.. code-block:: yaml

---
- name: Detect Unknown User Logons
  hosts: all

  sources:
    - ansible.eda.webhook:
        host: 0.0.0.0
        port: 5000

  rules:
    - name: Unknown user logon (Alert 1101)
      condition: event.payload.alert_id == "1101"
      action:
        run_playbook:
          name: quarantine_user.yml
          extra_vars:
            user_id: "{{ event.payload.user_id }}"
            system: "{{ event.payload.system }}"
::


**Playbook:** ``playbooks/quarantine_user.yml``

.. code-block:: yaml

---
- name: Quarantine Unknown User
  hosts: "{{ system }}"
  gather_facts: false

  tasks:
    - name: Revoke user access
      ibm.ibm_zos_core.zos_operator:
        cmd: "REVOKE {{ user_id }}"
      register: revoke_result

    - name: Create incident ticket
      ansible.builtin.uri:
        url: "https://ticketing.example.com/api/incidents"
        method: POST
        body_format: json
        body:
          title: "Unknown user logon detected"
          description: "User {{ user_id }} logged on to {{ system }}"
          severity: "high"
          category: "security"

    - name: Send alert to security team
      ansible.builtin.mail:
        to: security-ops@example.com
        subject: "URGENT: Unknown User Logon - {{ user_id }}"
        body: |
          Unknown user logon detected:
          User: {{ user_id }}
          System: {{ system }}
          Action: User access revoked
          Ticket: Created automatically
::


---

Example 3: Job failure response
--------------------------------------------------

**Rulebook:** ``rulebooks/job_monitoring.yml``

.. code-block:: yaml

---
- name: Monitor Job Failures
  hosts: all

  sources:
    - ansible.eda.kafka:
        host: kafka.example.com
        port: 9092
        topic: zos_job_events

  rules:
    - name: Critical job failure
      condition: |
        event.job_status == "FAILED" and 
        event.job_name.startswith("PROD")
      action:
        run_playbook:
          name: job_failure_response.yml
          extra_vars:
            job_name: "{{ event.job_name }}"
            job_id: "{{ event.job_id }}"
            return_code: "{{ event.return_code }}"
::


**Playbook:** ``playbooks/job_failure_response.yml``

.. code-block:: yaml

---
- name: Respond to Job Failure
  hosts: zos_systems
  gather_facts: false

  tasks:
    - name: Retrieve job output
      ibm.ibm_zos_core.zos_job_output:
        job_id: "{{ job_id }}"
      register: job_output

    - name: Analyze failure
      ansible.builtin.set_fact:
        failure_reason: "{{ job_output.jobs[0].ret_code.msg }}"

    - name: Attempt automatic recovery
      ibm.ibm_zos_core.zos_job_submit:
        src: "/u/jobs/{{ job_name }}.jcl"
        location: USS
        wait_time_s: 60
      register: retry_result
      when: return_code.code == "0008"

    - name: Create incident if recovery fails
      ansible.builtin.uri:
        url: "https://ticketing.example.com/api/incidents"
        method: POST
        body_format: json
        body:
          title: "Production Job Failure: {{ job_name }}"
          description: "{{ failure_reason }}"
          severity: "critical"
      when: retry_result is failed or return_code.code != "0008"
::


---

Example 4: System performance monitoring
--------------------------------------------------

**Rulebook:** ``rulebooks/performance_monitor.yml``

.. code-block:: yaml

---
- name: Monitor System Performance
  hosts: all

  sources:
    - ansible.eda.generic:
        payload:
          - cpu_usage: 95
            system: PROD1
          - cpu_usage: 87
            system: PROD2

  rules:
    - name: High CPU usage
      condition: event.cpu_usage > 90
      action:
        run_playbook:
          name: performance_response.yml
          extra_vars:
            system: "{{ event.system }}"
            cpu_usage: "{{ event.cpu_usage }}"
::


**Playbook:** ``playbooks/performance_response.yml``

.. code-block:: yaml

---
- name: Respond to High CPU Usage
  hosts: "{{ system }}"
  gather_facts: false

  tasks:
    - name: Collect system metrics
      ibm.ibm_zos_core.zos_operator:
        cmd: "D A,ALL"
      register: active_jobs

    - name: Identify resource-intensive jobs
      ansible.builtin.set_fact:
        high_cpu_jobs: "{{ active_jobs.content | 
                          regex_findall('\\w+\\s+\\d+\\.\\d+') }}"

    - name: Send performance alert
      ansible.builtin.mail:
        to: operations@example.com
        subject: "High CPU Alert: {{ system }} - {{ cpu_usage }}%"
        body: |
          System: {{ system }}
          CPU Usage: {{ cpu_usage }}%
          Active Jobs: {{ high_cpu_jobs | join(', ') }}
          
          Please investigate immediately.
::


---

Example 5: Comprehensive IBM zSecure integration
--------------------------------------------------

**Rulebook:** ``rulebooks/zsecure_comprehensive.yml``

.. code-block:: yaml

---
- name: Comprehensive zSecure Alert Monitoring
  hosts: all

  sources:
    - ansible.eda.file:
        path: /var/log/zsecure/alerts.log
        format: json

  rules:
    # Security Alerts
    - name: Unknown user logon (1101)
      condition: event.alert_id == "1101"
      action:
        run_playbook:
          name: security/quarantine_unknown_user.yml

    - name: Emergency user logon (1102)
      condition: event.alert_id == "1102"
      action:
        run_playbook:
          name: security/validate_emergency_user.yml

    - name: Superuser logon (1103)
      condition: event.alert_id == "1103"
      action:
        run_playbook:
          name: security/remove_superuser.yml

    # Authority Changes
    - name: System authority granted (1105)
      condition: event.alert_id == "1105"
      action:
        run_playbook:
          name: security/audit_authority_grant.yml

    - name: System authority revoked (1106)
      condition: event.alert_id == "1106"
      action:
        run_playbook:
          name: security/log_authority_revoke.yml

    # Password Security
    - name: Invalid password attempts (1111)
      condition: event.alert_id == "1111"
      action:
        run_playbook:
          name: security/lock_suspicious_account.yml

    - name: Password history flushed (1112)
      condition: event.alert_id == "1112"
      action:
        run_playbook:
          name: security/investigate_password_flush.yml

    # Administrative Activity
    - name: Major administrative activity (1120)
      condition: event.alert_id == "1120"
      action:
        run_playbook:
          name: security/audit_admin_activity.yml
::