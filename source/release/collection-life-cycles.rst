.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2024                                    .
.. ...........................................................................

.. _collection-life-cycles:

======================
Collection Life Cycles
======================

As part of Red Hat **Ansible Certified Content for Z**, customers have
access to supported versions. This offering publishes a product life
cycle for all **Ansible for IBM Z** collections so that customers and
partners can properly plan, deploy, support, and maintain the automation
that they use.

This product life cycle encompasses serviceable periods for each version, the
life cycle phase which identifies the various levels of maintenance over a
period of time from the initial release date and an explanation of the
severities.

Customers are expected to upgrade their environments to the most current
supported version of the product in a timely fashion. Features and bug
fixes target only the latest versions of the product, though some allowance
may be given for high security risk items.

Life cycle phase
----------------

To encourage the adoption of new features while keeping the high standard of
stability inherent, support is divided into life cycle phases:

- **Full support** covers the first year of the products life cycle.
- **Maintenance support** covers the second year of the products life cycle.

+----------+-----------------------+------------------------------+
| Severity | Full Support (year 1) | Maintenance Support (year 2) |
+==========+=======================+==============================+
| Critical | Yes                   | Yes                          |
+----------+-----------------------+------------------------------+
| High     | Yes                   | No                           |
+----------+-----------------------+------------------------------+


Critical and high severities are included in **year 1**, while
critical severities are included only in **year 2**.

Medium and low severities generally addressed in subsequent releases
to ensure a high standard of stability remains available for production
environments.

.. _Ansible Z life cycles - severity:

Severity Descriptions
---------------------

Severity descriptions describe the impact to the customer. Severity
assignment is only applicable to customers who obtain IBM Ansible Z
collections from Ansible Automation Platform and entitled for Z.

For community issues, severity is decided on by team who triages the issue
which will also be used for planning the change.

+----------+----------------------------------------------------+
| Severity | Description                                        |
+==========+====================================================+
| Critical | A problem that severely impacts your use of the    |
|          | software in a production environment (such as loss |
|          | of production data or in which your production     |
|          | systems are not functioning). The situation halts  |
|          | your business operations and no procedural         |
|          | workaround exists, includes security issues.       |
+----------+----------------------------------------------------+
| High     | A problem where the software is functioning but    |
|          | your use in a production environment is severely   |
|          | reduced. The situation is causing a high impact    |
|          | to portions of your business operations and no     |
|          | procedural workaround exists.                      |
+----------+----------------------------------------------------+
| Medium   | A problem that involves partial, non-critical loss |
|          | of use of the software in a production environment |
|          | or development environment and your business       |
|          | continues to function, including by using a        |
|          | procedural workaround.                             |
+----------+----------------------------------------------------+
| Low      | A general usage question, reporting of a           |
|          | documentation error, or recommendation for a       |
|          | future product enhancement or modification.        |
+----------+----------------------------------------------------+

.. note::

   Currently the IBM z/OS core collection is the only collection with a
   documented life cycle, others to follow soon.

.. _Ansible Z life cycles - collections:

Life cycles
-----------

.. toctree::
   :maxdepth: 1

   z/OS core<zos-core-cycles>
