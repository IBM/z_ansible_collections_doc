.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2026                                   .
.. ...........................................................................
.. TODO:
..    1) Request all contributors provide a reference (ref) back to the
..       collections ansible_content page like the ibm_zos_core collection.
..       For now, static links are used (which might actually be safer :) )
.. ...........................................................................

Integration with IBM Z
==================================================

EDA integrates with IBM Z systems through certified Ansible collections:

- **ibm.ibm_zos_core**: Core z/OS system automation.
- **ibm.ibm_zosmf**: IBM z/OS® Management Facility (z/OSMF) REST API integration.

Integration flow
--------------------------------------------------

::

1. Event occurs on z/OS (for example, IBM zSecure alert)
         ↓
2. Event is captured (log, email, or Apache Kafka)
         ↓
3. EDA rulebook processes the event
         ↓
4. Matching rule triggers playbook
         ↓
5. Playbook runs actions by using IBM Z modules
         ↓
6. Results are logged and monitored
::


Example actions on z/OS
--------------------------------------------------

- **Run operator commands** (``zos_operator``).
- **Submit batch jobs** (``zos_job_submit``).
- **Manage data sets** (``zos_data_set``).
- **Collect system information** (``zos_gather_facts``).
- **Update security profiles** (through IBM RACF® commands).
- **Modify system parameters**.