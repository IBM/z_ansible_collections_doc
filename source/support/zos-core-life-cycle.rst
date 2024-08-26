.. ...........................................................................
.. © Copyright IBM Corporation 2024                                          .
.. ...........................................................................

.. _zos-core-life-cycle:

===============================
The ``ibm_zos_core`` Life Cycle
===============================

The ``ibm_zos_core`` collection is developed and released on a flexible release cycle; generally, each quarter a beta is released followed by a GA version. Occasionally, the cycle may be extended to properly implement and test larger changes before a new release is made available.

End of Life for this collection is generally a 2-year cycle unless a dependency reaches EOL prior to the 2 years. For example, if a collection has released and its dependency reaches EOL 1 year later, then the collection will EOL at the same time as the dependency, 1 year later.

For further information about the version information for dependencies, see :ref:`zos-core-requirements`.

Life Cycle Phase
================

To encourage the adoption of new features while keeping the high standard of stability inherent, support is divided into life cycle phases:

- **Full support** covers the first years.
- **Maintenance support** covers the second year.

+--------------------------+------------------------------------+---------------------------+
| Life Cycle Phase         | Full Support                       | Maintenance Support       |
+==========================+====================================+===========================+
| Critical security fixes  | Yes                                | Yes                       |
+--------------------------+------------------------------------+---------------------------+
| Bug fixes by severity    | Critical and high severity issues  | Critical severity issues  |
+--------------------------+------------------------------------+---------------------------+

Severities
==========

.. glossary::

    Severity 1 (Critical): 
        A problem that severely impacts your use of the software in a production environment (such as loss of production data or in which your production systems are not functioning). The situation halts your business operations and no procedural workaround exists.

    Severity 2 (high): 
        A problem where the software is functioning but your use in a production environment is severely reduced. The situation is causing a high impact to portions of your business operations and no procedural workaround exists.

    Severity 3 (medium):
        A problem that involves partial, non-critical loss of use of the software in a production environment or development environment and your business continues to function, including by using a procedural workaround.

    Severity 4 (low): 
        A general usage question, reporting of a documentation error, or recommendation for a future product enhancement or modification.

Severities 3 and 4 are generally addressed in subsequent releases to ensure a high standard of stability remains available for production environments.

Life Cycle Guide
================

+------------+---------------+---------------+
|Version     | GA            | End of Life   |
+============+===============+===============+
| 1.11.x     |               |               |
+------------+---------------+---------------+
| 1.10.x     | 21 June 2024  | 21 June 2026  |
+------------+---------------+---------------+
| 1.9.x      | 05 Feb 2024   | 30 April 2025 |
+------------+---------------+---------------+
| 1.8.x      | 13 Dec 2023   | 30 April 2025 |
+------------+---------------+---------------+
| 1.7.x      | 10 Oct 2023   | 30 April 2025 |
+------------+---------------+---------------+
| 1.6.x      | 28 June 2023  | 30 April 2025 |
+------------+---------------+---------------+
| 1.5.x      | 25 April 2023 | 25 April 2025 |
+------------+---------------+---------------+
