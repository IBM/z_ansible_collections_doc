.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2026                                    .
.. ...........................................................................
.. TODO:
..    1) Request all contributors provide a reference (ref) back to the
..       collections ansible_content page like the ibm_zos_core collection.
..       For now, static links are used (which might actually be safer :) )
.. ...........................................................................
==================
Software Configuration
==================

Event-Driven Ansible (EDA) software configuration instructions provide steps for configuring rulebooks and playbooks from the IBM EDA z/OS collection in Ansible Automation Platform (AAP) for first-time users. 

This configuration enables EDA to consume zSecure alerts from z/OS via Kafka.

.. note::
   For the end-to-end workflow to run successfully, ensure that you configure z/OS with zSecure alerts routing to Kafka for Event-Driven Ansible consumption.

Prerequisites
-------------

* Ansible Automation Platform (AAP) installed and accessible.

* Access to GitHub for repository management.

* z/OS system with zSecure configured.

* Kafka broker configured and accessible.

* SMTP server for email notifications.

* Appropriate credentials for:
  
  * GitHub/Source Control
  * z/OS managed nodes
  * Kafka broker
  * SMTP server.

Environment Preparation
------------------------

Before you begin the configuration:

1. Ensure z/OS is configured with zSecure alerts.

2. Verify Kafka broker is receiving z/OS alerts.

3. Confirm network connectivity between AAP and all required systems.

4. Gather all necessary credentials and connection details.

.. note::
   Feel free to make any changes to the playbooks and rulebooks to adapt them to your specific environment requirements.

Step 1: Obtain the collection
------------------------------

Clone the ``ibm.ibm_eda_zos`` collection from GitHub to your local machine:

.. code-block:: bash

   git clone https://github.com/ansible-collections/ibm_eda_zos.git

**Collection Structure:**

* **Rulebooks location:** ``/extensions/eda/rulebooks/security``
* **Playbooks location:** ``/playbooks/security``

Step 2: Create a repository
----------------------------

1. Review the cloned collection and make any necessary modifications for your environment.
2. Create a new repository in your GitHub account.
3. Push the collection (with or without modifications) to your new repository.

.. code-block:: bash

   cd ibm_eda_zos
   git remote set-url origin https://github.com/<your-username>/<your-repo-name>.git
   git push -u origin main

Step 3: Set up credentials
---------------------------

Configure the following credentials in Ansible Automation Platform:

Automation Controller credentials
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. **Source Control credential**
   
   * **Purpose:** Connect to GitHub
   * **Type:** Source Control
   * **Required Information:**
     
     * GitHub username
     * Personal access token or password.

2. **Machine credentials (z/OS)**
   
   * **Purpose:** Connect to the z/OS managed node
   * **Type:** Machine
   * **Required Information:**
     
     * SSH username
     * SSH private key or password
     * Privilege escalation method (if required).

Event-Driven Ansible Controller credentials
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. **Source Control credential**
   
   * **Purpose:** Connect to GitHub
   * **Type:** Source Control
   * **Required Information:**
     
     * GitHub username
     * Personal access token or password.

2. **Red Hat Ansible Automation Platform credential**
   
   * **Purpose:** Connect to the Automation Controller
   * **Type:** Red Hat Ansible Automation Platform
   * **Required Information:**
     
     * Automation Controller URL
     * OAuth token or username/password.

Step 4: Create projects
-----------------------

Create projects in both controllers to access the collection content.

Automation Controller project
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Navigate to **Automation Controller → Projects**.
2. Click **Create project**.
3. Configure the project:
   
   * **Name:** IBM EDA z/OS Collection
   * **Organization:** Select your organization
   * **Source Control Type:** Git
   * **Source Control URL:** Your GitHub repository URL
   * **Source Control Credential:** Select the GitHub credential created in Step 3
   * **Update Revision on Launch:** Enabled (recommended)

4. Click **Save**.
5. Wait for the project sync to complete.

Event-Driven Ansible Controller project
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Navigate to **Event-Driven Ansible → Projects**.
2. Click **Create project**.
3. Configure the project:
   
   * **Name:** IBM EDA z/OS Collection
   * **Source Control Type:** Git
   * **Source Control URL:** Your GitHub repository URL
   * **Source Control Credential:** Select the GitHub credential created in Step 3

