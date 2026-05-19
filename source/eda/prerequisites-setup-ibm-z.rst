.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2026                                   .
.. ...........................................................................
.. TODO:
..    1) Request all contributors provide a reference (ref) back to the
..       collections ansible_content page like the ibm_zos_core collection.
..       For now, static links are used (which might actually be safer :) )
.. ...........................................................................

Quick start checklist
--------------------------------------------------

- [ ] Install Ansible and ansible-rulebook.
- [ ] Install IBM Z collections (``ibm.ibm_zos_core``, ``ibm.ibm_zosmf``).
- [ ] Configure inventory with z/OS systems.
- [ ] Set up event sources (syslog, webhook, and so on).
- [ ] Create rulebooks for your use cases.
- [ ] Develop response playbooks.
- [ ] Test in non-production environment.
- [ ] Configure monitoring and logging.
- [ ] Deploy to production.
- [ ] Document your automation workflows.

Using certified content in EDA
--------------------------------------------------

**Example: Using certified modules in playbooks**

.. code-block:: yaml

   ---
   - name: Automated IBM RACF user management (certified content)
     hosts: zos_systems
     collections:
       - ibm.ibm_zos_core
     
     tasks:
       - name: Run IBM RACF command by using certified module
         zos_tso_command:
           commands:
             - "LISTUSER {{ user_id }}"
         register: racf_output
       
       - name: Submit job by using certified module
         zos_job_submit:
           src: /ansible/jcl/backup.jcl
           location: LOCAL
           wait_time_s: 300
         register: job_result

::



Support and licensing
--------------------------------------------------

Red Hat Ansible Automation Platform subscription
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Includes access to all Red Hat Ansible Certified Content.
- Enterprise support for certified collections.
- Access to Automation Hub for certified content.
- Regular updates and security patches.

IBM support
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- IBM Z software subscriptions include support for IBM-developed collections.
- Integration support for IBM Z products.
- Access to IBM Z Ansible documentation and resources.


Getting started with certified content
--------------------------------------------------

.. code-block:: bash

   # Install Ansible Automation Platform (includes certified content access)
   # Or install individual certified collections:

   # Install IBM Z Core Collection (certified)
   ansible-galaxy collection install ibm.ibm_zos_core

   # Install IBM Z CICS Collection (certified)
   ansible-galaxy collection install ibm.ibm_zos_cics

   # Install IBM Z IMS Collection (certified)
   ansible-galaxy collection install ibm.ibm_zos_ims

   # Install IBM Z HMC Collection (certified)
   ansible-galaxy collection install ibm.ibm_zhmc

   # Verify installed collections
   ansible-galaxy collection list | grep ibm

   # View collection documentation
   ansible-doc -l ibm.ibm_zos_core

::

Additional resources
--------------------------------------------------

- **Ansible Automation Hub**: https://console.redhat.com/ansible/automation-hub
- **IBM Z Ansible Collections**: https://ibm.github.io/z_ansible_collections_doc/
- **Red Hat Certified Content**: https://access.redhat.com/articles/3642632
- **IBM Z DevOps**: https://www.ibm.com/z/devops