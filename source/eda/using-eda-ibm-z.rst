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
___________________

The following use cases demonstrate production-ready implementations for responding to IBM zSecure alerts with comprehensive error handling, ServiceNow® integration, and detailed notifications.


Use case 1: Unknown user logon detection (Alert 1101)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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



Use case 2: Superuser (uid 0) logon detection (Alert 1103)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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



Use case 3: System authority changes (Alerts 1105-1108)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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


Use case 4: Invalid password attempts (Alert 1111)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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



Use case 5: Emergency user logon (Alert 1102)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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