4. Click **Create project**.
5. Wait for the project sync to complete.

.. note::
   Both controllers now have access to the rulebooks and playbooks in the collection.

Step 5: Playbook setup in Automation Controller
------------------------------------------------

Configure the Automation Controller to execute playbooks in response to events.

Create a host
^^^^^^^^^^^^^

1. Navigate to **Automation Controller → Hosts**.
2. Click **Create host**.
3. Configure the host:
   
   * **Name:** Your z/OS managed node hostname
   * **Description:** z/OS system for EDA security automation

4. Click **Save**.

Create an inventory
^^^^^^^^^^^^^^^^^^^^

1. Navigate to **Automation Controller → Inventories**.
2. Click **Create inventory → Create inventory**.
3. Configure the inventory:
   
   * **Name:** z/OS EDA Inventory
   * **Organization:** Select your organization

4. Click **Save**.
5. Navigate to the **Hosts** tab.
6. Click **Add**.
7. Select the host created in the previous step.
8. Click **Save**.

Create a job template
^^^^^^^^^^^^^^^^^^^^^^

1. Navigate to **Automation Controller → Templates**.
2. Click **Create template → Create job template**.
3. Configure the job template:

   **Basic Information:**
   
   * **Name:** ``zSecure - Respond to Group Authority Change``
   * **Job Type:** Run
   * **Inventory:** Select ``z/OS EDA Inventory``
   * **Project:** Select ``IBM EDA z/OS Collection``
   * **Playbook:** ``playbooks/security/<playbook_name>.yml``
   * **Credentials:** Select the z/OS machine credential.

   **Extra Variables:**
   
   .. code-block:: yaml

      # Email configuration
      security_alert_recipients: <security-team-email>
      security_alert_sender: <eda-alerts-email>
      smtp_server: <your-smtp-relay>
      smtp_server_port: <your-smtp-port>

   **Example:**
   
   .. code-block:: yaml

      # Email configuration
      security_alert_recipients: security-team@example.com
      security_alert_sender: eda-alerts@example.com
      smtp_server: smtp.example.com
      smtp_server_port: 587

4. Click **Save**.

.. tip::
   Test the job template manually before activating the rulebook to ensure proper configuration.

Step 6: Rulebook setup in Event-Driven Ansible Controller
----------------------------------------------------------

Configure the Event-Driven Ansible Controller to listen for events and trigger automation.

Create a rulebook activation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. Navigate to **Event-Driven Ansible → Rulebook Activations**.
2. Click **Create rulebook activation**.
3. Configure the rulebook activation:

   **Basic Information:**
   
   * **Name:** ``zSecure Group Authority Monitor``
   * **Description:** Monitors Kafka for zSecure group authority change alerts
   * **Organization:** Default (or your organization)
   * **Project:** Select ``IBM EDA z/OS Collection``
   * **Rulebook:** Select the appropriate rulebook from the dropdown.
     
     * Path: ``extensions/eda/rulebooks/security/<rulebook-name>.yml``

   **Credentials:**
   
   * **Red Hat Ansible Automation Platform:** Select the AAP credential created in Step 3.

   **Decision Environment:**
   
   * Select an appropriate decision environment that includes:
     
     * Kafka Python libraries
     * Required Ansible collections
     * SSL certificate support

   **Extra Variables:**
   
   .. code-block:: yaml

      ssl_cafile: <path-to-ca-cert-file>
      kafka_host: <your-kafka-broker>
      kafka_port: <your-kafka-ssl-port>
      kafka_topic: <your-kafka-topic>
      security_protocol: SSL

   **Example:**
   
   .. code-block:: yaml

      ssl_cafile: /etc/pki/tls/certs/kafka-ca.crt
      kafka_host: kafka.example.com
      kafka_port: 9093
      kafka_topic: zsecure-alerts
      security_protocol: SSL

4. Click **Create rulebook activation**.

.. important::
   The rulebook activation starts listening for events immediately upon creation if enabled.

Step 7: Run your event
----------------------