.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2026                                   .
.. ...........................................................................
.. TODO:
..    1) Request all contributors provide a reference (ref) back to the
..       collections ansible_content page like the ibm_zos_core collection.
..       For now, static links are used (which might actually be safer :) )
.. ...........................................................................

Collections for Event-driven Ansible
======================================

Rulebooks
------------------

Start the rulebook engine
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   # Basic execution
   ansible-rulebook --rulebook rulebooks/zsecure_monitor.yml \
                    --inventory inventory.yml \
                    --verbose

   # With extra variables
   ansible-rulebook --rulebook rulebooks/zsecure_monitor.yml \
                    --inventory inventory.yml \
                    --vars vars/production.yml \
                    --verbose

   # In background with logging
   nohup ansible-rulebook --rulebook rulebooks/zsecure_monitor.yml \
                          --inventory inventory.yml \
                          --verbose > eda.log 2>&1 &

::


Inventory file example
~~~~~~~~~~~~~~~~~~~~~~

**File:** ``inventory.yml``

.. code-block:: yaml

   ---
   all:
     children:
       zos_systems:
         hosts:
           prod1:
             ansible_host: zos.prod1.example.com
             ansible_user: ansible
             ansible_python_interpreter: /usr/lpp/python/python3/bin/python3
           prod2:
             ansible_host: zos.prod2.example.com
             ansible_user: ansible
             ansible_python_interpreter: /usr/lpp/python/python3/bin/python3
         vars:
           ansible_connection: ssh

::

Best practices
~~~~~~~~~~~~~~~

1. Rulebook design
-----------------

- Keep rules simple and focused.
- Use descriptive names.
- Document conditions clearly.
- Test rules thoroughly before production.

2. Event source configuration
------------------------------

- Use secure connections (TLS/SSL).
- Implement proper authentication.
- Filter events at the source when possible.
- Monitor event source health.

3. Playbook development
--------------------------

- Make playbooks idempotent.
- Include error handling.
- Log all actions.
- Use Ansible Vault for sensitive data.

4. Security
-------------
- Encrypt credentials with Ansible Vault.
- Use least privilege access.
- Audit all automated actions.
- Implement approval workflows for critical changes.

5. Performance
---------------

- Optimize event filtering.
- Use async execution for long-running tasks.
- Monitor rulebook engine resource usage.
- Scale horizontally when needed.

6. Monitoring
-------------

- Log all rule matches and actions.
- Track playbook execution results.
- Set up alerts for rulebook failures.
- Monitor event processing latency.

Playbooks
----------

Event filter 
------------